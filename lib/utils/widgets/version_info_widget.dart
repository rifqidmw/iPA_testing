import 'package:base_project_mvvm_provider/utils/extensions/string_extensions.dart';
import 'package:base_project_mvvm_provider/utils/models/package_info_model.dart';
import 'package:base_project_mvvm_provider/utils/utils/common.dart';
import 'package:base_project_mvvm_provider/utils/utils/text_styles.dart';
import 'package:base_project_mvvm_provider/utils/widgets/snap_helper_widget.dart';
import 'package:flutter/material.dart';

/// VersionInfoWidget
class VersionInfoWidget extends StatelessWidget {
  final String prefixText;
  final String suffixText;
  final TextStyle? textStyle;
  final bool showError;

  const VersionInfoWidget({
    this.textStyle,
    this.prefixText = '',
    this.suffixText = '',
    this.showError = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SnapHelperWidget<PackageInfoData>(
      future: getPackageInfo(),
      onSuccess: (data) {
        if (data.versionName.validate().isEmpty) return Offstage();

        return Text(
          '$prefixText${data.versionName.validate()}$suffixText',
          style: textStyle ?? primaryTextStyle(),
        );
      },
      errorWidget: showError ? null : Offstage(),
    );
  }
}
