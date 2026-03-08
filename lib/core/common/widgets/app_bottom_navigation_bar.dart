import 'package:flutter/material.dart';
import 'package:vision_bot_mobile_app/core/resources/colors/color_palette.dart';
import 'package:vision_bot_mobile_app/core/resources/consts/image_consts.dart';
import 'package:vision_bot_mobile_app/src/home/providers/home_controller.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.controller,
    super.key,
  });

  final HomeController controller;

  bool _isSelected(int index) => controller.currentIndex == index;

  Widget _buildIconItem(Widget icon, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedScale(
          scale: isSelected ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: icon,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: EdgeInsets.only(top: isSelected ? 1 : 2),
          height: 6,
          width: isSelected ? 6 : 0,
          decoration: const BoxDecoration(
            color: ColorPalette.primaryColor,
          ),
        )
      ],
    );
  }

  BottomNavigationBarItem _item({
    required Widget icon,
    required int index,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: _buildIconItem(icon, _isSelected(index)),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall!;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.withAlpha(70),
          ),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
        ),
        child: BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: controller.changeIndex,
          backgroundColor: ColorPalette.backgroundColor,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: labelStyle,
          unselectedLabelStyle: labelStyle,
          selectedItemColor: ColorPalette.primaryColor,
          unselectedItemColor: Colors.white,
          elevation: 0,
          items: [
            _item(
              index: 0,
              label: 'robot',
              icon: ImageConsts.robotImage(
                color: _isSelected(0) ? ColorPalette.primaryColor : Colors.grey,
              ),
            ),
            _item(
              index: 1,
              label: 'control',
              icon: ImageConsts.controlImage(
                color: _isSelected(1) ? ColorPalette.primaryColor : Colors.grey,
              ),
            ),
            _item(
              index: 2,
              label: 'camera',
              icon: ImageConsts.cameraImage(
                color: _isSelected(2) ? ColorPalette.primaryColor : Colors.grey,
              ),
            ),
            _item(
              index: 3,
              label: 'settings',
              icon: ImageConsts.settingsImage(
                color: _isSelected(3) ? ColorPalette.primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
