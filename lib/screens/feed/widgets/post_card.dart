import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_assets.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/screens/feed/widgets/send_token_popup.dart';
import 'package:skyedge/screens/feed/widgets/tokenize_action_popup.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/show_image.dart';

class PostCard extends StatefulWidget {
  final String username;
  final String postText;
  final String? imageUrl;
  final String? platformIcon;
  final int likes, comments, shares, badgeCount;

  const PostCard({
    required this.username,
    required this.postText,
    this.imageUrl,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.badgeCount = 0,
    this.platformIcon,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        // borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User row
          Row(
            children: [
              // const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
              GestureDetector(
                onTap: () => context.push(AppRoutes.userProfileScreen),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: ShowImage(
                    height: 40,
                    width: 40,
                    imagelink:
                        "https://cdn.shopify.com/s/files/1/0086/0795/7054/files/Golden-Retriever.jpg?v=1645179525",
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.username,
                        style: AppTextStyle.button12
                            .copyWith(fontWeight: FontWeight.bold)),
                    const Text('Following',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: ShowImage(
                  height: 20,
                  width: 20,
                  imagelink: widget.platformIcon ??
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1024px-Instagram_icon.png",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Post text
          Text(widget.postText, style: AppTextStyle.body14Regular),
          const SizedBox(height: 12),

          // Optional image
          if (widget.imageUrl != null)
            LayoutBuilder(builder: (context, constrains) {
              return SizedBox(
                width: constrains.maxWidth,
                height: constrains.maxWidth,
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(12),
                  child: Image.network(widget.imageUrl!, fit: BoxFit.cover),
                ),
              );
            }),

          const SizedBox(height: 12),

          // Bottom bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _IconWithText(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  icon: SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 30,
                        color: isLiked
                            ? Colors.red
                            : AppTheme.blacktextColor(context)),
                  ),
                  label: widget.likes.toString()),
              _IconWithText(
                  icon: SvgPicture.asset(AppAssets.commentIcon,
                      height: 25,
                      width: 25,
                      color: AppTheme.blacktextColor(context)),
                  label: widget.comments.toString()),
              _IconWithText(
                  icon: SvgPicture.asset(AppAssets.shareIcon,
                      height: 30,
                      width: 30,
                      color: AppTheme.blacktextColor(context)),
                  label: widget.shares.toString()),
              _IconWithText(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => Dialog(child: const SendTokenPopup()));
                  },
                  icon: ShowImage(
                    height: 30,
                    width: 30,
                    imagelink: AppAssets.skyCoin,
                  ),
                  label: widget.badgeCount.toString(),
                  iconColor: Colors.blueAccent),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconWithText extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color iconColor;
  final void Function()? onTap;

  const _IconWithText({
    required this.icon,
    required this.label,
    this.iconColor = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Row(
        children: [
          icon,
          const SizedBox(width: 4),
          Text(label, style: AppTextStyle.button12),
        ],
      ),
    );
  }
}
