import 'package:flutter/material.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:json_tree_viewer/json_tree_viewer.dart';

class SearchDataDetails extends StatefulWidget {
  GBSearchData data;
  SearchDataDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<SearchDataDetails> createState() => _SearchDataDetailsState();
}

class _SearchDataDetailsState extends State<SearchDataDetails> {
  bool isLoading = false;
  Map<String, dynamic> details = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    setState(() {
      isLoading = true;
    });
    GBData? data = await GeocoderBuddy.searchToGBData(widget.data);
    if (data != null) {
      setState(() {
        isLoading = false;
        details = data.toJson();
      });
    } else {
      //error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Item Details"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: !isLoading
            ? JsonTreeViewer(
                data: details,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
