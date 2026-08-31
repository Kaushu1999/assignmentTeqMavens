import 'package:assignment/core/constants/app_assets.dart';
import 'package:assignment/core/constants/app_colors.dart';
import 'package:assignment/core/constants/app_text_styles.dart';
import 'package:assignment/core/widgets/app_background.dart';
import 'package:flutter/material.dart';

class HotelResortScreen extends StatefulWidget {
  const HotelResortScreen({super.key});

  @override
  State<HotelResortScreen> createState() => _HotelResortScreenState();
}

class _HotelResortScreenState extends State<HotelResortScreen> {
  static const HotelResort _hotel = HotelResort(
    heroImageAssets: [AppAssets.resortAsset2, AppAssets.resortAsset1],
    hostImageAsset: AppAssets.userProfile,
    hostName: 'Trang Luxury',
    hostCategory: 'Lifestyle',
    rating: '4.9',
    reviews: '1,648 reviews',
    availableDates: 'OCT 24 - 26',
    address: '1155 Rue Sherbrooke Ouest, Toronto,\nCanada H3A 2N3',
    description:
        'Experience a comfortable and memorable stay at our hotel, where modern amenities, warm hospitality, and convenient surroundings come together. Designed for both business and leisure travelers, the hotel offers well-appointed rooms, quality facilities, and attentive service to make every stay relaxing and enjoyable. Guests can enjoy comfortable accommodation, delicious dining options, high-speed Wi-Fi, housekeeping services, and convenient access to nearby attractions and business destinations. Whether you are visiting for a short business trip, a family vacation, or a weekend getaway, our hotel provides everything you need for a pleasant and hassle-free stay. With a welcoming atmosphere, thoughtful services, and a commitment to guest satisfaction, we aim to make every visit comfortable, convenient, and memorable.',
  );

  final PageController _heroPageController = PageController();
  int _activeHeroIndex = 0;

  @override
  void dispose() {
    _heroPageController.dispose();
    super.dispose();
  }

  void _handleHeroPageChanged(int index) {
    setState(() {
      _activeHeroIndex = index;
    });
  }

  void _goToHeroPage(int index) {
    _heroPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroImage(
              hotel: _hotel,
              controller: _heroPageController,
              activeIndex: _activeHeroIndex,
              onPageChanged: _handleHeroPageChanged,
              onIndicatorTap: _goToHeroPage,
            ),
            const SizedBox(height: 40),

            Transform.translate(
              offset: const Offset(0, -46),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    _DescriptionSection(description: _hotel.description),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelResort {
  const HotelResort({
    required this.heroImageAssets,
    required this.hostImageAsset,
    required this.hostName,
    required this.hostCategory,
    required this.rating,
    required this.reviews,
    required this.availableDates,
    required this.address,
    required this.description,
  });

  final List<String> heroImageAssets;
  final String hostImageAsset;
  final String hostName;
  final String hostCategory;
  final String rating;
  final String reviews;
  final String availableDates;
  final String address;
  final String description;
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({
    required this.hotel,
    required this.controller,
    required this.activeIndex,
    required this.onPageChanged,
    required this.onIndicatorTap,
  });

  final HotelResort hotel;
  final PageController controller;
  final int activeIndex;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onIndicatorTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.60,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              width: double.infinity,
              child: PageView.builder(
                controller: controller,
                physics: const PageScrollPhysics(),
                itemCount: hotel.heroImageAssets.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return Image.asset(
                    hotel.heroImageAssets[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(
                        color: Color(0xFF182126),
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.white54,
                          size: 42,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.28),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                _ImagePageIndicator(
                  activeIndex: activeIndex,
                  count: hotel.heroImageAssets.length,
                  onTap: onIndicatorTap,
                ),
                const SizedBox(height: 20),
                _HotelInfoCard(hotel: hotel),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePageIndicator extends StatelessWidget {
  const _ImagePageIndicator({
    required this.activeIndex,
    required this.count,
    required this.onTap,
  });

  final int activeIndex;
  final int count;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final selected = index == activeIndex;

        return GestureDetector(
          onTap: () => onTap(index),
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: index == count - 1 ? 24 : 29,
            height: 24,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                width: selected ? 20 : 18,
                height: 5,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.notificationBadge
                      : Colors.white.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _HotelInfoCard extends StatelessWidget {
  const _HotelInfoCard({required this.hotel});

  final HotelResort hotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(26, 40, 26, 40),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(34),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _HostAvatar(imageAsset: hotel.hostImageAsset),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  'Hosted by ${hotel.hostName},\n${hotel.hostCategory}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading3.copyWith(
                    fontSize: 20,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          _HotelStatsRow(hotel: hotel),
          const SizedBox(height: 26),
          _AddressRow(address: hotel.address),
        ],
      ),
    );
  }
}

class _HostAvatar extends StatelessWidget {
  const _HostAvatar({required this.imageAsset});

  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        imageAsset,
        width: 68,
        height: 68,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 68,
            height: 68,
            color: AppColors.primary.withValues(alpha: 0.18),
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          );
        },
      ),
    );
  }
}

class _HotelStatsRow extends StatelessWidget {
  const _HotelStatsRow({required this.hotel});

  final HotelResort hotel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.white, size: 17),
        const SizedBox(width: 5),
        Text(hotel.rating, style: AppTextStyles.bodyMedium),
        const _StatDivider(),
        Flexible(
          child: Text(
            hotel.reviews,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(fontSize: 15),
          ),
        ),
        const _StatDivider(),
        Flexible(
          child: Text(
            hotel.availableDates,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 18,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white.withValues(alpha: 0.18),
    );
  }
}

class _AddressRow extends StatelessWidget {
  const _AddressRow({required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.location_on_outlined,
            color: Colors.white,
            size: 23,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            address,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontSize: 16,
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: AppTextStyles.heading3.copyWith(fontSize: 17),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontSize: 16,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
