import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import '../common.dart';

class Detailpage extends StatefulWidget {
  final String id;

  const Detailpage({Key key, this.id}) : super(key: key);
  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  int itemcount = 1;
  Response response;
  Response response1;
  String serverurl = 'http://127.0.0.1:8000';

  var dio = Dio();
  StreamController _streamController = StreamController();
  StreamSink get statesink => _streamController.sink;
  Stream get statestream => _streamController.stream;
  fetchapi() async {
    response = await dio.get(serverurl + '/fruits/' + widget.id + '/');
    print(response.data.toString());
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      statesink.add(response.data);
    } else {
      throw response;
    }
  }

  addcart(map) async {
    response1 = await dio.post(
      serverurl + '/cart/',
      data: map,
    );
    print(response1.data.toString());
    print(response1.statusCode.toString());
    if (response1.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Added to Cart')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.data)));
      throw response;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
              stream: statestream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color:
                                  HexColor(response.data['color'].toString()),
                              //  Color(0xFFe5655c),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                          ),
                          Container(
                            height: 250,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 20),
                            child: Image.network(
                                serverurl + '/' + response.data['imgpath']),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    response.data['fruitname'].toString(),
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'RS ' + response.data['price'].toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Quantity',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (itemcount <= 1) {
                                            } else {
                                              itemcount -= 1;
                                            }
                                          });
                                        },
                                        child: Container(
                                          child: Icon(
                                            Icons.remove,
                                            size: 17,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        itemcount.toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            // if (itemcount <= 1) {
                                            // } else {
                                            itemcount += 1;
                                            // }
                                          });
                                        },
                                        child: Container(
                                          child: Icon(
                                            Icons.add,
                                            size: 17,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '1 kg',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Delivery time',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.timer, size: 15),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '20-30 mins',
                                            style: TextStyle(
                                              fontSize: 10,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Review',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  RatingBar.readOnly(
                                    // onRatingChanged: (rating) => setState(() {}),
                                    filledIcon: Icons.star,
                                    emptyIcon: Icons.star_border,
                                    initialRating: double.parse(
                                        response.data['rating'].toString()),
                                    halfFilledIcon: Icons.star_half,
                                    isHalfAllowed: false,
                                    filledColor: HexColor(
                                        response.data['color'].toString()),
                                    emptyColor: HexColor(
                                        response.data['color'].toString()),
                                    halfFilledColor: Colors.amberAccent,
                                    size: 20,
                                  ),
                                ],
                              ),
                              // SizedBox(height: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product details',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    response.data['desc'].toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(height: 5),

                              // SizedBox(height: 30),
                              InkWell(
                                onTap: () {
                                  var map = {
                                    'productid': response.data['id'],
                                    'userid': '123456'
                                  };
                                  addcart(map);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 13,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFf15c00),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "Add to cart",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Something Went Wrong!'));
                } else {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Loading..."),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
