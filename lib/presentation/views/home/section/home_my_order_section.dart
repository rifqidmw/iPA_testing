import 'package:base_flutter/core/utils/functions.dart';
import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/font_manager.dart';
import 'package:base_flutter/presentation/resources/strings_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class HomeMyOrderSection extends StatefulWidget {
  const HomeMyOrderSection({super.key});

  @override
  State<HomeMyOrderSection> createState() => _HomeMyOrderSectionState();
}

class _HomeMyOrderSectionState extends State<HomeMyOrderSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getString(AppStrings.myOrders),
            style: getBoldStyle(
                color: ColorManager.black,
                fontSize: 21,
                fontFamily: FontFamily.raleway),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              _buildOrderButton('To Pay'),
              const SizedBox(
                width: 8,
              ),
              _buildOrderButton('To Receive'),
              const SizedBox(
                width: 8,
              ),
              _buildOrderButton('To Review'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOrderButton(String title) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: ColorManager.blue2),
        child: Center(
          child: Text(
            title,
            style: getMediumStyle(
                color: ColorManager.sampleBlue1,
                fontSize: 16,
                fontFamily: FontFamily.raleway),
          ),
        ),
      ),
    );
  }
}
