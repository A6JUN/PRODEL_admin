import 'package:flutter/material.dart';
import 'package:prodel_admin/ui/widgets/product/image_item.dart';

class ShowImagesDialog extends StatelessWidget {
  final List<Map<String, dynamic>> images;
  const ShowImagesDialog({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          width: 1,
          color: Colors.black26,
        ),
      ),
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Images',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              images.isNotEmpty
                  ? Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List<Widget>.generate(
                        images.length,
                        (index) => ImageItem(
                          imageUrl: images[index]['image_url'],
                        ),
                      ),
                    )
                  : const Text('No images found !'),
            ],
          ),
        ),
      ),
    );
  }
}
