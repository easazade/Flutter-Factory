import 'package:stormberry/stormberry.dart';

part 'models.schema.dart';

@Model(views: [#CompletePost, #ReducedPost])
abstract class Post {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get title;

  String get content;

  // since we have another [User] object property here we need to specify in both Post, User classes that
  // on-to-many relationship is between author and posts columns. so on each field we specify the field from other
  // class which this field has a relation to.
  @BindTo(#posts)
  @ViewedIn(#CompletePost, as: #ReducedUser)
  @HiddenIn(#ReducedPost)
  User get author;

  @ViewedIn(#CompletePost, as: #ReducedUser)
  @HiddenIn(#ReducedPost)
  User? get editor;
}

@Model(views: [#CompleteUser, #ReducedUser])
abstract class User {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get name;

  String get bio;

  @BindTo(#author)
  @ViewedIn(#CompleteUser, as: #ReducedPost)
  @HiddenIn(#ReducedUser)
  List<Post> get posts;
}



@Model(tableName: 'meetings_all')
abstract class Meeting {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  @UseConverter(LatLngConverter())
  LatLng get location;
}

class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);
}

class LatLngConverter extends TypeConverter<LatLng> {
  const LatLngConverter() : super('point');

  @override
  dynamic encode(LatLng value) => PgPoint(value.latitude, value.longitude);

  @override
  LatLng decode(dynamic value) {
    if (value is PgPoint) {
      return LatLng(value.latitude, value.longitude);
    } else {
      var m = RegExp(r'\((.+),(.+)\)').firstMatch(value.toString());
      var lat = double.parse(m!.group(1)!.trim());
      var lng = double.parse(m.group(2)!.trim());
      return LatLng(lat, lng);
    }
  }
}
