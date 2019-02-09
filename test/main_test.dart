// Having a single main() instead of multiple "something_test.dart" files
// speeds up tests significantly.

import 'src/foundation.dart' as foundation;
import 'src/ip.dart' as ip;
import 'src/ip4.dart' as ip4;
import 'src/ip6.dart' as ip6;
import 'src/tcp.dart' as tcp;
import 'src/udp.dart' as udp;

void main() {
  foundation.main();
  ip.main();
  ip4.main();
  ip6.main();
  udp.main();
  tcp.main();
}
