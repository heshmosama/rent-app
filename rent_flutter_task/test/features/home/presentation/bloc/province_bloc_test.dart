import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rent_flutter_task/core/error/failures.dart';
import 'package:rent_flutter_task/core/usecase/base_usecase.dart';
import 'package:rent_flutter_task/core/utils/constants.dart';
import 'package:rent_flutter_task/features/home/domain/usecases/get_all_province.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/province/province_bloc.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/province/province_event.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/province/province_state.dart';

class MockGetAllProvinceUseCase extends Mock implements GetAllProvinceUseCase {}

void main() {
  late MockGetAllProvinceUseCase mockGetAllProvinceUseCase;
  late ProvincesBloc provincesBloc;
  late List<String> provinceResponse = ['WA'];

  setUp(() {
    mockGetAllProvinceUseCase = MockGetAllProvinceUseCase();
    provincesBloc = ProvincesBloc(mockGetAllProvinceUseCase, null);
  });

  void setUpMockGetAllProvincesSuccess() =>
      when(() => mockGetAllProvinceUseCase(NoParams()))
          .thenAnswer((_) async => Right(provinceResponse));
  group('get all province', () {
    test('should call use-case to get data', () async {
      // arrange
      setUpMockGetAllProvincesSuccess();
      // act
      provincesBloc.add(GetAllProvinceEvent());
      await untilCalled(() => mockGetAllProvinceUseCase(NoParams()));
      // assert
      verify(() => mockGetAllProvinceUseCase(NoParams()));
    });

    test(
      'should emit [Error] when the input is invalid',
      () {
        // arrange
        when(() => mockGetAllProvinceUseCase(NoParams()))
            .thenAnswer((invocation) async => Left(ServerFailure()));

        // assert later
        var expected = [
          Loading(),
          Error(message: server_failure_message),
        ];
        expectLater(provincesBloc.stream, emitsInOrder(expected));
        // act
        provincesBloc.add(GetAllProvinceEvent());
      },
    );

    test(
      'should emit [loaded] when the input is valid.',
      () {
        // arrange
        setUpMockGetAllProvincesSuccess();

        // assert later
        var expected = [
          Loading(),
          Loaded(provinces: provinceResponse),
        ];
        expectLater(provincesBloc.stream, emitsInOrder(expected));
        // act
        provincesBloc.add(GetAllProvinceEvent());
      },
    );
  });
}
