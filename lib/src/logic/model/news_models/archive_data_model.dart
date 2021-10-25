import 'dart:convert';

import 'package:flutter/foundation.dart';

// maintain and sterilize the archive news from the pass website
class ArchiveResponseModel {
  List<Map<String, String>> wrapData;
  ArchiveResponseModel({
    required this.wrapData,
  });

  ArchiveResponseModel copyWith({
    List<Map<String, String>>? wrapData,
  }) {
    return ArchiveResponseModel(
      wrapData: wrapData ?? this.wrapData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wrapData': wrapData,
    };
  }

  List<dynamic> toList() {
    return wrapData;
  }

  factory ArchiveResponseModel.fromMap(Map<String, dynamic> map) {
    return ArchiveResponseModel(
      wrapData: List<Map<String, String>>.from(map['wrapData']?.map((x) => x)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ArchiveResponseModel.fromJson(String source) =>
      ArchiveResponseModel.fromMap(
        json.decode(source),
      );

  @override
  String toString() => 'ArchiveResponseModel(wrapData: $wrapData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArchiveResponseModel &&
        listEquals(other.wrapData, wrapData);
  }

  @override
  int get hashCode => wrapData.hashCode;
}
