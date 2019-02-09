import 'package:ip/ip.dart';
import 'package:test/test.dart';

void main() {
  group("IpAddress", () {
    test("parse: invalid", () {
      expect(() => IpAddress.parse(""),
          throwsA(const TypeMatcher<ArgumentError>()));
    });

    test("parse: ipv4", () {
      final address = IpAddress.parse("0.0.0.0");
      expect(address, const TypeMatcher<Ip4Address>());
    });

    test("parse: ipv6", () {
      final address = IpAddress.parse("1:2::");
      expect(address, const TypeMatcher<Ip6Address>());
    });
  });
}
