import 'package:flutter/material.dart';

class Dashboardcard extends StatelessWidget {
  final String imgpath;
  final String title;
  final String desc;
  final String amt;
  bool fav;
  final Function ontap;
  final Function favontap;

  final Color bgcolor;
  final bool topright;
  final bool bottomright;
  final bool topleft;
  final bool bottomleft;

  Dashboardcard(
      {Key key,
      this.imgpath,
      this.title,
      this.desc,
      this.amt,
      this.fav,
      this.ontap,
      this.bgcolor,
      this.topright,
      this.bottomright,
      this.topleft,
      this.bottomleft,
      this.favontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 305,
      width: MediaQuery.of(context).size.width * 0.40,
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topleft == true ? 50 : 0),
          topRight: Radius.circular(topright == true ? 50 : 0),
          bottomLeft: Radius.circular(bottomleft == true ? 50 : 0),
          bottomRight: Radius.circular(bottomright == true ? 50 : 0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network(
              imgpath,
              height: 150,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              desc,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ ' + amt + ' each',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: favontap,
                  child: Icon(
                    fav == true ? Icons.favorite : Icons.favorite_border,
                    color: fav == true ? Colors.red : Colors.white,
                    size: 17,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ontap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "View more",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
