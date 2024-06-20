import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desired_job/gen/assets.gen.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:flutter_svg/svg.dart';

class DJAvatarNetwork extends StatelessWidget {
  const DJAvatarNetwork({
    super.key,
    required this.path,
    this.width = 40.0,
    this.height = 40.0,
  });

  final String? path;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: !(path ?? '').contains('http')
          ? SvgPicture.asset(
              Assets.icons.icLogoApp,
              width: width,
              height: height,
            )
          : Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: DJColor.h26E543),
                  borderRadius: BorderRadius.circular(width)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width),
                child: CachedNetworkImage(
                  imageUrl: path!,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Padding(
                    padding: EdgeInsets.all(6),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: DJColor.h26E543,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
    );
  }
}
