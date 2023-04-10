import 'package:flutter/material.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  double currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Text("0:00"),
                Slider(
                  mouseCursor: MouseCursor.defer,
                  value: currentSliderValue,
                  max: 100,
                  divisions: 5,
                  label: currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      currentSliderValue = value;
                    });
                  },
                ),
                Text("0:00")
              ],
            )
            // Expanded(
            //   child: Container(
            //     height: 300,
            //     width: 300,
            //     decoration: BoxDecoration(
            //       color: Colors.black12,
            //       shape: BoxShape.circle,
            //     ),
            //   ),
            // ),
            // Expanded(
            //   child: Container(
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //       color: Colors.black12,
            //       shape: BoxShape.rectangle,
            //       borderRadius: BorderRadius.all(Radius.circular(20)),
            //     ),
            //     child: Column(
            //       children: [
            //         Text(
            //           "Song Name",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(fontSize: 25, color: Colors.black),
            //         ),
            //         Text(
            //           "Artist Name",
            //           style: TextStyle(
            //             fontSize: 22,
            //             color: Colors.black,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
