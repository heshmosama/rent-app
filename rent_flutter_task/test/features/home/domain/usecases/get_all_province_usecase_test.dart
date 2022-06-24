import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rent_flutter_task/core/error/failures.dart';
import 'package:rent_flutter_task/core/usecase/base_usecase.dart';
import 'package:rent_flutter_task/features/home/domain/repositories/account_repository.dart';
import 'package:rent_flutter_task/features/home/domain/usecases/get_all_province.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  late MockAccountRepository mockAccountRepository;
  late GetAllProvinceUseCase getAllProvinceUseCase;
  late List<String> provinceResponse = ["WA"];

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    getAllProvinceUseCase = GetAllProvinceUseCase(mockAccountRepository);
  });

  group('get all province', () {
    test('get all province from repository.', () async {
      // arrange
      when(() => mockAccountRepository.getAllProvince())
          .thenAnswer((_) async => Right(provinceResponse));
      // act
      var result = await getAllProvinceUseCase(NoParams());
      // assert
      expect(result, Right(provinceResponse));
      verify(() => mockAccountRepository.getAllProvince());
      verifyNoMoreInteractions(mockAccountRepository);
    });

    test('should return ServerFailure when repository failed to get accounts',
        () async {
      // arrange
      when(() => mockAccountRepository.getAllProvince())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      var result = await getAllProvinceUseCase(NoParams());
      // assert
      expect(result, Left(ServerFailure()));
      verify(() => mockAccountRepository.getAllProvince());
      verifyNoMoreInteractions(mockAccountRepository);
    });
  });
}
