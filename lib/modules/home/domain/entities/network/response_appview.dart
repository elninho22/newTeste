import 'package:applocation/modules/home/domain/entities/appview.dart';
import 'package:equatable/equatable.dart';



class ResponseAppView extends Equatable {
  final int? count;
  final int? pages;
  final List<AppView>? model;
  final int? statusCode;
  final String? statusMessage;
  final String? errorMessage;

   ResponseAppView({this.count, this.pages, this.statusCode, this.statusMessage, this.errorMessage, this.model});

  @override
  List<Object?> get props => [statusCode, statusMessage, model];
}
