import 'package:advice_clean_arch/domain/entity/advice_entity.dart';
import 'package:dartz/dartz.dart';

import '../../core/failures/failures.dart';

abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource();
}
