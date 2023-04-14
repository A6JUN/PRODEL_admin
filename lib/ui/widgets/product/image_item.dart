import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prodel_admin/values/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        splashColor: Colors.grey[300],
        hoverColor: Colors.grey[200],
        focusColor: Colors.grey[50],
        onTap: () async {
          Uri imageUri = Uri.parse(imageUrl);

          if (await canLaunchUrl(imageUri)) {
            await launchUrl(imageUri);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
