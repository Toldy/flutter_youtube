import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
    final String image;
    final String title;
    final String author;
    final String viewsCount;
    final String date;
    final DocumentSnapshot snapshot;

    VideoModel.fromSnapshot(this.snapshot) :
                image = snapshot["image"],
                title = snapshot["title"],
                author = snapshot["author"],
                viewsCount = snapshot["views_count"],
                date = snapshot["date"];

    VideoModel(this.image, this.title, this.author, this.viewsCount, this.date, this.snapshot);
}