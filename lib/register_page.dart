import 'package:arastirma/api2.dart';
import 'package:arastirma/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage(); // secure_storage kullanımı

  Future<void> _login(BuildContext context) async {
    final savedUsername = await _secureStorage.read(key: 'username');
    final savedPassword = await _secureStorage.read(key: 'password');
    final savedMail = await _secureStorage.read(key: 'email');

    if (savedUsername == _usernameController.text && savedMail == _mailController.text && savedPassword == _passwordController.text) {
      API().addUser(savedUsername!, savedPassword!, savedMail!);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Kullanıcı adı ve şifre kontrolünden geçemediyse uygun bir işlem yapabilirsiniz.
    }
  }

  Future<void> _saveCredentials() async {
    await _secureStorage.write(key: 'username', value: _usernameController.text);
    await _secureStorage.write(key: 'password', value: _passwordController.text);
    await _secureStorage.write(key: 'email', value: _mailController.text);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fon Limanı'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _saveCredentials();
                await API().addUser(_usernameController.text, _passwordController.text, _mailController.text);
                await _login(context);
              },
              child: Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
