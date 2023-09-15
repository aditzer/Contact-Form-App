import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contact_form_app/model/user_form.dart';

class FireStoreRepository {
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('contact_forms');

  Future<Stream<List<UserForm>>> getForms() async {
    // checking if user is online
    bool isOnline = await _hasNetwork();

    // if the user is online try to fetch latest data from server
    if(isOnline){
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('contact_forms').get(const GetOptions(source: Source.server));
        return _collectionReference.snapshots().map((snapshot) {
          // all your documents will be fetched
          return querySnapshot.docs.map((document) {
            Map<String, dynamic> documentData = document.data() as Map<String, dynamic>;
            // map those documents one by one to UserForm and form its list
            return UserForm(
                name: documentData['name'],
                email: documentData['email'],
                phoneNumber: documentData['phone'],
                address: documentData['address']
            );
          }).toList();
        });
      } catch (error) {
        // if we got any exception in between throw error
        return Future.error("Failed to fetch forms!");
      }
    } else {
      // if not online throw error
      return Future.error("No internet connection!");
    }
  }

  Future<DocumentReference> addForm(UserForm userForm) async {
    // checking if user is online
    bool isOnline = await _hasNetwork();

    // if the user is online try to fetch latest data from server
    if(isOnline) {
      try {
        // add your userForm to collection
        return await _collectionReference.add({
          'name': userForm.name,
          'email': userForm.email,
          'phone': userForm.phoneNumber,
          'address': userForm.address
        });
      } catch (error) {
        // if we got any exception in between throw error
        return Future.error("Failed to submit form!");
      }
    } else {
      // if not online throw error
      return Future.error("No internet connection!");
    }
  }

  Future<bool> _hasNetwork() async {
    // return true if user is connected to internet
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
