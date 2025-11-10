import 'package:vigo_customer_billing/app/core/controllers/profile_controller.dart';
import 'package:vigo_customer_billing/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HeaderDashboard extends StatelessWidget {
  const HeaderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final profile_c = Get.find<ProfileController>();
    return ClipPath(
      clipper: HeaderDashboardClipPath(),
      child: Container(
        height: 269,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF690305), Color(0xFFAC0205)],
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 50),
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang, ',
                      style: monseratTextFont.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    Obx(
                      () => Skeletonizer(
                        enabled: profile_c.isLoading.value,
                        child: Text(
                          '${profile_c.accountbillData.value!.customer.name ?? 'Tidak Diketahui'}',
                          style: monseratTextFont.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderDashboardClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    // Start at the top left corner
    path.lineTo(0.0, size.height - 50);

    // Draw an oval bottom
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );

    // Complete the path
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
