{$id_form = "frm-send-contact-{rand()}"}
<div id="addthis-modalContact" class="content-contact contact-block-custom modal fade {$arr_config.class_prefix}"  role="dialog">
     <div class="modal-dialog">
        <div class="modal-content">
            <div class="mart15 fll w100"></div>
            <div class="frm-bk-contact">
                <div class="frm-contact-top">
                    <button type="button" class="close close-popup" data-dismiss="modal">
                        <i class="fa fa-close"></i>
                    </button>
                    <div class="iphorm-group-title">Để lại lời nhắn cho chúng tôi</div>
                </div>
                <form id="frm-send-contact-detail" class="frm-required form-contact" method="POST"
                          action="{Router::url('/contact/contact-us/send-request', true)}">
                        <div class="form-group hidden">
                            <input class="form-control required" type="text" name="title"
                                   value="Đăng ký thông tin" />
                        </div>
                        <div class="form-group">
                            <input class="form-control required" type="text" name="full_name"
                                   placeholder="Họ tên (*)"/>
                        </div>
                        <div class="form-group">
                            <input class="form-control required" type="number" name="phone"
                                   placeholder="Số điện thoại (*)"/>
                        </div>
                        <div class="form-group">
                            <input class="form-control required" type="email" name="email"
                                   placeholder="Email (*)"/>
                        </div>
                        <div class="form-group">
                            <textarea id="content_textarea" name="content" class="form-control" 
                                      rows="3" placeholder="Ghi chú (không bắt buộc)"></textarea>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-submit btnSubmit-modal">
                                <span class="name">GỬI CHO CHÚNG TÔI</span> 
                            </button>
                        </div>
                    </form>
            </div>            
        </div>
    </div>
</div>

<script type="text/javascript">

    $.validator.addMethod(
        "regex",
        function (value, element, regexp) {
            var re = new RegExp(regexp);
            return this.optional(element) || re.test(value);
        },
        "regex Mở rộng"
    );

    $("#frm-send-contact-detail").validate({
        rules: {
            "full_name": {
                required: true,
            },
            "title": {
                required: true,
            },
            "email": {
                required: true,
                email: true
            },
        },
        messages: {
            full_name: {
                required: '{__d('default','required_full_name')}',
            },
            phone: {
                required: '{__d('default','required_phone')}',
            },
            title: {
                required: '{__d('default','required_title')}',
            },
            email: {
                required: '{__d('default','format_email')}',
                email: '{__d('default','format_email')}',
            }
        },
        showErrors: function (errorMap, errorList) {
            // Clean up any tooltips for valid elements
            $.each(this.validElements(), function (index, element) {
                nh_functions.showTooltipSuccess(element);
            });

            // Create new tooltips for invalid elements
            $.each(errorList, function (index, error) {
                nh_functions.showTooltipError(error.element, error.message);
            });
        },
        submitHandler: function (form) {
            nh_functions.showLoadingPage();
            $.ajax({
                url: form.action,
                type: form.method,
                async: false,
                contentType: false,
                processData: false,
                data: new FormData($(form).get(0)),
                dataType: 'json',
                success: function (response) {
                    setTimeout(function () {
                        if (response.code == 'success') {
                            // alert success
                            nh_functions.showAlertGritter('success', 'Gửi yêu cầu thành công !');
                            $('#frm-send-contact input').val('');
                            $('#content_textarea').val('');
                        } else {
                            nh_functions.showAlertGritter('error', response.messages);
                        }
                        nh_functions.hiddenLoadingPage();
                    }, 1000);

                },
                error: function (response, json, errorThrown) {
                    nh_functions.showAlertGritter('error', response.messages);
                }
            });
        }
    });
</script>


