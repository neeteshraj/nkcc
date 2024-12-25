import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:support/core/constants/images_paths.dart';
import 'package:support/core/theme/app_colors.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSettingsPressed;
  final ValueChanged<String> onSearchChanged;
  final FocusNode focusNode;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onSettingsPressed,
    required this.onSearchChanged,
    required this.focusNode,
  });

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearchChanged(query); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border.all(color: AppColors.textSecondary),
        borderRadius: BorderRadius.circular(12.0), // Apply consistent border radius
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            ImagesPaths.search,
            color: Colors.white,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
              cursorColor: AppColors.white,
            ),
          ),
          IconButton(
            onPressed: widget.onSettingsPressed,
            icon: SvgPicture.asset(
              ImagesPaths.filter,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }

}
