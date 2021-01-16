import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
  	console.log("We are live in Action Cable");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // $('.header').append('<strong> '+ data.body.sender_name + '</strong> says')
    // debugger
    $('#response').append('<div class="header">'+data.body.sender_dp+'  <strong>'+ data.body.sender_name +'  </strong> says  </div> <div class="list"> <div class="item">'+ data.body.body +'</div></div>')
    // $('#lastmsg').append('<div class="header"><strong>'+ data.body.sender_name +'  </strong> says  </div> <div class="list"> <div class="item">'+ data.body.body +'</div></div></div>')

    console.log(data)

	$(function(){
		var messages = $('#refreshMe');
		function init() {
			messages.scrollTop(messages[0].scrollHeight);
		}

		window.setTimeout(init, 30);
	});
  }


});

