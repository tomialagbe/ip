import 'package:ip/foundation.dart';
import 'package:test/test.dart';

void main() {
  group("StructWriter: ", () {
    test("==", () {
      var a = _ExampleStructWriter([1, 2]);
      var b = _ExampleStructWriter([1, 2]);
      expect(a, equals(b));

      // Non-equal value
      b = _ExampleStructWriter([1, 3]);
      expect(a, isNot(equals(b)));

      // Non-equal length
      b = _ExampleStructWriter([1]);
      expect(a, isNot(equals(b)));
      b = _ExampleStructWriter([1, 2, 3]);
      expect(a, isNot(equals(b)));
    });

    test("hashCode", () {
      var a = _ExampleStructWriter([1, 2]);
      var b = _ExampleStructWriter([1, 2]);
      expect(a.hashCode, equals(b.hashCode));

      // Non-equal value
      b = _ExampleStructWriter([1, 3]);
      expect(a.hashCode, isNot(equals(b.hashCode)));

      // Non-equal length
      b = _ExampleStructWriter([1]);
      expect(a.hashCode, isNot(equals(b.hashCode)));
    });
  });
}

class _ExampleStructWriter extends RawEncodable {
  final List<int> bytes;

  _ExampleStructWriter(this.bytes);

  @override
  void encodeRaw(RawWriter writer) {
    writer.writeBytes(bytes);
  }

  @override
  int encodeRawCapacity() => bytes.length;
}
