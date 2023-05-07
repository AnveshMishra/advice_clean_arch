import 'package:advice_clean_arch/core/exceptions/custom_exceptions.dart';
import 'package:advice_clean_arch/data/datasources/advice_remote_datasource.dart';
import 'package:advice_clean_arch/data/model/advice_model.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'advice_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('AdviceRemoteDataSource', () {
    group('Should return advice model', () {
      test('when response code is 200', () async {
        final mockClient = MockClient();
        final adviceRemoteData = AdviceRemoteDataSourceImpl(client: mockClient);
        const responseBody = r'{"advice_id":7,"advice":"test advice"}';
        when(mockClient.get(
          Uri.parse("https://api.flutter-community.com/api/v1/advice"),
          headers: {
            "content-type": "application/json",
          },
        )).thenAnswer(
          (realInvocation) => Future.value(
            Response(responseBody, 200),
          ),
        );
        final result = await adviceRemoteData.getRandomAdviceFromApi();
        expect(
          result,
          AdviceModel(
            adviceId: 7,
            advice: "test advice",
          ),
        );
      });
      //! test (if status is not 200)
      test('when status code in not 200', () {
        final mockClient = MockClient();
        final adviceRemoteData = AdviceRemoteDataSourceImpl(client: mockClient);
        const responseBody = r'{"advice_id":7,"advice":"test advice"}';
        when(mockClient.get(
          Uri.parse("https://api.flutter-community.com/api/v1/advice"),
          headers: {
            "content-type": "application/json",
          },
        )).thenAnswer(
          (realInvocation) => Future.value(
            Response(responseBody, 400),
          ),
        );
        expect(
          () => adviceRemoteData.getRandomAdviceFromApi(),
          throwsA(
            isA<ServerException>(),
          ),
        );
      });
      // //! test if there is a type error
      // test(
      //     'when response code is 200 but there is some type error while parsing',
      //     () async {
      //   final mockClient = MockClient();
      //   final adviceRemoteData = AdviceRemoteDataSourceImpl(client: mockClient);
      //   const responseBody = r'{"advice_id":7}';
      //   when(mockClient.get(
      //     Uri.parse("https://api.flutter-community.com/api/v1/advice"),
      //     headers: {
      //       "content-type": "application/json",
      //     },
      //   )).thenAnswer(
      //     (realInvocation) => Future.value(
      //       Response(responseBody, 200),
      //     ),
      //   );
      //   final result = await adviceRemoteData.getRandomAdviceFromApi();
      //   expect(
      //     () => adviceRemoteData.getRandomAdviceFromApi(),
      //     isA<TypeError>(),
      //   );
      // });
    });
  });
}
