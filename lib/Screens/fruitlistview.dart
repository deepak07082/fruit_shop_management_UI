import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fruit_shop/Widgets/dashboardcard.dart';

import '../common.dart';
import 'detailpage.dart';

class Fruitlistview extends StatefulWidget {
  @override
  _FruitlistviewState createState() => _FruitlistviewState();
}

class _FruitlistviewState extends State<Fruitlistview> {
  Response response;
  String serverurl = 'http://127.0.0.1:8000';

  var dio = Dio();
  StreamController _streamController = StreamController();
  StreamSink get statesink => _streamController.sink;
  Stream get statestream => _streamController.stream;
  List mainlist = [];

  List chunk(List list, int chunkSize) {
    List chunks = [];
    int len = list.length;
    for (var i = 0; i < len; i += chunkSize) {
      int size = i + chunkSize;
      chunks.add(list.sublist(i, size > len ? len : size));
    }
    return chunks;
  }

  fetchapi() async {
    response = await dio.get(serverurl + '/fruitslist/');
    print(response.data.toString());
    print(response.statusCode.toString());
    setState(() {
      mainlist = chunk(response.data, 2);
    });
    print(mainlist);
    print(mainlist.length);
    if (response.statusCode == 200) {
      statesink.add(response.data);
    } else {
      throw response;
    }
  }

  changefav(String id, map) async {
    response = await dio.post(
      serverurl + '/fruits/$id/',
      data: map,
    );
    print(response.data.toString());
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      fetchapi();
    } else {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Fruits',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
          size: 16,
        ),
      ),
      body: Container(
        child: StreamBuilder(
            stream: statestream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        for (var i = 0; i < mainlist.length; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var ii = 0; ii < mainlist[i].length; ii++)
                                Container(
                                  height: 300,
                                  margin: EdgeInsets.all(7),
                                  child: Dashboardcard(
                                    ontap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Detailpage(
                                                    id: mainlist[i][ii]['id']
                                                        .toString(),
                                                  )));
                                    },
                                    amt: mainlist[i][ii]['price'].toString(),
                                    bgcolor: HexColor(
                                        mainlist[i][ii]['color'].toString()),
                                    bottomright: i == 0
                                        ? ii == 0
                                            ? true
                                            : false
                                        : i + 1 == mainlist.length
                                            ? false
                                            : ii == 0
                                                ? true
                                                : false,
                                    bottomleft: i == 0
                                        ? ii == 1
                                            ? true
                                            : false
                                        : i + 1 == mainlist.length
                                            ? false
                                            : ii == 1
                                                ? true
                                                : false,
                                    topleft: i == 0
                                        ? false
                                        : ii == 0
                                            ? false
                                            : true,
                                    topright: i == 0
                                        ? false
                                        : ii == 1
                                            ? false
                                            : true,
                                    desc: mainlist[i][ii]['desc'].toString(),
                                    fav: mainlist[i][ii]['favourite'],
                                    favontap: () {
                                      print("jjjjjjj");
                                      Map<String, dynamic> map = {
                                        'fruitname': mainlist[i][ii]
                                            ['fruitname'],
                                        'price': mainlist[i][ii]['price'],
                                        'desc': mainlist[i][ii]['desc'],
                                        'favourite': !mainlist[i][ii]
                                            ['favourite'],
                                        'imgpath': mainlist[i][ii]['imgpath'],
                                        'rating': mainlist[i][ii]['rating'],
                                        'color': mainlist[i][ii]['color'],
                                      };

                                      changefav(
                                          mainlist[i][ii]['id'].toString(),
                                          map);
                                    },
                                    imgpath: serverurl +
                                        '/' +
                                        mainlist[i][ii]['imgpath'].toString(),
                                    title:
                                        mainlist[i][ii]['fruitname'].toString(),
                                  ),
                                ),
                            ],
                          ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
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
    );
  }
}
