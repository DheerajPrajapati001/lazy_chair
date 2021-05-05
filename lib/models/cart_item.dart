/*
 * BSD 3-Clause License

    Copyright (c) 2020, RAY OKAAH - MailTo: ray@flutterengineer.com, Twitter: Rayscode
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 */

class WooCartItem {
  String key;
  int id;
  int quantity;
  int quantity_limit;
  String name;
  String sku;
  String permalink;
  List<WooCartItemImages> images;
  Prices prices;
  Total total;
  String linePrice;
  List<String> variation;

  WooCartItem(
      {this.key,
        this.id,
        this.quantity,
        this.name,
        this.sku,
        this.quantity_limit,
        this.permalink,
        this.images,
        this.prices,
        this.linePrice,
        this.variation,
      this.total});

  WooCartItem.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    quantity = json['quantity'];
    name = json['name'];
    sku = json['sku'];
    permalink = json['permalink'];
    quantity_limit = json['quantity_limit'];
    if (json['images'] != null) {
      images = new List<WooCartItemImages>();
      json['images'].forEach((v) {
        images.add(new WooCartItemImages.fromJson(v));
      });
    }
    prices = json['prices'] != null ? new Prices.fromJson(json['prices']) : null;
    total = json['prices'] != null ? new Total.fromJson(json['totals']) : null;

    linePrice = json['line_price'];
    variation = json['variation'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['sku'] = this.sku;
    data['quantity_limit'] = this.quantity_limit;
    data['permalink'] = this.permalink;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.prices != null) {
      data['prices'] = this.prices.toJson();
    }
    data['line_price'] = this.linePrice;
    data['variation'] = this.variation;
    return data;
  }
  @override toString() => this.toJson().toString();
}

class Prices {
  String price;
  String regularPrice;
  String salePrice;
  Null priceRange;
  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyDecimalSeparator;
  String currencyThousandSeparator;
  String currencyPrefix;
  String currencySuffix;
  RawPrices rawPrices;

  Prices({this.price, this.regularPrice, this.salePrice, this.priceRange, this.currencyCode, this.currencySymbol, this.currencyMinorUnit, this.currencyDecimalSeparator, this.currencyThousandSeparator, this.currencyPrefix, this.currencySuffix, this.rawPrices});

  Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    priceRange = json['price_range'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
    rawPrices = json['raw_prices'] != null ? new RawPrices.fromJson(json['raw_prices']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['price_range'] = this.priceRange;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    if (this.rawPrices != null) {
      data['raw_prices'] = this.rawPrices.toJson();
    }
    return data;
  }
}

class Total {
  String lineSubtotal;
  String lineSubtotalTax;
  String lineTotal;
  String lineTotalTax;
  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyDecimalSeparator;
  String currencyThousandSeparator;
  String currencyPrefix;
  String currencySuffix;

  Total({this.lineSubtotal, this.lineSubtotalTax, this.lineTotal, this.lineTotalTax, this.currencyCode, this.currencySymbol,
    this.currencyMinorUnit, this.currencyDecimalSeparator, this.currencyThousandSeparator, this.currencyPrefix,
    this.currencySuffix});

  Total.fromJson(Map<String, dynamic> json) {
    lineSubtotal = json['line_subtotal'];
    lineSubtotalTax = json['line_subtotal_tax'];
    lineTotal = json['line_total'];
    lineTotalTax = json['line_total_tax'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['line_subtotal'] = this.lineSubtotal;
    data['line_subtotal_tax'] = this.lineSubtotalTax;
    data['line_total'] = this.lineTotal;
    data['line_total_tax'] = this.lineTotalTax;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;

    return data;
  }
}


class RawPrices {
  int precision;
  String price;
  String regularPrice;
  String salePrice;

  RawPrices({this.precision, this.price, this.regularPrice, this.salePrice});

  RawPrices.fromJson(Map<String, dynamic> json) {
    precision = json['precision'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['precision'] = this.precision;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    return data;
  }
}

class WooCartItemImages {
  String id;
  String src;
  String thumbnail;
  bool srcset;
  String sizes;
  String name;
  String alt;

  WooCartItemImages(
      {this.id,
        this.src,
        this.thumbnail,
        this.srcset,
        this.sizes,
        this.name,
        this.alt});

  WooCartItemImages.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    src = json['src'];
    thumbnail = json['thumbnail'];

    if (json['srcset'] is String){
      srcset = bool.fromEnvironment(json['srcset']) ;
    }
    else{
      srcset = json['srcset'];
    }
    sizes = json['sizes'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
    data['thumbnail'] = this.thumbnail;
    data['srcset'] = this.srcset;
    data['sizes'] = this.sizes;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}
