/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class ProfileImages extends _i1.SerializableEntity {
  ProfileImages({
    this.id,
    required this.userId,
    this.avatar,
    this.avatarThumbnail,
    this.cover,
  });

  factory ProfileImages.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return ProfileImages(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      userId:
          serializationManager.deserialize<int>(jsonSerialization['userId']),
      avatar: serializationManager
          .deserialize<String?>(jsonSerialization['avatar']),
      avatarThumbnail: serializationManager
          .deserialize<String?>(jsonSerialization['avatarThumbnail']),
      cover:
          serializationManager.deserialize<String?>(jsonSerialization['cover']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String? avatar;

  String? avatarThumbnail;

  String? cover;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'avatar': avatar,
      'avatarThumbnail': avatarThumbnail,
      'cover': cover,
    };
  }
}
