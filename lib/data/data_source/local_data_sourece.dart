import 'package:base_flutter/data/responses/product/product_response.dart';
import 'package:base_flutter/presentation/resources/constants_manager.dart';

const int homeInterval = 60000;
const int storeDetailsInterval = 30000;

abstract class LocalDataSource {
  Future<void> saveProductsInCache(ProductResponse productResponse);
  void clearCache();
  void removeFromHomeCache(String key);
  void removeFromStoreDetailsCache(String key);
}

class LocalDataSourceImp implements LocalDataSource {
  Map<String, CachedItem> cachedItemMap = {};

  @override
  Future<void> saveProductsInCache(ProductResponse productResponse) async {
    cachedItemMap[AppConstants.productCacheDataKey] = CachedItem(productResponse);
  }

  @override
  void clearCache() {
    cachedItemMap.clear();
  }

  @override
  void removeFromHomeCache(String key) {
    cachedItemMap.remove(key);
  }

  @override
  void removeFromStoreDetailsCache(String key) {
    cachedItemMap.remove(key);
  }
}

class CachedItem {
  dynamic data;
  //time since saving data that comming from api to local data runtime based
  int cachCreationTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int determinedTime) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    return currentTime - cachCreationTime <= determinedTime;
  }
}
