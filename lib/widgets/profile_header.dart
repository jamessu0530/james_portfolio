import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';
import '../data/profile_data.dart';
import '../models/app_language.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.language,
    required this.isDarkMode,
    required this.onToggleLanguage,
    required this.onToggleTheme,
  });

  final AppLanguage language;
  final bool isDarkMode;
  final VoidCallback onToggleLanguage;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        // -- Toggle buttons (language + dark mode) --
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _TogglePill(
              label: language == AppLanguage.zh ? 'EN' : '中文',
              onTap: onToggleLanguage,
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onToggleTheme,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  size: 18,
                  color: colors.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // -- Avatar (Stack + gradient circle + initial) --
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: AppSizes.avatarSize,
              height: AppSizes.avatarSize,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colors.primary, colors.tertiary],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
            ),
            // Replace with Image.asset('assets/profile_photo.png') when ready
            const Text(
              'J',
              style: TextStyle(
                fontSize: AppSizes.avatarFontSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // -- Name --
        Text(
          ProfileData.name,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          ProfileData.englishName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),

        // -- Tagline --
        Text(
          ProfileData.tagline.text(language),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: colors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),

        // -- Location --
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 14,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              'Hsinchu, Taiwan',
              style: TextStyle(
                fontSize: 13,
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // -- Social links --
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialButton(
              icon: Icons.code,
              label: 'GitHub',
              url: ProfileData.githubURL,
            ),
            const SizedBox(width: 10),
            _SocialButton(
              icon: Icons.work_outline,
              label: 'LinkedIn',
              url: ProfileData.linkedInURL,
            ),
            const SizedBox(width: 10),
            _SocialButton(
              icon: Icons.article_outlined,
              label: 'Medium',
              url: ProfileData.mediumURL,
            ),
          ],
        ),
      ],
    );
  }
}

// -- Toggle pill for language switch --
class _TogglePill extends StatelessWidget {
  const _TogglePill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(AppSizes.togglePillRadius),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: colors.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}

// -- Social link button --
class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.url,
  });

  final IconData icon;
  final String label;
  final String url;

  Future<void> _open() async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: _open,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: colors.primaryContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppSizes.socialButtonRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: colors.primary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colors.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
