import 'package:advice_clean_arch/core/exceptions/custom_exceptions.dart';
import 'package:advice_clean_arch/core/failures/failures.dart';
import 'package:advice_clean_arch/data/datasources/advice_remote_datasource.dart';
import 'package:advice_clean_arch/data/model/advice_model.dart';
import 'package:advice_clean_arch/data/repositories/advice_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// import 'package:test/test.dart';

import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDataSourceImpl>()])
void main() {
  group("Advice repo impl", () {
    group('Should return AdviceEntity', () {
      test('when data source returns a advice model', () async {
        final mockDataSource = MockAdviceRemoteDataSourceImpl();
        final adviceRepo = AdviceRepoInplementation(dataSource: mockDataSource);
        when(mockDataSource.getRandomAdviceFromApi()).thenAnswer(
          (realInvocation) => Future.value(
            AdviceModel(advice: 'test', adviceId: 2),
          ),
        );
        final result = await adviceRepo.getAdviceFromDataSource();
        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
          result,
          Right<Failure, AdviceModel>(
            AdviceModel(advice: 'test', adviceId: 2),
          ),
        );
        verify(mockDataSource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      });

      test('When repo return failure', () async {
        final mockDataSouce = MockAdviceRemoteDataSourceImpl();
        AdviceRepoInplementation repo =
            AdviceRepoInplementation(dataSource: mockDataSouce);
        when(mockDataSouce.getRandomAdviceFromApi()).thenAnswer(
          (realInvocation) => Future.error(ServerException()),
        );
        final result = await repo.getAdviceFromDataSource();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(
          result,
          Left<Failure, AdviceModel>(AdviceFailure()),
        );
      });
    });
  });
}
