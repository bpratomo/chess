import 'dart:math';

final boardEdgeIndex = numberToLetter.keys.reduce(max) + 1;

class Address {
  int verticalAddress;
  int horizontalAddress;

  Address(this.horizontalAddress, this.verticalAddress);
}

Address parseAddress(String address) {
  final horizontalAddress =
      letterToNumber[address.substring(0, 1)] ?? boardEdgeIndex;
  final verticalAddress = int.parse(address.substring(1));

  return Address(horizontalAddress, verticalAddress);
}

String calculateNewAddress(String currentAddress, int verticalMovementSpeed,
    int horizontalMovementSpeed) {
  final parsedAddress = parseAddress(currentAddress);
  final newHorizontalAddress =
      parsedAddress.horizontalAddress + horizontalMovementSpeed;

  final newVerticalAddress =
      parsedAddress.verticalAddress + verticalMovementSpeed;

  final newAddress =
      '${numberToLetter[newHorizontalAddress]}$newVerticalAddress';

  return newAddress;
}

bool isAddressValid(String address) {
  final parsedAddress = parseAddress(address);
  final isAddressTooHigh =
      max(parsedAddress.horizontalAddress, parsedAddress.verticalAddress) > 8;
  final isAddressTooLow =
      min(parsedAddress.horizontalAddress, parsedAddress.verticalAddress) < 1;
  return !isAddressTooHigh && !isAddressTooLow;
}

final letterToNumber = <String, int>{
  'a': 1,
  'b': 2,
  'c': 3,
  'd': 4,
  'e': 5,
  'f': 6,
  'g': 7,
  'h': 8
};
final numberToLetter = <int, String>{
  1: 'a',
  2: 'b',
  3: 'c',
  4: 'd',
  5: 'e',
  6: 'f',
  7: 'g',
  8: 'h',
};
