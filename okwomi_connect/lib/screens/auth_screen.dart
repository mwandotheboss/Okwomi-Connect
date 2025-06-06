import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _smsController = TextEditingController();
  String? _verificationId;
  bool _isLoading = false;
  String? _error;

  final AuthService _authService = AuthService();

  void _signInWithEmail() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      await _authService.signInWithEmail(_emailController.text, _passwordController.text);
    } catch (e) {
      setState(() { _error = e.toString(); });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  void _signUpWithEmail() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      await _authService.signUpWithEmail(_emailController.text, _passwordController.text);
    } catch (e) {
      setState(() { _error = e.toString(); });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  void _signInWithGoogle() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      setState(() { _error = e.toString(); });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  void _verifyPhone() async {
    setState(() { _isLoading = true; _error = null; });
    await _authService.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      codeSent: (verificationId) {
        setState(() { _verificationId = verificationId; _isLoading = false; });
      },
      verificationCompleted: (credential) async {
        await _authService.signInWithSmsCode(credential.verificationId!, credential.smsCode!);
        setState(() { _isLoading = false; });
      },
      verificationFailed: (e) {
        setState(() { _error = e.message; _isLoading = false; });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() { _verificationId = verificationId; _isLoading = false; });
      },
    );
  }

  void _signInWithSmsCode() async {
    if (_verificationId == null) return;
    setState(() { _isLoading = true; _error = null; });
    try {
      await _authService.signInWithSmsCode(_verificationId!, _smsController.text);
    } catch (e) {
      setState(() { _error = e.toString(); });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_error != null) ...[
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 8),
                  ],
                  const Text('Email Sign In', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
                  TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
                  Row(
                    children: [
                      ElevatedButton(onPressed: _signInWithEmail, child: const Text('Sign In')),
                      const SizedBox(width: 8),
                      OutlinedButton(onPressed: _signUpWithEmail, child: const Text('Sign Up')),
                    ],
                  ),
                  const Divider(height: 32),
                  const Text('Phone Sign In', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone (+254...)')),
                  ElevatedButton(onPressed: _verifyPhone, child: const Text('Send Code')),
                  if (_verificationId != null) ...[
                    TextField(controller: _smsController, decoration: const InputDecoration(labelText: 'SMS Code')),
                    ElevatedButton(onPressed: _signInWithSmsCode, child: const Text('Verify Code')),
                  ],
                  const Divider(height: 32),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.login),
                    label: const Text('Sign in with Google'),
                    onPressed: _signInWithGoogle,
                  ),
                ],
              ),
            ),
    );
  }
} 