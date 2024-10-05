import 'package:base_flutter/core/utils/extensions.dart';
import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationBarComponent extends StatefulWidget {
  final List<BottomNavigationBarConfig> items;
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavigationBarComponent({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  State<BottomNavigationBarComponent> createState() => _BottomNavigationBarComponentState();
}

class _BottomNavigationBarComponentState extends State<BottomNavigationBarComponent> {

  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.blue10,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.items.asMap().entries.map((entry) {
            int idx = entry.key;
            BottomNavigationBarConfig item = entry.value;
            return InkWell(
              onTap: () {
                setState(() {
                        _selectedIndex = idx;
                      });
                      widget.onItemTapped(idx);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(item.image, width: 20, height: 20, colorFilter: ColorFilter.mode(
                      _selectedIndex == idx ? ColorManager.blue4 : ColorManager.neutral1, BlendMode.srcIn),),
                    const SizedBox(height: 6,),
                    Text(
                      item.label.orEmpty(),
                      style: getMediumStyle(color: _selectedIndex == idx ? ColorManager.blue4 : ColorManager.neutral1, fontSize: 12),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BottomNavigationBarConfig {
  final int id;
  final String label;
  final String image;

  BottomNavigationBarConfig({required this.id, required this.label, required this.image});
}
