
  @override
  Widget build(BuildContext context) {
    dataList = [];

    return FutureBuilder<DocumentSnapshot>(
        future: _dataCollection.doc(widget.documentId).get(),
        builder: (context, snapshot) {
          // dataList = [];

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Row(children: []);
        }