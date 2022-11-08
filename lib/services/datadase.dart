import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ron/models/brew.dart';
import 'package:ron/models/user.dart';

class DatabaseService{

  final String? uid ;
  DatabaseService({this.uid });

  // collection reference
  final  CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async{
    // it return a reference to that document with this uid, if the document does not exist it will create one
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.get('name')?? "",
        strength: doc.get('strength') ?? 0,
          sugars: doc.get('sugars') ?? "0",
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid: uid!,
        sugars: snapshot.data()['sugars'],
        strength: snapshot.data()['strength'],
        name: snapshot.data()['name'],
    );
  }

  //get brews stream
  Stream< List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user dic stream
  Stream <UserData> get userData{
    return brewCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}