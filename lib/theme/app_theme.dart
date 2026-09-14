import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  AppThemeColors get colors => Theme.of(this).extension<AppThemeColors>()!;
}

/// Design language: "Vault" — a quiet, ink-dark ledger with a single
/// aurora-gradient signature reserved for the card faces themselves.
/// Everything else (chrome, lists, sheets) stays disciplined charcoal/ivory
/// so the cards — the actual subject of this app — are what pops.
class AppColors {
  AppColors._();

  //DARK
  static const Color darkCanvas = Color(0xFF0A0C12);
  static const Color darkSurface = Color(0xFF12151E);
  static const Color darkSurfaceRaised = Color(0xFF181C27);
  static const Color darkHairline = Color(0xFF262B38);

  static const Color darkIvory = Color(0xFFF3F1EC);
  static const Color darkIvoryMuted = Color(0xFFA6ABBA);
  static const Color darkIvoryFaint = Color(0xFF676D80);

  // ===========================================================================
  // LIGHT
  // ===========================================================================

  static const Color lightCanvas = Color(0xFFF6F5F2);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceRaised = Color(0xFFF0EFEB);
  static const Color lightHairline = Color(0xFFE0DED8);

  static const Color lightIvory = Color(0xFF181A20);
  static const Color lightIvoryMuted = Color(0xFF686B75);
  static const Color lightIvoryFaint = Color(0xFF9699A3);

  static const Color canvas = Color(0xFF0A0C12); // near-ink background
  static const Color surface = Color(0xFF12151E); // panels
  static const Color surfaceRaised = Color(0xFF181C27); // sheets, tiles
  static const Color hairline = Color(0xFF262B38); // subtle separators
  static const Color ivory = Color(0xFFF3F1EC); // primary text
  static const Color ivoryMuted = Color(0xFFA6ABBA); // secondary text
  static const Color ivoryFaint = Color(0xFF676D80); // tertiary / hints

  // Signature accent — a warm brass/gold used sparingly for emphasis only
  // (progress, highlighted numerals, primary actions). Not a gradient wash.
  static const Color brass = Color(0xFFCBA25F);
  static const Color brassDim = Color(0xFF8C7345);

  static const Color positive = Color(0xFF6FCF97); // credits / refunds
  static const Color negative = Color(0xFFE07A5F); // overdue / high usage
  static const Color danger = Color(0xFFE0555F);

  // Card face gradient presets — each a distinct "metal" personality.
  static const List<List<Color>> cardPalettes = [
    [Color(0xFF232946), Color(0xFF5B6EE1)], // Indigo
    [Color(0xFF1F2A24), Color(0xFF36A269)], // Forest
    [Color(0xFF2B1E2E), Color(0xFFB34D7A)], // Plum
    [Color(0xFF1C1F26), Color(0xFF667085)], // Graphite
    [Color(0xFF2E2116), Color(0xFFC47A35)], // Copper
    [Color(0xFF16232B), Color(0xFF35A6BA)], // Teal

    [Color(0xFF172033), Color(0xFF4B82D1)], // Sapphire
    [Color(0xFF261A14), Color(0xFF9A6042)], // Espresso
    [Color(0xFF211B2D), Color(0xFF8557C7)], // Royal Purple
    [Color(0xFF182A2A), Color(0xFF35A98F)], // Jade
    [Color(0xFF29251A), Color(0xFFC39A32)], // Gold
    [Color(0xFF20252B), Color(0xFF66829A)], // Slate
    [Color(0xFF29181B), Color(0xFFBC1D3D)], // Ruby
    [Color(0xFF15252A), Color(0xFF299BC0)], // Ocean
    [Color(0xFF24201B), Color(0xFF9A6A3A)], // Walnut
    [Color(0xFF1B2029), Color(0xFF5278D4)], // Midnight Blue
  ];
} //[Color(0xFF2B1E2E), Color.fromARGB(255, 188, 29, 29)],

class AppRadii {
  AppRadii._();
  static const double card = 26;
  static const double sheet = 28;
  static const double tile = 18;
  static const double pill = 100;
  static const double button = 16;
}

