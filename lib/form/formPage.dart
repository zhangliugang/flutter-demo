import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode _focusNode;

  final controller = TextEditingController();
  final controller2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    controller.addListener(_printLatestValue);
    controller2.addListener(() {
      print("${controller2.text}");
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  _printLatestValue() {
    controller2.text = controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: controller,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Please enter a password.',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey
                  ),
                  prefixText: '+86 ',
                  hasFloatingPlaceholder: true
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
                focusNode: _focusNode,
              ),
              TextFormField(
controller: controller2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Processing Data'),
                          duration: Duration(milliseconds: 500),
                        )
                    );
                  }
                },
                  child: Text('Submit'),),
              )
            ],
          ),

        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FocusScope.of(context).requestFocus(_focusNode),
        tooltip: '',
        child: Icon(Icons.edit),
      ),

    );
  }

}