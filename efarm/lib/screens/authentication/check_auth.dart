
import 'package:efarm/screens/consumer/consumer_dashboard.dart';
import 'package:efarm/screens/farmer/farmer_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../helper/loading_widget.dart';
import '../../utils/app_constant.dart';
import '../../widgets/loading_widget_lottie.dart';
import '../welcome.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AppStarted || state is Loading) {
          return const LoadingWidgetLottie();
        }
        if (state is Authenticated) {
          return state.user.type == 'Farmer' ? const FarmerDashboard() : const ConsumerDashboard();
        }
        if (state is Unauthenticated) {
          return const WelcomeScreen();
        }
        if (state is Error) {
          return const WelcomeScreen();
        }
        return const LoadingWidget();
      },
    );
  }
}
