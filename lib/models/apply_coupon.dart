// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ApplyCoupon welcomeFromJson(String str) => ApplyCoupon.fromJson(json.decode(str));

String welcomeToJson(ApplyCoupon data) => json.encode(data.toJson());

class ApplyCoupon {
  ApplyCoupon({
    this.coupons,
    this.shippingRates,
    this.shippingAddress,
    this.billingAddress,
    this.items,
    this.itemsCount,
    this.itemsWeight,
    this.needsPayment,
    this.needsShipping,
    this.hasCalculatedShipping,
    this.fees,
    this.totals,
    this.errors,
    this.paymentRequirements,
    this.extensions,
  });

  List<Coupon>? coupons;
  List<WelcomeShippingRate>? shippingRates;
  IngAddress? shippingAddress;
  IngAddress? billingAddress;
  List<WelcomeItem>? items;
  int? itemsCount;
  int? itemsWeight;
  bool? needsPayment;
  bool? needsShipping;
  bool? hasCalculatedShipping;
  List<dynamic>? fees;
  WelcomeTotals? totals;
  List<dynamic>? errors;
  List<String>? paymentRequirements;
  Extensions? extensions;

  factory ApplyCoupon.fromJson(Map<String, dynamic> json) => ApplyCoupon(
    coupons: List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
    shippingRates: List<WelcomeShippingRate>.from(json["shipping_rates"].map((x) => WelcomeShippingRate.fromJson(x))),
    shippingAddress: IngAddress.fromJson(json["shipping_address"]),
    billingAddress: IngAddress.fromJson(json["billing_address"]),
    items: List<WelcomeItem>.from(json["items"].map((x) => WelcomeItem.fromJson(x))),
    itemsCount: json["items_count"],
    itemsWeight: json["items_weight"],
    needsPayment: json["needs_payment"],
    needsShipping: json["needs_shipping"],
    hasCalculatedShipping: json["has_calculated_shipping"],
    fees: List<dynamic>.from(json["fees"].map((x) => x)),
    totals: WelcomeTotals.fromJson(json["totals"]),
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
    paymentRequirements: List<String>.from(json["payment_requirements"].map((x) => x)),
    extensions: Extensions.fromJson(json["extensions"]),
  );

  Map<String, dynamic> toJson() => {
    "coupons": List<dynamic>.from(coupons!.map((x) => x.toJson())),
    "shipping_rates": List<dynamic>.from(shippingRates!.map((x) => x.toJson())),
    "shipping_address": shippingAddress!.toJson(),
    "billing_address": billingAddress!.toJson(),
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "items_count": itemsCount,
    "items_weight": itemsWeight,
    "needs_payment": needsPayment,
    "needs_shipping": needsShipping,
    "has_calculated_shipping": hasCalculatedShipping,
    "fees": List<dynamic>.from(fees!.map((x) => x)),
    "totals": totals!.toJson(),
    "errors": List<dynamic>.from(errors!.map((x) => x)),
    "payment_requirements": List<dynamic>.from(paymentRequirements!.map((x) => x)),
    "extensions": extensions!.toJson(),
  };
}

