import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

  Widget buildList(QuerySnapshot snapshot) {
    return ListView.builder( //returns a list view builder
        itemCount: snapshot.docs.length, //sets the item count to the length of the snapshot doc
        itemBuilder: (context, index) {
          //variable doc initialised with the value of the doc snapshot index, allowing properties to be accessed
          final doc = snapshot.docs[index];
          String docName = doc["movieName"];
          return Container( //return a container widget
              key: Key(doc.id), //assign the key doc.id to the container
              child: Card( //return a Card child widget
                  child: ListTile( //return a ListTile as the child widget
                key: Key(doc.id),
                //set the title of the list tile to the movieName document,
                //pulls the saved movie titles from the Firestore cloud database
                title: Text(doc["movieName"],
                    style: Theme.of(context).textTheme.bodyLarge), //assigns bodyLarge text theme to the retrieved movie title
                trailing: const Icon(Icons.delete_forever, color: Colors.red), //adds a trailing delete forever icon in colour red
                onTap: () => showDialog( //when the delete forever icon is tapped, show a dialog
                    context: context,
                    barrierDismissible: false, //disable the user's ability to tap off the dialog to dismiss it, forcing them to choose an action
                    builder: (BuildContext context) => AlertDialog( //builds an AlertBox that the user must interact with
                          title: Text('Remove $docName from Watchlist?', //sets the title of such to the subject of the AlertBox - asking if the user wants to remove the movie
                              style: Theme.of(context).textTheme.titleSmall), //styling set to titleSmall text theme
                          content: Text( //content text widget set to provide more detail to the user about their pending action
                            'Are you sure you want to remove $docName from your Watchlist? This cannot be undone.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          actions: <Widget>[ //action options of the alert box set up so that multiple widgets options can be shown
                            TextButton( //first text button set as a Cancel option - allowing the user to go back to their Watchlist without deleting the movie
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: Text('Cancel', style: GoogleFonts.questrial(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold)),
                            ),
                            TextButton( //second text button set as the confirm option
                              key: Key(doc.id),
                              onPressed: () { //when the text button is pressed
                                Navigator.pop(context, 'Delete Movie');
                                FirebaseFirestore.instance
                                    .collection("movieWatchlist") //get an instance of the movieWatchlist collection in Firestore
                                    .doc(doc.id) //pass in the specific document ID of the targetted movie title in Firestore
                                    .delete(); //and delete it from the cloud database
                              },
                              child: Text('Delete Movie', style: GoogleFonts.questrial(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        )),
              )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Your Movie Watchlist",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          elevation: 0.0,
          backgroundColor: const Color(0xff191826),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            StreamBuilder<QuerySnapshot>( //builds a stream that listens to what the Firestore database has stored in it
                stream: FirebaseFirestore.instance //the stream is defined as an instance of the movieWatchlist collection
                    .collection("movieWatchlist")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) { //if the snapshot does not have data
                    return Column(children: const <Widget>[ //return a column with multiple widget children
                      CircularProgressIndicator(), //display circular progress indicator
                      SizedBox(height: 5), //with a sized box with a height of 5 to add separation
                      Center(child: Text("Loading...")) //add a central text widget underneath stating that the data is loading
                    ]);
                  } else { //else, if the snapshot has data
                    //returned the buildList widget as defined above and pass the snapshot data into it
                    //so that the movie's title can be displayed from Firestore
                    return Expanded(child: buildList(snapshot.data!));
                  }
                })
          ]),
        ));
  }

