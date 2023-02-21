import 'package:provider_medical_valley/core/base_service/network_error.dart';

import '../../data/models/categories_model.dart';
import '../../data/models/search_result.dart';

abstract class MyHomeState {}

class SuccessHomeState extends MyHomeState {
  CategoryResponse category;

  SuccessHomeState(this.category);
}

class SearchResultState extends MyHomeState {
  SearchResult searchResult;

  SearchResultState(this.searchResult);
}

class InitialHomeState extends MyHomeState {}

class ErrorHomeState extends MyHomeState {
  ErrorStates states;

  ErrorHomeState(this.states);
}

class LoadingHomeState extends MyHomeState {}
