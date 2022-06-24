import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/account_repository.dart';

@lazySingleton
class GetAllProvinceUseCase implements BaseUseCase<List<String>, NoParams> {
  final AccountRepository _accountRepository;
  GetAllProvinceUseCase(this._accountRepository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async =>
      _accountRepository.getAllProvince();
}
