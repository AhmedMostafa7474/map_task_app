import 'package:cloud_firestore/cloud_firestore.dart';

class Source_web_services
{
  List<DocumentSnapshot> documentList=[];
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>GetFirstplaces()async{
    final firestore = FirebaseFirestore.instance;
    var response=await firestore.collection("Source").limit(14).get();
    documentList.addAll(response.docs);
    return response.docs;
  }
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>GetNextplaces()async{
    final firestore = FirebaseFirestore.instance;
    var response=await firestore.collection("Source").limit(10).startAfterDocument(documentList[documentList.length - 1]).get();
    documentList.addAll(response.docs);
    print("yes");
    return response.docs;
  }
}