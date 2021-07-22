import 'package:flutter/material.dart';
import 'views/widgets/self_Card.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //     home: Scaffold(
      //         body: Padding(
      //   padding: EdgeInsets.fromLTRB(16, 44, 16, 55),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       DropdownCard(
      //         color: Color.fromARGB(255, 244, 244, 244),
      //         firstText: '工科数学',
      //         secondText: '李文学 | 2-18周 周一 周三 周五 第1大节',
      //       )
      //     ],
      //   ),
      //   // child: LineTextField(),
      // ))
      home: SearchDemo(),
    );
  }
}

//搜索框
class SearchBarTest extends StatefulWidget {
  SearchBarTest({Key? key}) : super(key: key);

  @override
  _SearchBarTestState createState() => _SearchBarTestState();
}

class _SearchBarTestState extends State<SearchBarTest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          Image.asset('images/search.png'),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextField(
                decoration: InputDecoration(
              hintText: '搜索课程、老师、地点、专业、班号',
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 15),
            )),
          )
        ],
      ),
    );
  }
}

class SearchDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("请搜索"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBarDelegate());
            },
          )
        ],
      ),
    );
  }
}

class SearchBarDelegate extends SearchDelegate<String> {
  SearchBarDelegate({
    Key? key,
  }) : super(
          searchFieldLabel: '搜索课程、老师、地点、班号',
          searchFieldStyle: TextStyle(
              fontSize: 15, color: Color.fromARGB(255, 122, 122, 122)),
        );

  // 搜索条右侧的按钮执行方法，我们在这里方法里放入一个clear图标。 当点击图片时，清空搜索的内容。
  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  // 搜索栏左侧的图标和功能，点击时关闭整个搜索页面
  @override
  Widget buildLeading(BuildContext context) {
    return Image.asset('images/search.png');
  }

  // 搜索到内容了
  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentList
        : searchList.where((input) => input.startsWith(query)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(22, 15, 0, 0),
          child: Text(
            '课程',
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 69, 69, 69),
                fontWeight: FontWeight.w700),
          ),
        ),
        Flexible(
            child: Padding(
          padding: EdgeInsets.fromLTRB(18, 8, 18, 0),
          child: ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              return ButtonCard(
                firstText: suggestionList[index],
                secondText: '李文学 | 2-18周 周一 周三 周五 第1大节',
              );
            },
          ),
        ))
      ],
    );
  }
}

const searchList = [
  "工科数学1",
  "工科数学2",
  "工科数学3",
  "工科数学4",
  "工科数学5",
];

const recentList = [
  "推荐结果1-ii",
  "推荐结果2-jj",
  "推荐结果3-kk",
  "推荐结果4-ll",
  "推荐结果5-mm",
];
