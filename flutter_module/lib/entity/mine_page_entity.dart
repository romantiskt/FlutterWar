import 'package:json_annotation/json_annotation.dart';

part 'mine_page_entity.g.dart';

///  flutter packages pub run build_runner build 生成 xx.g.dart文件
@JsonSerializable()
class MinePageEntity extends Object {

  @JsonKey(name: 'modules')
  List<Modules> modules;

  MinePageEntity(this.modules,);

  factory MinePageEntity.fromJson(Map<String, dynamic> srcJson) => _$MinePageEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MinePageEntityToJson(this);

}


@JsonSerializable()
class Modules extends Object {

  @JsonKey(name: 'items')
  List<Items> items;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'title')
  String title;

  Modules(this.items,this.type,this.title);

  factory Modules.fromJson(Map<String, dynamic> srcJson) => _$ModulesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ModulesToJson(this);

}


@JsonSerializable()
class Items extends Object {

  @JsonKey(name: 'idType')
  String idType;

  @JsonKey(name: 'top_text')
  String topText;

  @JsonKey(name: 'vip_rank')
  String vipRank;

  @JsonKey(name: 'vip_text')
  String vipText;

  @JsonKey(name: 'vip_url')
  String vipUrl;

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'text')
  String text;

  @JsonKey(name: 'url')
  String url;

  Items(this.idType,this.topText,this.vipRank,this.vipText,this.vipUrl,this.image,this.text,this.url,);

  factory Items.fromJson(Map<String, dynamic> srcJson) => _$ItemsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);

}


