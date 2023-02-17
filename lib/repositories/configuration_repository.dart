import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigurationRepository {
  static Configuration? currentConfiguration;

  static loadEnvFile() async {
    await dotenv.load(fileName: '.env');

    currentConfiguration = Configuration(
      userName: dotenv.get('USER_NAME'),
      passWord: dotenv.get('PASSWORD'),
    );
  }

  static Configuration get() {
    return currentConfiguration!;
  }
}

class Configuration {
  String userName;
  String passWord;

  Configuration({
    required this.userName,
    required this.passWord,
  });
}
