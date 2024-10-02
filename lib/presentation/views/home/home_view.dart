import 'package:base_flutter/domain/models/product_model.dart';
import 'package:base_flutter/presentation/resources/assets_manager.dart';
import 'package:base_flutter/presentation/resources/color_manager.dart';
import 'package:base_flutter/presentation/resources/font_manager.dart';
import 'package:base_flutter/presentation/resources/routes_manager.dart';
import 'package:base_flutter/presentation/resources/styles_manager.dart';
import 'package:base_flutter/presentation/views/home/section/home_my_order_section.dart';
import 'package:base_flutter/presentation/views/home/section/home_product_section.dart';
import 'package:base_flutter/presentation/widgets/card/avatar_card.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/core/di/dependency_injection.dart';
import 'package:base_flutter/presentation/views/home/home_viewmodel.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/state_renderer/state_renderer_imp.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _homeViewModel = dIinstance<HomeViewModel>();

  _bind() {
    _homeViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: null,
        actions: [
          const SizedBox(width: 8,),
          const AvatarCard(
            imagePath: ImageAssets.sampleAvatar,
            size: 40,
            elevation: 0,
          ),
          Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: ColorManager.sampleBlue1),
            child: Center(
              child: Text(
                'My Activity',
                style: getMediumStyle(
                    color: ColorManager.white,
                    fontSize: 16,
                    fontFamily: FontFamily.raleway),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.settingRoute);
              },
              icon: SvgPicture.asset(ImageAssets.icSettingCircle)),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(ImageAssets.icMessageCircle)),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(ImageAssets.icVoucherCircle)),
        ],
      ),
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const HomeMyOrderSection(),
            const SizedBox(
              height: 25,
            ),
            StreamBuilder<FlowState>(stream: _homeViewModel.stateOutput, builder: (context, snapshot) {
              return snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
                _homeViewModel.start();
              }) ?? _getContentWidget();
            },),
          ],
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<List<ProductModel>>(
      stream: _homeViewModel.outputListProduct,
      builder: (context, snapshot) => HomeProductSection(listProduct: snapshot.data??[])
    );
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }
}
