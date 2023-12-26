import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class PasswordEncryptor {
  late Uint8List key;

  PasswordEncryptor({required String secretKey}) {
    // Hash the secret key using SHA-256
    var hashedKey = sha256.convert(Uint8List.fromList(utf8.encode(secretKey))).bytes;

    // Use the first 32 bytes of the hashed key as the encryption key
    key = Uint8List.fromList(hashedKey.sublist(0, 32));
  }

  String hashPassword(String password) {
    // Hash the password using SHA-256
    var hashedPassword = sha256.convert(Uint8List.fromList(utf8.encode(password))).bytes;

    // Return the hashed password as a base64-encoded string
    return base64UrlEncode(hashedPassword);
  }

  bool verifyPassword(String password, String hashedPassword) {
    // Hash the provided password and compare it with the stored hashed password
    return hashPassword(password) == hashedPassword;
  }
}