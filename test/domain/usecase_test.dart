import 'package:advice_clean_arch/data/repositories/advice_repo_impl.dart';
import 'package:advice_clean_arch/domain/entity/advice_entity.dart';
import 'package:advice_clean_arch/domain/usecases/advice_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoInplementation>()])
void main() {
  group("Advice usecase", () {
    test("Should return AdviceEntity", () async {
      final mockRepo = MockAdviceRepoInplementation();
      final usecaseUnderTest = AdviceUseCases(adviceRepo: mockRepo);
      when(mockRepo.getAdviceFromDataSource()).thenAnswer(
        (realInvocation) => Future.value(
          const Right(AdviceEntity(advice: "test", id: 1)),
        ),
      );
      final result = await usecaseUnderTest.getAdvice();
    });
  });
}
