class ResponseHeaderModel {
  final int status;
  final String? statusCode;
  final String? requestId;
  final String? timeStamp;
  final String? responseTitle;
  final String? responseDescription;

  ResponseHeaderModel({
    required this.status,
    required this.statusCode,
    required this.requestId,
    required this.timeStamp,
    required this.responseTitle,
    required this.responseDescription,
  });

  factory ResponseHeaderModel.fromJson(Map<String, dynamic> json) {
    return ResponseHeaderModel(
      status: json['status'] ?? 0,
      statusCode: json['statusCode'] as String?,
      requestId: json['requestId'] as String?,
      timeStamp: json['timeStamp'] as String?,
      responseTitle: json['responseTitle'] as String?,
      responseDescription: json['responseDescription'] as String?,
    );
  }
}

class SpecificationsModel {
  final String? dimensions;
  final String? weight;
  final String? capacity;
  final String? powerRating;
  final int? filterStages;
  final String? material;
  final List<String>? features;
  final String? createdAt;
  final String? updatedAt;

  SpecificationsModel({
    this.dimensions,
    this.weight,
    this.capacity,
    this.powerRating,
    this.filterStages,
    this.material,
    this.features,
    this.createdAt,
    this.updatedAt,
  });

  factory SpecificationsModel.fromJson(Map<String, dynamic> json) {
    return SpecificationsModel(
      dimensions: json['dimensions'] as String?,
      weight: json['weight'] as String?,
      capacity: json['capacity'] as String?,
      powerRating: json['powerRating'] as String?,
      filterStages: json['filterStages'] as int?,
      material: json['material'] as String?,
      features: json['features'] != null
          ? List<String>.from(json['features'])
          : null,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}

class ProductModel {
  final String id;
  final String productTypeId;
  final String name;
  final String slug;
  final String brand;
  final String model;
  final String category;
  final String? description;
  final SpecificationsModel specifications;
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
  final String? thumbnail;
  final String? cover;
  final String? releaseDate;
  final String status;
  final String? notes;
  final String createdAt;
  final String updatedAt;
  final int version;

  ProductModel({
    required this.id,
    required this.productTypeId,
    required this.name,
    required this.slug,
    required this.brand,
    required this.model,
    required this.category,
    this.description,
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
    this.thumbnail,
    this.cover,
    this.releaseDate,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      productTypeId: json['productTypeId'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] as String?,
      specifications: SpecificationsModel.fromJson(json['specifications'] ?? {}),
      compatibleParts: List<String>.from(json['compatibleParts'] ?? []),
      manualsAndResources: List<String>.from(json['manualsAndResources'] ?? []),
      certifications: List<String>.from(json['certifications'] ?? []),
      images: List<String>.from(json['images'] ?? []),
      price: json['price'] ?? 0.0,
      stock: json['stock'] ?? 0,
      discount: json['discount'] ?? 0,
      rating: json['rating'] ?? 0.0,
      reviews: json['reviews'] ?? 0,
      sold: json['sold'] ?? 0,
      warranty: json['warranty'] ?? 0,
      warrantyType: json['warrantyType'] ?? '',
      warrantyDescription: json['warrantyDescription'] ?? '',
      thumbnail: json['thumbnail'] as String?,
      cover: json['cover'] as String?,
      releaseDate: json['releaseDate'] as String?,
      status: json['status'] ?? '',
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      version: json['__v'] ?? 0,
    );
  }
}

class ResponseModel {
  final List<ProductModel> productIds;
  final List<String> productIdsAsString;
  final List<String> productNames;
  final String? billNumber;
  final String? dateDispatched;
  final String? customerName;
  final String? customerAddress;

  ResponseModel({
    required this.productIds,
    required this.productIdsAsString,
    required this.productNames,
    this.billNumber,
    this.dateDispatched,
    this.customerName,
    this.customerAddress,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      productIds: (json['productIds'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList(),
      productIdsAsString: List<String>.from(json['productIdsAsString'] ?? []),
      productNames: List<String>.from(json['productNames'] ?? []),
      billNumber: json['billNumber'] as String?,
      dateDispatched: json['dateDispatched'] as String?,
      customerName: json['customerName'] as String?,
      customerAddress: json['customerAddress'] as String?,
    );
  }
}

class MyOwnedBillModel {
  final ResponseHeaderModel responseHeader;
  final ResponseModel response;

  MyOwnedBillModel({
    required this.responseHeader,
    required this.response,
  });

  factory MyOwnedBillModel.fromJson(Map<String, dynamic> json) {
    return MyOwnedBillModel(
      responseHeader: ResponseHeaderModel.fromJson(json['responseHeader'] ?? {}),
      response: ResponseModel.fromJson(json['response'] ?? {}),
    );
  }
}
