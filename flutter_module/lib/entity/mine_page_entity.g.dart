// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mine_page_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinePageEntity _$MinePageEntityFromJson(Map<String, dynamic> json) {
  return MinePageEntity(
    (json['modules'] as List)
        ?.map((e) =>
            e == null ? null : Modules.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MinePageEntityToJson(MinePageEntity instance) =>
    <String, dynamic>{
      'modules': instance.modules,
    };

Modules _$ModulesFromJson(Map<String, dynamic> json) {
  return Modules(
    (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Items.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['type'] as String,
    json['title'] as String,
  );
}

Map<String, dynamic> _$ModulesToJson(Modules instance) => <String, dynamic>{
      'items': instance.items,
      'type': instance.type,
      'title': instance.title,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return Items(
    json['idType'] as String,
    json['top_text'] as String,
    json['vip_rank'] as String,
    json['vip_text'] as String,
    json['vip_url'] as String,
    json['image'] as String,
    json['text'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'idType': instance.idType,
      'top_text': instance.topText,
      'vip_rank': instance.vipRank,
      'vip_text': instance.vipText,
      'vip_url': instance.vipUrl,
      'image': instance.image,
      'text': instance.text,
      'url': instance.url,
    };
