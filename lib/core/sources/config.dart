enum Env { dev, stg, prod }

class Config {
  String baseUrl;

  Config({
    required this.baseUrl,
  });

  static var currentEnv = Env.dev;

  static Config get currentConfig {
    switch (currentEnv) {
      case Env.dev:
        return dev;
      case Env.stg:
        return stg;
      case Env.prod:
        return prod;
    }
  }

  static Config get dev => Config(
        baseUrl: 'http://192.168.123.226:8080',
      );

  static Config get stg => Config(
        baseUrl: 'http://myzen8labs.try0.xyz',
      );

  static Config get prod => Config(
        baseUrl: 'http://myzen8labs.try0.xyz',
      );
}
