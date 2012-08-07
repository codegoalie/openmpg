$(function() {
  $('.datejs').change(function() {
    var orig_val = $(this).val();
    var new_val = Date.parse(orig_val).toString('M/d/yyyy h:mm tt');
    if(new_val)
      $(this).val(new_val);
  });
});
