
class ImageModel {
    int id;
    String pageUrl;
    String type;
    String tags;
    String webformatUrl;
    String largeImageUrl;
    int imageWidth;
    int imageHeight;
    int imageSize;
    int views;
    int downloads;
    int likes;
    int comments;
    String user;
    String userImageUrl;

    ImageModel({
        required this.id,
        required this.pageUrl,
        required this.type,
        required this.tags,
        required this.webformatUrl,
        required this.largeImageUrl,
        required this.imageWidth,
        required this.imageHeight,
        required this.imageSize,
        required this.views,
        required this.downloads,
        required this.likes,
        required this.comments,
        required this.user,
        required this.userImageUrl,
    });

    factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        pageUrl: json["pageURL"],
        type: json["type"],
        tags: json["tags"],
        webformatUrl: json["webformatURL"],
        largeImageUrl: json["largeImageURL"],
        imageWidth: json["imageWidth"],
        imageHeight: json["imageHeight"],
        imageSize: json["imageSize"],
        views: json["views"],
        downloads: json["downloads"],
        likes: json["likes"],
        comments: json["comments"],
        user: json["user"],
        userImageUrl: json["userImageURL"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pageURL": pageUrl,
        "type": type,
        "tags": tags,
        "webformatURL": webformatUrl,
        "largeImageURL": largeImageUrl,
        "imageWidth": imageWidth,
        "imageHeight": imageHeight,
        "imageSize": imageSize,
        "views": views,
        "downloads": downloads,
        "likes": likes,
        "comments": comments,
        "user": user,
        "userImageURL": userImageUrl,
    };
}
