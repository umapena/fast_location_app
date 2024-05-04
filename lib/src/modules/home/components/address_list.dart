import 'package:fast_location_app/src/modules/home/model/address_model.dart';
import 'package:flutter/material.dart';

class AddressList extends StatefulWidget {
  final List<AddressModel> addressList;

  const AddressList({
    super.key,
    required this.addressList,
  });

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 245, 245, 245),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: widget.addressList.isEmpty
            ? _addressListEmpty()
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _addressItem(widget.addressList[index]);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(height: 1),
                itemCount: widget.addressList.length),
      ),
    ]);
  }

  Widget _addressListEmpty() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off,
              size: 40,
              color: Colors.green,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Não há locais recentes",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }

  Widget _addressItem(AddressModel address) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.place_outlined,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.publicPlace.length <= 20
                      ? address.publicPlace
                      : '${address.publicPlace.substring(0, 20)}...',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      address.neighborhood,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${address.city}, ${address.state}',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                address.cep,
                style: const TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
