import 'dart:convert';

import 'package:github_search/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final int id;
  final String login;
  final String avatarUrl;

  ResultSearchModel({
    required this.id,
    required this.login,
    required this.avatarUrl,
  }) : super(id: id, login: login, avatarUrl: avatarUrl);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'avatar_url': avatarUrl,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      id: map['id'],
      login: map['login'],
      avatarUrl: map['avatar_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
