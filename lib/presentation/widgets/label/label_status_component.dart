import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/widgets.dart';

class LabelStatusComponent extends StatelessWidget {
  const LabelStatusComponent({super.key, required this.config});

  final LabelStatusConfig config;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: config.backgroundColor
      ),
      child: Center(
        child: Text(
          config.title,
          style: getRegularStyle(color: config.textColor),
        ),
      ),
    );
  }
}

enum LabelStatusConfig {
  open(title: 'Open', textColor: ColorManager.warning7, backgroundColor: ColorManager.warning1),
  close(title: 'Close', textColor: ColorManager.green8, backgroundColor: ColorManager.green1),
  inactive(title: 'Inactive', textColor: ColorManager.secondary5, backgroundColor: ColorManager.secondary1),
  approved(title: 'Approved', textColor: ColorManager.error7, backgroundColor: ColorManager.error1);

  final String title;
  final Color textColor;
  final Color backgroundColor;

  const LabelStatusConfig({required this.title, required this.textColor, required this.backgroundColor});
}