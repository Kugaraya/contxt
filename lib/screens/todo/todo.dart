import "package:flutter/material.dart";


class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController _textAddController = TextEditingController();
  TextEditingController _textEditController = TextEditingController();
  bool _isComposing = false, _isActiveAdd = false, _isActiveEdit = false;
  int _editIndex;
  List<int> _status = [];
  List<String> text = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isActiveAdd || _isActiveEdit ? Colors.red : Theme.of(context).primaryColor,
        child: Icon(_isActiveAdd || _isActiveEdit ? Icons.close : Icons.add),
        onPressed: () {
          setState(() {
            _isActiveAdd = _isActiveAdd ? false : true;
            _textAddController.clear();
            _textEditController.clear();
          });
        },
      ),
      appBar: AppBar(
        title: Text("To Do"),
        centerTitle: true,
        backgroundColor: Colors.indigo[300],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            children: <Widget>[
              if(_isActiveAdd)
                _activeAdd(),
              if(_isActiveEdit)
                _activeEdit(),
              for(int i=0; i < _status.length; i++)
                _addCard(i),
            ],
          ),
        ),
      ),
    );
  }

  _submitAddEntry(String _text) {
    _textAddController.clear();
    setState(() {
      _status.add(0);
      text.add(_text);
      _isComposing = false;
      _isActiveAdd = false;
    });
  }

  _submitEditEntry(String _text, int index) {
    _textEditController.clear();
    setState(() {
      text[index] = _text;
      _isComposing = false;
      _isActiveEdit = false;
    });
  }

  Widget _activeAdd() {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            autofocus: true,
            controller: _textAddController,
            maxLines: 6,
            maxLength: 500,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (String text) {
              setState(() {
                _isComposing = text.length > 0;
              });
            },
            onSubmitted: _submitAddEntry,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          child: IconButton(
            icon: Icon(Icons.send, color: Colors.blue,),
            onPressed: _isComposing ?
            () => _submitAddEntry(_textAddController.text) : null,
          ),
        ),
      ]
    );
  }

  Widget _activeEdit() {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            autofocus: true,
            controller: _textEditController,
            maxLines: 6,
            maxLength: 500,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (String text) {
              setState(() {
                _isComposing = text.length > 0;
              });
            },
            onSubmitted: _submitEditEntry(_textEditController.text, _editIndex),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          child: IconButton(
            icon: Icon(Icons.send, color: Colors.blue,),
            onPressed: _isComposing ?
            () => _submitEditEntry(_textEditController.text, _editIndex) : null,
          ),
        ),
      ]
    );
  }

  Widget _addCard(int i) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
      elevation: 3,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 55.0,
              height: 55.0,
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: Icon(_status[i] == 0 ? Icons.check_box_outline_blank : Icons.check_box),
                onPressed: () {
                  setState(() {
                    _status[i] = _status[i] == 0 ? 1 : 0;
                  });
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 55.0,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _isActiveEdit = true;
                      _editIndex = i;
                    });
                  },
                  child: Text(text[i], 
                    textAlign: TextAlign.left, 
                    style: TextStyle(color: Colors.grey[400]),
                    overflow: TextOverflow.ellipsis,
                    textWidthBasis: TextWidthBasis.parent,
                    maxLines: 2,
                    softWrap: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 55.0,
              height: 55.0,
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: Icon(Icons.delete_forever),
                onPressed: () {
                  setState(() {
                    _status.removeAt(i);
                    text.removeAt(i);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}