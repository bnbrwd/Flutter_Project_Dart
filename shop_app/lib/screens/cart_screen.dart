import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  // SizedBox(width: 10), // add space b\w row
                  Spacer(),
                  Chip(
                    label: Text(
                      '\₹${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ), //Text('\₹${cart.totalAmount}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  // TextButton(
                  //     child: Text('ORDER NOW'),
                  //     style: TextButton.styleFrom(primary: Colors.orange),
                  //     onPressed: cart.totalAmount <= 0
                  //         ? null
                  //         : () {
                  //             //here order is not changing only dispatch the action so used as false
                  //             Provider.of<Orders>(context, listen: false)
                  //                 .addOrder(
                  //               cart.items.values.toList(),
                  //               cart.totalAmount,
                  //             );
                  //             cart.clear();
                  //           }),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(width: 10), //for inser space.
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length, // no of element in list.
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
              ), //build list of entries
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: _isLoading ? CircularProgressIndicator(color: Colors.green) : Text('ORDER NOW'),
        style: TextButton.styleFrom(primary: Colors.orange),
        onPressed: (widget.cart.totalAmount <= 0 || _isLoading) 
            ? null
            : () async {
              setState(() {
                _isLoading = true;
              });
                //here order is not changing only dispatch the action so used as false
               await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(),
                  widget.cart.totalAmount,
                );
                setState(() {
                _isLoading = false;
              });
                widget.cart.clear();
              });
  }
}
