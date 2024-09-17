enum Flavor {
  sit,
  uat,
  preprod,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.sit:
        return 'Base Flutter SIT';
      case Flavor.uat:
        return 'Base Flutter UAT';
      case Flavor.preprod:
        return 'Base Flutter PreProd';
      case Flavor.prod:
        return 'Base Flutter Prod';
      default:
        return 'title';
    }
  }

}
