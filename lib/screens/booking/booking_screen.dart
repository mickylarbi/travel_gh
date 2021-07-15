import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_gh/screens/booking/ticket_screen.dart';
import 'package:travel_gh/shared/background.dart';
import 'package:travel_gh/shared/customSliverList.dart';
import 'package:travel_gh/shared/custom_rounded_button.dart';
import 'package:travel_gh/shared/custom_textformfield.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

enum PaymentMethod { mobileMoney, creditCard }
enum MobileNetwork { MTN, Vodafone, AirtelTigo }
enum CardType { mastercard, visa }

class _BookingScreenState extends State<BookingScreen> {
  int _seats = 1;
  MobileNetwork _mobileNetwork;
  CardType _cardType;
  PaymentMethod _paymentMethod;

  momoOnChanged(value) {
    _mobileNetwork = value;
    setState(() {});
  }

  creditCardOnChanged(value) {
    _cardType = value;
    setState(() {});
  }

  List<String> momoNetworkImages = [
    'assets/images/SeekPng.com_money-png-images_691715.png',
    'assets/images/vodafone.png',
    'assets/images/how-to-use-airteltigo-money-to-buy-google-play-apps-750x750.jpeg'
  ];

  List<String> creditCardImages = [
    'assets/images/773px-Mastercard-logo.svg.png',
    'assets/images/Visa_Inc._logo.svg.png'
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BackgroundDesign(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white.withOpacity(.9),
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  textTheme: TextTheme(
                      headline6: TextStyle(color: Colors.black, fontSize: 16)),
                  expandedHeight: MediaQuery.of(context).size.height * 0.1,
                  pinned: true,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('Book your seats...',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(24),
                  sliver: SliverList(
                      delegate: CustomSliverList(
                    [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('How many seats?'), deIncrementor()],
                      ),
                      Divider(height: 70),
                      Text('How would you like to pay?'),
                      ExpansionPanelList.radio(
                        elevation: 0,
                        dividerColor: Colors.transparent,
                        expansionCallback: (int, bool) {
                          print('$int');
                          print('$bool');

                          if (int == 0 && bool == false) {
                            if (_paymentMethod is PaymentMethod)
                              _paymentMethod = PaymentMethod.creditCard;
                            else
                              _paymentMethod = PaymentMethod.mobileMoney;
                          } else if (int == 1 && bool == false) {
                            if (_paymentMethod is PaymentMethod)
                              _paymentMethod = PaymentMethod.mobileMoney;
                            else
                              _paymentMethod = PaymentMethod.creditCard;
                          } else {
                            _paymentMethod = null;
                          }
                          print('$_paymentMethod');
                        },
                        children: [
                          ExpansionPanelRadio(
                              canTapOnHeader: true,
                              backgroundColor: Colors.transparent,
                              value: 'Mobile money',
                              headerBuilder: (context, isOpen) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Mobile money'),
                                );
                              },
                              body: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: MobileNetwork.values
                                          .map((e) => InkWell(
                                                onTap: () {
                                                  _mobileNetwork = e;
                                                  setState(() {});
                                                },
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      momoNetworkImages[
                                                          e.index],
                                                      height: 60,
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                    Radio(
                                                      value: e,
                                                      groupValue:
                                                          _mobileNetwork,
                                                      onChanged: momoOnChanged,
                                                    )
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                    CustomTextFormField(
                                      hintText: 'Enter mobile money number',
                                      enabled: _mobileNetwork is MobileNetwork,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        MaskTextInputFormatter(
                                            mask: '### ### ####',
                                            filter: {'#': RegExp(r'[0-9]')})
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          ExpansionPanelRadio(
                              canTapOnHeader: true,
                              backgroundColor: Colors.transparent,
                              value: 'Debit/Credit card',
                              headerBuilder: (context, isOpen) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Debit/Credit card'),
                                );
                              },
                              body: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: CardType.values
                                        .map((e) => InkWell(
                                              onTap: () {
                                                _cardType = e;
                                                setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                      creditCardImages[e.index],
                                                      height: 60,
                                                      fit: BoxFit.fitHeight),
                                                  Radio(
                                                    value: e,
                                                    groupValue: _cardType,
                                                    onChanged:
                                                        creditCardOnChanged,
                                                  )
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                  CustomTextFormField(
                                    hintText: 'Enter credit card info',
                                    enabled: _cardType is CardType,
                                    inputFormatters: [
                                      MaskTextInputFormatter(
                                        mask: _cardType == CardType.visa
                                            ? '#### #### #### ####    ##/##   ###'
                                            : '#### #### #### #### ###    ##/##   ###',
                                        filter: {"#": RegExp(r'[0-9]')},
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                      Divider(height: 70),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    height: 60,
                                    child: Text(
                                      'Trip Summary',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    )),
                                SizedBox(height: 20),
                                Text(
                                  'Route',
                                  style: TextStyle(
                                      color: Color(0xFFA9A9A9),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'From:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  'Kumasi',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'To:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  'Cape Coast',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 60,
                                    color: Colors.black,
                                    child: Image.asset('assets/images/oa.png',
                                        height: 60, fit: BoxFit.fitHeight)),
                                SizedBox(height: 20),
                                Text(
                                  'Departure',
                                  style: TextStyle(
                                      color: Color(0xFFA9A9A9),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Date:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  '21 April 2021',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Time:',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Text(
                                  '08:00 AM',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 50),
                      Center(
                        child: Text(
                          'Price:',
                          style: TextStyle(
                              color: Color(0xFFA9A9A9),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                          child: Text(
                        'GHC 80.00',
                        style: TextStyle(
                            color: Color(0xFF00C0CC),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                      SizedBox(height: 30),
                      CustomRoundedButton(
                        text: 'CONFIRM TRIP',
                        height: 60,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Confirming payment\nPlease wait...',
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 10),
                                        CupertinoActivityIndicator()
                                      ],
                                    ),
                                  ));
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.pop(context);
                          }).then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TicketScreen()));
                          });
                        },
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  deIncrementor() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.grey[300].withOpacity(.5),
              onTap: () {
                if (_seats > 1) {
                  --_seats;
                  setState(() {});
                }
              },
              child: Icon(
                Icons.remove,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            '$_seats',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF358FA0)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Color(0xFF358FA0).withOpacity(.5),
              onTap: () {
                if (_seats < 10) {
                  ++_seats;
                  setState(() {});
                }
              },
              child: Icon(
                Icons.add,
                color: Color(0xFF358FA0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
