import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyRadioList {
  List<MyRadio> radios ;

  MyRadioList({
    @required this.radios,
  });

  MyRadioList copyWith({List<MyRadio> radios}){
    return MyRadioList(radios: radios ?? this.radios);
  }
  Map<String, dynamic> toMap() {
    return {
      'radios': radios?.map((x) => x.toMap())?.toList(),
    };
  }

  

  factory MyRadioList.fromMap(Map<String, dynamic> map) {
    return MyRadioList(
      radios: List<MyRadio>.from(map['radios']?.map((x) => MyRadio.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadioList.fromJson(String source) => MyRadioList.fromMap(json.decode(source));

  @override
  String toString() => 'MyRadioList(: $radios)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MyRadioList &&
      listEquals(other.radios,radios );
  }

  @override
  int get hashCode => radios.hashCode;
}

class MyRadio {
final int id;
final String name;
final String tagLine;
final String color;
final String desc;
final String url;
final String icon;
final String image;
final String lang;
final String category;
final bool dislike;
final int order ;
  MyRadio({
    @required this.id,
    @required this.name,
    @required this.tagLine,
    @required this.color,
    @required this.desc,
    @required this.url,
    @required this.icon,
    @required this.image,
    @required this.lang,
    @required this.category,
    @required this.dislike,
    @required this.order,
  });



  MyRadio copyWith({
    int  id,
    String name,
    String tagLine,
    String color,
    String desc,
    String url,
    String icon,
    String image,
    String lang,
    String category,
    bool dislike,
    int order ,
  }) {
    return MyRadio(
      id: id ?? this.id,
      name: name ?? this.name,
      tagLine: tagLine ?? this.tagLine,
      color: color ?? this.color,
      desc: desc ?? this.desc,
      url: url ?? this.url,
      icon: icon ?? this.icon,
      image: image ?? this.image,
      lang: lang ?? this.lang,
      category: category ?? this.category,
      dislike: dislike ?? this.dislike,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tagLine': tagLine,
      'color': color,
      'desc': desc,
      'url': url,
      'icon': icon,
      'image': image,
      'lang': lang,
      'category': category,
      'dislike': dislike,
      'order': order,
    };
  }

  factory MyRadio.fromMap(Map<String, dynamic> map) {
    return MyRadio(
      id: map['id'],
      name: map['name'],
      tagLine: map['tagLine'],
      color: map['color'],
      desc: map['desc'],
      url: map['url'],
      icon: map['icon'],
      image: map['image'],
      lang: map['lang'],
      category: map['category'],
      dislike: map['dislike'],
      order: map['order'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadio.fromJson(String source) => MyRadio.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Radio(id: $id, name: $name, tagLine: $tagLine, color: $color, desc: $desc, url: $url, icon: $icon, image: $image, lang: $lang, category: $category, dislike: $dislike, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MyRadio &&
      other.id == id &&
      other.name == name &&
      other.tagLine == tagLine &&
      other.color == color &&
      other.desc == desc &&
      other.url == url &&
      other.icon == icon &&
      other.image == image &&
      other.lang == lang &&
      other.category == category &&
      other.dislike == dislike &&
      other.order == order;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      tagLine.hashCode ^
      color.hashCode ^
      desc.hashCode ^
      url.hashCode ^
      icon.hashCode ^
      image.hashCode ^
      lang.hashCode ^
      category.hashCode ^
      dislike.hashCode ^
      order.hashCode;
  }
}
