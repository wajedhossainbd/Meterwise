import 'package:flutter_test/flutter_test.dart';
import 'package:meterwise/features/updates/data/update_service.dart';

void main() {
  test('version comparison detects newer releases correctly', () {
    expect(UpdateService.isNewer('3.5.0', '3.4.1'), isTrue);
    expect(UpdateService.isNewer('4.0.0', '3.9.9'), isTrue);
    expect(UpdateService.isNewer('3.4.2', '3.4.1'), isTrue);
    expect(UpdateService.isNewer('3.4.1', '3.4.1'), isFalse);
    expect(UpdateService.isNewer('3.4.0', '3.4.1'), isFalse);
    expect(UpdateService.isNewer('3.3.9', '3.4.0'), isFalse);
  });

  test('v-prefixed tags and build suffixes are tolerated', () {
    expect(UpdateService.isNewer('v3.5.0', '3.4.1'), isTrue);
    expect(UpdateService.isNewer('3.5.0+27', '3.4.1'), isTrue);
  });
}
