import 'package:ip/foundation.dart';
import 'package:ip/ip.dart';

/// Superclass of [Ip4Address] and [Ip6Address].
abstract class IpAddress extends SelfEncoder {
  const IpAddress();

  /// Inspects whether the address is IPv4 address or IPv6 mapping of IPv4
  /// address.
  bool get isIpv4;

  /// Inspects whether the address is a local network address (e.g. 10.0.01).
  bool get isLocalNetwork;

  /// Inspects whether the address is loopback address (e.g. 127.0.0.1)
  bool get isLoopback;

  /// Returns protocol ([ipv4] or [ipv6]).
  Protocol get protocol;

  /// Returns string representation of the address.
  String toString();

  static IpAddress fromBytes(List<int> bytes) {
    switch (bytes.length) {
      case 4:
        return Ip4Address.fromBytes(bytes, 0);
      case 16:
        return Ip6Address.fromBytes(bytes, 0);
      default:
        throw ArgumentError.value(
            bytes, "bytes", "invalid length (${bytes.length})");
    }
  }

  /// Parses either [Ip4Address] or [Ip6Address].
  static IpAddress parse(String source) {
    for (var i = 0; i < source.length; i++) {
      final c = source.substring(i, i + 1);
      switch (c) {
        case ":":
          return Ip6Address.parse(source);
        case ".":
          return Ip4Address.parse(source);
      }
    }
    return throw ArgumentError.value(source, "source");
  }
}
