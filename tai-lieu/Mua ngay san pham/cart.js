var nh_cart = {
    show_modal: true,
    init: function () {
        var self = this;

        // event add to cart on list
        $(document).on('click', '.btn-shop-cart', function () {
            var item_id = $(this).attr('item-id');
            if (item_id == null) item_id = 0;
            var data_post = {
                item_id: item_id,
                quantity: 1,
            };

            self.addToCart(data_post);
        })
        
        $(document).on('click', '.btn-mn', function (event) {
            var item_id = $(this).attr('item-id');
            if (item_id == null) item_id = 0;
            var quantity = 1;

            if (quantity > 0) {
                var data_post = {
                    item_id: item_id,
                    quantity: quantity,
                };
                self.addToCartNow(data_post);
            } else {
                nh_functions.showAlertGritter('error', message);
                return false;
            }
        });
        
        $(document).on('click', '.btn-buynow-detail', function (event) {
            var item_id = $(this).attr('item-id');
            if (item_id == null) item_id = 0;
            var quantity = parseInt($.trim($('.num-quantity').val()));

            if (quantity > 0) {
                var data_post = {
                    item_id: item_id,
                    quantity: quantity,
                };
                self.addToCartNow(data_post);
            } else {
                nh_functions.showAlertGritter('error', message);
                return false;
            }
        });

        // event add to cart in detail page
        $(document).on('click', '.btn-add-cart-two,.btn-installment', function (event) {
            var item_id = $(this).attr('item-id');
            if (item_id == null) item_id = 0;
            var quantity = parseInt($.trim($('.num-quantity').val()));
            var installment = typeof($(this).data('installment')) != 'undefined' ? $(this).data('installment') : '';
            if (quantity > 0) {
                var data_post = {
                    item_id: item_id,
                    quantity: quantity,
                    installment:installment
                };
                self.addToCart(data_post);
            } else {
                var message = global_lang.messages_please_select_quantity;
                nh_functions.showAlertGritter('error', message);
                return false;
            }
        });

        // event change quantity in order
        $(document).on('change', '.input-cart', function () {
            var item_id = $(this).attr('item-id');
            if (item_id == null) item_id = 0;

            var quantity = parseInt($.trim($(this).val()));
            // check quantity
            if (!quantity > 0) {
                var message = global_lang.messages_please_select_quantity;
                nh_functions.showAlertGritter('error', message);
                return false;
            }

            var data_post = {
                item_id: item_id,
                quantity: quantity,
                change_quantity: true,
            }
            // not show modal
            self.show_modal = false;

            self.addToCart(data_post);
        });


        // delete item in order
        $(document).on('click', '.delete-order', function (event) {
            self.deleteOrder({
                product_id: $(this).attr('product-id'),
                item_id: $(this).attr('item-id')
            })
        });
    },
    addToCart: function (data_post) {
        var self = this;
        nh_functions.showLoadingPage();
        $.ajax({
            async: false,
            url: '/orders/Orders/addCart',
            type: 'POST',
            dataType: 'json',
            data: {data: data_post},
            success: function (response) {
                if (response.code == 0) {                    
                    $('.mini-cart-order .number').text(response.count_product)
                    // add new item to mini cart
                    if (!$.isEmptyObject(response.data) && $('.shoppingcart-box').length > 0) {
                        var data = $.parseJSON(response.data);
                        var product_id = data['item_add']['product_id'];
                        var item_id = data['item_add']['item_id'];
                        // check product exist in cart
                        $('.shoppingcart-box .item').each(function (index) {
                            var element_product_id = $(this).find('.delete-order').attr('product-id');
                            var element_item_id = $(this).find('.delete-order').attr('item-id');
                            if (product_id == element_product_id && item_id == element_item_id) {
                                var this_number = $(this).find('.number-item').text();
                                $(this).find('.number-item').text(parseInt(this_number) + 1);
                            }
                        });

                        //refresh list product in mini cart
                        nh_functions.loadContentBlockTabs('orders/Orders/miniCart', {}, '.shoppingcart-box');
                    }

                    // if type is installment => redirect to page info card
                    if(typeof(response.installment) != 'undefined' && response.installment == 1){
                        window.location.href = '/order/card-info?installment=1';
                        return false;
                    }
                    // show modal add to cart
                    if (self.show_modal) {
                        nh_functions.hiddenLoadingPage();
                        self.showModalAddToCart(response.data);
                    } else {
                        window.location = window.location.href;
                    }
                } else {
                    nh_functions.showAlertGritter('error', response.messages)
                }
            },
            error: function (response, json, errorThrown) {

            }
        });
    },
    
    addToCartNow: function (data_post) {
        var self = this;
        nh_functions.showLoadingPage();
        $.ajax({
            async: false,
            url: '/orders/Orders/addCart',
            type: 'POST',
            dataType: 'json',
            data: {data: data_post},
            success: function (response) {
                if (response.code == 0) {                    
                    $('.mini-cart-order .number').text(response.count_product)
                    // add new item to mini cart
                    if (!$.isEmptyObject(response.data) && $('.shoppingcart-box').length > 0) {
                        var data = $.parseJSON(response.data);
                        var product_id = data['item_add']['product_id'];
                        var item_id = data['item_add']['item_id'];
                        // check product exist in cart
                        var exist_element = false;
                        $('.shoppingcart-box .item').each(function (index) {
                            var element_product_id = $(this).find('.delete-order').attr('product-id');
                            var element_item_id = $(this).find('.delete-order').attr('item-id');
                            if (product_id == element_product_id && item_id == element_item_id) {
                                exist_element = true;
                                var this_number = $(this).find('.number-item').text();
                                $(this).find('.number-item').text(parseInt(this_number) + 1);
                            }
                        });
                        
                        nh_functions.loadContentBlockTabs('orders/Orders/miniCart', {}, '.shoppingcart-box');
                        
                        window.location = '/order/card-info';

                    }
                } else {
                    nh_functions.showAlertGritter('error', response.messages)
                }
            },
            error: function (response, json, errorThrown) {

            }
        });
    },

    showModalAddToCart: function (data_json) {
        var data = {};
        var self = this;
        var modal = $('#add-cart-modal')
        if (typeof data_json != 'undefined') {
            data = $.parseJSON(data_json);
        }
        // show info add to cart
        if (!$.isEmptyObject(data.item_add)) {
            var item_add = data.item_add;
            modal.find('.product-name-modal').text(item_add.name);
            modal.find('.price-modal').text(nh_functions.formatMoney(item_add.price));
            modal.find('.price-sale-modal').toggleClass('hidden', item_add.price_sale == 0 ? true : false).text(nh_functions.formatMoney(item_add.price_sale)).append(global_lang.currency_unit);
            modal.find('.image-cart-modal a').attr('href', '/' + item_add.url);
            modal.find('.image-cart-modal img').attr('src', '/' + item_add.url_img);
        }

        // show modal
        modal.modal('show');

    },
    deleteOrder: function (dataPost) {
        nh_functions.showLoadingPage();
        $.ajax({
            url: '/orders/Orders/ajaxDeleteOrder',
            type: 'POST',
            async: false,
            data: dataPost,
            dataType: 'json',
            success: function (response) {
                location.reload();
            },
            error: function (response, json, errorThrown) {
                errorHandler(response);
            }
        });
    },
}


