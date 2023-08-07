import 'package:flutter/material.dart';
import 'package:image_search_19day/core/result.dart';
import 'package:image_search_19day/domain/use_case/get_top_five_viewd_photo_use_case.dart';
import 'package:image_search_19day/presentation/main/main_state.dart';

class MainViewModel with ChangeNotifier {
  final GetTopFiveViewdPhotoUseCase _getTopFiveViewdPhotoUseCase;

  MainViewModel(this._getTopFiveViewdPhotoUseCase);

  MainState _state = const MainState();

  MainState get state => _state;

  void fetchImages(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = _getTopFiveViewdPhotoUseCase.execute(query);

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(
          photos: data,
          isLoading: false,
        );
      case Error(:final e):
        _state = state.copyWith(
          isLoading: false,
        );
    }
    notifyListeners();
  }
}
