import 'package:base_flutter/core/utils/functions.dart';
import 'package:base_flutter/domain/models/product_model.dart';
import 'package:base_flutter/presentation/resources/assets_manager.dart';
import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/font_manager.dart';
import 'package:base_flutter/presentation/resources/strings_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class HomeProductSection extends StatefulWidget {
  const HomeProductSection({super.key, required this.listProduct});

  final List<ProductModel> listProduct;

  @override
  State<HomeProductSection> createState() => _HomeProductSectionState();
}

class _HomeProductSectionState extends State<HomeProductSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getString(AppStrings.justForYou),
            style: getBoldStyle(
                color: ColorManager.black,
                fontSize: 21,
                fontFamily: FontFamily.raleway),
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.listProduct.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              return _buildProductItem(widget.listProduct[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: ColorManager.white, width: 4)),
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: double.infinity,
            height: 180,
            child: Image.network(
              product.images,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.title,
          style: getRegularStyle(
              color: ColorManager.black,
              fontSize: 12,
              fontFamily: FontFamily.nunitoSans),
        ),
        const SizedBox(height: 4),
        Text(
          '\$${product.price}',
          style: getBoldStyle(
              color: ColorManager.black,
              fontSize: 17,
              fontFamily: FontFamily.raleway),
        )
      ],
    );
  }
}
