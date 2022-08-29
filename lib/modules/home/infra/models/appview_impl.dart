
import 'package:applocation/modules/home/domain/entities/appview.dart';

class AppViewImpl extends AppView {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? gender;
  final String? image;
  final String? created;
  final String? type;

  const AppViewImpl({this.id, this.name, this.status, this.species, this.gender, this.image, this.created, this.type});



  factory AppViewImpl.fromMap(Map<String, dynamic> json) => AppViewImpl(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        gender: json['gender'],
        image: json['image'],
        created: json['created'],
        type: json['type'],
      );


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['species'] = species;
    data['gender'] = gender;
    data['image'] = image;
    data['created'] = created;
    data['type'] = type;
    return data;
  }
}
