import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.all(80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome', style: Theme.of(ctx).textTheme.headline1),
            TextFormField(
              decoration: InputDecoration(hintText: "username"),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(ctx, '/main'),
              child: Text('登录'),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            )
          ],
        ),
      ),
    ));
  }
}
