// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class AnekdotAdapter extends TypeAdapter<Anekdot> {
  @override
  final typeId = 0;

  @override
  Anekdot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Anekdot(anekdotText: fields[0] as String);
  }

  @override
  void write(BinaryWriter writer, Anekdot obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.anekdotText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnekdotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
