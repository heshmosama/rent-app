import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rent_flutter_task/core/error/failures.dart';
import 'package:rent_flutter_task/core/usecase/base_usecase.dart';
import 'package:rent_flutter_task/features/home/domain/repositories/account_repository.dart';
import 'package:rent_flutter_task/features/home/domain/usecases/get_all_state_codes.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  late MockAccountRepository mockAccountRepository;
  late GetAllStateCodeUseCase getAllStateCodeUseCase;
  late List<int> stateCodesResponse = [0];

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    getAllStateCodeUseCase = GetAllStateCodeUseCase(mockAccountRepository);
  });

  group('get all state codes', () {
    test('get all state codes from repository.', () async {
      // arrange
      when(() => mockAccountRepository.getAllStateCodes())
          .thenAnswer((_) async => Right(stateCodesResponse));
      // act
      var result = await getAllStateCodeUseCase(NoParams());
      // assert
      expect(result, Right(stateCodesResponse));
      verify(() => mockAccountRepository.getAllStateCodes());
      verifyNoMoreInteractions(mockAccountRepository);
    });

    test('should return ServerFailure when repository failed to get accounts',
        () async {
      // arrange
      when(() => mockAccountRepository.getAllStateCodes())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      var result = await getAllStateCodeUseCase(NoParams());
      // assert
      expect(result, Left(ServerFailure()));
      verify(() => mockAccountRepository.getAllStateCodes());
      verifyNoMoreInteractions(mockAccountRepository);
    });
  });
}
