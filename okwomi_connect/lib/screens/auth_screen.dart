import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
  String? _emailError;
  String? _passwordError;
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  void _signInWithEmail() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _emailError = null;
      _passwordError = null;
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    bool valid = true;
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+').hasMatch(email)) {
      _emailError = 'Please enter a valid email address';
      valid = false;
    }
    if (password.isEmpty) {
      _passwordError = 'Password cannot be empty';
      valid = false;
    }
    if (!valid) {
      setState(() { _isLoading = false; });
      return;
    }
    try {
      await _authService.signInWithEmail(email, password);
      if (mounted) Navigator.of(context).pushReplacementNamed('/dashboard');
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
      if (mounted) Navigator.of(context).pushReplacementNamed('/dashboard');
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

  String getGoogleLogoAsset(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (kIsWeb) {
      if (brightness == Brightness.dark) {
        return 'assets/icons/google-signin-assets/Web/web_dark_rd_SI@1x.png';
      } else if (brightness == Brightness.light) {
        return 'assets/icons/google-signin-assets/Web/web_light_rd_SI@1x.png';
      } else {
        return 'assets/icons/google-signin-assets/Web/web_neutral_rd_SI@1x.png';
      }
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      if (brightness == Brightness.dark) {
        return 'assets/icons/google-signin-assets/Android/android_dark_rd_SI@1x.png';
      } else if (brightness == Brightness.light) {
        return 'assets/icons/google-signin-assets/Android/android_light_rd_SI@1x.png';
      } else {
        return 'assets/icons/google-signin-assets/Android/android_neutral_rd_SI@1x.png';
      }
    } else {
      // Fallback to web light for other platforms
      return 'assets/icons/google-signin-assets/Web/web_light_rd_SI@1x.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF233444)
          : const Color(0xFFFBFBF3),
      appBar: AppBar(title: const Text('Welcome to the Okwomi Family')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Introduction Section
                            Column(
                              children: [
                                // TODO: Replace with your family image asset
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.shade50,
                                  ),
                                  child: const Center(
                                    child: FaIcon(FontAwesomeIcons.peopleGroup, size: 70, color: Colors.blue),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'The Okwomi Family',
                                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Welcome to the Okwomi Family portal! Connect, share, and celebrate our heritage together. Please sign in to continue.',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                            if (_error != null) ...[
                              Text(_error!, style: const TextStyle(color: Colors.red)),
                              const SizedBox(height: 8),
                            ],
                            // Email/Password Sign In
                            const Text('Sign in with Email', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 12),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(labelText: 'Email', errorText: _emailError),
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+').hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(labelText: 'Password', errorText: _passwordError),
                              obscureText: true,
                              autofillHints: const [AutofillHints.password],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  _signInWithEmail();
                                }
                              },
                              child: const Text('Sign In'),
                            ),
                            SizedBox(height: 24),
                            const Divider(height: 32),
                            SizedBox(height: 24),
                            // Google Sign In
                            Center(
                              child: GestureDetector(
                                onTap: _signInWithGoogle,
                                child: Image.asset(
                                  getGoogleLogoAsset(context),
                                  height: 48,
                                  width: 240,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Privacy Policy and Terms links
                            Center(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 16,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).pushNamed('/privacy'),
                                    child: Text(
                                      'Privacy Policy',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  Text('|', style: Theme.of(context).textTheme.bodySmall),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).pushNamed('/terms'),
                                    child: Text(
                                      'Terms of Service',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
} 