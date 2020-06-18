import 'package:json_annotation/json_annotation.dart';

part 'ingredient_model.g.dart';

@JsonSerializable()
class IngredientModel {
  String title;
  @JsonKey(name: "use-by")
  String useBy;
  @JsonKey(ignore: true)
  bool hasSelected;

  IngredientModel({
    this.title,
    this.useBy,
    this.hasSelected: false,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientModelToJson(this);
}
