import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/gold_button.dart';
import 'auth_providers.dart';
import '../data/fake_auth_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();

  bool _useOtp = false;
  bool _obscurePassword = true;
  bool _isSubmitting = false;
  String? _errorText;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isSubmitting = true;
      _errorText = null;
    });
    try {
      final repo = ref.read(authRepositoryProvider);
      if (_useOtp) {
        await repo.loginWithOtp(phone: _idController.text.trim(), otp: _otpController.text.trim());
      } else {
        await repo.login(
          driverIdOrPhone: _idController.text.trim(),
          password: _passwordController.text,
        );
      }
      if (mounted) context.go('/home');
    } on AuthException catch (e) {
      setState(() => _errorText = e.message);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.xxl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.local_taxi_rounded, color: AppColors.background, size: 30),
                ),
                const SizedBox(height: 28),
                Text('Welcome back', style: AppTextStyles.displayLarge.copyWith(fontSize: 26)),
                const SizedBox(height: 8),
                Text('Sign in with your driver credentials to see your assigned jobs.',
                    style: AppTextStyles.bodyMuted),
                const SizedBox(height: 36),
                Text(_useOtp ? 'Phone number' : 'Driver ID / Phone', style: AppTextStyles.label),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _idController,
                  style: AppTextStyles.body,
                  keyboardType: TextInputType.phone,
                  autofillHints: const [AutofillHints.username],
                  decoration: const InputDecoration(hintText: 'e.g. DRV-77219 or +966 5X XXX XXXX'),
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 20),
                if (!_useOtp) ...[
                  Text('Password', style: AppTextStyles.label),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    style: AppTextStyles.body,
                    obscureText: _obscurePassword,
                    autofillHints: const [AutofillHints.password],
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: AppColors.textMuted,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                ] else ...[
                  Text('One-time code', style: AppTextStyles.label),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _otpController,
                    style: AppTextStyles.body,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: const InputDecoration(hintText: '4-6 digit code', counterText: ''),
                    validator: (v) => (v == null || v.trim().length < 4) ? 'Enter the code sent to you' : null,
                  ),
                ],
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => setState(() => _useOtp = !_useOtp),
                    child: Text(_useOtp ? 'Use password instead' : 'Sign in with OTP instead'),
                  ),
                ),
                if (_errorText != null) ...[
                  const SizedBox(height: 4),
                  Text(_errorText!, style: AppTextStyles.body.copyWith(color: AppColors.danger)),
                ],
                const SizedBox(height: 20),
                GoldButton(
                  label: _useOtp ? 'Verify & sign in' : 'Sign in',
                  isLoading: _isSubmitting,
                  onPressed: _submit,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Assigned by dispatch? Contact your fleet manager for access.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.caption,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
