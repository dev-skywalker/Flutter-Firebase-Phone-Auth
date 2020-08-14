import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_bloc/bloc/user/user_bloc.dart';
import 'package:soft_bloc/screen/home_page.dart';
import 'package:soft_bloc/services/user_repository.dart';

class CreateUserPage extends StatefulWidget {

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _nameTextController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(userRepository: UserRepository()),
      child: Scaffold(
        body: BlocListener<UserBloc,UserState>(listener: (context,state){
          if(state is LoadingState){
            _isLoading = true;
          }
        },
          child: BlocBuilder<UserBloc,UserState>(
            builder: (context,state){
              if(state is CreateUserState){
               return HomePage(userData: state.userData);
              }
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameTextController,
                        decoration: InputDecoration(
                          hintText: "Enter Name",
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                            borderSide: new BorderSide(
                              color: Colors.deepPurpleAccent,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 150,
                        height: 40,
                        child: RaisedButton(
                          child: _isLoading ?
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                              : Text(
                            "Add User",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.deepPurpleAccent,
                          onPressed: () {
                            BlocProvider.of<UserBloc>(context).add(
                              CreateUser(_nameTextController.value.text),
                            );
                          },
                        ),
                      ),
                    ],
                  )
              );
            },
          )
        ),
      ),
    );
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
