import 'package:advice_clean_arch/data/datasources/advice_remote_datasource.dart';
import 'package:advice_clean_arch/domain/entity/advice_entity.dart';
import 'package:advice_clean_arch/core/failures/failures.dart';
import 'package:advice_clean_arch/domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

import '../../core/exceptions/custom_exceptions.dart';

class AdviceRepoInplementation extends AdviceRepo {
  final AdviceRemoteDataSource dataSource;

  AdviceRepoInplementation({required this.dataSource});
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      final result = await dataSource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(AdviceFailure());
    } catch (e) {
      return left(AdviceFailure());
    }
  }
}
