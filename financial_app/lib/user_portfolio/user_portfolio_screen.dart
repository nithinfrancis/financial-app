import 'package:financial_app/models/user.dart';
import 'package:financial_app/saved_cards/my_saved_cards_screen.dart';
import 'package:financial_app/utils/app_colors.dart';
import 'package:financial_app/utils/app_globals.dart';
import 'package:financial_app/widgets/chart/charts.dart';
import 'package:financial_app/widgets/custom_load_widget.dart';
import 'package:financial_app/widgets/transaction_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'user_portfolio_bloc.dart';

class UserPortfolioScreen extends StatefulWidget {
  const UserPortfolioScreen({Key? key}) : super(key: key);

  @override
  _UserPortfolioScreenState createState() => _UserPortfolioScreenState();
}

class _UserPortfolioScreenState extends State<UserPortfolioScreen> {
  final UserPortfolioBloc _bloc = UserPortfolioBloc(InitialUserScreenState());

  UserList? _userList;

  Widget circularProgress = Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: const <Widget>[
          Text(
            "Please Wait..",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(width: 100,),
          SizedBox(height: 30,
          width: 30,
          child: CircularProgressIndicator(),
          )
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserPortfolioBloc, UserPortfolioState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is UserLoadingState) {
        } else if (state is UserLoadErrorState) {
        } else if (state is UserLoadedState) {
          if (state.userApiResponseList != null) {
            _userList = state.userApiResponseList;
          }
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, UserPortfolioState state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                topSectionWidget(),
                Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 40, top: 30, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            headingWidget("PERFORMANCE CHART"),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const SavedCardScreen(),
                                  ),
                                );
                              },
                              child:moreButton(),
                            ),
                          ],
                        ),
                      ),
                      CustomChart(),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 20, top: 20),
                        child: headingWidget("TOP USERS FROM YOUR COMMUNITY"),
                      ),
                      SizedBox(
                        height: 100,
                        child: (state is UserLoadingState)
                            ? SizedBox(height: 100, child: circularProgress)
                            : SizedBox(
                          height: 100,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: _userList?.userList?.length ?? 0,
                            itemBuilder: (context, i) {
                              String fullName = _userList!.userList[i].username;
                              List<String> names = fullName.split(' ');
                              return SizedBox(
                                  width: 80,
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        userImageList[(i % 4)],
                                        height: 50,
                                        width: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          names.first,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            headingWidget("RECENT TRANSACTIONS"),
                            InkWell(
                                onTap: (){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const SavedCardScreen(),
                                    ),
                                  );
                                },
                                child: moreButton()),
                          ],
                        ),
                      ),
                      transactionTile(isSuccess: false),
                      transactionTile(isSuccess: true),
                      transactionTile(isSuccess: true),
                      transactionTile(isSuccess: true),

                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
                        child: headingWidget("FINANCIAL GOALS"),
                      ),
                      customLoadWidget(
                        heading: "31 of Total 100",
                        percentage: 31,
                        color: AppColors.blueColor,
                      ),
                      customLoadWidget(
                        heading: "160 of Total 200",
                        percentage: 80,
                        color: AppColors.redColor,
                      ),
                      customLoadWidget(
                        heading: "240 of Total 400",
                        percentage: 60,
                        color: AppColors.lightBlueColor,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget topSectionWidget() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Hola, ',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(text: 'Michael', style: TextStyle(fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    const Text(
                      "Tolenemos excelentes noticias para ti",
                      style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                "assets/svg/bell.svg",
                color: Colors.white,
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 25,
              ),
              Image.asset(
                "assets/images/top_profile.png",
                height: 20,
                width: 20,
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "\$56,271.68",
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "+\$9,736",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                width: 25,
              ),
              Icon(
                Icons.arrow_upward,
                color: AppColors.greenColor,
                size: 20,
              ),
              Text(
                " 2.3%",
                style: TextStyle(color: AppColors.greenColor),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "ACCOUNT BALANCE",
            style: TextStyle(color: AppColors.greyColor, fontSize: 13),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "12",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Following",
                    style: TextStyle(color: AppColors.greyColor, fontSize: 12, height: 1.5),
                  ),
                ],
              ),
              Container(
                width: 1.0,
                height: 30,
                color: AppColors.greyColor,
                // height: ,
              ),
              Column(
                children: [
                  const Text(
                    "36",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Transactions",
                    style: TextStyle(color: AppColors.greyColor, fontSize: 12, height: 1.5),
                  ),
                ],
              ),
              Container(
                width: 1.0,
                height: 30,
                color: AppColors.greyColor,
                // height: ,
              ),
              Column(
                children: [
                  const Text(
                    "4",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Bills",
                    style: TextStyle(color: AppColors.greyColor, fontSize: 12, height: 1.5),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget moreButton(){
    return  Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.greyColor.withOpacity(0.6)),
      child: const Text(
        "MORE",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Text headingWidget(String heading) {
    return Text(
      heading,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  @override
  void initState() {
    super.initState();
    _bloc.add(LoadUserEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
