class PostResponse {
    PostResponse({
        this.data,
        this.total,
        this.page,
        this.limit,
    });

    final List<Post>? data;
    final int? total;
    final int? page;
    final int? limit;

    factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        data: List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "limit": limit,
    };
}

class Post {
    Post({
        required this.id,
        this.image,
        this.likes,
        this.tags,
        required this.text,
        required this.publishDate,
        this.updatedDate,
        required this.owner,
    });

    final String id;
    final String? image;
    final int? likes;
    final List<String>? tags;
    final String text;
    final DateTime publishDate;
    final DateTime? updatedDate;
    final Owner owner;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        image: json["image"],
        likes: json["likes"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        text: json["text"],
        publishDate: DateTime.parse(json["publishDate"]),
        updatedDate: json["updatedDate"] == null ? null : DateTime.parse(json["updatedDate"]),
        owner: Owner.fromJson(json["owner"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "likes": likes,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "text": text,
        "publishDate": publishDate.toIso8601String(),
        "updatedDate": updatedDate == null ? null : updatedDate!.toIso8601String(),
        "owner": owner.toJson(),
    };
}

class Owner {
    Owner({
        required this.id,
        required this.firstName,
        required this.lastName,
        this.title,
        this.picture,
    });

    final String id;
    final String firstName;
    final String lastName;
    final String? title;
    final String? picture;

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        title: json["title"],
        picture: json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "title": title,
        "picture": picture,
    };
}
