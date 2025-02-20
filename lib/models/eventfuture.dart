import 'dart:convert';

class TicketType {
  final int id;
  final String name;
  final String price;
  final int quantityAvailable;
  final String developerFeePercentage;
  final double developerPart;
  final double organizerPart;

  TicketType({
    required this.id,
    required this.name,
    required this.price,
    required this.quantityAvailable,
    required this.developerFeePercentage,
    required this.developerPart,
    required this.organizerPart,
  });

  factory TicketType.fromJson(Map<String, dynamic> json) {
    return TicketType(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantityAvailable: json['quantity_available'],
      developerFeePercentage: json['developer_fee_percentage'],
      developerPart: json['developer_part'].toDouble(),
      organizerPart: json['organizer_part'].toDouble(),
    );
  }
}

class Event {
  final int id;
  final List<TicketType> ticketTypes;
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
  final String? image;
  final String? video;
  final String createdAt;
  final String totalEarnings;
  final String totalEarningsByCategoryByDeveloper;
  final String totalEarningsByDeveloper;
  final int views;
  final int organizer;
  bool isFavorite; // Ajoute cette propriété pour suivre l'état du favori


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
    this.image,
    this.video,
    required this.createdAt,
    required this.totalEarnings,
    required this.totalEarningsByCategoryByDeveloper,
    required this.totalEarningsByDeveloper,
    required this.views,
    required this.organizer,
    this.isFavorite = false ,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event && other.id == id; // Comparez l'ID
  }

  @override
  int get hashCode => id.hashCode; // Utilisez l'ID pour le hashcode

  factory Event.fromJson(Map<String, dynamic> json) {
    var ticketTypesJson = json['ticket_types'] as List;
    List<TicketType> ticketTypesList =
        ticketTypesJson.map((i) => TicketType.fromJson(i)).toList();

    return Event(
      id: json['id'],
      ticketTypes: ticketTypesList,
      totalEarningsByCategory: json['total_earnings_by_category'],
      organizerName: json['organizer_name'],
      name: json['name'],
      description: json['description'],
      locationPlace: json['location_place'],
      locationVille: json['location_ville'],
      locationCommune: json['location_commune'],
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      image: json['image'],
      video: json['video'],
      createdAt: json['created_at'],
      totalEarnings: json['total_earnings'],
      totalEarningsByCategoryByDeveloper: json['total_earnings_by_category_by_developer'],
      totalEarningsByDeveloper: json['total_earnings_by_developer'],
      views: json['views'],
      organizer: json['organizer'],     
      isFavorite: json['is_favorite'] ?? false, // Par défaut à `false` si non présent

    );
  }
}
