// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catagory_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatogaryModelAdapter extends TypeAdapter<CatogaryModel> {
  @override
  final int typeId = 1;

  @override
  CatogaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatogaryModel(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[2] as CatogaryType,
      isDeleted: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CatogaryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatogaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CatogaryTypeAdapter extends TypeAdapter<CatogaryType> {
  @override
  final int typeId = 2;

  @override
  CatogaryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CatogaryType.income;
      case 1:
        return CatogaryType.expense;
      default:
        return CatogaryType.income;
    }
  }

  @override
  void write(BinaryWriter writer, CatogaryType obj) {
    switch (obj) {
      case CatogaryType.income:
        writer.writeByte(0);
        break;
      case CatogaryType.expense:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatogaryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
