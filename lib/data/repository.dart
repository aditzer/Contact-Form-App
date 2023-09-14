import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contact_form_app/model/user_form.dart';

class FireStoreRepository {
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('contact_forms');

  Future<Stream<List<UserForm>>> getForms() async {
    bool isOnline = await _hasNetwork();

    if(isOnline){
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('contact_forms').get(const GetOptions(source: Source.server));
        return _collectionReference.snapshots().map((snapshot) {
          return querySnapshot.docs.map((document) {
            Map<String, dynamic> documentData = document.data() as Map<String, dynamic>;
            return UserForm(
                name: documentData['name'],
                email: documentData['email'],
                phoneNumber: documentData['phone'],
                address: documentData['address']
            );
          }).toList();
        });
      } catch (error) {
        return Future.error("Failed to fetch forms!");
      }
    } else {
      return Future.error("No internet connection!");
    }
  }

  Future<DocumentReference> addForm(UserForm userForm) async {
    bool isOnline = await _hasNetwork();
    if(isOnline) {
      try {
        return await _collectionReference.add({
          'name': userForm.name,
          'email': userForm.email,
          'phone': userForm.phoneNumber,
          'address': userForm.address
        });
      } catch (error) {
        return Future.error("Failed to submit form!");
      }
    } else {
      return Future.error("No internet connection!");
    }
  }

  Future<bool> _hasNetwork() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
