import 'package:base_flutter/core/utils/extensions.dart';
import 'package:base_flutter/data/responses/login/login_response.dart';
import 'package:base_flutter/data/responses/product/product_response.dart';
import 'package:base_flutter/domain/models/product_model.dart';
import 'package:base_flutter/domain/models/user_model.dart';
import 'package:base_flutter/presentation/resources/constants_manager.dart';

extension LoginResponseMapper on LoginResponse? {
  UserModel toDomain() {
    return UserModel(
        id: this?.id.orZero() ?? AppConstants.zero,
        username: this?.username.orEmpty() ?? AppConstants.empty,
        email: this?.email.orEmpty() ?? AppConstants.empty,
        firstName: this?.firstName.orEmpty() ?? AppConstants.empty,
        lastName: this?.lastName.orEmpty() ?? AppConstants.empty,
        gender: this?.gender.orEmpty() ?? AppConstants.empty,
        image: this?.image.orEmpty() ?? AppConstants.empty,
        token: this?.token.orEmpty() ?? AppConstants.empty,
        refreshToken: this?.refreshToken.orEmpty() ?? AppConstants.empty);
  }
}

extension ProductResponseMapper on ProductResponse? {
  List<ProductModel> toDomain() {
    if (this == null) {
      return [];
    }
    
    return this!.products!.map((e) {
      return ProductModel(
        title: e.title.orEmpty(),
        price: e.price.orZero(),
        images: e.thumbnail.orEmpty()
      );
    }).toList();
  } 
}