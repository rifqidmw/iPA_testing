import 'package:flutter/material.dart';

class ProgressTrackerModel {
  final String name;
  final IconData? icon;
  bool? active;

  ProgressTrackerModel({
    required this.name,
    required this.icon,
    this.active = false,
  });
}

class ProgressTrackerComponent extends StatelessWidget {
  final int currentIndex;

  final List<ProgressTrackerModel> statusList;
  final Color? activeColor;
  final Color? inActiveColor;

  final double height = 100;

  const ProgressTrackerComponent({
    Key? key,
    required this.currentIndex,
    required this.statusList,
    this.activeColor = Colors.green,
    this.inActiveColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < statusList.length; i++) {
      if (i == 0) {
        statusList[i].active = true;
      } else {
        if (statusList[i].active!) {
          statusList[i].active = i <= currentIndex;
        }
      }
    }

    return LayoutBuilder(builder: (_, BoxConstraints box) {
      final count = (box.constrainWidth() / (1.4 * 8.0)).floor();

      return SizedBox(
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: List.generate(count, (_) {
                return SizedBox(
                  width: 10.0,
                  height: 2.8,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }),
            ),
            Positioned(
              top: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(statusList.length, (index) {
                    return trackProgress(statusList[index], index);
                  }),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget trackProgress(ProgressTrackerModel status, int index) {
    final statusCount = statusList.length;

    return Expanded(
      child: SizedBox(
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Icon(
                status.icon,
                size: 26,
                color: status.active! ? activeColor : inActiveColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: status.active! && index < statusCount,
                  child: Expanded(
                    child: Container(
                      height: 3.2,
                      decoration: BoxDecoration(
                        color: status.active! ? activeColor : inActiveColor,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.circle,
                  color: status.active! ? activeColor : inActiveColor,
                  size: 22,
                ),
                Visibility(
                  visible: status.active! && index < statusCount,
                  child: Expanded(
                    child: Container(
                      height: 3.2,
                      decoration: BoxDecoration(
                        color: currentIndex != index ||
                                currentIndex + 1 == statusCount
                            ? activeColor
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Display the label or name of the step.
            Positioned(
              bottom: 0,
              child: Text(
                status.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: status.active! ? activeColor : inActiveColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
How to Use
final List<ProgressTrackerModel> statuList = [
    ProgressTrackerModel(name: 'ORDER', icon: Icons.shopping_bag),
    ProgressTrackerModel(name: 'SHIP', icon: Icons.local_shipping),
    ProgressTrackerModel(name: 'DONE', icon: Icons.check_circle),
  ];

int index = 0;

  void nextButton() {
    setState(() {
      index++;
      statuList[index].active = true;
    });
  }

ProgressTrackerComponent(currentIndex: index, statusList: statuList),
*/