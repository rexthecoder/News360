/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart';
import 'package:loggy/loggy.dart';
import 'package:news360/src/logic/logic.dart';

// Abstarction of the base scrapper
abstract class BaseScrapper {
  Future<Response> init({required String link});
  BeautifulSoup parse(String response);
  List<Map<String, dynamic>> archiveData(BeautifulSoup data);
  Map<String, dynamic> content(String data);
  dynamic headline(String response);
  dynamic archive(String response);
}

/// host all the scrapping of the website
class Scrapper extends BaseScrapper with UiLoggy {
  var client = Client();
  late Response response;

  @override
  Future<Response> init({required String link}) async {
    response = await client.get(Uri.parse(link));
    return response;
  }

  @override
  BeautifulSoup parse(String response) {
    BeautifulSoup bs = BeautifulSoup(response);

    return bs;
  }

  @override
  List<Map<String, dynamic>> archiveData(BeautifulSoup data) {
    var news = data.find(
      'ul',
      class_: 'inner-lead-story-bottom',
    );
    List<Map<String, dynamic>> newsMap = [];

    for (var index = 0; index < news!.children.length; index++) {
      newsMap.add({
        'title': news.children[index].h3!.text,
        'link': news.children[index].a!.attributes['href'],
        'image': news.children[index].img!.attributes['src'],
      });
    }
    return newsMap;
  }

  @override
  Map<String, dynamic> content(String data) {
    var parseData = parse(data);
    var news = parseData.find(
      'div',
      class_: 'article-left-col',
    );
    List<Map<String, dynamic>> newsMap = [];

    newsMap.add({
      'title': news!.h1!.text,
      'image': news.img!.attributes['src'],
      'content': news.find('p', id: 'article-123')!.text,
      'type': news.find('p', class_: 'floatLeft')!.text
    });
    return newsMap[0];
  }

  @override
  dynamic headline(String response) {
    var data = parse(response);
    final headline = HeadlineResponseModel(wrapData: []).obs;

    var news = data.find(
      'div',
      class_: 'upper',
    );

    for (var index = 0; index < news!.ul!.children.length; index++) {
      headline.update((headline) {
        headline!.wrapData.add({
          'title': news.ul!.children[index].p!.text,
          'link': news.ul!.children[index].a!.attributes['href'].toString(),
          'image': news.ul!.children[index].img!.attributes['src'].toString(),
        });
      });
    }

    return headline.value.toList();
  }

  @override
  archive(String response) {
    var data = parse(response);
    final archive = ArchiveResponseModel(wrapData: []).obs;

    var news = data.find(
      'div',
      class_: 'upper',
    );

    for (var index = 0; index < news!.children.length; index++) {
      archive.update((archive) {
        archive!.wrapData.add({
          'title': news.children[index].p!.text,
          'link': news.children[index].a!.attributes['href'].toString(),
          'image': news.children[index].img!.attributes['src'].toString(),
        });
      });
    }

    return archive.value.toList();
  }
}

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but callback have index as second argument
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}
