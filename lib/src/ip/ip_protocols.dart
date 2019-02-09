import 'package:ip/foundation.dart';
import 'package:ip/icmp.dart';
import 'package:ip/tcp.dart';
import 'package:ip/udp.dart';

const Map<int, Protocol> ipProtocolMap = <int, Protocol>{
  ipProtocolIcmp: icmp,
  ipProtocolTcp: tcp,
  ipProtocolUdp: udp,
};

const int ipProtocolIcmp = 1;
const int ipProtocolTcp = 6;
const int ipProtocolUdp = 17;
