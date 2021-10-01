import 'dart:convert';
import 'dart:typed_data';

class ByteConverter {
  static String getStringFromBytes(ByteData data) {
    final buffer = data.buffer;
    var list = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return utf8.decode(list);
  }

  static Uint8List getBytesFromString(String dataString) {
    List<int> list = dataString.codeUnits;
    return Uint8List.fromList(list);
  }
}
