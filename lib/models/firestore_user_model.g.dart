// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FirestoreUserAdapter extends TypeAdapter<FirestoreUser> {
  @override
  final int typeId = 1;

  @override
  FirestoreUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FirestoreUser(
      id: fields[0] as String,
      username: fields[1] as String,
      tasksCompleted: fields[2] as String,
      photoUrl: fields[4] as String,
      bio: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FirestoreUser obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.tasksCompleted)
      ..writeByte(3)
      ..write(obj.bio)
      ..writeByte(4)
      ..write(obj.photoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirestoreUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
