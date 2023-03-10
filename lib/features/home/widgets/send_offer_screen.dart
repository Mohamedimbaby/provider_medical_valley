import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/dialogs/loading_dialog.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:provider_medical_valley/core/widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider_medical_valley/core/widgets/primary_button.dart';
import 'package:provider_medical_valley/core/widgets/snackbars.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/models/requets_model.dart';
import 'package:provider_medical_valley/features/home/negotiation/bloc/negotiation_bloc.dart';
import 'package:provider_medical_valley/features/home/negotiation/data/offer_model.dart';
import 'package:rxdart/rxdart.dart';
class SendOfferScreen extends StatelessWidget {
  BookRequest result ;
  List<String> slots = [
  "09:00",
  "09:30",
  "10:00",
  "10:30",
  "11:00",
  "11:30",
  "12:00",
  "12:30",
  "01:00",
  "01:30",
  "02:00",
  ];
   SendOfferScreen({
     required this.result ,
     Key? key}) : super(key: key);
   var _formKey = GlobalKey<FormState>();
  NegotiationBloc negotiationBloc = GetIt.instance<NegotiationBloc>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        header: AppLocalizations.of(context)!.negotiation,
        leadingIcon: GestureDetector(
            onTap : () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios )),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            BlocListener<NegotiationBloc , NegotiationState>(
              bloc: negotiationBloc,
                listener: (context, state) {
                  if (state is LoadingNegotiationState) {
                    LoadingDialogs.showLoadingDialog(context);
                  }
                  else if (state is SuccessNegotiationState) {
                    LoadingDialogs.hideLoadingDialog();
                    CoolAlert.show(
                      barrierDismissible: false,
                      context: context,
                      onConfirmBtnTap: () async {
                        Navigator.pop(context);
                        Navigator.pop(context);

                      },
                      type: CoolAlertType.success,
                      text: AppLocalizations.of(context)!.offer_sent_success,
                    );
                  } else {
                    LoadingDialogs.hideLoadingDialog();
                    CoolAlert.show(
                      barrierDismissible: false,
                      context: context,
                      onConfirmBtnTap: () async {
                        Navigator.pop(context);
                      },
                      type: CoolAlertType.error,
                      text: AppLocalizations.of(context)!.something_went_wrong,
                    );
                  }
                },
              child: Container(),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade300),
                                image:  const DecorationImage(
                                  image: AssetImage(personImage),
                                )),
                          ),
                          const SizedBox(width: 22,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "3 min",
                                style: AppStyles.baloo2FontWith500WeightAnd22Size
                                    .copyWith(color: blackColor,fontSize: 18),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xffEB8B17),
                                    size: 16,
                                  ),
                                  Text(
                                    "4.2",
                                    style: AppStyles.baloo2FontWith400WeightAnd12Size
                                        .copyWith(color: lightGrey),
                                  ),

                                ],
                              ),
                              Text(
                                "name",
                                style: AppStyles.baloo2FontWith400WeightAnd18Size
                                    .copyWith(
                                    color: blackColor,
                                    decoration: TextDecoration.none),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 3.h),
                              Row(
                                children: [
                                  SvgPicture.asset(cardIconOne,),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "category",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.baloo2FontWith400WeightAnd16Size
                                        .copyWith(color: blackColor),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  SvgPicture.asset(cardIconTwo),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "service",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.baloo2FontWith400WeightAnd16Size
                                        .copyWith(color: blackColor),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 24.h,),
                      const Divider(thickness: 2,),
                      SizedBox(height: 18.h,),

                      Text(AppLocalizations.of(context)!.send_negotiation, style: AppStyles.baloo2FontWith500WeightAnd16Size.copyWith(color: blackColor),),
                      SizedBox(height: 32.h,),
                      Text(AppLocalizations.of(context)!.choose_time, style: AppStyles.baloo2FontWith500WeightAnd16Size.copyWith(color: blackColor),),

                      SizedBox(height: 16.h,),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: slots.length,
                            scrollDirection :Axis.horizontal,
                            itemBuilder: _buildSlot),
                      ),

                      SizedBox(height: 32.h,),
                      Text(AppLocalizations.of(context)!.enter_price, style: AppStyles.baloo2FontWith400WeightAnd14Size.copyWith(color: blackColor),),
                      SizedBox(height: 8.h,),
                      SizedBox(
                        width: 140,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller,
                          validator: (text) => text!.isEmpty ? AppLocalizations.of(context)!.price_invalid : null,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.price,
                            suffix: Text("SR" , style: AppStyles.baloo2FontWith400WeightAnd14Size,),
                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: grey)),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: primaryColor))

                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 25,
              right: 25,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: PrimaryButton(
                onPressed: () {
                  String userEncoded = LocalStorageManager.getUser();
                Map<String, dynamic> user = jsonDecode(userEncoded);
                  if(_formKey.currentState!.validate()){
                    negotiationBloc.sendOffer(SendOffer(
                      price: int.parse(controller.text),
                      requestId: result.id,
                      id: user["data"]["id"],
                      userId: result.userId,
                      slot: slots[selectedBorder.value],
                    ));
                  }else {
                    context.showSnackBar(AppLocalizations.of(context)!.please_fill_all_data);
                  }

                },
                text: AppLocalizations.of(context)!.send,
            ),
              ),)
          ],
        ),
      ),
    );
  }
  BehaviorSubject<int> selectedBorder = BehaviorSubject.seeded(0);
  Widget _buildSlot(BuildContext context, int index) {
    return StreamBuilder<int>(
      stream: selectedBorder.stream,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: ()=> selectedBorder.sink.add(index),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration:  BoxDecoration(
              color: selectedBorder.value != index  ? whiteColor : primaryColor,
              border: Border.all(
                color: selectedBorder.value != index  ? borderGrey : whiteColor
              )
            ),
            child: Text(slots[index] , style: AppStyles.baloo2FontWith400WeightAnd18Size.copyWith(color: selectedBorder.value != index ? blackColor : whiteColor,decoration: TextDecoration.none),),
          ),
        );
      }
    );

  }
}
