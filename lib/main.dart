import 'package:flutter/material.dart';
part 'data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.purple,
        ),
        home: MyHomePage()
        // home: Scaffold(
        //   appBar: AppBar(
        //     title: Text("Hell World"),
        //   ),
        //   body: Text(
        //     'Hell World',
        //     style: TextStyle(fontSize: 40),
        //   ),
        // )
        );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedBottomTap = 0;
  var _selectedTodayShoppingCategory = _todayShoppingCategories[0]; // '멘즈';

  int _selectedTrendPageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  _selectedBottomTap = index;
                });
              },
              currentIndex: _selectedBottomTap,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag), label: "쇼핑 홈"),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
                BottomNavigationBarItem(icon: Icon(Icons.notes), label: "뉴스 홈"),
              ],
            ),
            appBar: AppBar(
              title: Text('Hell World'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: '쇼핑'),
                  Tab(text: '라이브'),
                  Tab(text: '선물')
                ],
              ),
            ),
            body: TabBarView(children: <Widget>[
              CustomScrollView(scrollDirection: Axis.vertical, slivers: [
                // SliverAppBar(
                //     title: Text('Hell World'),
                //     bottom: TabBar(tabs: [
                //       Tab(text: '쇼핑'),
                //       Tab(text: '라이브'),
                //       Tab(text: '선물')
                //     ])),
                SliverToBoxAdapter(child: createTodayShopping()),
                SliverToBoxAdapter(child: createTrendPick()),
                SliverToBoxAdapter(child: createMustHaveLive()),
                SliverToBoxAdapter(child: createOtherCategories()),
              ]),
              SingleChildScrollView(),
              SingleChildScrollView(),
            ])));
  }

  viewDialog(String message) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Text('Info'),
              content: Text('$message'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                )
              ]);
        });
  }

  Widget createSeparator(double indent) {
    if (indent < 10) {
      return const Divider(height: 2, thickness: 2, indent: 0, endIndent: 0);
    }

    return const Divider(height: 2, thickness: 2, indent: 10, endIndent: 10);
  }

  Widget createRealtimeKeyword() {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.all(5.0),
            child: Text(
              '쇼핑트렌드차트',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget createOtherCategories() {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(5.0),
            child: Text(
              '더 많은 상품이 궁금하다면?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          for (var category in _otherCategories)
            createCategory(category[0], category[1])
        ],
      ),
    );
  }

  Widget createCategory(String name, List<String> list) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(children: [
            Text(
              '| $name',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            createSeparator(10.0)
          ]),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
            childAspectRatio: 1.5,
            children: [
              for (var item in list)
                Container(
                  margin: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                  child: ElevatedButton(
                    onPressed: () => viewDialog('$name /// $item'),
                    child: Expanded(
                      child: Text(
                        item,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFEEEEEE)),
                    ),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }

  Widget createMustHaveLive() {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(5.0),
            child: Text(
              '놓치면 안될 혜택 가득 LIVE',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 130.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var item in _trendList[0])
                  createTodayShoppingImageItem(item[0], item[1], columnCount: 3)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget createTrendPick() {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              margin: EdgeInsets.all(5.0),
              child: Text(
                '트렌드Pick | 스타일 UP',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () => viewDialog('트렌드Pick | 스타일 UP'))
          ]),
          createTrendList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () => setState(() => _selectedTrendPageNumber > 0
                    ? _selectedTrendPageNumber--
                    : _selectedTrendPageNumber = _trendList.length - 1),
              ),
              Text('${_selectedTrendPageNumber + 1} / ${_trendList.length}'),
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () => setState(() =>
                    _selectedTrendPageNumber < _trendList.length - 1
                        ? _selectedTrendPageNumber++
                        : _selectedTrendPageNumber = 0),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget createTrendList() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        for (var item in _trendList[_selectedTrendPageNumber])
          createTodayShoppingImageItem(item[0], item[1], columnCount: 3)
      ],
    );
  }

  Widget createTodayShopping() {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: Text(
                  '오늘의 쇼핑',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              DropdownButton(
                  items: _todayShoppingCategories
                      .map(
                        (value) =>
                            DropdownMenuItem(child: Text(value), value: value),
                      )
                      .toList(),
                  value: _selectedTodayShoppingCategory,
                  onChanged: (value) =>
                      setState(() => _selectedTodayShoppingCategory = value)),
              Container(),
              Container(),
              ElevatedButton.icon(
                onPressed: () => viewDialog('브랜드데이 버튼'),
                icon: Icon(Icons.branding_watermark),
                label: Text('브랜드데이', style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple)),
              )
            ],
          ),
          createSeparator(0.0),
          createTodayShoppingList(),
          for (var element in _todayShoppingList[_selectedTodayShoppingCategory]
              ['Text'])
            createTodayShoppingTextList(element[0], element[1], element[2]),
        ],
      ),
    );
  }

  Widget createTodayShoppingList() {
    return GridView.count(
        padding: EdgeInsets.all(2.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          for (var e in _todayShoppingList[_selectedTodayShoppingCategory]
              ['Image'])
            createTodayShoppingImageItem(e[0], e[1])
        ]);
  }

  Widget createTodayShoppingImageItem(String imagePath, String content,
      {int columnCount = 2}) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: 320.0 / columnCount,
      // height: 320.0 / columnCount,
      child: TextButton(
        onPressed: () => viewDialog('$imagePath /// $content'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(imagePath,
                fit: BoxFit.cover,
                width: 320.0 / columnCount,
                height: 240.0 / columnCount),
            Flexible(
                fit: FlexFit.loose,
                child: Text(content, style: TextStyle(color: Colors.black)))
          ],
        ),
      ),
    );
  }

  Widget createTodayShoppingTextList(
      IconData iconData, String preText, String content) {
    return Column(children: [
      createSeparator(10.0),
      GestureDetector(
        onTap: () => viewDialog('$preText / $content'),
        child: Container(
          margin: EdgeInsets.all(3.0),
          child: Row(
            children: [
              Container(
                  child: Icon(iconData, color: Color(0xFF9900FF)),
                  margin: EdgeInsets.all(2.0)),
              Container(
                  child: Text(
                    preText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9900FF),
                    ),
                  ),
                  margin: EdgeInsets.all(2.0)),
              Container(child: Text(content), margin: EdgeInsets.all(2.0))
            ],
          ),
        ),
      )
    ]);
  }
}