var payment_installment = {
    data:{
        payment_code:'',
        bank_code:'',
        card:'',
        month:''
    },
    label:{
        month:'tháng'
    },
    info_installment:{

    },
    init: function (option) {
        var self = this;

        if(typeof(option.payment_code) != 'undefined'){
            self.data.payment_code = option.payment_code;
        }

        if(typeof(option.label) != 'undefined'){
            self.label = option.label;
        }
        // select bank
        $(document).on('click', '#list-banks-installment li', function (event) {
            $('#list-banks-installment li').removeClass('active');
            $('#list-cards-installment li').removeClass('active');
            $('#list-month-installment li').removeClass('active');
            
            $(this).addClass('active');
            var str_cards = typeof($(this).data('card')) != 'undefined' ? $(this).data('card') : '';
            var bank_code = typeof($(this).data('code')) != 'undefined' ? $(this).data('code') : '';
            self.data.bank_code = bank_code;
            self.showCards(str_cards);
        });

        // select card
        $(document).on('click', '#list-cards-installment li', function (event) {
            $('#list-cards-installment li').removeClass('active');
            $('#list-month-installment li').removeClass('active');
            $(this).addClass('active');           
            var card = typeof($(this).data('card')) != 'undefined' ? $(this).data('card') : '';
            self.data.card = card;
            self.loadInfoInstallment(self.data);
        });

        // select month
        $(document).on('click', '#list-month-installment li', function (event) {
            $('#list-month-installment li').removeClass('active');
            $(this).addClass('active');
            var month = typeof($(this).data('month')) != 'undefined' ? $(this).data('month') : '';
            self.data.month = month;
            var data = typeof(self.info_installment[month]) != 'undefined' ? self.info_installment[month] : {};
            self.showDetailInstallment(data);
        });


        $(document).on('click', '#btn-pay-installment', function (event) {
            if(self.data.bank_code == ''){
                nh_functions.showAlertGritter('error', 'Bạn chưa chọn ngân hàng');
                return false;
            }

            if(self.data.card == ''){
                nh_functions.showAlertGritter('error', 'Bạn chưa chọn loại thẻ');
                return false;
            }

            if(self.data.month == ''){
                nh_functions.showAlertGritter('error', 'Bạn chưa chọn số tháng thanh toán');
                return false;
            }

            self.payInstallment();
        });
    },

    showCards:function(str_cards){
        $('#list-cards-installment li').addClass('hidden');
        var list_cards = str_cards.split(',');        
        if(!$.isEmptyObject(list_cards)){
            $('#list-cards-installment li').each(function( index ) {
                var card = $(this).data('card');
                if($.inArray(card, list_cards) > -1){
                    $(this).removeClass('hidden');
                }
            });
        }
    },

    loadInfoInstallment:function(){
        var self = this;
        nh_functions.showLoadingPage();
        $.ajax({
            async: true,
            url: '/orders/Orders/loadInfoInstallment',
            type: 'POST',
            dataType: 'json',
            data: {data: self.data},
            success: function (response) {
                if(!$.isEmptyObject(response)){       
                    self.info_installment = response;
                    self.showMonthInstallment(response);
                } 
                nh_functions.hiddenLoadingPage();
            },
            error: function (response, json, errorThrown) {

            }
        });
    },

    showMonthInstallment:function(response){
        var self = this;
        var html_month = '';
        var i = 0;
        $.each(response, function( index, value ) {
            var active = '';
            if(i == 0){
                active = 'active';
                self.data.month = index;
                self.showDetailInstallment(value);
            }
            var month = typeof(value.month) != 'undefined' ? value.month : '';
            if(month > 0){
                html_month += '<li data-month="'+ value.month +'" class="'+ active +'"><a>'+ value.month + ' ' +  self.label.month +'</a></li>';
            }

            i++;
        });

        $('#list-month-installment').removeClass('hidden');
        $('#list-month-installment .wrap-month').html(html_month);
    },

    showDetailInstallment:function(data){
        if(!$.isEmptyObject(data)){       
            var wrap = $('#info-installment');
            wrap.find('.month').text(data.month);
            wrap.find('.amout-by-month').text(nh_functions.formatMoney(data.amount_by_month));
            wrap.find('.amount-fee').text(nh_functions.formatMoney(data.amount_fee));
            wrap.find('.amount-final').text(nh_functions.formatMoney(data.amount_final));
        } 
    },

    payInstallment:function(){
        var self = this;
        nh_functions.showLoadingPage();
        $.ajax({
            async: true,
            url: '/orders/Orders/payInstallment',
            type: 'POST',
            dataType: 'json',
            data: {data: self.data},
            success: function (response) {
                nh_functions.hiddenLoadingPage();
                if(response.code == 1){
                    nh_functions.showAlertGritter('success', response.messages,1000);                                        
                }else{
                    nh_functions.showAlertGritter('error', response.messages,1000);    
                }

                if(response.router.length > 0){
                    setTimeout(function () {
                        window.location.href = response.router;
                    }, 1200);
                }
                
            },
            error: function (response, json, errorThrown) {

            }
        });
    }
}

