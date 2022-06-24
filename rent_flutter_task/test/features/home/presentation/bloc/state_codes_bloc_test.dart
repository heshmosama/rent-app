import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rent_flutter_task/core/error/failures.dart';
import 'package:rent_flutter_task/core/usecase/base_usecase.dart';
import 'package:rent_flutter_task/core/utils/constants.dart';
import 'package:rent_flutter_task/features/home/domain/usecases/get_all_state_codes.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/state-code/state_code_bloc.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/state-code/state_code_event.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/state-code/state_code_states.dart';

class MockGetAllStateCodeUseCase extends Mock
    implements GetAllStateCodeUseCase {}

void main() {
  late MockGetAllStateCodeUseCase mockGetAllStateCodeUseCase;
  late StateCodeBloc stateCodeBloc;
  late List<int> stateCodeResponse = [0];

  setUp(() {
    mockGetAllStateCodeUseCase = MockGetAllStateCodeUseCase();
    stateCodeBloc = StateCodeBloc(mockGetAllStateCodeUseCase, null);
  });

  void setUpMockGetAllStateCodesSuccess() =>
      when(() => mockGetAllStateCodeUseCase(NoParams()))
          .thenAnswer((_) async => Right(stateCodeResponse));
  group('get all state codes', () {
    test('should call use-case to get data', () async {
      // arrange
      setUpMockGetAllStateCodesSuccess();
      // act
      stateCodeBloc.add(GetAllStateCodeEvent());
      await untilCalled(() => mockGetAllStateCodeUseCase(NoParams()));
      // assert
      verify(() => mockGetAllStateCodeUseCase(NoParams()));
    });

    test(
      'should emit [Error] when the input is invalid',
      () {
        // arrange
        when(() => mockGetAllStateCodeUseCase(NoParams()))
            .thenAnswer((invocation) async => Left(ServerFailure()));

        // assert later
        var expected = [
          Loading(),
          Error(message: server_failure_message),
        ];
        expectLater(stateCodeBloc.stream, emitsInOrder(expected));
        // act
        stateCodeBloc.add(GetAllStateCodeEvent());
      },
    );

    test(
      'should emit [loaded] when the input is valid.',
      () {
        // arrange
        setUpMockGetAllStateCodesSuccess();

        // assert later
        var expected = [
          Loading(),
          Loaded(codes: stateCodeResponse),
        ];
        expectLater(stateCodeBloc.stream, emitsInOrder(expected));
        // act
        stateCodeBloc.add(GetAllStateCodeEvent());
      },
    );
  });
}
