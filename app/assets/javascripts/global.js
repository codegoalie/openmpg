$(function() {
  // set current time zone
  Date.prototype.stdTimezoneOffset = function() {
    var jan = new Date(this.getFullYear(), 0, 1);
    var jul = new Date(this.getFullYear(), 6, 1);
    return Math.max(jan.getTimezoneOffset(), jul.getTimezoneOffset());
  }

  $(document).ready(function() {
    if(!($.cookie('timezone'))) {
        $.cookie('timezone', (new Date()).stdTimezoneOffset());
      }
  });

  $('.datejs').change(function() {
    $("span#date_error").remove();
    var orig_val = $(this).val();
    var new_val = Date.parse(orig_val).toString('M/d/yy h:mm tt');
    if(new_val)
      $(this).val(new_val);
    else
      $(this).addClass('error').after("<span id='date_error' class='error'>Invalid date format. Please try again.</span>")
  });

  $(".acts-like-link").live('click', function() {
    var path = $(this).data('href');
    if(path != "") {
      window.location = path;
    }
  });
});
