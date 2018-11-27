import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_youtube/Model/VideoModel.dart';


class HomeView extends StatefulWidget {
    @override
    _HomeView createState() => _HomeView();
}


class _HomeView extends State<HomeView> {

    List<VideoModel> _videos = [
        VideoModel("images/video_1.png", "RESPECT PIKACHU - POKEMON LET'S GO #1", "JirayaTV", "", "", null),
        VideoModel("images/video_2.png", "Chamonix, la fabrique de l'extreme", "émissions RMC", "", "", null),
    ];

    @override
    Widget build(BuildContext context) {
        return Stack(children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('home_videos').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                        case ConnectionState.waiting: return new Text('Loading...');
                        default:
                            final count = snapshot.data.documents.length;

                            return ListView.builder(
                                    itemCount: count,
                                    itemBuilder: (BuildContext context, int index) {
                                        final document = snapshot.data.documents[index];
                                        final model = VideoModel.fromSnapshot(document);

                                        print(model);

                                        return VideoCard(video: _videos[index]);
                                    });
                    }
                },
            ),
        ]);
    }
}

class VideoCard extends StatelessWidget {

    final VideoModel video;

    // ignore: private_optional_parameter
    const VideoCard({Key key, this.video}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        Widget titleSection = Row(
            children: [
                CircleAvatar(),
                Container(width: 12),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                    video.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                            ),
                            Text(
                                video.author,
                                style: TextStyle(
                                    color: Colors.grey[500],
                                ),
                            ),
                        ],
                    ),
                ),
                Icon(
                    Icons.more_vert,
                    color: Colors.grey[500],
                ),
            ],
        );

        return
            Container(
                    decoration:
                    new BoxDecoration(
                            border: new Border(
                                    bottom: new BorderSide(color: Color(0x88888866))
                            )
                    ),
                    child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children:
                                    <Widget>[
                                        Image.asset(
                                            video.image,
                                            fit: BoxFit.cover,
                                        ),
                                        Container(
                                                padding: EdgeInsets.only(top: 12),
                                                child: titleSection),
                                    ]
                            )
                    )
            );
    }
}