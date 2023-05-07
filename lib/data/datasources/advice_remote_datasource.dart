import 'dart:convert';

import 'package:advice_clean_arch/core/exceptions/custom_exceptions.dart';
import 'package:advice_clean_arch/data/model/advice_model.dart';
import 'package:http/http.dart' as http;

abstract class AdviceRemoteDataSource {
  Future getRandomAdviceFromApi();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final http.Client client;

  AdviceRemoteDataSourceImpl({required this.client});
  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse("https://api.flutter-community.com/api/v1/advice"),
      headers: {
        "content-type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final resposneBody = json.decode(response.body);
      AdviceModel adviceModel = AdviceModel.fromJson(resposneBody);
      return adviceModel;
    } else {
      throw ServerException();
    }
  }
}
