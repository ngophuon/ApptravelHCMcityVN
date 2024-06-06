import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/screens/map/map.dart';
import 'package:complex_ui_rive_animation/screens/blog/detail_screen.dart';

class PostBottomBar3 extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height/(1.5),
      padding: EdgeInsets.only(top: 20,left: 20,right: 20),
      decoration: BoxDecoration(
        color: Color(0xFFEDF2F6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        )
      ),
      child: ListView(children: [
        Padding(
          padding: EdgeInsets.only(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bảo Tàng lịch Sử ",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 25,
                      ),
                      Text("4.5",
                      style: TextStyle(fontWeight: FontWeight.w600),)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25),
              Text("Địa chỉ: Số 2 đường Nguyễn Bỉnh Khiêm, phường Bến Nghé, Quận 1, Thành phố Hồ Chí Minh \nGiờ mở cửa tham khảo: 8:00 – 11:30 và 13:00 – 17:00 (Từ thứ Ba đến Chủ nhật hằng tuần) \nGiá vé tham khảo: 1.000 VNĐ/trẻ em, 2.000 VNĐ/người lớn và 15.000 VNĐ/du khách nước ngoài",
              style: TextStyle(color: Colors.black54,fontSize: 16),
              textAlign: TextAlign.justify,),
              SizedBox(height: 20),
              Row(
                children: [
                Padding(
      padding: EdgeInsets.only(right: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(imagePath: "images/baotang.jpg"),
            ),
          );
        },
        child: Hero(
          tag: "imageHero", // Đặt tag duy nhất cho hình ảnh "images/dulich1.jpg"
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "images/baotang.jpg",
              fit: BoxFit.cover,
              width: 120,
              height: 90,
            ),
          ),
        ),
      ),
    ),
                  Padding(
      padding: EdgeInsets.only(right: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(imagePath: "images/baotang1.jpg"),
            ),
          );
        },
        child: Hero(
          tag: "imageHero", // Đặt tag duy nhất cho hình ảnh "images/dulich1.jpg"
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "images/baotang1.jpg",
              fit: BoxFit.cover,
              width: 120,
              height: 90,
            ),
          ),
        ),
      ),
    ),
                  
                  Expanded(
                    child: Container(
                      alignment:Alignment.center,
                      width: 120,
                      height: 90,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage("images/baotang2.jpg"),
                          fit: BoxFit.cover,
                          opacity: 0.4,

                        ),
                      ),
                      child: Text(
                        "5+",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                       ),),
                ],
              ),

              SizedBox(height: 15),
              Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(Icons.bookmark_outline,size: 40),

                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Map_sc(
                              latitude: 10.788233, // pass the latitude dynamically
                              longitude: 106.704754, // pass the longitude dynamically
                              title: "Đây là điểm đến bảo tàng lịch sử TPHCM  ", // pass the title dynamically
                            ),
                          ),
                        );
                      },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Text(
                            "Định vị",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