var promotion_functions = {
    checkCouponCode: function (coupon_code,arr_product_id) {
        nh_functions.showLoadingPage();
        $.ajax({
            url: '/orders/Orders/checkCouponCode',
            type: 'POST',
            async: false,
            data: {
                coupon_code: coupon_code,
                arr_product_id: arr_product_id
            },
            dataType: 'json',
            success: function (response) {

                if (response.code == 'success') {
                    setTimeout(function () {
                        promotion_functions.reloadPage();
                    }, 500);

                } else {
                    nh_functions.hiddenLoadingPage();
                    nh_functions.showAlertGritter('error', response.messages);
                }
            },
            error: function (response, json, errorThrown) {
                nh_functions.hiddenLoadingPage();
            }
        });
    },
    deleteCouponCode: function () {
        nh_functions.showLoadingPage();
        $.ajax({
            url: '/orders/Orders/deleteCouponCode',
            type: 'POST',
            async: false,
            data: {},
            dataType: 'html',
            success: function (response) {
                setTimeout(function () {
                    promotion_functions.reloadPage();
                }, 500);
            },
            error: function (response, json, errorThrown) {
                nh_functions.hiddenLoadingPage();
            }
        });
    },
    reloadPage: function () {
        location.reload();
    },
    goBack: function () {
        window.history.back();
    }
}