import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitState());

  static ImageCubit get(context) => BlocProvider.of(context);

  File? imageProfile;
  var picker = ImagePicker();

  Future<void> getImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      imageProfile = File(pickerFile.path);
      emit(ImageChangeState());
    } else {
      emit(ImageChangeFilerState());
    }
  }
  void clearImage() {
    imageProfile = null;
    emit(ImageInitState());

}
}
