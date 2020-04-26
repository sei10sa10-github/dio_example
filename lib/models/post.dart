import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dio_example/models/serializers.dart';

part 'post.g.dart';

abstract class Post implements Built<Post, PostBuilder> {

  int get userId;

  int get id;

  String get title;

  String get body;

  Post._();
  factory Post([updates(PostBuilder b)]) = _$Post;

  static Serializer<Post> get serializer => _$postSerializer;

  static Post fromJson(String jsonString) {
    return serializers.deserializeWith(Post.serializer, json.decode(jsonString));
  }

  static Post fromDecoded(Object jsonObject) {
    return serializers.deserializeWith(Post.serializer, jsonObject);
  }

  String toJson() {
    return json.encode(serializers.serializeWith(Post.serializer, this));
  }
}