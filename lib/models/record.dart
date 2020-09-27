import 'package:flutter/cupertino.dart';
import 'package:piggybank/models/model.dart';
import 'package:piggybank/models/category.dart';

class Record extends Model {

  /// Represents the Record object.
  /// A Record has:
  /// - value: monetary value associated to the movement (can be positive, or negative)
  /// - title: a headline for the record
  /// - category: a Category object assigned to the movement, describing the type of movement (income, expense)
  /// - dateTime: a date representing when the movement was performed

  int id;
  double value;
  String title;
  String description;
  Category category;
  DateTime dateTime;
  int recurrence_id;

  Record(this.value, this.title, this.category, this.dateTime, {this.id, this.description, this.recurrence_id});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': title,
      'value': value,
      'datetime': dateTime.millisecondsSinceEpoch,
      'category_name': category.name,
      'category_type': category.categoryType.index,
      'description': description
    };

    if (this.id != null) { map['id'] = this.id; }
    if (this.recurrence_id != null) { map['recurrence_id'] = this.recurrence_id; }
    return map;
  }

  static Record fromMap(Map<String, dynamic> map) {
    return Record(
      map['value'],
      map['title'],
      map['category'],
      new DateTime.fromMillisecondsSinceEpoch(map['datetime']),
      id: map['id'],
      description: map['description'],
      recurrence_id: map['recurrence_id']
    );
  }

  get date {
    return dateTime.year.toString() + dateTime.month.toString() + dateTime.day.toString();
  }

}