import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complex_ui_rive_animation/profile/update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../screens/on_boardibg/on_boarding_screen.dart';
import 'package:image_picker/image_picker.dart';



class ProfilePage extends StatefulWidget {
  final String username;
  final String email;

  ProfilePage({required this.username, required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String phoneNumber;
  late String address;
  late String currentPhoneNumber;
  late String currentAddress;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        phoneNumber = data['phoneNumber'] ?? '';
        address = data['address'] ?? '';
        currentPhoneNumber = phoneNumber;
        currentAddress = address;
      });
    }
  }

  Future<void> updateUserInfo(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
          {
            'phoneNumber': phoneNumber,
            'address': address,
          });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thông tin đã được cập nhật thành công')),
      );
    }
  }
  // đăng xuất không quay lại
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => OnbodingScreen()),
          (route) => false,
    );
  }

  Future<void> uploadImage(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        try {
          String fileName = DateTime
              .now()
              .millisecondsSinceEpoch
              .toString();

          Reference storageReference = FirebaseStorage.instance.ref().child(
              'images/$fileName');

          UploadTask uploadTask = storageReference.putFile(imageFile);
          TaskSnapshot storageSnapshot = await uploadTask;

          String imageUrl = await storageSnapshot.ref.getDownloadURL();

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'imageUrl': imageUrl});

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tải ảnh lên thành công')),
          );
        } catch (error) {
          print('Lỗi tải ảnh lên: $error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đã xảy ra lỗi khi tải ảnh lên')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true, // Đặt giá trị true để căn giữa tiêu đề
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Thay đổi thành sắp xếp từ trên xuống
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            Align(
              alignment: Alignment.topCenter, // Đặt hình tròn và tên ở top center
              child: Container(
                width: 100,
                height: 100,
                child: GestureDetector(
                  onTap: () => uploadImage(context),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person),
                        );
                      }
                      var data = snapshot.data!.data() as Map<String, dynamic>?;
                      String imageUrl = data?['imageUrl'] ?? '';

                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue,
                        child: Text(
                          widget.username.substring(0, 1).toUpperCase(),
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topCenter, // Đặt tên người dùng ở top center
              child: Text(
                'User: ${widget.username}',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              width: 100,
              height: 2,
              color: Colors.grey, // Màu sắc của gạch ngang
            ),

            SizedBox(height: 100),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thông tin người dùng'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 8),
                          Text('User: ${widget.username ?? ''}'),
                          SizedBox(height: 8),
                          Text('email: ${widget.email ?? ''}'),
                          SizedBox(height: 8),
                          Text('Số điện thoại: ${phoneNumber ?? ''}'),
                          SizedBox(height: 8),
                          Text('Địa chỉ: ${address ?? ''}'),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Đóng'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center, // Căn giữa nội dung chữ
                child: Text(
                  'Xem thông tin',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Đặt bán kính bo góc ở đây
                ),
                backgroundColor: Colors.grey[200],
                minimumSize: Size(120, 60), // Đặt kích thước chiều dài và chiều rộng ở đây
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateProfilePage()),
                );
              },
              child: Text(
                'Cập nhật thông tin',
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
            ),
            SizedBox(height: 25),
            GestureDetector(
              onTap: logout,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Đăng xuất',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}