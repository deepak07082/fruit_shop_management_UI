import 'package:flutter/material.dart';
import 'package:fruit_shop/Widgets/dashboardcard.dart';

import 'detailpage.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Icon(
            Icons.menu,
            color: Colors.black,
            size: 16,
          ),
          SizedBox(
            width: 20,
          ),
        ],
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 16,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi Deepak",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Find fresh fruits what you want",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: 'Search fresh fruits',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 300,
                      child: Dashboardcard(
                        amt: '1.99',
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Detailpage(),
                            ),
                          );
                        },
                        bgcolor: Color(0xFFefc65c),
                        bottomright: true,
                        desc:
                            "Fruit is one of the ingredients to keep our body well. which helps our body to prevent disease.",
                        fav: true,
                        imgpath: 'pic_banana.png',
                        title: 'Banana',
                      ),
                    ),
                    Container(
                      child: Dashboardcard(
                        amt: '2.45',
                        bgcolor: Color(0xFFe5655c),
                        bottomleft: true,
                        desc:
                            "Fruit is one of the ingredients to keep our body well. which helps our body to prevent disease.",
                        fav: false,
                        imgpath: 'pic_apple.png',
                        title: 'Apple',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 300,
                      child: Dashboardcard(
                        amt: '1.99',
                        bgcolor: Color(0xFFa5bc6c),
                        topright: true,
                        desc:
                            "Fruit is one of the ingredients to keep our body well. which helps our body to prevent disease.",
                        fav: false,
                        imgpath: 'pic_pineapple.png',
                        title: 'Pineapple',
                      ),
                    ),
                    Container(
                      child: Dashboardcard(
                        amt: '2.45',
                        bgcolor: Color(0xFFf5b170),
                        topleft: true,
                        desc:
                            "Fruit is one of the ingredients to keep our body well. which helps our body to prevent disease.",
                        fav: true,
                        imgpath: 'pic_mongo.png',
                        title: 'Mango',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 13,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFf15c00),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Best 50+ Fresh Fruits",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Center(
                                      child: Text("Go"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
