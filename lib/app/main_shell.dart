import 'package:app_boilerplate/core/constants/app_assets.dart';
import 'package:app_boilerplate/core/constants/app_colors.dart';
import 'package:app_boilerplate/core/extensions/context_extensions.dart';
import 'package:app_boilerplate/features/cart/presentation/pages/cart_page.dart';
import 'package:app_boilerplate/features/home/presentation/pages/home_page.dart';
import 'package:app_boilerplate/features/settings/presentation/pages/you_page.dart';
import 'package:app_boilerplate/features/shop/presentation/pages/shop_page.dart';
import 'package:app_boilerplate/features/train/presentation/pages/train_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Hosts the five main tabs (Home, Train, Shop, Cart, You) with the lime
/// bottom navigation bar.
class MainShell
    extends
        StatefulWidget {
  const MainShell({
    super.key,
    this.initialIndex = 0,
  });

  final int initialIndex;

  @override
  State<
    MainShell
  >
  createState() => _MainShellState();
}

class _MainShellState
    extends
        State<
          MainShell
        > {
  late int _index = widget.initialIndex;

  void
  _onTap(
    int index,
  ) => setState(
    () => _index = index,
  );

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: IndexedStack(
        index: _index,
        children: const [
          HomePage(),
          TrainPage(),
          ShopPage(),
          CartPage(),
          YouPage(),
        ],
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _index,
        onTap: _onTap,
        labels: [
          l10n.navHome,
          l10n.navTrain,
          l10n.navShop,
          l10n.navCart,
          l10n.navYou,
        ],
      ),
    );
  }
}

class _BottomNav
    extends
        StatelessWidget {
  const _BottomNav({
    required this.currentIndex,
    required this.onTap,
    required this.labels,
  });

  final int currentIndex;
  final ValueChanged<
    int
  >
  onTap;
  final List<
    String
  >
  labels;

  static const _icons = [
    AppAssets.iconHouse,
    AppAssets.iconDumbbell,
    AppAssets.iconShoppingBag,
    AppAssets.iconShoppingCart,
    AppAssets.iconUserRound,
  ];

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.grey.withValues(
              alpha: 0.2,
            ),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              labels.length,
              (
                index,
              ) {
                final selected =
                    index ==
                    currentIndex;
                return GestureDetector(
                  onTap: () => onTap(
                    index,
                  ),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.lime
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              999,
                            ),
                          ),
                          child: SvgPicture.asset(
                            _icons[index],
                            width: 22,
                            height: 22,
                            colorFilter: ColorFilter.mode(
                              selected
                                  ? AppColors.charcoal
                                  : AppColors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          labels[index],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: selected
                                ? AppColors.charcoal
                                : AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
