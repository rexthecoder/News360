import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart';
import 'package:news360/src/logic/scrapper/apps_scrapper.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  _TestingScreenState createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  Scrapper scraping = Scrapper();
  dynamic data = [];
  late Stream<FileResponse> fileStream;
  @override
  void initState() {
    super.initState();
    fileStream = DefaultCacheManager().getFileStream(
        'https://www.ghanaweb.com/GhanaHomePage/NewsArchive/',
        withProgress: true);
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      // var response = await scraping.init(
      //     link: 'https://www.ghanaweb.com/GhanaHomePage/NewsArchive/');
    });
  }

  @override
  Widget build(BuildContext context) {
    // data = scraping.headline();
    // print(data);
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder<FileResponse>(
              stream: fileStream,

            
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Text('Loading');
                }
                FileInfo output = snapshot.data as FileInfo;
                initHeadlineScrapping(output);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var item in data) ...[
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DisplayContent(
                                link: item['link'],
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(item['link'],
                                style: context.h5
                                    .copyWith(color: AppColors.blackDarker)),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                  image: OptimizedCacheImageProvider(
                                      item['image'])),
                            ),
                          ),
                        ),
                      ],
                      ListTile(),
                      Text('Hello World',
                          style: context.h5
                              .copyWith(color: AppColors.blackDarker)),
                    ],
                  ),
                );
              })),
    );
  }

  void initHeadlineScrapping(FileInfo output) {
    output.file.readAsString().then((value) {
      data = scraping.headline(value);
    });
  }
}

class DisplayContent extends StatefulWidget {
  const DisplayContent({Key? key, this.link}) : super(key: key);

  final String? link;

  @override
  _DisplayContentState createState() => _DisplayContentState();
}

class _DisplayContentState extends State<DisplayContent> {
  Scrapper scraping = Scrapper();
  dynamic data = [];

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      var response = await scraping.init(
          link:
              'https://www.ghanaweb.com/GhanaHomePage/NewsArchive/${widget.link}');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (var item in data) ...[
                Text(item['title'],
                    style: context.h5.copyWith(color: AppColors.blackDarker)),
                Image.network(item['image']),
                Text(item['content'],
                    style: context.h5.copyWith(color: AppColors.blackDarker)),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
