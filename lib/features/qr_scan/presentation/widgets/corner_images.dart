import 'package:flutter/material.dart';
import 'package:support/core/constants/images_paths.dart';
import 'package:support/core/utils/size_utils.dart';

class CornerImages extends StatelessWidget {
  const CornerImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: SizeUtils.getHeight(context, 0.198),
          left: SizeUtils.getWidth(context, 0.049),
          child: Image.asset(
            ImagesPaths.topLeft,
            width: 40,
            height: 40,
          ),
        ),
        Positioned(
          top: SizeUtils.getHeight(context, 0.198),
          right: SizeUtils.getWidth(context, 0.049),
          child: Image.asset(
            ImagesPaths.topRight,
            width: 40,
            height: 40,
          ),
        ),
        Positioned(
          bottom: SizeUtils.getHeight(context, 0.198),
          left: SizeUtils.getWidth(context, 0.049),
          child: Image.asset(
            ImagesPaths.bottomLeft,
            width: 40,
            height: 40,
          ),
        ),
        Positioned(
          bottom: SizeUtils.getHeight(context, 0.198),
          right: SizeUtils.getWidth(context, 0.049),
          child: Image.asset(
            ImagesPaths.bottomRight,
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }
}
