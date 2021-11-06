import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../logic/global/profile_list.dart';
import '../../../../logic/global/variables.dart';
import '../controller/profile_controller.dart';
import '../../../templates/export.dart';
import '../../../theme/theme.dart';
import '../../../../resources/assets/assets.gen.dart';
import 'package:spaces/spaces.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AppWrapper(
        child: Padding(
          padding: context.spacing().insets.horizontal.normal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              AutoSizeText(
                'Profile',
                style: context.h5.copyWith(
                  color: isDarkMode ? AppColors.white : AppColors.blackPrimary,
                ),
              ),
              const Space.normal(),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.greyLight,
                    maxRadius: 40,
                    backgroundImage: AssetImage(
                      Assets.images.avatargold.path,
                    ),
                  ),
                  const Space.normal(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        user?.value.username == null
                            ? 'cartonuser'
                            : '${user?.value.username}',
                        style: context.h6.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? AppColors.white
                              : AppColors.blackPrimary,
                        ),
                      ),
                      AutoSizeText(
                        '${user?.value.email}',
                        overflow: TextOverflow.fade,
                        style: context.bodyText1.copyWith(
                          color: AppColors.greyPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Space.normal(),
              ProfileCard(
                label: 'notification'.tr,
                trailing: Switcher(
                  value: false,
                  size: SwitcherSize.medium,
                  iconOff: EvaIcons.bell,
                  enabledSwitcherButtonRotate: true,
                  colorOff: AppColors.greyLight,
                  colorOn: AppColors.purplePrimary,
                  onChanged: (bool state) {
                    //
                  },
                ),
              ),
              const Space.small(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: profileList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: context.spacing().insets.vertical.semiSmall,
                    child: ProfileCard(
                      onTap: () => controller.navigateToNextScreen(index),
                      label: profileList[index],
                    ),
                  );
                },
              ),
              const Space.small(),
              InkWell(
                onTap: () => controller.handleSignOut(context),
                child: ProfileCard(
                  label: 'signOut'.tr,
                  trailing: const Icon(
                    EvaIcons.logOut,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.label,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final String label;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: AppColors.greyLighter,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: AutoSizeText(
            label.tr,
            style: context.h6.copyWith(
              color: AppColors.blackPrimary,
            ),
          ),
          trailing: trailing ?? const Icon(EvaIcons.arrowIosForward),
        ),
      ),
    );
  }
}
