import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';

// import 'package:statenotifier_sample/counter_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'news_state.freezed.dart';

// part 'counter_state.g.dart';


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
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

//グローバル変数でProviderを設定。
final newsProvider = StateNotifierProvider((ref) => NewsController());

@freezed
abstract class NewsState with _$NewsState {
  factory NewsState({
    bool loading,
    List<Article> articles,
  }) = _NewsState;
}


class NewsController extends StateNotifier<NewsState> {


  NewsQueryService _newsQueryService;

  NewsController(this._newsQueryService) : super(NewsState(loading: false));


  Future<void> getNews() async {
    List<Article> articles = [];
    articles = await _newsQueryService.getNews();
    state = state.copyWith(articles: articles);
  }


}


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            context.read(newsProvider).getNews();
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Demo"),
        ),
        body: HeadPage()
    );
  }
}

class HeadPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //controllerのメソッドを読む場合は、context.read(Provider名).メソッド名と書いて呼び出す。
    final _fetch = context.read(newsProvider).getNews();
    // TODO: implement build
    return FutureBuilder<void>(
      future: _fetch,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print("エラーが出たよ");
        }
        return HeadNewsListPage();
      },
    );
  }

}

//viewの部分表示
class HeadNewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        //Hooksを使わない場合はConsumerでProviderを使用する。
        child: Consumer(
            builder:(context, watch, child){
              //stateを呼び出す場合は、watchで監視し(変更を監視)、下のように書くと、NwesState内のstateを取得可能。
              final state = watch(newsProvider.state);
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  return ArticleTile(state.articles[index]);
                },
              );
            }
        ),
      ),
    );
  }
}


}


