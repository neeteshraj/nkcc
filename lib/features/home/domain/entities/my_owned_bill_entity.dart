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
      status: json['status'] ?? 0,
      statusCode: json['statusCode'] ?? '',
      requestId: json['requestId'] ?? '',
      timeStamp: json['timeStamp'] ?? '',
      responseTitle: json['responseTitle'] ?? '',
      responseDescription: json['responseDescription'] ?? '',
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
      dimensions: json['dimensions'] ?? '',
      weight: json['weight'] ?? '',
      capacity: json['capacity'] ?? '',
      powerRating: json['powerRating'] ?? '',
      filterStages: json['filterStages'] ?? 0,
      material: json['material'] ?? '',
      features: List<String>.from(json['features'] ?? []),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
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
      id: json['_id'] ?? '',
      productTypeId: json['productTypeId'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      specifications: Specifications.fromJson(json['specifications'] ?? {}),
      compatibleParts: List<String>.from(json['compatibleParts'] ?? []),
      manualsAndResources: List<String>.from(json['manualsAndResources'] ?? []),
      certifications: List<String>.from(json['certifications'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      price: (json['price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      discount: json['discount'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: json['reviews'] ?? 0,
      sold: json['sold'] ?? 0,
      warranty: json['warranty'] ?? 0,
      warrantyType: json['warrantyType'] ?? '',
      warrantyDescription: json['warrantyDescription'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      cover: json['cover'] ?? '',
      releaseDate: json['releaseDate'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      version: json['version'] ?? 0,
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
      responseHeader: ResponseHeader.fromJson(json['responseHeader'] ?? {}),
      response: MyBillResponse.fromJson(json['response'] ?? {}),
    );
  }

  MyOwnedBillEntity combine(MyOwnedBillEntity other) {
    return MyOwnedBillEntity(
      responseHeader: responseHeader,
      response: MyBillResponse(
        productIds: [...response.productIds, ...other.response.productIds],
        productIdsAsString: [
          ...response.productIdsAsString,
          ...other.response.productIdsAsString
        ],
        productNames: [...response.productNames, ...other.response.productNames],
        billNumber: response.billNumber,
        dateDispatched: response.dateDispatched,
        customerName: response.customerName,
        customerAddress: response.customerAddress,
      ),
    );
  }
}
