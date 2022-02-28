import 'package:ip/ip.dart';
import 'package:ip/udp.dart';
import 'package:raw/raw.dart';
import 'package:raw/test_helpers.dart';
import 'package:test/test.dart';

void main() {
  group("UdpPacket", () {
    group("default", () {
      final exampleIpPacket = Ip4Packet();
      final example = UdpPacket();
      example.parentPacket = exampleIpPacket;

      test("encode, decode", () {
        // Test that this doesn't throw
        final bytes = example.toUint8ListViewOrCopy();

        // Test reading written default bytes
        final decoded = UdpPacket();
        decoded.parentPacket = exampleIpPacket;
        decoded.decodeRaw(RawReader.withBytes(bytes));

        // Test equality
        expect(decoded, selfEncoderEquals(example));
      });
    });

    group("example #1", () {
      late List<int> exampleBytes;
      late UdpPacket example;

      setUp(() {
        exampleBytes = [
          0xFE, // source port
          0xDC,
          0xBA, // destination port
          0x98,
          0, // length
          0x03,
          0x47, // checksum
          0x75,
          1, // payload
          2,
          3
        ];
      });

      setUp(() {
        final exampleIpPacket = Ip4Packet();
        exampleIpPacket.source = Ip4Address.loopback;
        exampleIpPacket.destination = Ip4Address.loopback;
        example = UdpPacket();
        example.parentPacket = exampleIpPacket;
        example.sourcePort = 0xFEDC;
        example.destinationPort = 0xBA98;
        example.payload = RawData([1, 2, 3]);
      });

      test("encode, decode, encode", () {
        // encode
        final writer = RawWriter(capacity: 500);
        example.encodeRaw(writer);
        final encoded = writer.toUint8List();
        expect(encoded, byteListEquals(exampleBytes));
        final encodedReader = RawReader.withBytes(encoded);

        // encode -> decode
        final decoded = UdpPacket();
        decoded.decodeRaw(encodedReader);

        // For UDP checksum, we need parent packet
        decoded.parentPacket = example.parentPacket;

        // encode -> decode -> encode
        // (the next two lines should both encode)
        expect(decoded.toUint8ListViewOrCopy(), byteListEquals(exampleBytes));
        expect(decoded, selfEncoderEquals(example));
        expect(encodedReader.availableLength, 0);
      });

      test("decode", () {
        final reader = RawReader.withBytes(exampleBytes);
        final decoded = UdpPacket();
        decoded.parentPacket = example.parentPacket;
        decoded.decodeRaw(reader);
        expect(decoded, selfEncoderEquals(example));
        expect(reader.availableLength, 0);
      });

      test("decoded properties", () {
        final reader = RawReader.withBytes(exampleBytes);
        final decoded = UdpPacket();
        decoded.decodeRaw(reader);
        expect(decoded.sourcePort, equals(0xFEDC));
        expect(decoded.destinationPort, equals(0xBA98));
        expect(decoded.payload.toUint8ListViewOrCopy(), byteListEquals([1, 2, 3]));
      });
    });
  });
}
