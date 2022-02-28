import 'package:ip/foundation.dart';
import 'package:ip/ip.dart';


class Ip4Address extends IpAddress {
  static final Ip4Address any = zero;
  static final Ip4Address zero = Ip4Address.fromUint32(0);
  static final Ip4Address broadcast = Ip4Address.fromUint32(0xFFFFFFFF);
  static final Ip4Address loopback = Ip4Address.parse("127.0.0.1");

  factory Ip4Address.decode(RawReader reader) {
    return Ip4Address.fromUint32(reader.readUint32());
  }

  factory Ip4Address.fromBytes(List<int> bytes, int index) {
    return Ip4Address.fromUint32(((0xFF & bytes[index]) << 24) |
        ((0xFF & bytes[index + 1]) << 16) |
        ((0xFF & bytes[index + 2]) << 8) |
        (0xFF & bytes[index + 3]));
  }

  @override
  int encodeRawCapacity() => 4;

  /// Returns address as a 32-bit unsigned internet.
  final int asUint32;

  @override
  void encodeRaw(RawWriter writer) {
    writer.writeUint32(asUint32);
  }

  const Ip4Address.fromUint32(this.asUint32);

  @override
  bool get isLocalNetwork {
    final value = this.asUint32;
    final b0 = value >> 24;
    if (b0 == 10) {
      return true;
    }
    if (b0 == 192 && (0xFF & (value >> 16)) == 168) {
      return true;
    }
    return false;
  }

  @override
  bool get isLoopback => asUint32 == 0x7F000001;

  @override
  bool get isIpv4 => true;

  @override
  Protocol get protocol => ipv4;

  @override
  String toString() => toUint8ListViewOrCopy().join(".");

  static Ip4Address parse(String s) {
    final bytes = s.split(".").map((number) => int.parse(number)).toList();
    if (bytes.length != 4) {
      throw ArgumentError.value(s);
    }
    return Ip4Address.fromBytes(bytes, 0);
  }
}
