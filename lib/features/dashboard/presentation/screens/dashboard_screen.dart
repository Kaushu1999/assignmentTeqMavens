import 'dart:ui';
import 'package:assignment/core/constants/app_colors.dart';
import 'package:assignment/core/constants/app_text_styles.dart';
import 'package:assignment/core/constants/static_constant_data.dart';
import 'package:assignment/core/widgets/app_background.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardBody();
  }
}

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  String _searchQuery = '';

  List<Property> get _filteredProperties {
    final query = _searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return properties;
    }

    return properties.where((property) {
      return property.title.toLowerCase().contains(query);
    }).toList();
  }

  void _handleSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final properties = _filteredProperties;

    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 75),
            const _DashboardHeader(),
            const SizedBox(height: 35),
            _SearchBar(onChanged: _handleSearchChanged),
            const SizedBox(height: 50),
            Expanded(
              child: properties.isEmpty
                  ? const _EmptySearchResult()
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 120),
                      itemCount: properties.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 22),
                      itemBuilder: (context, index) {
                        return _PropertyCard(property: properties[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Property {
  const Property({
    required this.imageUrl,
    required this.title,
    required this.distance,
    required this.available,
    required this.price,
  });

  final String imageUrl;
  final String title;
  final String distance;
  final String available;
  final String price;
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good Morning', style: AppTextStyles.dashBoard),
              Text('Prabhat', style: AppTextStyles.dashBoard),
            ],
          ),
        ),

        const SizedBox(width: 12),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: const Color(0xFF2C2C2C), width: 1),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),

          const Icon(Icons.search, color: Colors.white, size: 20),

          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              cursorColor: AppColors.primary,
              style: AppTextStyles.bodyLarge,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: 'Search Location',
                hintStyle: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              textInputAction: TextInputAction.search,
            ),
          ),

          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            icon: const Icon(
              Icons.mic_none_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({required this.property});

  final Property property;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                property.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF182126),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.white54,
                      size: 40,
                    ),
                  );
                },
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 70,
              height: 80,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white.withValues(alpha: 0.015),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.20),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _PropertyInfo(
                title: property.title,
                distance: property.distance,
                available: property.available,
                price: property.price,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No locations found',
        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}

class _PropertyInfo extends StatelessWidget {
  const _PropertyInfo({
    required this.title,
    required this.distance,
    required this.available,
    required this.price,
  });

  final String title;
  final String distance;
  final String available;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading2.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _PropertyDetail(label: 'Distance', value: distance),
              ),

              Expanded(
                child: Center(
                  child: _PropertyDetail(label: 'Available', value: available),
                ),
              ),

              Expanded(
                child: Center(
                  child: _PropertyDetail(label: 'Price', value: price),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PropertyDetail extends StatelessWidget {
  const _PropertyDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 13,
            color: const Color(0xFF8E9295),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
