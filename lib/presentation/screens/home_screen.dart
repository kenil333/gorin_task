import 'package:flutter/material.dart';
import 'package:gorin_task/utils/extensions/locale_extension.dart';
import 'package:provider/provider.dart';

import '../../helpers/firestore_helper.dart';
import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../../utils/app_size.dart';
import '../../utils/app_style.dart';
import '../providers/auth_provider.dart';
import '../widgets/common_loading.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: AppSize.topPadding + 80,
            width: double.infinity,
            padding: EdgeInsets.only(
              left: AppSize.size24,
              right: AppSize.size24,
              top: AppSize.topPadding,
            ),
            color: AppColor.primary,
            child: Row(
              children: [
                SizedBox(width: AppSize.size24),
                Expanded(
                  child: Text(
                    context.l10n.users,
                    style: AppStyle.font24600,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AuthProvider>().logout(
                      onSuccess: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.logout_rounded,
                    color: AppColor.white,
                    size: AppSize.size24,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirestoreHelper.users,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CommonLoading();
                } else if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    padding: EdgeInsets.only(
                      left: AppSize.size20,
                      right: AppSize.size20,
                      // top: AppSize.size20,
                      bottom: AppSize.bottomPadding,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) => Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.optionalButton,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              AppImage.appIcon,
                              width: AppSize.size.width * 0.16,
                              height: AppSize.size.width * 0.16,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: AppSize.size20),
                          Expanded(
                            child: Text(
                              snapshot.data!.docs[i].data()["name"],
                              style: AppStyle.font16400.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      context.l10n.nothingHere,
                      style: AppStyle.font20500,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
