import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/screens/map/map.dart';
import 'package:complex_ui_rive_animation/screens/blog/detail_screen.dart';

class PostBottomBar2 extends StatelessWidget{
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
                    "Nhà Hát Lớn ",
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
              Text("Địa chỉ: Số 7 đường Công Trường Lam Sơn, phường Bến Nghé, Quận 1, Thành phố Hồ Chí Minh \nGiờ mở cửa tham khảo: 9:00 – 16:30 (ngày thường) và 9:00 – 12:00 (cuối tuần) \nGiá vé tham khảo: Khoảng 700.000 VNĐ/người tùy vào các sự kiện, chương trình biểu diễn",
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
              builder: (_) => DetailScreen(imagePath: "images/nhahatlon.jpg"),
            ),
          );
        },
        child: Hero(
          tag: "imageHero", // Đặt tag duy nhất cho hình ảnh "images/dulich1.jpg"
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "images/nhahatlon.jpg",
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
              builder: (_) => DetailScreen(imagePath: "images/nhahatlon1.jpg"),
            ),
          );
        },
        child: Hero(
          tag: "imageHero", // Đặt tag duy nhất cho hình ảnh "images/dulich1.jpg"
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "images/nhahatlon1.jpg",
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
                          image: AssetImage("images/nhahatlon2.jpg"),
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
                              latitude: 10.776851, // pass the latitude dynamically
                              longitude: 106.703206, // pass the longitude dynamically
                              title: "Đây là Nhà hát lớn  ", // pass the title dynamically
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
