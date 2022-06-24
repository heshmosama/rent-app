import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:rent_flutter_task/core/config/dio_configration.dart';
import 'package:rent_flutter_task/core/utils/constants.dart';
import 'di_configuration.config.dart';

final getIt = GetIt.instance;
@InjectableInit()
configureDependencies(String environment) =>
    $initGetIt(getIt, environment: environment);

@module
abstract class DataSourceModule {
  @Named("BaseUrl")
  String get baseUrl => dotenv.get('BASE_URL', fallback: url);

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => getDio(url);
}

@module
abstract class AppModule {
  @injectable
  Logger get logger => Logger();
}
