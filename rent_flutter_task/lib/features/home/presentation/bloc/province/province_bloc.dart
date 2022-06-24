import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:rent_flutter_task/core/usecase/base_usecase.dart';
import 'package:rent_flutter_task/features/home/domain/usecases/get_all_province.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/province/province_event.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/province/province_state.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/builders.dart';

@lazySingleton
class ProvincesBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final GetAllProvinceUseCase _getAllProvinceUseCase;
  final Logger? _logger;

  ProvincesBloc(this._getAllProvinceUseCase, this._logger) : super(Empty()) {
    on<GetAllProvinceEvent>((event, emit) => mapEventToState(emit, event));
  }

  void mapEventToState(
      Emitter<ProvinceState> emit, GetAllProvinceEvent event) async {
    emit(Loading());
    var response = await _getAllProvinceUseCase.call(NoParams());
    _logger?.d('response', response);
    var failureOrData = await _eitherLoadedOrErrorState(response);
    emit(failureOrData);
  }

  Future<ProvinceState> _eitherLoadedOrErrorState(
    Either<Failure, List<String>> failureOrTrivia,
  ) async =>
      failureOrTrivia.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (provinces) => Loaded(provinces: provinces),
      );
}
