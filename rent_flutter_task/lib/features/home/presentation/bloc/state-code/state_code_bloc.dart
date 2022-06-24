import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:rent_flutter_task/core/usecase/base_usecase.dart';
import 'package:rent_flutter_task/features/home/domain/usecases/get_all_state_codes.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/state-code/state_code_event.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/state-code/state_code_states.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/builders.dart';

@lazySingleton
class StateCodeBloc extends Bloc<StateCodeEvent, StateCodeState> {
  final GetAllStateCodeUseCase _getAllStateCodeUseCase;
  final Logger? _logger;

  StateCodeBloc(this._getAllStateCodeUseCase, this._logger) : super(Empty()) {
    on<GetAllStateCodeEvent>((event, emit) => mapEventToState(emit, event));
  }

  void mapEventToState(
      Emitter<StateCodeState> emit, GetAllStateCodeEvent event) async {
    emit(Loading());
    var response = await _getAllStateCodeUseCase.call(NoParams());
    _logger?.d('response', response);
    var failureOrData = await _eitherLoadedOrErrorState(response);
    emit(failureOrData);
  }

  Future<StateCodeState> _eitherLoadedOrErrorState(
    Either<Failure, List<int>> failureOrTrivia,
  ) async =>
      failureOrTrivia.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (codes) => Loaded(codes: codes),
      );
}
