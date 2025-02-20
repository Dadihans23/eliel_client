class TicketCategory {
  final String categoryName;
  final String price;
  
  TicketCategory({required this.categoryName, required this.price});
  
  factory TicketCategory.fromJson(Map<String, dynamic> json) {
    return TicketCategory(
      categoryName: json['ticket_name'],
      price: json['ticket_price'],
    );
  }
}
