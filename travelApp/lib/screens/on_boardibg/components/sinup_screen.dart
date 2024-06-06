import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:complex_ui_rive_animation/screens/entry/entry_point.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  bool _isHidden = true;
  final TextEditingController _confettiController = TextEditingController(); // Đổi tên biến
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }


  Future<void> _handleSignUp() async {
    if (_confettiController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Vui lòng nhập đầy đủ thông tin."),
        ),
      );
    } else {
      try {
        // Tạo tài khoản mới với email và mật khẩu
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );


        // Lưu tên và email vào Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'id': userCredential.user!.uid, // Lưu ID của người dùng
          'confetti': _confettiController.text,
          'email': _emailController.text,
          'images':'',
        });

        // Sau khi thành công, điều hướng đến màn hình chính hoặc màn hình đăng nhập
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EntryPoint(),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tạo tài khoản thành công!")),
        );
      } catch (e) {
        String errorMessage = "Lỗi khi tạo tài khoản.";
        if (e is FirebaseAuthException) {
          if (e.code == 'email-already-in-use') {
            errorMessage = "Email đã được sử dụng.";
          } else if (e.code == 'weak-password') {
            errorMessage = "Mật khẩu quá yếu.";
          } else if (e.code == 'invalid-email') {
            errorMessage = "Email không hợp lệ.";
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          backgroundColor: Colors.transparent,
          body: Stack(

            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28,
                    left: 35,
                    right: 35,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _confettiController, // Sử dụng biến đã đổi tên
                        decoration: InputDecoration(
                          labelText: 'Confetti', // Cập nhật nhãn
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: _toggleVisibility,
                            icon: _isHidden
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: _handleSignUp,
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("SIGH UP NOW"),
                                Icon(Icons.content_paste_rounded, color: Colors.grey),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

