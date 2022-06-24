// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i3;

import '../../features/home/data/datasource/remote/service/accounts_network_service.dart'
    as _i5;
import '../../features/home/data/datasource/remote/soruce/account_datasource_impl.dart'
    as _i7;
import '../../features/home/data/datasource/remote/soruce/accounts_datasource.dart'
    as _i6;
import '../../features/home/data/repositories/account_repository_impl.dart'
    as _i9;
import '../../features/home/domain/repositories/account_repository.dart' as _i8;
import '../../features/home/domain/usecases/get_all_accounts.dart' as _i10;
import '../../features/home/domain/usecases/get_all_province.dart' as _i11;
import '../../features/home/domain/usecases/get_all_state_codes.dart' as _i12;
import '../../features/home/presentation/bloc/accounts/accounts_bloc.dart'
    as _i15;
import '../../features/home/presentation/bloc/province/province_bloc.dart'
    as _i13;
import '../../features/home/presentation/bloc/state-code/state_code_bloc.dart'
    as _i14;
import 'di_configuration.dart' as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  final dataSourceModule = _$DataSourceModule();
  gh.factory<_i3.Logger>(() => appModule.logger);
  gh.factory<String>(() => dataSourceModule.baseUrl, instanceName: 'BaseUrl');
  gh.lazySingleton<_i4.Dio>(
      () => dataSourceModule.dio(get<String>(instanceName: 'BaseUrl')));
  gh.lazySingleton<_i5.AccountService>(
      () => _i5.AccountService(get<_i4.Dio>()));
  gh.lazySingleton<_i6.AccountsDataSource>(
      () => _i7.AccountDataSourceImpl(get<_i5.AccountService>()));
  gh.lazySingleton<_i8.AccountRepository>(() => _i9.AccountRepositoryImpl(
      get<_i6.AccountsDataSource>(), get<_i3.Logger>()));
  gh.lazySingleton<_i10.GetAllAccountsUseCase>(
      () => _i10.GetAllAccountsUseCase(get<_i8.AccountRepository>()));
  gh.lazySingleton<_i11.GetAllProvinceUseCase>(
      () => _i11.GetAllProvinceUseCase(get<_i8.AccountRepository>()));
  gh.lazySingleton<_i12.GetAllStateCodeUseCase>(
      () => _i12.GetAllStateCodeUseCase(get<_i8.AccountRepository>()));
  gh.lazySingleton<_i13.ProvincesBloc>(() =>
      _i13.ProvincesBloc(get<_i11.GetAllProvinceUseCase>(), get<_i3.Logger>()));
  gh.lazySingleton<_i14.StateCodeBloc>(() => _i14.StateCodeBloc(
      get<_i12.GetAllStateCodeUseCase>(), get<_i3.Logger>()));
  gh.lazySingleton<_i15.AccountsBloc>(() =>
      _i15.AccountsBloc(get<_i10.GetAllAccountsUseCase>(), get<_i3.Logger>()));
  return get;
}

class _$AppModule extends _i16.AppModule {}

class _$DataSourceModule extends _i16.DataSourceModule {}
