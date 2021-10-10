import 'dart:convert';

import 'package:flutter/foundation.dart';

class HeadlineResponseModel {
  List<Map<String, String>> wrapData;

  HeadlineResponseModel({
    required this.wrapData,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HeadlineResponseModel &&
        listEquals(other.wrapData, wrapData);
  }

  @override
  int get hashCode => wrapData.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'wrapData': wrapData,
    };
  }

  List<dynamic> toList() {
    return wrapData;
  }

  factory HeadlineResponseModel.fromMap(Map<String, dynamic> map) {
    return HeadlineResponseModel(
      wrapData: List<Map<String, String>>.from(map['wrapData']?.map((x) => x)),
    );
  }

  String toJson() => json.encode(toMap());

  factory HeadlineResponseModel.fromJson(String source) =>
      HeadlineResponseModel.fromMap(json.decode(source));
}
