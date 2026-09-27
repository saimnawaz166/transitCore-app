import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  static TextStyle get _base => GoogleFonts.manrope(color: AppColors.textPrimary);

  static TextStyle get displayLarge => _base.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      );

  static TextStyle get headline => _base.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get title => _base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get body => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMuted => body.copyWith(color: AppColors.textMuted);

  static TextStyle get label => _base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
        color: AppColors.textMuted,
      );

  static TextStyle get caption => _base.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
      );

  static TextStyle get buttonGold => _base.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.background,
      );

  static TextStyle get buttonOutline => _base.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.gold,
      );
}
