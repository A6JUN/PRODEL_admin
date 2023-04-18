import 'package:flutter/material.dart';
import 'package:prodel_admin/ui/widgets/custom_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductImagesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> images;
  const ProductImagesScreen({
    super.key,
    required this.images,
  });

  @override
  State<ProductImagesScreen> createState() => _ProductImagesScreenState();
}

class _ProductImagesScreenState extends State<ProductImagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Product Images',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Divider(
                thickness: 1,
                color: Color.fromARGB(255, 165, 163, 163),
                height: 30,
              ),
              widget.images.isNotEmpty
                  ? Expanded(
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: List<Widget>.generate(
                          widget.images.length,
                          (index) => ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: widget.images[index]['url'],
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                              progressIndicatorBuilder:
                                  (context, url, progress) => const Center(
                                      child: CustomProgressIndicator()),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Text(
                      'No images found',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
