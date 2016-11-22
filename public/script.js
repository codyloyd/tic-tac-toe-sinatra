$(document).ready(function() {
  $(".square").click(function(){
    var value = $(this).attr("value")
    $(this).html('X')
    $.post('/', {position: value, mark: 'X'},
      function (result) {
        location.reload()
      })
  });
});
