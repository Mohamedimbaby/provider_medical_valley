import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_styles.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String goodMorningText;
  final Widget leadingIcon;
  final Widget hiddenWidget;
  final TextEditingController controller;

  CustomHomeAppBar(
      {required this.goodMorningText,
      required this.leadingIcon,
      required this.hiddenWidget,
      required this.controller,
      Key? key});

  BehaviorSubject<bool> _isClicked = BehaviorSubject();

  @override
  Widget build(BuildContext context) {
    _isClicked.sink.add(false);
    return StreamBuilder<bool>(
        stream: _isClicked,
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.only(top: 30),
            decoration: const BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30.h,
                        ),
                        leadingIcon,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20.h,
                                ),
                                Text(
                                  goodMorningText,
                                  style: AppStyles
                                      .baloo2FontWith700WeightAnd17Size,
                                ),
                                Image.asset(
                                  handIcon,
                                )
                              ],
                            ),
                            Text(
                              "?????????? ????????",
                              style: AppStyles.baloo2FontWith400WeightAnd22Size,
                            ),
                          ],
                        ),
                      ],
                    )),
                    InkWell(
                        onTap: () => _isClicked.sink.add(!_isClicked.value),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 20.0),
                          child: snapshot.hasData && snapshot.data == true
                              ? SvgPicture.asset(planIconDown)
                              : SvgPicture.asset(planIcon),
                        )),
                  ],
                ),
                StreamBuilder<bool>(
                    stream: _isClicked,
                    builder: (context, snapshot) {
                      return snapshot.hasData && snapshot.data == true
                          ? Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 40.h,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .reply_to_customers,
                                        style: AppStyles
                                            .baloo2FontWith400WeightAnd16Size,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: false,
                                          activeColor: whiteColor,
                                          checkColor: primaryColor,
                                          fillColor: MaterialStateProperty.all(
                                              whiteColor),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          onChanged: (newValue) {},
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .auto_replay,
                                          style: AppStyles
                                              .baloo2FontWith400WeightAnd14Size
                                              .copyWith(color: whiteColor),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: false,
                                          activeColor: whiteColor,
                                          checkColor: primaryColor,
                                          fillColor: MaterialStateProperty.all(
                                              whiteColor),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          onChanged: (newValue) {},
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .within_three_hours,
                                          style: AppStyles
                                              .baloo2FontWith400WeightAnd14Size
                                              .copyWith(color: whiteColor),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          : Container();
                    })
              ],
            ),
          );
        });
  }

  @override
  Size get preferredSize => Size.fromHeight(180.h);
}
