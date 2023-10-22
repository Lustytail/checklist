// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeListAdapter extends TypeAdapter<HomeList> {
  @override
  final int typeId = 202;

  @override
  HomeList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeList(
      homeList: (fields[0] as List).cast<Home>(),
    );
  }

  @override
  void write(BinaryWriter writer, HomeList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.homeList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
