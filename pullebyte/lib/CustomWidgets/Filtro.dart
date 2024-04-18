import 'package:flutter/material.dart';

class FiltroTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            50,
            (index) => Container(
              width: 120,
              height: 60,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 17, 17, 17),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 3,
                  color: Colors.orange,
                ),
              ),
              child: Center(
                child: Text('Item $index'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
