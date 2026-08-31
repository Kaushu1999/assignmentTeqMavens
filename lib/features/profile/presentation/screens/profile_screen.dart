import 'package:assignment/core/constants/app_assets.dart';
import 'package:assignment/core/constants/app_colors.dart';
import 'package:assignment/core/constants/app_text_styles.dart';
import 'package:assignment/core/widgets/app_background.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const List<ProfileMenuItem> _items = [
    ProfileMenuItem(
      iconAsset: AppAssets.iconEditProfile,
      title: 'Edit Profile',
      subtitle: 'Manage your professional profile',
    ),
    ProfileMenuItem(
      iconAsset: AppAssets.iconAccount,
      title: 'Account',
      subtitle: 'Manage account and login settings',
    ),
    ProfileMenuItem(
      iconAsset: AppAssets.iconNotification,
      title: 'Notification',
      subtitle: 'Manage your notification preferences',
    ),
    ProfileMenuItem(
      iconAsset: AppAssets.iconAppearance,
      title: 'Appearance',
      subtitle: 'Customize your app experience',
    ),
    ProfileMenuItem(
      iconAsset: AppAssets.iconHelpAndFeedback,
      title: 'Help & Feedback',
      subtitle: 'Get help or share feedback',
    ),
    ProfileMenuItem(
      iconAsset: AppAssets.iconInviteFriend,
      title: 'Invite a friend',
      subtitle: 'Invite friends to NextRole.app',
    ),
    ProfileMenuItem(
      iconAsset: AppAssets.iconPrivacySecurity,
      title: 'Privacy & Security',
      subtitle: 'Manage privacy and data settings',
    ),
    ProfileMenuItem(
      iconAsset: AppAssets.iconSubscription,
      title: 'Subscription',
      subtitle: 'Manage your plan and billing',
      badge: 'Coming Soon',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ProfileMenuTile(item: _items[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: _items.length,
        ),
      ),
    );
  }
}

class ProfileMenuItem {
  const ProfileMenuItem({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    this.badge,
  });

  final String iconAsset;
  final String title;
  final String subtitle;
  final String? badge;
}

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({super.key, required this.item});

  final ProfileMenuItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(34),
        child: Ink(
          height: 66,
          padding: const EdgeInsets.fromLTRB(14, 9, 18, 9),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(34),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Row(
            children: [
              _ProfileMenuIcon(iconAsset: item.iconAsset),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (item.badge != null) ...[
                const SizedBox(width: 10),
                _ProfileMenuBadge(label: item.badge!),
              ],
              const SizedBox(width: 12),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFD5D8DA),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileMenuIcon extends StatelessWidget {
  const _ProfileMenuIcon({required this.iconAsset});

  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cardBackground,
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Center(
        child: Image.asset(
          iconAsset,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image_not_supported_outlined,
              color: Colors.white,
              size: 20,
            );
          },
        ),
      ),
    );
  }
}

class _ProfileMenuBadge extends StatelessWidget {
  const _ProfileMenuBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.notificationBadge.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          maxLines: 1,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.notificationBadge,
            fontSize: 8,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
