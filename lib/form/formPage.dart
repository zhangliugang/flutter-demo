import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  counterText: '111',
                  prefixText: '+86 ',
                  hasFloatingPlaceholder: true
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                },
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
      )

    );
  }

}