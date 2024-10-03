import 'package:flutter/material.dart';

class CardScrollView extends StatefulWidget {
  @override
  _CardScrollViewState createState() => _CardScrollViewState();
}

class _CardScrollViewState extends State<CardScrollView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar notas...',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print('Search icon pressed');
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListWheelScrollView(
            itemExtent: 120,
            diameterRatio: 2.5,
            physics: FixedExtentScrollPhysics(),
            children: List.generate(10, (index) => _buildCard(index)),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        color: Color.fromARGB(128, 127, 134, 238),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'History Test',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.attachment,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                '10:30 hrs, to 11:30 hrs.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
