"use strict";

var script = document.createElement('script');
script.src = 'http://code.jquery.com/jquery-3.2.1.js';
document.getElementsByTagName('head')[0].appendChild(script);

var setting; //setting

var formatUnitStreet = ["Australia", "Canada", "France", "Hong Kong", "Malaysia", "New Zealand", "Singapore", "South Africa", "United Kingdom", "United States"],
    formatStreetUnit = ["Austria", "Belgium", "Brazil", "Czech Republic", "Denmark", "Estonia", "Finland", "Germany", "Greece", "Italy", "Mexico", "Netherlands", "Norway", "Portugal", "Spain", "Switzerland", "Sweden"],
    head = document.getElementsByTagName("head")[0],
    address_1 = document.getElementById("checkout_shipping_address_address1") || document.getElementById("checkout_billing_address_address1") || document.getElementById("checkout_shipping_address_attributes_address1"),
    address_2 = document.getElementById("checkout_shipping_address_address2") || document.getElementById("checkout_billing_address_address2") || document.getElementById("checkout_shipping_address_attributes_address2"),
    city = document.getElementById("checkout_shipping_address_city") || document.getElementById("checkout_billing_address_city") || document.getElementById("checkout_shipping_address_attributes_city"),
    cityParent = city ? city.parentElement.parentElement : null,
    zip = document.getElementById("checkout_shipping_address_zip") || document.getElementById("checkout_billing_address_zip") || document.getElementById("checkout_shipping_address_attributes_zip"),
    state = document.getElementById("checkout_shipping_address_province") || document.getElementById("checkout_billing_address_province") || document.getElementById("checkout_shipping_address_attributes_province"),
    country = document.getElementById("checkout_shipping_address_country") || document.getElementById("checkout_billing_address_country") || document.getElementById("checkout_shipping_address_attributes_country"),
    initializeAutocomplete = function() {
        window.Checkout.$("[data-google-places]").removeAttr("data-google-places");
        var e = new google.maps.places.Autocomplete(address_1, {
            types: ["address"],
            componentRestrictions: {
                country: country.options[country.selectedIndex].getAttribute("data-code")
            }
        });
        country.onchange = function() {
            e.setOptions({
                componentRestrictions: {
                    country: this.options[this.selectedIndex].getAttribute("data-code")
                }
            })
        };
        e.addListener("place_changed", function() {
            var t = e.getPlace();
            if (t.address_components) {
                var n = t.address_components.find(function(e) {
                        return -1 !== e.types.indexOf("subpremise")
                    }),
                    s = (t.address_components.find(function(e) {
                        return -1 !== e.types.indexOf("premise")
                    }), t.address_components.find(function(e) {
                        return -1 !== e.types.indexOf("street_number")
                    })),
                    o = t.address_components.find(function(e) {
                        return -1 !== e.types.indexOf("route")
                    }),
                    d = t.address_components.find(function(e) {
                        return -1 !== e.types.indexOf("locality")
                    }),
                    r = t.address_components.find(function(e) {
                        return -1 !== e.types.indexOf("neighborhood")
                    }),
                    a = t.address_components.find(function(e) {
                        return -1 !== e.types.indexOf("postal_town")
                    }),
                    i = t.address_components.find(function(e) {
                        return -1 !== e.types.indexOf("administrative_area_level_2")
                    }),
                    c = t.address_components.find(function(e) {
                        return -1 !== e.types.indexOf("administrative_area_level_1")
                    }),
                    l = t.address_components.find(function(e) {
                        return -1 !== e.types.indexOf("postal_code")
                    }),
                    u = t.address_components.find(function(e) {
                        return -1 !== e.types.indexOf("country")
                    }).long_name;

                    - 1 !== formatUnitStreet.indexOf(u) ? address_1.value = (s ? s.short_name + " " : "") + (o ? o.short_name + " " : "") : -1 !== formatStreetUnit.indexOf(u) && (address_1.value = (o ? o.short_name + " " : "") + (s ? " " + s.short_name : "")),
                    d ? city.value = d.long_name : a ? city.value = a.long_name : r ? city.value = r.long_name : i && (city.value = i.long_name),
                    state && c && (state.value = c.long_name),
                    zip && l && (zip.value = l.long_name),
                    address_2 && n && (address_2.value = n.long_name)
            }
        }), google.maps.event.addDomListener(address_1, "keydown", function(e) {
            13 === e.keyCode && e.preventDefault()
        })
    };

    var validateAddress = function(s) {
        var geocoder = new google.maps.Geocoder();

        var shipping_address = document.getElementsByClassName("review-block__content")[0].innerHTML;
        var geocoder = new google.maps.Geocoder();

        //var textCorrect = "Thanks for specifying a correct shipping address.";
        //var textInaccurate = "Is the shipping address correct?";
        var textCorrect = setting && setting.text_correct ? setting.text_correct : "Thanks for specifying a correct shipping address.";
        var textInaccurate = setting && setting.text_inaccurate ? setting.text_inaccurate : "Is the shipping address correct?";

        var s = function() {
            var e = document.createElement("div");
            e.setAttribute("id", "addressValidatorBox"), document.getElementsByClassName("main__header")[0].appendChild(e)
        };

        var log_history = function(address, shop) {
          var httpreq = new XMLHttpRequest;
          var url = "https://address-validation.herokuapp.com";
          httpreq.open("GET", url + "/add_history?address=" + address + '&shop=' + shop, true),
          httpreq.send(null),
          httpreq.onreadystatechange = function() {
            if (4 === httpreq.readyState) {

            }
          }
        };

        geocoder.geocode({'address': shipping_address}, function(results, status) {
          if (status === 'OK') {
            s(), document.getElementById("addressValidatorBox").innerHTML = "<h2>" + textCorrect + "</h2>";
            var custom_style = 'background: #' + setting.color_background + '; color: #' + setting.color_text + '; border-color: #' + setting.color_border + ';';
            var e = "#addressValidatorBox{margin-top: 25px;padding: 8px;text-align: center;border-radius: 5px; border: 2px solid;" + custom_style + '}',
            t = document.createElement("style");
            t.styleSheet ? t.styleSheet.cssText = e : t.appendChild(document.createTextNode(e)), document.getElementsByTagName("head")[0].appendChild(t);
            //console.log(shipping_address);
            var shop = Shopify.shop || Shopify.Checkout.apiHost;
            console.log(shop)
            log_history(shipping_address, shop);
          } else {
            s(), document.getElementById("addressValidatorBox").innerHTML = "<h2>" + textInaccurate + "</h2>";
            var custom_style = 'background: #' + setting.color_background_warning + '; color: #' + setting.color_text_warning + '; border-color: #' + setting.color_border_warning + ';';
            var e = "#addressValidatorBox{margin-top: 25px;padding: 8px;text-align: center;border-radius: 5px; border: 2px solid;" + custom_style + '}',
            t = document.createElement("style");
            t.styleSheet ? t.styleSheet.cssText = e : t.appendChild(document.createTextNode(e)), document.getElementsByTagName("head")[0].appendChild(t)
          }
        });
    }

