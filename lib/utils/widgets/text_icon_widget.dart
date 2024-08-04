import 'package:base_project_mvvm_provider/utils/extensions/int_extensions.dart';
import 'package:base_project_mvvm_provider/utils/extensions/string_extensions.dart';
import 'package:base_project_mvvm_provider/utils/extensions/widget_extensions.dart';
import 'package:base_project_mvvm_provider/utils/utils/text_styles.dart';
import 'package:base_project_mvvm_provider/utils/widgets/marquee_widget.dart';
import 'package:flutter/material.dart';

// TextIcon
class TextIcon extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final Widget? prefix;
  final Widget? suffix;
  final int spacing;
  final int? maxLine;
  final Function? onTap;
  final EdgeInsets? edgeInsets;
  final bool expandedText;
  final bool useMarquee;
  final BoxDecoration? boxDecoration;

  TextIcon({
    this.text,
    this.textStyle,
    this.prefix,
    this.suffix,
    this.spacing = 4,
    this.maxLine,
    this.onTap,
    this.edgeInsets,
    this.expandedText = false,
    this.useMarquee = false,
    this.boxDecoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets ?? EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: boxDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          prefix != null ? Row(children: [prefix!, spacing.width]) : SizedBox(),
          if (expandedText && useMarquee)
            Marquee(child: buildText()).expand()
          else if (useMarquee)
            Marquee(child: buildText())
          else if (expandedText)
            buildText().expand()
          else
            buildText(),
          suffix != null ? Row(children: [spacing.width, suffix!]) : SizedBox(),
        ],
      ),
    ).onTap(onTap);
  }

  /// build Text widget
  Widget buildText() {
    return Text(
      text.validate(),
      style: textStyle ?? primaryTextStyle(),
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}
