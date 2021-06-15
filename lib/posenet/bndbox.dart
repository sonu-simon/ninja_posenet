import 'package:flutter/material.dart';
import 'package:flutter_fruit_ninja_clone/canvas_area/canvas_area.dart';

class BndBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  BndBox(
    this.results,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW,
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      results.forEach((re) {
        // print(re);
        Offset point;
        print(
            'leftShoulder: ${re['keypoints'][5]['x']} , ${re['keypoints'][5]['y']}');
        var _x = ((re['keypoints'][5]['x'] + re['keypoints'][6]['x']) / 2);
        var _y = ((re['keypoints'][5]['y'] + re['keypoints'][6]['y']) / 2);

        var scaleW, scaleH, x, y;

        if (screenH / screenW > previewH / previewW) {
          scaleW = screenH / previewH * previewW;
          scaleH = screenH;
          var difW = (scaleW - screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          y = _y * scaleH;
        } else {
          scaleH = screenW / previewW * previewH;
          scaleW = screenW;
          var difH = (scaleH - screenH) / scaleH;
          x = _x * scaleW;
          y = (_y - difH / 2) * scaleH;
        }

        //Add the x,y to the touchslice to cut the fruits
        point = Offset(x, y);
        if (touchSlice.pointsList.length > 16) {
          touchSlice.pointsList.removeAt(0);
        }
        touchSlice.pointsList.add(point);

        lists = [
          Positioned(
            left: x - 6,
            top: y - 6,
            width: 100,
            height: 12,
            child: Container(
              child: Text(
                "● keyPoint",
                style: TextStyle(
                  color: Color.fromRGBO(37, 213, 253, 1.0),
                  fontSize: 12.0,
                ),
              ),
            ),
          )
        ];
      });

      return lists;
    }

    return Stack(children: _renderKeypoints());
  }
}
