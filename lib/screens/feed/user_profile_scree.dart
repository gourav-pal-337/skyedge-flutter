import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skyedge/constants/app_textstyle.dart';
import 'package:skyedge/my_appbar.dart';
import 'package:skyedge/show_image.dart';
import 'package:skyedge/theme/app_theme.dart';
import 'package:skyedge/widgets/submit_button.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final List<Map<String, dynamic>> gridItems = [
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1694819488591-a43907d1c5cc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9nfGVufDB8fDB8fHww',
      'icon':
          "https://upload.wikimedia.org/wikipedia/commons/6/6c/Facebook_Logo_2023.png"
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1694819488591-a43907d1c5cc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9nfGVufDB8fDB8fHww',
      'icon':
          "https://cdn.prod.website-files.com/5d66bdc65e51a0d114d15891/64cebdd90aef8ef8c749e848_X-EverythingApp-Logo-Twitter.jpg",
      'text':
          'Pawsitively loving this moment with my furry friends! 🐶❤️ What’s your dog’s favorite treat?'
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt4-JLqqi-TFwZCN5_skhRBl8_tZecE3AZ_g&s',
      'icon':
          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1024px-Instagram_icon.png"
    },
    {
      'image':
          'https://cdn.pixabay.com/photo/2023/08/18/15/02/dog-8198719_1280.jpg',
      'icon':
          "https://upload.wikimedia.org/wikipedia/commons/6/6c/Facebook_Logo_2023.png"
    },
    {
      'image':
          'https://m.media-amazon.com/images/I/71YvB1o9zPL._AC_UF1000,1000_QL80_.jpg',
      'icon':
          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1024px-Instagram_icon.png"
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1694819488591-a43907d1c5cc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9nfGVufDB8fDB8fHww',
      'icon':
          "https://cdn.prod.website-files.com/5d66bdc65e51a0d114d15891/64cebdd90aef8ef8c749e848_X-EverythingApp-Logo-Twitter.jpg",
      'text':
          'Pawsitively loving this moment with my furry friends! 🐶❤️ What’s your dog’s favorite treat?'
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1694819488591-a43907d1c5cc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9nfGVufDB8fDB8fHww',
      'icon':
          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1024px-Instagram_icon.png"
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1694819488591-a43907d1c5cc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9nfGVufDB8fDB8fHww',
      'icon':
          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/1024px-Instagram_icon.png"
    },
    {
      'image':
          'https://plus.unsplash.com/premium_photo-1694819488591-a43907d1c5cc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9nfGVufDB8fDB8fHww',
      'icon':
          "https://upload.wikimedia.org/wikipedia/commons/6/6c/Facebook_Logo_2023.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF111111),
      appBar: MyAppBar(
        title: "Ruffles",
      ),
      // AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: const BackButton(color: Colors.white),
      //   title: const Text('Ruffles', style: TextStyle(color: Colors.white)),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            // Avatar
            const CircleAvatar(
              radius: 48,
              backgroundImage: NetworkImage(
                  'https://plus.unsplash.com/premium_photo-1694819488591-a43907d1c5cc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZG9nfGVufDB8fDB8fHww'),
            ),
            const SizedBox(height: 8),

            // Username & Bio
            const Text('Username', style: AppTextStyle.subtitle18Medium),
            const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
                textAlign: TextAlign.center,
                style: AppTextStyle.body14Medium,
              ),
            ),
            const SizedBox(height: 4),
            const Text('#hashtag', style: TextStyle(color: AppTheme.blue)),

            const SizedBox(height: 16),

            // Stats Row
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: _StatItem(count: '150', label: 'Posts')),
                  VerticalDivider(
                    color: AppTheme.greyText,
                    thickness: 1,
                    endIndent: 5,
                    indent: 5,
                  ),
                  Expanded(
                      child: _StatItem(count: '1,234', label: 'Followers')),
                  VerticalDivider(
                    color: AppTheme.greyText,
                    thickness: 1,
                    endIndent: 5,
                    indent: 5,
                  ),
                  Expanded(child: _StatItem(count: '180', label: 'Following')),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Follow Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SubmitButton(
                onTap: () {},
                label: 'Follow',
              ),
            ),

            const SizedBox(height: 12),

            // Grid
            StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: gridItems.map((item) {
                return SizedBox(
                    // width: .maxWidth / 2,
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _GridTile(item: item),
                ));
              }).toList(),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: LayoutBuilder(builder: (context, constrain) {
            //     return Wrap(
            //       children: gridItems.map((item) {
            //         return SizedBox(
            //             // width: constrain.maxWidth / 2,
            //             child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: _GridTile(item: item),
            //         ));
            //       }).toList(),
            //     );
            //   }),
            // GridView.builder(
            //   physics: const NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: gridItems.length,
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 12,
            //     crossAxisSpacing: 12,
            //     childAspectRatio: 1,
            //   ),
            //   itemBuilder: (context, index) {
            //     final item = gridItems[index];
            //     return _GridTile(item: item);
            //   },
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: AppTextStyle.subtitle18SemiBold),
        const SizedBox(height: 4),
        Text(label,
            style: AppTextStyle.button12.copyWith(color: AppTheme.greyText)),
      ],
    );
  }
}

class _GridTile extends StatelessWidget {
  final Map<String, dynamic> item;

  const _GridTile({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.containsKey('text')) {
      return Container(
        height: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ShowImage(
                height: 24,
                width: 24,
                imagelink: item['icon'],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                item['text'],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        ShowImage(
          imagelink: item['image'],
          boxFit: BoxFit.contain,
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Align(
            alignment: Alignment.topRight,
            child: ShowImage(
              height: 24,
              width: 24,
              imagelink: item['icon'],
            ),
          ),
        ),
      ],
    );
  }
}
