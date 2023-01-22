import 'package:rick_and_morty/feature/data/models/location_model.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  PersonModel({
    required id,
    required name,
    required status,
    required species,
    required type,
    required gender,
    required origin,
    required location,
    required image,
    required episode,
    required created,
  }) : super(
          created: created,
          episode: episode,
          image: image,
          location: location,
          origin: origin,
          gender: gender,
          type: type,
          species: species,
          status: status,
          name: name,
          id: id,
        );

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: json['origin']!= null ? LocationModel.fromJson(json['origin']) : null, 
        location: json['location']!= null ? LocationModel.fromJson(json['location']) : null, 
        image: json['image'],
        episode:
            (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
        created: DateTime.parse(json['created'] as String));
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin,
      'location':location,
      'image': image,
      'episode': episode,
      'created': created.toIso8601String(),
    };
  }
}
