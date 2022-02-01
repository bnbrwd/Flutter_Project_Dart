// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import '../providers/products.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProductScreen> {
  final _priceFocusNode =
      FocusNode(); //used to jump to next input form by pressing nextButton from keypad.
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  // TextEditingController: get access to the input the user entered before the form is submitted.before submit show preview.
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  //global key will allow us to interact with the state behind the form widget
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    //to add new listener to that focus node.and execute when focus node changes
    super.initState();
  }

  // didChangeDependencies it always runs when page is open though
  @override
  void didChangeDependencies() {
    //runs before build is executed
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        final product =
            Provider.of<Products>(context, listen: false).findById(productId);
        // one time call so listen as false
        _editedProduct = product;
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // used node to be sure that clear up that memory, free up memory that they have occupied.
  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    // it will triggered all validation
    if (!isValid) {
      return;
    }
    _form.currentState.save(); //to save
    setState(() {
      _isLoading = true;
    });

    print(
        'new items are \n id=${_editedProduct.id},\n title=${_editedProduct.title},\n description=${_editedProduct.description},\n price=${_editedProduct.price}, \n imageUrl=${_editedProduct.imageUrl}');
    if (_editedProduct.id != null) {
      // existing product is editing
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      // setState(() {
      //   _isLoading = false;
      // });
      // Navigator.of(context).pop();
      // go to previous page which show all products.
    } else {
      //new product is adding
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occured'),
            content: Text('Something went wrong'),
            actions: <Widget>[
              TextButton(
                child: Text('Okey'),
                style: TextButton.styleFrom(primary: Colors.orange),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      } 
      // finally {
      //   // it run weather above condition is succeeded or fails.
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      //   // go to previous page which show all products.
      // }
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // go to previous page which show all products.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form, //to make connection
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration:
                          InputDecoration(labelText: 'Title'), //hint text
                      textInputAction: TextInputAction
                          .next, //jump to next form when we click next from kaypad.and hide error msg.
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                        //jump to next form from title for focus when we click next from kaypad. i.e price form field
                      },
                      validator: (value) {
                        //here value is entered text
                        if (value.isEmpty) {
                          return 'please provide a value';
                        } else {
                          return null; // means no error
                        }
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: value,
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          price: _editedProduct.price,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        //here value is entered text
                        if (value.isEmpty) {
                          return 'please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'please enter a valid number.';
                        }
                        if (double.tryParse(value) <= 0) {
                          return 'please enter a number greater then zero.';
                        }
                        return null; // no error
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          imageUrl: _editedProduct.imageUrl,
                          price: double.parse(value),
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        //here value is entered text
                        if (value.isEmpty) {
                          return 'please enter a description';
                        }
                        if (value.length < 10) {
                          return 'should be at least 10 characters long';
                        }
                        return null; // no error
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: value,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          imageUrl: _editedProduct.imageUrl,
                          price: _editedProduct.price,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.end, //image URL show at bottom
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: _initValues['imageUrl'],
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller:
                                _imageUrlController, //used to show preview
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              //here value is entered text
                              if (value.isEmpty) {
                                return 'please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'please enter a valid image URL';
                              }
                              return null; // no error
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                                imageUrl: value,
                                price: _editedProduct.price,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
