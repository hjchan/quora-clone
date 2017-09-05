function verify(e){
  e.preventDefault();
  $p = $(this).next()
  $.ajax({
    url: $(this).attr('action'),
    method: $(this).attr('method'),
    data: $(this).serialize(),
    dataType: 'json',
    success: function(data){
      console.log(data);
      if (data.success){
        $p.html('');
        window.location.href = data.url;
      }else{
        $p.html(data.msg);
      }
    }
  });
}

function upvote(e){
  e.preventDefault();
  var id = e.target.getAttribute('data-qid')
  var pressed = (e.target.getAttribute("aria-pressed") === "true");
  e.target.setAttribute("aria-pressed", !pressed);
  var parent = $(e.target).parents(".card.col")
  parent.toggleClass("border-primary")
  if (parent.next().find('#vote-img').attr('aria-pressed')){
    parent.next().removeClass("border-primary")
    parent.next().find('#vote-img').attr('aria-pressed',false)
  }
  $.ajax({
    dataType: 'json',
    url: '/questions/' + id + '/upvote/' + !pressed,
    method: 'POST',
    success: function(data) {
      console.log(data)
      $('#upvote-count-' + id).html(data.upvote_count)
      $('#downvote-count-' + id).html(data.downvote_count)
    },
    error: function(data) {
      console.log(data)
    }
  });
}

function downvote(e){
  e.preventDefault();
  var id = e.target.getAttribute('data-qid')
  var pressed = (e.target.getAttribute("aria-pressed") === "true");
  e.target.setAttribute("aria-pressed", !pressed);
  var parent = $(e.target).parents(".card.col")
  parent.toggleClass("border-primary")
  if (parent.prev().find('#vote-img').attr('aria-pressed')){
    parent.prev().removeClass("border-primary")
    parent.prev().find('#vote-img').attr('aria-pressed',false)
  }
  $.ajax({
    dataType: 'json',
    url: '/questions/' + id + '/downvote/' + !pressed,
    method: 'POST',
    success: function(data) {
      console.log(data)
      $('#upvote-count-' + id).html(data.upvote_count)
      $('#downvote-count-' + id).html(data.downvote_count)
    },
    error: function(data) {
      console.log(data)
    }
  });
}

function ansUpvote(e){
  e.preventDefault();
  var id = e.target.getAttribute('data-qid')
  var pressed = (e.target.getAttribute("aria-pressed") === "true");
  e.target.setAttribute("aria-pressed", !pressed);
  var parent = $(e.target).parents(".card.col")
  parent.toggleClass("border-primary")
  if (parent.next().find('#vote-img').attr('aria-pressed')){
    parent.next().removeClass("border-primary")
    parent.next().find('#vote-img').attr('aria-pressed',false)
  }
  $.ajax({
    dataType: 'json',
    url: '/answers/' + id + '/upvote/' + !pressed,
    method: 'POST',
    success: function(data) {
      console.log(data)
      $('#a-upvote-count-' + id).html(data.upvote_count)
      $('#a-downvote-count-' + id).html(data.downvote_count)
    },
    error: function(data) {
      console.log(data)
    }
  });
}

function ansDownvote(e){
  e.preventDefault();
  var id = e.target.getAttribute('data-qid')
  var pressed = (e.target.getAttribute("aria-pressed") === "true");
  e.target.setAttribute("aria-pressed", !pressed);
  var parent = $(e.target).parents(".card.col")
  parent.toggleClass("border-primary")
  if (parent.prev().find('#vote-img').attr('aria-pressed')){
    parent.prev().removeClass("border-primary")
    parent.prev().find('#vote-img').attr('aria-pressed',false)
  }
  $.ajax({
    dataType: 'json',
    url: '/answers/' + id + '/downvote/' + !pressed,
    method: 'POST',
    success: function(data) {
      console.log(data)
      $('#a-upvote-count-' + id).html(data.upvote_count)
      $('#a-downvote-count-' + id).html(data.downvote_count)
    },
    error: function(data) {
      console.log(data)
    }
  });
}

function expand(e){
  e.preventDefault()
  target = $(e.target)
  target.parent().html(target.data('detail'))
}

function switchSignUp(){
  $('#loginModal').modal('hide')
  $('#signupModal').modal('show')
}

function switchSignIn(){
  $('#signupModal').modal('hide')
  $('#loginModal').modal('show')
}

$(document).ready(function(){
  console.log("jQuery Ready");
  $('#modal-sign-in-form').on("submit", verify);
  $('#modal-sign-up-form').on("submit", verify);
  $('#switch-sign-up').click(switchSignUp);
  $('#switch-sign-in').click(switchSignIn);
  $('#sign-in-form').on("submit", verify);
  $('#sign-up-form').on("submit", verify);
  $('.upvote').click(upvote);
  $('.downvote').click(downvote);
  $('.a-upvote').click(ansUpvote);
  $('.a-downvote').click(ansDownvote);
  $('.question-more').click(expand);
})

// new Socket
// socket.connect() => channel
// channel.on('new_messgae', function(msg) {
//   $('#msg-container').append(msg)
// }
