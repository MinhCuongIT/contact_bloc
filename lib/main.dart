import 'package:contactbloc/blocs/contact_bloc/bloc.dart';
import 'package:contactbloc/models/res.dart';
import 'package:contactbloc/widgets/waiting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'blocs/blocDelegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Contacts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = ScrollController();
  bool isShowFloatingButton;
  Respo res = Respo();

  scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        isShowFloatingButton = false;
      });
    } else {
      if (!isShowFloatingButton) {
        setState(() {
          isShowFloatingButton = true;
        });
      }
    }
  }

  @override
  void initState() {
    isShowFloatingButton = true;
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(),
      child: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is InitialContactState) {
            print('Trang thai khoi tao');
          } else if (state is AddContactState) {
            res.add(Contact(state.name, state.phone));
          } else if (state is RemoveContactState) {
            res.remove(state.phone);
          }
        },
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(widget.title),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {},
                  )
                ],
              ),
              body: Stack(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: res.getAll().length == 0
                          ? Center(
                              child: Text('Không có danh bạ'),
                            )
                          : ListView(
                              controller: _scrollController,
                              children:
                                  List.generate(res.getAll().length, (index) {
                                Contact contact = res.getAll()[index];
                                return Card(
                                  child: Slidable(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.account_circle,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                      title: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              contact.name,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        contact.phone,
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.more_vert,
                                                size: 20,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.call,
                                                size: 20,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actionPane: SlidableScrollActionPane(),
                                    actionExtentRatio: 0.25,
                                    secondaryActions: <Widget>[
                                      IconSlideAction(
                                        icon: Icons.delete,
                                        color: Colors.red,
                                        caption: "Xóa",
                                        onTap: () {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible: false,
                                            // false = user must tap button, true = tap outside dialog
                                            builder:
                                                (BuildContext dialogContext) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Xác nhận',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                content: Text(
                                                    'Bạn có chắc chắn muốn xóa "${contact.name}" không?'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('Đồng ý'),
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  ContactBloc>(
                                                              context)
                                                          .add(RemoveContact(
                                                              contact.phone));
                                                      Navigator.of(
                                                              dialogContext)
                                                          .pop(); // Dismiss alert dialog
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: Text('Hủy'),
                                                    onPressed: () {
                                                      Navigator.of(
                                                              dialogContext)
                                                          .pop(); // Dismiss alert dialog
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ),
                    ),
                  ),
                  // state is InitialContactState ? WaitingDialog : SizedBox(),
                ],
              ),
              floatingActionButton: AnimatedSwitcher(
                child: isShowFloatingButton
                    ? FloatingActionButton(
                        onPressed: () {
                          TextEditingController txtName =
                              TextEditingController();
                          TextEditingController txtPhone =
                              TextEditingController();
                          FocusNode fnTxtName = FocusNode();
                          FocusNode fnTxtPhone = FocusNode();
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            // false = user must tap button, true = tap outside dialog
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: Text('Thêm danh bạ'),
                                content: Container(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
//                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextField(
                                          controller: txtName,
                                          focusNode: fnTxtName,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            labelText: 'Tên',
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onSubmitted: (_) {
                                            // print('onSubmit method!');
                                            // fnTxtName.unfocus();
                                            FocusScope.of(dialogContext)
                                                .requestFocus(fnTxtPhone);
                                          },
                                        ),
                                        TextField(
                                          controller: txtPhone,
                                          focusNode: fnTxtPhone,
                                          textInputAction: TextInputAction.done,
                                          onSubmitted: (_) {
                                            FocusScope.of(dialogContext)
                                                .requestFocus(FocusNode());
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Số điện thoại',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Hủy'),
                                    onPressed: () {
                                      Navigator.of(dialogContext)
                                          .pop(); // Dismiss alert dialog
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Đồng ý'),
                                    onPressed: () {
                                      if (txtName.text.isEmpty ||
                                          txtPhone.text.isEmpty) {
                                        showDialog<void>(
                                          context: dialogContext,
                                          barrierDismissible: false,
                                          // false = user must tap button, true = tap outside dialog
                                          builder:
                                              (BuildContext dialogContext1) {
                                            return AlertDialog(
                                              title: Text('Thông báo'),
                                              content: Text(
                                                  'Nội dung không được trống'),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('Ok'),
                                                  onPressed: () {
                                                    Navigator.of(dialogContext1)
                                                        .pop(); // Dismiss alert dialog
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        return;
                                      }
                                      // add new contact
                                      BlocProvider.of<ContactBloc>(context).add(
                                          AddContact(
                                              txtName.text, txtPhone.text));
                                      Navigator.of(dialogContext)
                                          .pop(); // Dismiss alert dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        tooltip: 'Add new a contact',
                        child: Icon(Icons.add),
                      )
                    : SizedBox(),
                duration: Duration(
                  seconds: 1,
                ),
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        ScaleTransition(
                  child: child,
                  scale: animation,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
