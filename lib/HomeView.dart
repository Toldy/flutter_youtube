import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_youtube/Model/VideoModel.dart';


class HomeView extends StatefulWidget {
    @override
    _HomeView createState() => _HomeView();
}


class _HomeView extends State<HomeView> {

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
                            return ListView.builder(
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder: (BuildContext context, int index) {
                                        final document = snapshot.data.documents[index];
                                        final model = VideoModel.fromSnapshot(document);

                                        return VideoCard(video: model);
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

        return Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0x88888866)),
                ),
            ),
            child: GestureDetector(
                    child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children:
                                    <Widget>[
                                        Image.network(
                                            video.thumbnailUrl,
                                            fit: BoxFit.cover,
                                        ),
                                        Container(
                                                padding: EdgeInsets.only(top: 12),
                                                child: titleSection),
                                    ]
                            )
                    ),
                    onTap: () => _onItemTapped(video, context)
            ),
        );
    }

    _onItemTapped(VideoModel video, BuildContext context) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondScreen(video: video)),
        );
    }
}
class SecondScreen extends StatelessWidget {

    final VideoModel video;

    const SecondScreen({Key key, @required this.video}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Second Screen"),
            ),
            body: VideoCard(video: video),
        );
    }
}