class IngAddress {
  IngAddress({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  factory IngAddress.fromJson(Map<String, dynamic> json) => IngAddress(
    firstName: json["first_name"],
    lastName: json["last_name"],
    company: json["company"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "country": country,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
  };
}

class Coupon {
  Coupon({
    this.code,
    this.discountType,
    this.totals,
  });

  String? code;
  String? discountType;
  CouponTotals? totals;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    code: json["code"],
    discountType: json["discount_type"],
    totals: CouponTotals.fromJson(json["totals"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "discount_type": discountType,
    "totals": totals!.toJson(),
  };
}

class CouponTotals {
  CouponTotals({
    this.totalDiscount,
    this.totalDiscountTax,
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix,
  });

  String? totalDiscount;
  String? totalDiscountTax;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  factory CouponTotals.fromJson(Map<String, dynamic> json) => CouponTotals(
    totalDiscount: json["total_discount"],
    totalDiscountTax: json["total_discount_tax"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    currencyMinorUnit: json["currency_minor_unit"],
    currencyDecimalSeparator: json["currency_decimal_separator"],
    currencyThousandSeparator: json["currency_thousand_separator"],
    currencyPrefix: json["currency_prefix"],
    currencySuffix: json["currency_suffix"],
  );

  Map<String, dynamic> toJson() => {
    "total_discount": totalDiscount,
    "total_discount_tax": totalDiscountTax,
    "currency_code": currencyCode,
    "currency_symbol": currencySymbol,
    "currency_minor_unit": currencyMinorUnit,
    "currency_decimal_separator": currencyDecimalSeparator,
    "currency_thousand_separator": currencyThousandSeparator,
    "currency_prefix": currencyPrefix,
    "currency_suffix": currencySuffix,
  };
}

class Extensions {
  Extensions();

  factory Extensions.fromJson(Map<String, dynamic> json) => Extensions(
  );

  Map<String, dynamic> toJson() => {
  };
}

class WelcomeItem {
  WelcomeItem({
    this.key,
    this.id,
    this.quantity,
    this.quantityLimit,
    this.name,
    this.shortDescription,
    this.description,
    this.sku,
    this.lowStockRemaining,
    this.backordersAllowed,
    this.showBackorderBadge,
    this.soldIndividually,
    this.permalink,
    this.images,
    this.variation,
    this.itemData,
    this.prices,
    this.totals,
    this.catalogVisibility,
    this.extensions,
  });

  String? key;
  int? id;
  int? quantity;
  int? quantityLimit;
  String? name;
  String? shortDescription;
  String? description;
  String? sku;
  dynamic lowStockRemaining;
  bool? backordersAllowed;
  bool? showBackorderBadge;
  bool? soldIndividually;
  String? permalink;
  List<Image>? images;
  List<dynamic>? variation;
  List<dynamic>? itemData;
  Prices? prices;
  ItemTotals? totals;
  String? catalogVisibility;
  Extensions? extensions;

  factory WelcomeItem.fromJson(Map<String, dynamic> json) => WelcomeItem(
    key: json["key"],
    id: json["id"],
    quantity: json["quantity"],
    quantityLimit: json["quantity_limit"],
    name: json["name"],
    shortDescription: json["short_description"],
    description: json["description"],
    sku: json["sku"],
    lowStockRemaining: json["low_stock_remaining"],
    backordersAllowed: json["backorders_allowed"],
    showBackorderBadge: json["show_backorder_badge"],
    soldIndividually: json["sold_individually"],
    permalink: json["permalink"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    variation: List<dynamic>.from(json["variation"].map((x) => x)),
    itemData: List<dynamic>.from(json["item_data"].map((x) => x)),
    prices: Prices.fromJson(json["prices"]),
    totals: ItemTotals.fromJson(json["totals"]),
    catalogVisibility: json["catalog_visibility"],
    extensions: Extensions.fromJson(json["extensions"]),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "id": id,
    "quantity": quantity,
    "quantity_limit": quantityLimit,
    "name": name,
    "short_description": shortDescription,
    "description": description,
    "sku": sku,
    "low_stock_remaining": lowStockRemaining,
    "backorders_allowed": backordersAllowed,
    "show_backorder_badge": showBackorderBadge,
    "sold_individually": soldIndividually,
    "permalink": permalink,
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
    "variation": List<dynamic>.from(variation!.map((x) => x)),
    "item_data": List<dynamic>.from(itemData!.map((x) => x)),
    "prices": prices!.toJson(),
    "totals": totals!.toJson(),
    "catalog_visibility": catalogVisibility,
    "extensions": extensions!.toJson(),
  };
}

class Image {
  Image({
    this.id,
    this.src,
    this.thumbnail,
    this.srcset,
    this.sizes,
    this.name,
    this.alt,
  });

  int? id;
  String? src;
  String? thumbnail;
  String? srcset;
  String? sizes;
  String? name;
  String? alt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    src: json["src"],
    thumbnail: json["thumbnail"],
    srcset: json["srcset"],
    sizes: json["sizes"],
    name: json["name"],
    alt: json["alt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "src": src,
    "thumbnail": thumbnail,
    "srcset": srcset,
    "sizes": sizes,
    "name": name,
    "alt": alt,
  };
}

class Prices {
  Prices({
    this.price,
    this.regularPrice,
    this.salePrice,
    this.priceRange,
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix,
    this.rawPrices,
  });

  String? price;
  String? regularPrice;
  String? salePrice;
  dynamic priceRange;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;
  RawPrices? rawPrices;

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
    price: json["price"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    priceRange: json["price_range"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    currencyMinorUnit: json["currency_minor_unit"],
    currencyDecimalSeparator: json["currency_decimal_separator"],
    currencyThousandSeparator: json["currency_thousand_separator"],
    currencyPrefix: json["currency_prefix"],
    currencySuffix: json["currency_suffix"],
    rawPrices: RawPrices.fromJson(json["raw_prices"]),
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "price_range": priceRange,
    "currency_code": currencyCode,
    "currency_symbol": currencySymbol,
    "currency_minor_unit": currencyMinorUnit,
    "currency_decimal_separator": currencyDecimalSeparator,
    "currency_thousand_separator": currencyThousandSeparator,
    "currency_prefix": currencyPrefix,
    "currency_suffix": currencySuffix,
    "raw_prices": rawPrices!.toJson(),
  };
}

class RawPrices {
  RawPrices({
    this.precision,
    this.price,
    this.regularPrice,
    this.salePrice,
  });

  int? precision;
  String? price;
  String? regularPrice;
  String? salePrice;

  factory RawPrices.fromJson(Map<String, dynamic> json) => RawPrices(
    precision: json["precision"],
    price: json["price"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
  );

  Map<String, dynamic> toJson() => {
    "precision": precision,
    "price": price,
    "regular_price": regularPrice,
    "sale_price": salePrice,
  };
}

class ItemTotals {
  ItemTotals({
    this.lineSubtotal,
    this.lineSubtotalTax,
    this.lineTotal,
    this.lineTotalTax,
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix,
  });

  String? lineSubtotal;
  String? lineSubtotalTax;
  String? lineTotal;
  String? lineTotalTax;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  factory ItemTotals.fromJson(Map<String, dynamic> json) => ItemTotals(
    lineSubtotal: json["line_subtotal"],
    lineSubtotalTax: json["line_subtotal_tax"],
    lineTotal: json["line_total"],
    lineTotalTax: json["line_total_tax"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    currencyMinorUnit: json["currency_minor_unit"],
    currencyDecimalSeparator: json["currency_decimal_separator"],
    currencyThousandSeparator: json["currency_thousand_separator"],
    currencyPrefix: json["currency_prefix"],
    currencySuffix: json["currency_suffix"],
  );

  Map<String, dynamic> toJson() => {
    "line_subtotal": lineSubtotal,
    "line_subtotal_tax": lineSubtotalTax,
    "line_total": lineTotal,
    "line_total_tax": lineTotalTax,
    "currency_code": currencyCode,
    "currency_symbol": currencySymbol,
    "currency_minor_unit": currencyMinorUnit,
    "currency_decimal_separator": currencyDecimalSeparator,
    "currency_thousand_separator": currencyThousandSeparator,
    "currency_prefix": currencyPrefix,
    "currency_suffix": currencySuffix,
  };
}

class WelcomeShippingRate {
  WelcomeShippingRate({
    this.packageId,
    this.name,
    this.destination,
    this.items,
    this.shippingRates,
  });

  int? packageId;
  String? name;
  Destination? destination;
  List<ShippingRateItem>? items;
  List<ShippingRateShippingRate>? shippingRates;

  factory WelcomeShippingRate.fromJson(Map<String, dynamic> json) => WelcomeShippingRate(
    packageId: json["package_id"],
    name: json["name"],
    destination: Destination.fromJson(json["destination"]),
    items: List<ShippingRateItem>.from(json["items"].map((x) => ShippingRateItem.fromJson(x))),
    shippingRates: List<ShippingRateShippingRate>.from(json["shipping_rates"].map((x) => ShippingRateShippingRate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "package_id": packageId,
    "name": name,
    "destination": destination!.toJson(),
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "shipping_rates": List<dynamic>.from(shippingRates!.map((x) => x.toJson())),
  };
}

class Destination {
  Destination({
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
  });

  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "country": country,
  };
}

class ShippingRateItem {
  ShippingRateItem({
    this.key,
    this.name,
    this.quantity,
  });

  String? key;
  String? name;
  int? quantity;

  factory ShippingRateItem.fromJson(Map<String, dynamic> json) => ShippingRateItem(
    key: json["key"],
    name: json["name"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "quantity": quantity,
  };
}

class ShippingRateShippingRate {
  ShippingRateShippingRate({
    this.rateId,
    this.name,
    this.description,
    this.deliveryTime,
    this.price,
    this.taxes,
    this.instanceId,
    this.methodId,
    this.metaData,
    this.selected,
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix,
  });

  String? rateId;
  String? name;
  String? description;
  String? deliveryTime;
  String? price;
  String? taxes;
  int? instanceId;
  String? methodId;
  List<MetaDatum>? metaData;
  bool? selected;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  factory ShippingRateShippingRate.fromJson(Map<String, dynamic> json) => ShippingRateShippingRate(
    rateId: json["rate_id"],
    name: json["name"],
    description: json["description"],
    deliveryTime: json["delivery_time"],
    price: json["price"],
    taxes: json["taxes"],
    instanceId: json["instance_id"],
    methodId: json["method_id"],
    metaData: List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
    selected: json["selected"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    currencyMinorUnit: json["currency_minor_unit"],
    currencyDecimalSeparator: json["currency_decimal_separator"],
    currencyThousandSeparator: json["currency_thousand_separator"],
    currencyPrefix: json["currency_prefix"],
    currencySuffix: json["currency_suffix"],
  );

  Map<String, dynamic> toJson() => {
    "rate_id": rateId,
    "name": name,
    "description": description,
    "delivery_time": deliveryTime,
    "price": price,
    "taxes": taxes,
    "instance_id": instanceId,
    "method_id": methodId,
    "meta_data": List<dynamic>.from(metaData!.map((x) => x.toJson())),
    "selected": selected,
    "currency_code": currencyCode,
    "currency_symbol": currencySymbol,
    "currency_minor_unit": currencyMinorUnit,
    "currency_decimal_separator": currencyDecimalSeparator,
    "currency_thousand_separator": currencyThousandSeparator,
    "currency_prefix": currencyPrefix,
    "currency_suffix": currencySuffix,
  };
}

class MetaDatum {
  MetaDatum({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class WelcomeTotals {
  WelcomeTotals({
    this.totalItems,
    this.totalItemsTax,
    this.totalFees,
    this.totalFeesTax,
    this.totalDiscount,
    this.totalDiscountTax,
    this.totalShipping,
    this.totalShippingTax,
    this.totalPrice,
    this.totalTax,
    this.taxLines,
    this.currencyCode,
    this.currencySymbol,
    this.currencyMinorUnit,
    this.currencyDecimalSeparator,
    this.currencyThousandSeparator,
    this.currencyPrefix,
    this.currencySuffix,
  });

  String? totalItems;
  String? totalItemsTax;
  String? totalFees;
  String? totalFeesTax;
  String? totalDiscount;
  String? totalDiscountTax;
  String? totalShipping;
  String? totalShippingTax;
  String? totalPrice;
  String? totalTax;
  List<dynamic>? taxLines;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  factory WelcomeTotals.fromJson(Map<String, dynamic> json) => WelcomeTotals(
    totalItems: json["total_items"],
    totalItemsTax: json["total_items_tax"],
    totalFees: json["total_fees"],
    totalFeesTax: json["total_fees_tax"],
    totalDiscount: json["total_discount"],
    totalDiscountTax: json["total_discount_tax"],
    totalShipping: json["total_shipping"],
    totalShippingTax: json["total_shipping_tax"],
    totalPrice: json["total_price"],
    totalTax: json["total_tax"],
    taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    currencyMinorUnit: json["currency_minor_unit"],
    currencyDecimalSeparator: json["currency_decimal_separator"],
    currencyThousandSeparator: json["currency_thousand_separator"],
    currencyPrefix: json["currency_prefix"],
    currencySuffix: json["currency_suffix"],
  );

  Map<String, dynamic> toJson() => {
    "total_items": totalItems,
    "total_items_tax": totalItemsTax,
    "total_fees": totalFees,
    "total_fees_tax": totalFeesTax,
    "total_discount": totalDiscount,
    "total_discount_tax": totalDiscountTax,
    "total_shipping": totalShipping,
    "total_shipping_tax": totalShippingTax,
    "total_price": totalPrice,
    "total_tax": totalTax,
    "tax_lines": List<dynamic>.from(taxLines!.map((x) => x)),
    "currency_code": currencyCode,
    "currency_symbol": currencySymbol,
    "currency_minor_unit": currencyMinorUnit,
    "currency_decimal_separator": currencyDecimalSeparator,
    "currency_thousand_separator": currencyThousandSeparator,
    "currency_prefix": currencyPrefix,
    "currency_suffix": currencySuffix,
  };
}
