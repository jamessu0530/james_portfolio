import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_constants.dart';
import '../../data/profile_data.dart';
import '../../models/app_language.dart';
import '../../styles/app_colors.dart';
import '../common/glass_card.dart';

class IdentityCard extends StatelessWidget {
  const IdentityCard({
    super.key,
    required this.language,
    required this.isDarkMode,
    required this.avatarPath,
    required this.onAvatarChanged,
    required this.onToggleLanguage,
    required this.onToggleTheme,
    this.cardColor,
  });

  final AppLanguage language;
  final bool isDarkMode;
  final String? avatarPath;
  final ValueChanged<String?> onAvatarChanged;
  final VoidCallback onToggleLanguage;
  final VoidCallback onToggleTheme;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    const Color textColor = AppColors.cardTextDark;

    return GlassCard(
      color: cardColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _Pill(
                label: language == AppLanguage.zh ? 'EN' : '中文',
                onTap: onToggleLanguage,
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onToggleTheme,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    size: 18,
                    color: textColor.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          _IdentityAvatar(
            path: avatarPath,
            onChanged: onAvatarChanged,
          ),
          const SizedBox(height: 24),
          const Text(
            ProfileData.name,
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            ProfileData.englishName,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: textColor.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 15,
                color: textColor.withValues(alpha: 0.4),
              ),
              const SizedBox(width: 4),
              Text(
                'Hsinchu, Taiwan',
                style: TextStyle(
                  fontSize: 14,
                  color: textColor.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            ProfileData.tagline.text(language),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor.withValues(alpha: 0.6),
            ),
          ),
          const Spacer(flex: 2),
          Icon(
            Icons.keyboard_arrow_up_rounded,
            size: 26,
            color: textColor.withValues(alpha: 0.18),
          ),
          Text(
            language == AppLanguage.zh ? '上滑探索' : 'Swipe up',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: textColor.withValues(alpha: 0.18),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppSizes.togglePillRadius),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.cardTextDark.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}

class _IdentityAvatar extends StatefulWidget {
  const _IdentityAvatar({required this.path, required this.onChanged});

  final String? path;
  final ValueChanged<String?> onChanged;

  @override
  State<_IdentityAvatar> createState() => _IdentityAvatarState();
}

class _IdentityAvatarState extends State<_IdentityAvatar> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pick() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 800,
    );
    if (file != null) widget.onChanged(file.path);
  }

  @override
  Widget build(BuildContext context) {
    final bool has = widget.path != null && widget.path!.isNotEmpty;

    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: _pick,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.25),
                  Colors.white.withValues(alpha: 0.08),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipOval(
              child: has
                  ? Image.file(File(widget.path!), fit: BoxFit.cover)
                  : const Center(
                      child: Text(
                        'J',
                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ),
        ),
        if (has)
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () => widget.onChanged(null),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
