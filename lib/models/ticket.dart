class Event {
  final int id;
  final List<dynamic> ticketTypes; // Peut être un type plus spécifique si nécessaire
  final String totalEarningsByCategory;
  final String organizerName;
  final String name;
  final String description;
  final String locationPlace;
  final String locationVille;
  final String locationCommune;
  final String date;
  final String startTime;
  final String endTime;
  final String image;
  final String? video; // Peut être nul
  final String createdAt;
  final String totalEarnings;
  final String totalEarningsByCategoryByDeveloper;
  final String totalEarningsByDeveloper;
  final int views;
  final int favoriteCount;
  final int commentCount;
  final int organizer;

  Event({
    required this.id,
    required this.ticketTypes,
    required this.totalEarningsByCategory,
    required this.organizerName,
    required this.name,
    required this.description,
    required this.locationPlace,
    required this.locationVille,
    required this.locationCommune,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.image,
    required this.video,
    required this.createdAt,
    required this.totalEarnings,
    required this.totalEarningsByCategoryByDeveloper,
    required this.totalEarningsByDeveloper,
    required this.views,
    required this.favoriteCount,
    required this.commentCount,
    required this.organizer,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      ticketTypes: json['ticket_types'] ?? [],
      totalEarningsByCategory: json['total_earnings_by_category'] ?? '',
      organizerName: json['organizer_name'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      locationPlace: json['location_place'] ?? '',
      locationVille: json['location_ville'] ?? '',
      locationCommune: json['location_commune'] ?? '',
      date: json['date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      image: json['image'] ?? '',
      video: json['video'],
      createdAt: json['created_at'] ?? '',
      totalEarnings: json['total_earnings'] ?? '',
      totalEarningsByCategoryByDeveloper: json['total_earnings_by_category_by_developer'] ?? '',
      totalEarningsByDeveloper: json['total_earnings_by_developer'] ?? '',
      views: json['views'] ?? 0,
      favoriteCount: json['favorite_count'] ?? 0,
      commentCount: json['comment_count'] ?? 0,
      organizer: json['organizer'] ?? 0,
    );
  }
}

class Ticket {
  final int id;
  final String categoryName;
  final double price;
  final Event event;

  Ticket({
    required this.id,
    required this.categoryName,
    required this.price,
    required this.event,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      categoryName: json['category_name'] ?? '',
      price: double.tryParse(json['price']) ?? 0.0,
      event: Event.fromJson(json['event']),
    );
  }
}
