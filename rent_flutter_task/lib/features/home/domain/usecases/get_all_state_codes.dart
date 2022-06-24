import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/account_repository.dart';

@lazySingleton
class GetAllStateCodeUseCase implements BaseUseCase<List<int>, NoParams> {
  final AccountRepository _accountRepository;
  GetAllStateCodeUseCase(this._accountRepository);

  @override
  Future<Either<Failure, List<int>>> call(NoParams params) async =>
      _accountRepository.getAllStateCodes();
}
