import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Page'),
        backgroundColor: Colors.amber.shade100,
        foregroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              buildReviewContainer(
                starsQuantity: 5,
                starsSize: 18.0,
                starsColor: Colors.yellow,
                text:
                    '"The staff was friendly, knowledgeable, \nand went above and beyond to ensure \nI had the right vehicle for my needs." ',
              ),
              SizedBox(height: 20),
              buildReviewContainer(
                starsQuantity: 4,
                starsSize: 15.0,
                starsColor: Colors.yellow,
                text:
                    '"The quality of the rental vehicle exceeded my expectations. \nI felt safe and comfortable."',
              ),
              SizedBox(height: 20),
              buildReviewContainer(
                starsQuantity: 5,
                starsSize: 15.0,
                starsColor: Colors.yellow,
                text:
                    '"The online reservation system is user-friendly,\nand the pickup and drop-off process was quick and efficient.\nNo hidden fees or surprises, \njust a straightforward and reliable service."',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReviewContainer({
    required int starsQuantity,
    required double starsSize,
    required Color starsColor,
    required String text,
  }) {
    List<Widget> starIcons = List.generate(
      starsQuantity,
      (index) => Icon(
        Icons.star,
        size: starsSize,
        color: starsColor,
      ),
    );

    return Container(
      width: 350,
      height: 150,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8.0,
            spreadRadius: 1.0,
            offset: Offset(0, 1),
          ),
        ],
        color: Colors.blue.shade50,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: starIcons,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1.0,
                color: Color.fromARGB(255, 65, 64, 64),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
