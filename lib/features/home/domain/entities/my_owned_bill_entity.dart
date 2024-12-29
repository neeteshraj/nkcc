class ResponseHeader {
  final int status;
  final String statusCode;
  final String requestId;
  final String timeStamp;
  final String responseTitle;
  final String responseDescription;

  ResponseHeader({
    required this.status,
    required this.statusCode,
    required this.requestId,
    required this.timeStamp,
    required this.responseTitle,
    required this.responseDescription,
  });

  factory ResponseHeader.fromJson(Map<String, dynamic> json) {
    return ResponseHeader(
      status: json['status'] as int,
      statusCode: json['statusCode'] as String,
      requestId: json['requestId'] as String,
      timeStamp: json['timeStamp'] as String,
      responseTitle: json['responseTitle'] as String,
      responseDescription: json['responseDescription'] as String,
    );
  }
}

class Specifications {
  final String dimensions;
  final String weight;
  final String capacity;
  final String powerRating;
  final int filterStages;
  final String material;
  final List<String> features;
  final String createdAt;
  final String updatedAt;

  Specifications({
    required this.dimensions,
    required this.weight,
    required this.capacity,
    required this.powerRating,
    required this.filterStages,
    required this.material,
    required this.features,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Specifications.fromJson(Map<String, dynamic> json) {
    return Specifications(
      dimensions: json['dimensions'] as String,
      weight: json['weight'] as String,
      capacity: json['capacity'] as String,
      powerRating: json['powerRating'] as String,
      filterStages: json['filterStages'] as int,
      material: json['material'] as String,
      features: List<String>.from(json['features']),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}

class Product {
  final String id;
  final String productTypeId;
  final String name;
  final String slug;
  final String brand;
  final String model;
  final String category;
  final String description;
  final Specifications specifications;
  final List<String> compatibleParts;
  final List<String> manualsAndResources;
  final List<String> certifications;
  final List<String> images;
  final double price;
  final int stock;
  final int discount;
  final double rating;
  final int reviews;
  final int sold;
  final int warranty;
  final String warrantyType;
  final String warrantyDescription;
  final String thumbnail;
  final String cover;
  final String releaseDate;
  final String status;
  final String notes;
  final String createdAt;
  final String updatedAt;
  final int version;

  Product({
    required this.id,
    required this.productTypeId,
    required this.name,
    required this.slug,
    required this.brand,
    required this.model,
    required this.category,
    required this.description,
    required this.specifications,
    required this.compatibleParts,
    required this.manualsAndResources,
    required this.certifications,
    required this.images,
    required this.price,
    required this.stock,
    required this.discount,
    required this.rating,
    required this.reviews,
    required this.sold,
    required this.warranty,
    required this.warrantyType,
    required this.warrantyDescription,
    required this.thumbnail,
    required this.cover,
    required this.releaseDate,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      productTypeId: json['productTypeId'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      specifications: Specifications.fromJson(json['specifications']),
      compatibleParts: List<String>.from(json['compatibleParts']),
      manualsAndResources: List<String>.from(json['manualsAndResources']),
      certifications: List<String>.from(json['certifications']),
      images: List<String>.from(json['images']),
      price: json['price'] as double,
      stock: json['stock'] as int,
      discount: json['discount'] as int,
      rating: json['rating'] as double,
      reviews: json['reviews'] as int,
      sold: json['sold'] as int,
      warranty: json['warranty'] as int,
      warrantyType: json['warrantyType'] as String,
      warrantyDescription: json['warrantyDescription'] as String,
      thumbnail: json['thumbnail'] as String,
      cover: json['cover'] as String,
      releaseDate: json['releaseDate'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: json['version'] as int,
    );
  }
}

class MyBillResponse {
  final List<Product> productIds;
  final List<String> productIdsAsString;
  final List<String> productNames;
  final String billNumber;
  final String dateDispatched;
  final String customerName;
  final String customerAddress;

  MyBillResponse({
    required this.productIds,
    required this.productIdsAsString,
    required this.productNames,
    required this.billNumber,
    required this.dateDispatched,
    required this.customerName,
    required this.customerAddress,
  });

  factory MyBillResponse.fromJson(Map<String, dynamic> json) {
    return MyBillResponse(
      productIds: (json['productIds'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
      productIdsAsString: List<String>.from(json['productIdsAsString']),
      productNames: List<String>.from(json['productNames']),
      billNumber: json['billNumber'] as String,
      dateDispatched: json['dateDispatched'] as String,
      customerName: json['customerName'] as String,
      customerAddress: json['customerAddress'] as String,
    );
  }
}

class MyOwnedBillEntity {
  final ResponseHeader responseHeader;
  final MyBillResponse response;

  MyOwnedBillEntity({
    required this.responseHeader,
    required this.response,
  });

  factory MyOwnedBillEntity.fromJson(Map<String, dynamic> json) {
    return MyOwnedBillEntity(
      responseHeader: ResponseHeader.fromJson(json['responseHeader']),
      response: MyBillResponse.fromJson(json['response']),
    );
  }

  MyOwnedBillEntity combine(MyOwnedBillEntity other) {
    return MyOwnedBillEntity(
        responseHeader: responseHeader,
        response: MyBillResponse(
            productIds: [
              ...response.productIds,
              ...other.response.productIds
            ],
            productIdsAsString: [
              ...response.productIdsAsString,
              ...other.response.productIdsAsString
            ],
            productNames: [
              ...response.productNames,
              ...other.response.productNames
            ],
            billNumber: response.billNumber,
            dateDispatched: response.dateDispatched,
            customerName: response.customerName,
            customerAddress: response.customerAddress));
  }
}
