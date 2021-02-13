import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/data/product_data.dart';
import 'package:virtual_store/widgets/product_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data()['title']),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          builder: (context, snapshot) {
            if(!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator()
              );
            else
              return TabBarView(
                children: [
                  GridView.builder(
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return ProductTile('grid', ProductData.fromDocument(snapshot.data.docs[index]));
                    },
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return ProductTile('list', ProductData.fromDocument(snapshot.data.docs[index]));
                    }
                  )
                ],
                physics: NeverScrollableScrollPhysics(),
              );
            
          },
          future: FirebaseFirestore.instance.collection('products').doc(snapshot.id)
            .collection('items').get()
        )
      ),
    );
  }
}