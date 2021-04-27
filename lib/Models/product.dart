import 'dart:convert';

class Product {
  Product({
    this.id,
    this.type,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.slug,
    this.code,
    this.model,
    this.brand,
    this.price,
    this.quantity,
    this.content,
    this.seoTitle,
    this.seoKeywords,
    this.seoDescription,
    this.condition,
    this.usedTime,
    this.usedType,
    this.delivery,
    this.deliveryArea,
    this.deliveryCost,
    this.warranty,
    this.warrantyTime,
    this.warrantyType,
    this.negotiable,
    this.location,
    this.longitude,
    this.latitude,
    this.isFeatured,
    this.hits,
    this.soldStatus,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  int id;
  int type;
  int categoryId;
  int subCategoryId;
  String name;
  String slug;
  String code;
  String model;
  String brand;
  String price;
  dynamic quantity;
  String content;
  String seoTitle;
  dynamic seoKeywords;
  String seoDescription;
  String condition;
  String usedTime;
  String usedType;
  String delivery;
  String deliveryArea;
  String deliveryCost;
  String warranty;
  String warrantyTime;
  String warrantyType;
  String negotiable;
  String location;
  String longitude;
  String latitude;
  int isFeatured;
  int hits;
  String soldStatus;
  int status;
  int createdBy;
  int updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  Images images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        type: json["type"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        name: json["name"],
        slug: json["slug"],
        code: json["code"],
        model: json["model"],
        brand: json["brand"],
        price: json["price"],
        quantity: json["quantity"],
        content: json["content"],
        seoTitle: json["seo_title"],
        seoKeywords: json["seo_keywords"],
        seoDescription: json["seo_description"],
        condition: json["condition"],
        usedTime: json["used_time"],
        usedType: json["used_type"],
        delivery: json["delivery"],
        deliveryArea: json["delivery_area"],
        deliveryCost: json["delivery_cost"],
        warranty: json["warranty"],
        warrantyTime: json["warranty_time"],
        warrantyType: json["warranty_type"],
        negotiable: json["negotiable"],
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        isFeatured: json["is_featured"],
        hits: json["hits"],
        soldStatus: json["sold_status"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        images: Images.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "name": name,
        "slug": slug,
        "code": code,
        "model": model,
        "brand": brand,
        "price": price,
        "quantity": quantity,
        "content": content,
        "seo_title": seoTitle,
        "seo_keywords": seoKeywords,
        "seo_description": seoDescription,
        "condition": condition,
        "used_time": usedTime,
        "used_type": usedType,
        "delivery": delivery,
        "delivery_area": deliveryArea,
        "delivery_cost": deliveryCost,
        "warranty": warranty,
        "warranty_time": warrantyTime,
        "warranty_type": warrantyType,
        "negotiable": negotiable,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "is_featured": isFeatured,
        "hits": hits,
        "sold_status": soldStatus,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "images": images.toJson(),
      };
}

class Images {
  Images({
    this.thumb,
    this.preview,
    this.original,
  });

  String thumb;
  String preview;
  String original;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        thumb: json["thumb"],
        preview: json["preview"],
        original: json["original"],
      );

  Map<String, dynamic> toJson() => {
        "thumb": thumb,
        "preview": preview,
        "original": original,
      };
}
