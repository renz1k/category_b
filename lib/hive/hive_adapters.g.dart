// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class FavoriteAnekdotsAdapter extends TypeAdapter<FavoriteAnekdots> {
  @override
  final typeId = 1;

  @override
  FavoriteAnekdots read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteAnekdots(
      id: fields[0] as String,
      createdAt: fields[2] as DateTime,
      anekdotText: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteAnekdots obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.anekdotText)
      ..writeByte(2)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAnekdotsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocalAnekdotAdapter extends TypeAdapter<LocalAnekdot> {
  @override
  final typeId = 2;

  @override
  LocalAnekdot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalAnekdot(id: fields[0] as String, text: fields[1] as String);
  }

  @override
  void write(BinaryWriter writer, LocalAnekdot obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalAnekdotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
