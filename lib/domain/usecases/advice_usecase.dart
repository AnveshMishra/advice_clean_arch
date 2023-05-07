import 'package:advice_clean_arch/core/failures/failures.dart';
import 'package:advice_clean_arch/data/repositories/advice_repo_impl.dart';
import 'package:advice_clean_arch/domain/entity/advice_entity.dart';
import 'package:dartz/dartz.dart';

//* contains bussiness logic/helper functions which can be used
//* in our bloc or cubit.

class AdviceUseCases {
  final AdviceRepoInplementation adviceRepo;

  AdviceUseCases({
    required this.adviceRepo,
  });
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    //* can be used to for some business logic
    return adviceRepo.getAdviceFromDataSource();
  }
}
