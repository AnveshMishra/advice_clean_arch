import 'package:advice_clean_arch/data/datasources/advice_remote_datasource.dart';
import 'package:advice_clean_arch/data/repositories/advice_repo_impl.dart';
import 'package:advice_clean_arch/domain/usecases/advice_usecase.dart';
import 'package:advice_clean_arch/presentation/pages/advice/bloc/advice_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I; // service locator

Future<void> initDependencies() async {
  //* Application Layer:
  sl.registerFactory(
    () => AdviceBloc(
      adviceUseCases: sl(),
    ),
  );

  //* domain layer:
  sl.registerFactory(
    () => AdviceUseCases(
      adviceRepo: sl(),
    ),
  );

  //* data layer:

  sl.registerFactory(
    () => AdviceRepoInplementation(
      dataSource: AdviceRemoteDataSourceImpl(
        client: sl(),
      ),
    ),
  );

  //* external:
  sl.registerFactory(
    () => http.Client(),
  );
}
