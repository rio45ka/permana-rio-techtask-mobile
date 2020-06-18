// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) {
  return RecipeModel(
    title: json['title'] as String,
    desc: json['desc'] as String,
    ingredients:
        (json['ingredients'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'desc': instance.desc,
      'ingredients': instance.ingredients,
    };
