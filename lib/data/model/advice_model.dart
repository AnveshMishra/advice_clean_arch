import 'package:advice_clean_arch/domain/entity/advice_entity.dart';
import 'package:equatable/equatable.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  final int adviceId;
  final String advice;
  AdviceModel({
    required this.adviceId,
    required this.advice,
  }) : super(advice: advice, id: adviceId);

  factory AdviceModel.fromJson(Map<String, dynamic> json) => AdviceModel(
        adviceId: json["advice_id"],
        advice: json["advice"],
      );

  Map<String, dynamic> toJson() => {
        "advice_id": adviceId,
        "advice": advice,
      };
}
