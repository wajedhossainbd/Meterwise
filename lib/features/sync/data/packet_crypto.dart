import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

/// AES-256-GCM envelope encryption for Drive packets.
///
/// The key is derived from the meter code, which is shared with tenants only
/// through the landlord's QR. Drive stores only ciphertext; a compromise of a
/// Google account alone does not reveal billing data without the meter code.
class PacketCrypto {
  const PacketCrypto._();

  static Key _key(String meterCode) => Key(Uint8List.fromList(sha256
      .convert(utf8.encode('MeterWise:v1:$meterCode'))
      .bytes));

  static String encrypt(String meterCode, Map<String, dynamic> packet) {
    final iv = IV.fromSecureRandom(12);
    final encrypter = Encrypter(AES(_key(meterCode), mode: AESMode.gcm));
    final cipher = encrypter.encrypt(jsonEncode(packet), iv: iv);
    return jsonEncode(<String, String>{
      'v': '1',
      'iv': iv.base64,
      'ct': cipher.base64,
    });
  }

  static Map<String, dynamic> decrypt(String meterCode, String envelope) {
    final map = jsonDecode(envelope) as Map<String, dynamic>;
    final iv = IV.fromBase64(map['iv'] as String);
    final cipher = Encrypted.fromBase64(map['ct'] as String);
    final plain = Encrypter(AES(_key(meterCode), mode: AESMode.gcm))
        .decrypt(cipher, iv: iv);
    return jsonDecode(plain) as Map<String, dynamic>;
  }
}
