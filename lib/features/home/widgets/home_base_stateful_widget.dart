import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/app_styles.dart';
import 'package:provider_medical_valley/core/strings/images.dart';
import 'package:provider_medical_valley/features/home/history/presentation/history_screen.dart';
import 'package:provider_medical_valley/features/home/more_screen/presentation/more_screen.dart';
import 'package:provider_medical_valley/features/home/notifications/persentation/screens/notifications_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../home_screen/persentation/screens/home_screen.dart';

class HomeBaseStatefulWidget extends StatefulWidget {
  const HomeBaseStatefulWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeBaseStatefulWidgetState();
}

class HomeBaseStatefulWidgetState extends State<HomeBaseStatefulWidget> {
  final BehaviorSubject<int> _index = BehaviorSubject();

  @override
  initState() {
    _index.sink.add(0);
    super.initState();
  }

  @override
  dispose() {
    _index.stream.drain();
    _index.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: getBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
      //   floatingActionButton: getFloatingButton(),
    );
  }

  getBody() {
    return StreamBuilder<int>(
      stream: _index,
      builder: (context, snapshot) {
        if (snapshot.data == 0) {
          return const HomeScreen();
        } else if (snapshot.data == 1) {
          return const NotificationsScreen();
        } else if (snapshot.data == 2) {
          return const HistoryScreen();
        } else if (snapshot.data == 3) {
          return const MoreScreen();
        }
        return Container(
          color: Colors.green,
        );
      },
    );
  }

  buildBottomNavigationBar() {
    return StreamBuilder<int>(
        stream: _index,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            onTap: (newIndex) {
              _index.sink.add(newIndex);
            },
            currentIndex: snapshot.data ?? 0,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: AppStyles.baloo2FontWith600WeightAnd18Size,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(homeIconDeactivated),
                  activeIcon: SvgPicture.asset(homeIconActive),
                  backgroundColor: whiteColor,
                  label: AppLocalizations.of(context)!.home),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(notificationIconDeactivated),
                  activeIcon: SvgPicture.asset(notificationIconActive),
                  backgroundColor: whiteColor,
                  label: AppLocalizations.of(context)!.notifications),
              BottomNavigationBarItem(
                  icon: Stack(children: [
                    SvgPicture.asset(negotiationIconDeactivated),
                    Positioned(
                      // draw a red marble
                      top: 0.0,
                      left: 10.0,
                      child: Text(
                        "(23)",
                        style: AppStyles.baloo2FontWith400WeightAnd12Size
                            .copyWith(color: primaryColor),
                      ),
                    )
                  ]),
                  activeIcon: SvgPicture.asset(negotiationIconActive),
                  backgroundColor: whiteColor,
                  label: AppLocalizations.of(context)!.negotiation),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(menuIconDeactivated),
                  activeIcon: SvgPicture.asset(menuIconActive),
                  backgroundColor: whiteColor,
                  label: AppLocalizations.of(context)!.more),
            ],
          );
        });
  }
}
