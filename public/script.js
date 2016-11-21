$(document).ready(function() {
  $(".square").click(function(){
    var value = $(this).attr("value")
    $.post('/', {position: value, mark: 'X'},
      function (result) {
        location.reload()
      })
  });
});
