
import 'package:base_project_mvvm_provider/utils/utils.dart';

// num Extensions
extension NumExt on num? {
  /// Validate given double is not null and returns given value if null.
  num validate({num value = 0}) => this ?? value;

  /// Returns price with currency
  String toCurrencyAmount() => "$defaultCurrencySymbol${validate()}";
}
