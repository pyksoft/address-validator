"use strict";
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
                    }).long_name; - 1 !== formatUnitStreet.indexOf(u) ? address_1.value = (s ? s.short_name + " " : "") + o.short_name : -1 !== formatStreetUnit.indexOf(u) && (address_1.value = o.short_name + (s ? " " + s.short_name : "")), d ? city.value = d.long_name : a ? city.value = a.long_name : r ? city.value = r.long_name : i && (city.value = i.long_name), state && c && (state.value = c.long_name), zip && l && (zip.value = l.long_name), address_2 && n && (address_2.value = n.long_name)
            }
        }), google.maps.event.addDomListener(address_1, "keydown", function(e) {
            13 === e.keyCode && e.preventDefault()
        })
    };
! function() {
    var e = "https://app.roboturk.co/address_validator/api",
        t = Shopify.shop || Shopify.Checkout.apiHost,
        n = function() {
            document.getElementById("addressValidatorBox").style.backgroundColor = c.colorBackground, document.getElementById("addressValidatorBox").style.borderColor = c.colorBorder, document.getElementById("addressValidatorBox").style.color = c.colorText, document.getElementById("addressValidatorBox").getElementsByTagName("h2")[0] && (document.getElementById("addressValidatorBox").getElementsByTagName("h2")[0].style.color = c.colorText), [].forEach.call(document.getElementsByClassName("changed"), function(e) {
                return e.style.color = c.colorHighlight
            });
            var e = "#suggestedAddress:hover, #originalAddress:hover { background-color: " + c.colorHover + "!important };",
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
            })), "updated" === n ? (document.getElementById("addressValidatorBox").innerHTML = "<h2>" + c.textSelectSuggestion + "</h2>", document.getElementsByClassName("review-block__content")[0] ? document.getElementsByClassName("review-block__content")[0].innerHTML = s : document.querySelector(".content-box__row.content-box__row--secondary p") ? document.querySelector(".content-box__row.content-box__row--secondary p").innerHTML = s : document.getElementById("shipping-address-recap") && (document.getElementById("shipping-address-recap").innerHTML = s)) : document.getElementById("addressValidatorBox").innerHTML = "<h2>" + c.textSelectConfirm + "</h2>", document.getElementById("addressValidatorBox").getElementsByTagName("h2")[0].style.color = c.colorText
        },
        d = function(e, t) {
            var n = document.createElement("div");
            return n.setAttribute("id", e), n.style.borderRadius = "5px", n.style.marginBottom = "10px", n.style.padding = "10px", n.style.border = "1px solid #e59400", n.style.color = "#e59400", n.style.backgroundColor = "#fff6e5", n.innerHTML = t, n
        },
        r = function(e) {
            var n = document.getElementById("addressAlertWrapper"),
                s = function(e) {
                    var t = e.replace(/[^\w\s]/gi, "").replace(/ /g, "").toLowerCase(),
                        n = -1 !== t.indexOf("box") && t.length < 8,
                        s = -1 !== t.indexOf("pobox") && t.length < 12;
                    return n || s
                },
                o = function(e) {
                    return -1 !== ["letussellit.myshopify.com", "buymobilerapidco.myshopify.com", "buy-mobile-new-zealand.myshopify.com", "from-china-with-love-australia.myshopify.com", "vayahss.myshopify.com", "amaysim.myshopify.com"].indexOf(t) && -1 !== e.replace(/[^\w\s]/gi, "").replace(/ /g, "").toLowerCase().indexOf("parcellocker")
                },
                r = s(address_1.value) || s(address_2.value) || o(address_1.value) || o(address_2.value),
                a = d("addressAlertWrapper", e.textPOBox || "&#9888; We cannot deliver to a P.O. Box. Please provide a valid street address.");
            r && !n ? cityParent.insertBefore(a, cityParent.childNodes[0]) : !r && n && document.getElementById("addressAlertWrapper").remove()
        },
        a = function(e) {
            var t = document.getElementById("numAlertWrapper"),
                n = !/\d/.test(address_1.value) && address_1.value.length >= 6,
                s = d("numAlertWrapper", e.textStreetNum || "&#9888; Please specify a street number.");
            n && !t ? cityParent.insertBefore(s, cityParent.childNodes[0]) : !n && t && document.getElementById("numAlertWrapper").remove()
        };
    if (Shopify.Checkout && "contact_information" === Shopify.Checkout.step && t) {
        var i = new XMLHttpRequest;
        i.open("GET", e + "/brand_preferences?shop=" + t, !0), i.send(null), i.onreadystatechange = function() {
            if (4 === i.readyState) {
                var e = JSON.parse(i.responseText);
                if (e.disable_po_boxes ? (address_2 && (address_2.onkeyup = function() {
                        return r(e.customization)
                    }), e.address1_num_check ? address_1.onkeyup = function() {
                        r(e.customization), a(e.customization)
                    } : address_1.onkeyup = function() {
                        return r(e.customization)
                    }) : e.address1_num_check && (address_1.onkeyup = function() {
                        return a(e.customization)
                    }), e.autocomplete) {
                    var t = document.createElement("script");
                    t.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyABMvMXqWmgepYbmi8fnm2zm9pW2ECgPq0&libraries=places&callback=initializeAutocomplete", t.type = "text/javascript", head.appendChild(t)
                }
            }
        }
    }
    var c = void 0,
        l = ["done", "invalid order", "no shipping address", "already fulfilled", "invalid request", "invalid store", "invalid country", "invalid checkout", "ignore order"];
    if (Shopify.Checkout && "shipping_method" === Shopify.Checkout.step && t) {
        var u = new XMLHttpRequest;
        u.open("GET", e + "/brand_preferences?shop=" + t, !0), u.send(null), u.onreadystatechange = function() {
            if (4 === u.readyState && JSON.parse(u.responseText).validate_pre_checkout && "write_script_tags,read_orders,write_orders,read_checkouts,write_checkouts" === JSON.parse(u.responseText).scope) {
                c = JSON.parse(u.responseText).customization;
                var d = document.createElement("link");
                d.rel = "stylesheet", d.type = "text/css", d.href = "https://s3-us-west-2.amazonaws.com/addressvalidator/validate.css", head.appendChild(d);
                var r = new XMLHttpRequest;
                r.open("POST", e + "/checkout_validate"), r.setRequestHeader("Content-Type", "application/json;charset=UTF-8"), r.send(JSON.stringify({
                    shop: t,
                    token: Shopify.Checkout.token
                })), r.onreadystatechange = function() {
                    if (4 === r.readyState) {
                        if ("Address is valid" === r.responseText) s(), document.getElementById("addressValidatorBox").innerHTML = "<h2>" + c.textCorrect + "</h2>";
                        else if (-1 !== l.indexOf(r.responseText)) console.log(r.responseText);
                        else if ("Street address was verified, but confirm apt/suite/unit number." === r.responseText) s(), document.getElementById("addressValidatorBox").innerHTML = "<h2>" + c.textAptSuite + "</h2>";
                        else if (200 === r.status) {
                            s(), window.scrollTo(0, 0);
                            var e = JSON.parse(r.responseText).original,
                                t = JSON.parse(r.responseText).suggested;
                            document.getElementById("addressValidatorBox").innerHTML = "\n<h2>" + c.textSuggest1 + "</h2>\n<small>" + c.textSuggest2 + "</small>\n<br /><br />\n<div id='suggestedAddress'>\n<b><i>Suggested address:</i></b>\n<br />\n" + t + "\n</div>\n<hr />\n<div id='originalAddress'>\n<b><i>Original address:</i></b>\n<br />\n" + e + "\n</div>\n", document.getElementById("suggestedAddress").onclick = function() {
                                return o("updated", t.replace(/<br>/g, ","))
                            }, document.getElementById("originalAddress").onclick = function() {
                                return o("confirmed", null)
                            }
                        } else s(), document.getElementById("addressValidatorBox").innerHTML = "<h2>" + c.textInaccurate + "</h2>"; - 1 === l.indexOf(r.responseText) && n()
                    }
                }
            }
        }
    }
}();