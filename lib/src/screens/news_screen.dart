import 'package:flutter/material.dart';
import 'package:kazakh_invest/src/components/custom_news_list_widget.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({Key key}) : super(key: key);

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: Text(
                  "Новости",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: const Color.fromRGBO(242, 242, 242, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Color.fromRGBO(96, 182, 227, 1),
                      labelColor: Colors.black,
                      controller: _tabController,
                      labelStyle: TextStyle(
                        fontSize: 14,
                      ),
                      tabs: [
                        Tab(
                          text: 'Инвестиции',
                        ),
                        Tab(
                          text: 'Бизнес, экономика, финансы',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                CustomListWidget(),
                CustomListWidget(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
