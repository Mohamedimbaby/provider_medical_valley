import 'package:flutter/material.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:provider_medical_valley/features/home/widgets/home_base_stateful_widget.dart';

import 'base_stateful_widget.dart';

class NoInternetConnectionWidget extends BaseStatefulWidget {
  const NoInternetConnectionWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NoInternetConnectionState();
}

class NoInternetConnectionState extends BaseStatefulWidgetState {
  @override
  getScreenBody() {
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const HomeBaseStatefulWidget())),
      child: Container(
        alignment: AlignmentDirectional.center,
        child: Image.asset(noInternetIcon),
      ),
    );
  }
}
