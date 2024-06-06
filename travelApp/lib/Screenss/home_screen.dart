import 'package:flutter/material.dart';
import 'package:complex_ui_rive_animation/screens/map/Post_screen.dart';
import 'package:complex_ui_rive_animation/screens/map/other_screen.dart';
import 'package:complex_ui_rive_animation/screens/map/other_screen1.dart';
import 'package:complex_ui_rive_animation/screens/map/post_screen1.dart';


class HomeScreen extends StatelessWidget {
  var category = [
    'địa điểm tiết kiệm chi phí',
    'view đẹp',
    'sang chảnh',
    'tốt nhất',
    'đẹp nhất',
    'checkin xin xo'
  ];
  var tendiadiem=[
    'Nhà thờ đức bà',
    'Dinh độc lập',
    'Nhà hát lớn thành phố',
    'Bảo tàng lịch sử TP.HCM',
    'Bến nhà rồng',
    'Khu du lịch suối tiên',
    'Thảo Cầm Viên',
    'Công viên nước đầm sen',
    ' Bảo tàng tranh 3D Artinus',
    'Địa đạo Củ Chi',
    'Khu du lịch sinh thái Bình Quới',
    'Khu du lịch sinh thái Cần Giờ',
    'Phố đi bộ Nguyễn Huệ',
    'Phố Tây Bùi Viện',
    'Hẻm Bia: Lost in HongKong'

  ];

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        child: ListView.builder(
                          itemCount: 17,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {  
                              if (index == 0) {
      // Nhấp vào hình ảnh thứ nhất
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostScreen(), // Trang cho hình ảnh thứ nhất
        ),
      );
    } else if (index == 1) {
      // Nhấp vào hình ảnh thứ hai
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => otherScreen(), // Trang cho hình ảnh thứ hai
        ),
      );
    } else if (index == 2) {
      // Nhấp vào hình ảnh thứ ba
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => otherScreen1(), // Trang cho hình ảnh thứ ba
        ),
      );
    } else {
      // Nhấp vào các hình ảnh khác
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostScreenother(),
                  ),
                );
              }
                              },
                              child: Container(
                                width: 160,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage("images/dulich${index + 1}.jpg"),
                                    fit: BoxFit.cover,
                                    opacity: 0.7,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        Icons.bookmark_border_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        for (int i = 0; i < 6; i++)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Text(
                              category[i],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
ListView.builder( 
  physics: NeverScrollableScrollPhysics(),
  itemCount: 15,
  shrinkWrap: true,
  itemBuilder: (BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [ 
          InkWell(
            onTap: () {
              if (index == 0) {
      // Nhấp vào hình ảnh thứ nhất
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostScreen(), // Trang cho hình ảnh thứ nhất
        ),
      );
    } else if (index == 1) {
      // Nhấp vào hình ảnh thứ hai
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => otherScreen(), // Trang cho hình ảnh thứ hai
        ),
      );
    } else if (index == 2) {
      // Nhấp vào hình ảnh thứ ba
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => otherScreen1(), // Trang cho hình ảnh thứ ba
        ),
      );
    } else {
      // Nhấp vào các hình ảnh khác
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostScreenother(),
                  ),
                );
              }
            },
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("images/dulich${index + 1}.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.8,
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10),
                          child: Row(
                            
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween ,
                            children: [
                           
                              Text(
                                tendiadiem[index],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(Icons.more_vert,size: 30),
                            ],),),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
