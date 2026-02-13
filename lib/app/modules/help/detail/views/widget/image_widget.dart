import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:vigo_customer_billing/app/data/models/models.dart';

class ImageWidget extends StatelessWidget {
  final HelpModel data;
  const ImageWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderboxColor, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: data.attachmentUrl != null
            ? GestureDetector(
                onTap: () {
                  Get.dialog(
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.black.withOpacity(0.2),
                          child: SizedBox.expand(
                            child: InteractiveViewer(
                              child:
                                  // Image.network(data.img),
                                  Image.network(
                                    data.attachmentUrl ?? '',
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Text('Failed to load image'),
                                      );
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                  ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 25,
                            ),
                            onPressed: () => Get.back(),
                          ),
                        ),
                      ],
                    ),
                    barrierDismissible: true,
                  );
                },
                child: Image.network(
                  data.attachmentUrl ?? '',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Text('Failed to load image'));
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              )
            : Text('-'),
      ),
    );
  }
}
