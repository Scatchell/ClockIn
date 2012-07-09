// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function toggle_hidden(div_id, use_current_hidden_tag_id, checkbox_id) {
    if ($(checkbox_id).is(':checked')) {
        $(div_id).hide();
        $(use_current_hidden_tag_id).val("true");
    } else {
        $(div_id).show();
        $(use_current_hidden_tag_id).val("false");
    }

}

$(document).ready(
    function() {
        $('.delete_user').bind('ajax:success', function() {
            $(this).closest('tr').fadeOut();
        });

        $('.delete_clock_time').bind('ajax:success', function() {
            $(this).closest('div').fadeOut();
        });
    }
);