class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 40;
}

ThemeData buildAppTheme({Brightness brightness = Brightness.dark}) {
  final isDark = brightness == Brightness.dark;

  final base = ThemeData(brightness: brightness, useMaterial3: true);

  final colors = isDark ? AppThemeColors.dark : AppThemeColors.light;

  return base.copyWith(
    scaffoldBackgroundColor: colors.canvas,

    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.brass,
          brightness: brightness,
        ).copyWith(
          primary: AppColors.brass,
          secondary: AppColors.brass,
          error: AppColors.danger,
          surface: colors.surface,
        ),

    extensions: [colors],

    textTheme: _buildTextTheme(base.textTheme, colors),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      foregroundColor: colors.ivory,
    ),

    dividerColor: colors.hairline,

    splashFactory: InkRipple.splashFactory,

    highlightColor: Colors.transparent,
  );
}

TextTheme _buildTextTheme(TextTheme base, AppThemeColors colors) {
  return base.copyWith(
    headlineSmall: base.headlineSmall?.copyWith(
      color: colors.ivory,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.4,
    ),

    labelMedium: base.labelMedium?.copyWith(
      color: colors.ivoryMuted,
      fontSize: 13,
    ),
    displayLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.8,
      color: colors.ivory,
      height: 1.1,
    ),

    headlineMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.4,
      color: colors.ivory,
    ),

    titleLarge: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      color: colors.ivory,
    ),

    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: colors.ivory,
    ),

    bodyLarge: TextStyle(
      fontSize: 15.5,
      fontWeight: FontWeight.w400,
      color: colors.ivory,
      height: 1.4,
    ),

    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: colors.ivoryMuted,
      height: 1.4,
    ),

    bodySmall: TextStyle(
      fontSize: 12.5,
      fontWeight: FontWeight.w400,
      color: colors.ivoryFaint,
    ),

    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: colors.ivory,
    ),
  );
}

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color canvas;
  final Color surface;
  final Color surfaceRaised;
  final Color hairline;
  final Color ivory;
  final Color ivoryMuted;
  final Color ivoryFaint;

  const AppThemeColors({
    required this.canvas,
    required this.surface,
    required this.surfaceRaised,
    required this.hairline,
    required this.ivory,
    required this.ivoryMuted,
    required this.ivoryFaint,
  });

  static const dark = AppThemeColors(
    canvas: AppColors.darkCanvas,
    surface: AppColors.darkSurface,
    surfaceRaised: AppColors.darkSurfaceRaised,
    hairline: AppColors.darkHairline,
    ivory: AppColors.darkIvory,
    ivoryMuted: AppColors.darkIvoryMuted,
    ivoryFaint: AppColors.darkIvoryFaint,
  );

  static const light = AppThemeColors(
    canvas: AppColors.lightCanvas,
    surface: AppColors.lightSurface,
    surfaceRaised: AppColors.lightSurfaceRaised,
    hairline: AppColors.lightHairline,
    ivory: AppColors.lightIvory,
    ivoryMuted: AppColors.lightIvoryMuted,
    ivoryFaint: AppColors.lightIvoryFaint,
  );

  @override
  AppThemeColors copyWith({
    Color? canvas,
    Color? surface,
    Color? surfaceRaised,
    Color? hairline,
    Color? ivory,
    Color? ivoryMuted,
    Color? ivoryFaint,
  }) {
    return AppThemeColors(
      canvas: canvas ?? this.canvas,
      surface: surface ?? this.surface,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      hairline: hairline ?? this.hairline,
      ivory: ivory ?? this.ivory,
      ivoryMuted: ivoryMuted ?? this.ivoryMuted,
      ivoryFaint: ivoryFaint ?? this.ivoryFaint,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) {
      return this;
    }

    return AppThemeColors(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      ivory: Color.lerp(ivory, other.ivory, t)!,
      ivoryMuted: Color.lerp(ivoryMuted, other.ivoryMuted, t)!,
      ivoryFaint: Color.lerp(ivoryFaint, other.ivoryFaint, t)!,
    );
  }
}
