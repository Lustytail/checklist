// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckListAdapter extends TypeAdapter<CheckList> {
  @override
  final int typeId = 100;

  @override
  CheckList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckList(
      address: fields[0] as String,
      questionId: fields[1] as int,
      answer: fields[2] as String?,
      description: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CheckList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.questionId)
      ..writeByte(2)
      ..write(obj.answer)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