! function() {
    var t = Shopify.shop || Shopify.Checkout.apiHost,
        n = function() {
            document.getElementById("addressValidatorBox").style.backgroundColor = setting.color_background, document.getElementById("addressValidatorBox").style.borderColor = setting.color_border, document.getElementById("addressValidatorBox").style.color = setting.color_text, document.getElementById("addressValidatorBox").getElementsByTagName("h2")[0] && (document.getElementById("addressValidatorBox").getElementsByTagName("h2")[0].style.color = setting.color_text), [].forEach.call(document.getElementsByClassName("changed"), function(e) {
                return e.style.color = setting.color_highlight
            });
            var e = "#suggestedAddress:hover, #originalAddress:hover { background-color: " + setting.color_hover + "!important };",
                t = document.createElement("style");
            t.styleSheet ? t.styleSheet.cssText = e : t.appendChild(document.createTextNode(e)), document.getElementsByTagName("head")[0].appendChild(t)
        },
        s = function() {
            var e = document.createElement("div");
            e.setAttribute("id", "addressValidatorBox"), document.getElementsByClassName("main__header")[0].appendChild(e)
        },
        o = function(n, s) {
            var o = new XMLHttpRequest;
            o.open("POST", e + "/checkout_update"), o.setRequestHeader("Content-Type", "application/json;charset=UTF-8"), o.send(JSON.stringify({
                shop: t,
                token: Shopify.Checkout.token,
                status: n
            })), "updated" === n ? (document.getElementById("addressValidatorBox").innerHTML = "<h2>" + setting.text_select_suggestion + "</h2>", document.getElementsByClassName("review-block__content")[0] ? document.getElementsByClassName("review-block__content")[0].innerHTML = s : document.querySelector(".content-box__row.content-box__row--secondary p") ? document.querySelector(".content-box__row.content-box__row--secondary p").innerHTML = s : document.getElementById("shipping-address-recap") && (document.getElementById("shipping-address-recap").innerHTML = s)) : document.getElementById("addressValidatorBox").innerHTML = "<h2>" + setting.text_select_confirm + "</h2>", document.getElementById("addressValidatorBox").getElementsByTagName("h2")[0].style.color = setting.color_text
        },
        d = function(e, t) { //styles for warning
            var n = document.createElement("div");
            return n.setAttribute("id", e), n.style.borderRadius = "5px", n.style.marginBottom = "10px", n.style.padding = "10px", n.style.border = "1px solid #" + setting.color_border_warning, n.style.color = "#" + setting.color_text_warning, n.style.backgroundColor = "#" + setting.color_background_warning, n.innerHTML = t, n
        },
        r = function(e) {
            var n = document.getElementById("addressAlertWrapper"),
                s = function(e) {
                    var t = e.replace(/[^\w\s]/gi, "").replace(/ /g, "").toLowerCase(),
                        n = -1 !== t.indexOf("box") && t.length < 8,
                        s = -1 !== t.indexOf("pobox") && t.length < 12;
                    return n || s
                },
                /*o = function(e) {
                    return -1 !== ["letussellit.myshopify.com", "buymobilerapidco.myshopify.com", "buy-mobile-new-zealand.myshopify.com", "from-china-with-love-australia.myshopify.com", "vayahss.myshopify.com", "amaysim.myshopify.com"].indexOf(t) && -1 !== e.replace(/[^\w\s]/gi, "").replace(/ /g, "").toLowerCase().indexOf("parcellocker")
                },*/
                r = s(address_1.value) || s(address_2.value), // || o(address_1.value) || o(address_2.value),
                a = d("addressAlertWrapper", "&#9888; " + setting.text_pobox_warning);

            r && !n ? cityParent.insertBefore(a, cityParent.childNodes[0]) : !r && n && document.getElementById("addressAlertWrapper").remove();

            a = d("addressAlertWrapper", "&#9888; " + setting.text_apt_suite);

            var aptEmpty = address_2.value.trim() == "";
            !r && !n && aptEmpty ? cityParent.insertBefore(a, cityParent.childNodes[0]) : !aptEmpty && r && n && document.getElementById ("addressAlertWrapper").remove();
        },
        a = function(e) {
            var t = document.getElementById("numAlertWrapper"),
                n = !/^\d/.test(address_1.value) && address_1.value.length >= 6,
                s = d("numAlertWrapper", "&#9888; " + setting.text_streetnum_warning);

            if(n && !t) {
                cityParent.insertBefore(s, cityParent.childNodes[0]);
            }

            if(!n && t) {
                document.getElementById("numAlertWrapper").remove()
            }
            //n && !t ? cityParent.insertBefore(s, cityParent.childNodes[0]) : !n && t && document.getElementById("numAlertWrapper").remove()
        };

    if (Shopify.Checkout && "contact_information" === Shopify.Checkout.step) {
      var httpreq = new XMLHttpRequest;
      var url = "https://address-validation.herokuapp.com",
      shop = Shopify.shop || Shopify.Checkout.apiHost;
      httpreq.open("GET", url + "/settings?shop=" + shop, true),
      httpreq.send(null),
      httpreq.onreadystatechange = function() {
        if (4 === httpreq.readyState) {
          var resp = JSON.parse(httpreq.responseText);
          setting = resp.setting;
          if (setting.pobox_warning ? (address_2 && (address_2.onkeyup = function() {
              return r("");
          }), setting.streetnum_warning ? address_1.onkeyup = function() {
              r(""), a("")
          } : address_1.onkeyup = function() {
              return r("");
          }) : setting.streetnum_warning && (address_1.onkeyup = function() {
              return a("");
          }), setting.auto_complete) {
              var t = document.createElement("script");
              t.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyA7s-Y8HrzH481F0eT2gndRVwvEbVVx7bg&libraries=places&callback=initializeAutocomplete", t.type = "text/javascript", head.appendChild(t)
          }
        }
      }
    }
    if (Shopify.Checkout && "shipping_method" === Shopify.Checkout.step) {
      var httpreq = new XMLHttpRequest;
      var url = "https://address-validation.herokuapp.com",
      shop = Shopify.shop || Shopify.Checkout.apiHost;
      httpreq.open("GET", url + "/settings?shop=" + shop, true),
      httpreq.send(null),
      httpreq.onreadystatechange = function() {
        if (4 === httpreq.readyState) {
          var resp = JSON.parse(httpreq.responseText);
          setting = resp.setting;
          if (setting.validate_address) {
            var t = document.createElement("script");
            t.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyDUHjLA15WQ7HZ16oYq031AO7Nhy2gXLDg&callback=validateAddress", t.type = "text/javascript", head.appendChild(t);
          }
        }
      }
    }
}();
