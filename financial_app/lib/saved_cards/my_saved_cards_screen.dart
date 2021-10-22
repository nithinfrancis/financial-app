import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_app/utils/app_colors.dart';
import 'package:financial_app/widgets/credit_card_widget.dart';
import 'package:financial_app/widgets/transaction_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class SavedCardScreen extends StatefulWidget {
  const SavedCardScreen({Key? key}) : super(key: key);

  @override
  _SavedCardScreenState createState() => _SavedCardScreenState();
}

class _SavedCardScreenState extends State<SavedCardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Widget> imageSliders = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 6);
    imageSliders = [
      creditCard(cardName: "Nithin", expireDate: "09/22", cardNumber: "4349 6275 4578 7019", gradient1: AppColors.themeColor, gradient2: const Color(0xff342965)),
      creditCard(cardName: "Francis", expireDate: "09/22", cardNumber: "5567 6890 7845 0850", gradient1: const Color(0xff3B5900), gradient2: Colors.green),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            "My Saved cards",
          ),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          elevation: 0,
          actions: [
            SvgPicture.asset("assets/svg/menu_button.svg", color: Colors.black, height: 16, width: 16),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 220,
              child: CarouselSlider(
                items: imageSliders,
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: false,
                    height: double.infinity,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageSliders.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: (_current == entry.key) ? 25 : 15.0,
                    height: 6.0,
                    margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(_current == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
            TabBar(
              padding: const EdgeInsets.all(15),
              controller: _tabController,
              labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              labelColor: Colors.black,
              unselectedLabelColor: AppColors.subHeadingColor,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              isScrollable: true,
              indicatorWeight: 4,
              // indicatorPadding: EdgeInsets.only(left:20,right: 20),
              tabs: [
                tabHeadingWidget('Menu tittle 1'),
                tabHeadingWidget('Menu tittle 2'),
                tabHeadingWidget('Menu tittle 3'),
                tabHeadingWidget('Menu tittle 4'),
                tabHeadingWidget('Menu tittle 5'),
                tabHeadingWidget('Menu tittle 6'),
              ],
              indicatorColor: AppColors.subHeadingColor,
              enableFeedback: true,
            ),
            Expanded(
                child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: _tabController,
              children: [
                tabContentWidget(),
                tabContentWidget(),
                tabContentWidget(),
                tabContentWidget(),
                tabContentWidget(),
                tabContentWidget(),
              ],
            )),
          ],
        ));
  }



  Widget tabHeadingWidget(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(text),
    );
  }

  Widget tabContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "RECENT TRANSACTIONS",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, i) {
              return transactionTile(isSuccess:( i%3==0)?true:false);
            },
          ),
        )
      ],
    );
  }
}
