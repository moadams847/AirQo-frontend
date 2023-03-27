import 'package:json_annotation/json_annotation.dart';

part 'health_tip.g.dart';

@JsonSerializable(createToJson: false)
class HealthTip {
  HealthTip({
    required this.name,
    required this.description,
    required this.image,
  });

  @JsonKey()
  final String name;

  @JsonKey()
  final String description;

  @JsonKey()
  final String image;

  factory HealthTip.fromJson(Map<String, dynamic> json) =>
      _$HealthTipFromJson(json);
}
