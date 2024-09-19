enum Environment { sit, uat, preprod, prod }

abstract class AppEnvironment {
  static late String baseApiUrl;
  static late String title;
  static late Environment _environment;
  static Environment get environment => _environment;
  static setupEnv(Environment env) {
    _environment = env;
    switch (env) {
      case Environment.sit:
        {
          baseApiUrl = 'https://sit.dummyjson.com';
          title = 'SIT';
          break;
        }
      case Environment.uat:
        {
          baseApiUrl = 'https://uat.dummyjson.com';
          title = 'UAT';
          break;
        }
      case Environment.preprod:
        {
          baseApiUrl = 'https://preprod.dummyjson.com';
          title = 'PRE PROD';
          break;
        }
      case Environment.prod:
        {
          baseApiUrl = 'https://dummyjson.com';
          title = 'PROD';
          break;
        }
    }
  }
}
