import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skyedge/constants/app_assets.dart';

Image myErrorImage = Image.asset(
  AppAssets.logo,
);

class ShowImage extends StatelessWidget {
  const ShowImage({
    this.imagelink = '',
    this.boxFit = BoxFit.cover,
    this.height,
    this.width,
    super.key,
  });
  final dynamic imagelink;
  final double? width;
  final double? height;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    // debugPrint('imageLink Runtype : ${imagelink.runtimeType}');
    if (imagelink == '' || imagelink == null) {
      return SizedBox(
        height: height,
        width: width,
        child: FancyShimmerImage(
          imageUrl: imagelink,
          boxFit: boxFit,
          errorWidget: myErrorImage,
        ),
      );
    } else if (imagelink.runtimeType != String) {
      return SizedBox(
        height: height,
        width: width,
        child: Image.file(
          imagelink,
          fit: boxFit,
        ),
      );
    } else if (imagelink.toString().contains('http') &&
        imagelink.toString().contains('://')) {
      return SizedBox(
        height: height,
        width: width,
        child: FancyShimmerImage(
          imageUrl: imagelink,
          boxFit: boxFit,
          errorWidget: myErrorImage,
        ),
      );
    } else if (imagelink.toString().contains('.svg') &&
        imagelink.toString().contains('assets')) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(
          imagelink,
          fit: boxFit,
        ),
      );
    } else if (imagelink.toString().contains('data:') &&
        imagelink.toString().contains(';base')) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.network(
          imagelink,
          fit: boxFit,
        ),
      );
    } else {
      return SizedBox(
        height: height,
        width: width,
        child: Image.asset(
          imagelink,
          fit: boxFit,
        ),
      );
    }
  }
}

class FancyShimmerImage extends StatelessWidget {
  const FancyShimmerImage({
    required this.imageUrl,
    this.boxFit = BoxFit.fill,
    this.width = 300,
    this.height = 300,
    this.shimmerDuration = const Duration(milliseconds: 1500),
    this.cacheKey,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.shimmerBackColor,
    this.errorWidget,
    this.boxDecoration,
    this.color,
    this.alignment,
    this.imageBuilder,
    super.key,
  });

  final String imageUrl;
  final double width;
  final double height;

  final Duration shimmerDuration;
  final BoxFit boxFit;
  final String? cacheKey;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Color? shimmerBackColor;
  final Widget? errorWidget;
  final BoxDecoration? boxDecoration;
  final Color? color;
  final Alignment? alignment;
  final ImageWidgetBuilder? imageBuilder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        alignment: alignment ?? Alignment.center,
        color: color,
        imageUrl: imageUrl,
        cacheKey: cacheKey,
        fit: boxFit,
        width: width,
        height: height,
        imageBuilder: imageBuilder,
        placeholder: (context, url) => const Center(
              child: CupertinoActivityIndicator(),
            ),
        errorWidget: (context, url, error) => myErrorImage);
  }
}
