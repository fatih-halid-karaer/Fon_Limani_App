
import 'package:arastirma/api2.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'register_page.dart'; // Yeni kullanıcı kaydı için sayfa

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    // Burada, kullanıcı adı ve şifre kontrolü yapabilir ve giriş durumuna göre işlem yapabilirsiniz.
    // Şu anda sadece basit bir kontrol yapıyoruz ve doğru ise ana sayfaya yönlendiriyoruz.
    //API().loginUser(_usernameController.text, _passwordController.text);
    if(_usernameController.text == 'kul' && _passwordController.text == 'sif') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Kullanıcı kayıtlı değilse, yeni kayıt sayfasına yönlendir.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fon Limanı',
        style: TextStyle(fontSize: 25,color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ImageIcon(
                AssetImage('assets/fon_limani_white_logo.png'),
                size: 100.0,
                color: Colors.blue,
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                  _login(context);
                 //API().loginUser(_usernameController.text, _passwordController.text);
                },
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}

