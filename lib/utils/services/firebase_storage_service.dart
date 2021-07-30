import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getCompanyPhotosUrl(String ref) async {
    try {
      return await _storage.ref(ref).getDownloadURL();
    } catch (e) {
      print(e);
    }
  }
}
