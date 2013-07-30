$(document).ready(function() {
  $('#tweet_form').on("submit",function(event){
    event.preventDefault();
    $(this).hide();
    var data = $(this).serialize();
    var url = $(this).attr('action');
    $('.container').append($('<div id="load-div"><img id="loading" src="ajax-loader.gif"></div>'));
    $.ajax({
      url: url,
      type: 'POST',
      data: data,
      }).done(function(response) {
      $('#load-div').replaceWith(response);
      }).fail(function(response) {$('#load-div').replaceWith('<div id="error"><p>Error: Invalid Credentials</p></div>');
      });

  //   $.post(url, data, function(response) {
  //     $('#load-div').replaceWith(response);
  //   })
  })

  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
});
