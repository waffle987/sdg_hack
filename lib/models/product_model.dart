import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel {
  final String name;
  final String description;
  final String photoUrl;
  final String productId;
  final String fileName;
  final String price;
  final Map likes;

  ProductModel({
    @required this.name,
    @required this.description,
    @required this.photoUrl,
    @required this.productId,
    @required this.fileName,
    @required this.price,
    @required this.likes,
  });

  factory ProductModel.fromDocument({@required DocumentSnapshot doc}) {
    return ProductModel(
      name: doc['name'],
      description: doc['description'],
      photoUrl: doc['photoUrl'],
      productId: doc['productId'],
      fileName: doc['fileName'],
      price: doc['price'],
      likes: doc['likes'],
    );
  }
}
