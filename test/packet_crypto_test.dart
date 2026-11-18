import 'package:flutter_test/flutter_test.dart';
import 'package:meterwise/features/sync/data/packet_crypto.dart';

void main() {
  test('Drive packet round-trips through AES-GCM encryption', () {
    const code = 'MW-LNA5-ZJDA';
    final packet = <String, dynamic>{
      'version': 1,
      'meterCode': code,
      'property': {'name': 'Rahman Villa'},
      'amount': 1137.12,
    };

    final envelope = PacketCrypto.encrypt(code, packet);

    expect(envelope, isNot(contains('Rahman Villa')));
    expect(envelope, isNot(contains('1137.12')));
    expect(envelope, contains('"ct"'));

    final restored = PacketCrypto.decrypt(code, envelope);
    expect(restored['property']['name'], 'Rahman Villa');
    expect(restored['amount'], 1137.12);
  });

  test('wrong meter code cannot decrypt a packet', () {
    final envelope = PacketCrypto.encrypt(
      'MW-AAAA-BBBB',
      <String, dynamic>{'secret': 'value'},
    );
    expect(
      () => PacketCrypto.decrypt('MW-CCCC-DDDD', envelope),
      throwsA(anything),
    );
  });
}
