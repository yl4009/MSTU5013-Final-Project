<navbar>
  <!-- HTML -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="#">Bidding Game</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>

	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	    </ul>
	    <div class="form-inline my-2 my-lg-0">
				<span if={ player } class="navbar-text mr-3"><img src={ player.photoURL }></span>
				<span if={ player } class="navbar-text mr-3">{ player.displayName }</span>
				<input if={ player && !room } class="form-control mr-sm-2" ref="roomCode" placeholder="Room Code" onkeypress={ enterRoomCode }>
				<button show={ room } class="btn btn-outline-warning my-2 my-sm-0 mr-sm-2" type="button" onclick={ exitRoom }>Exit Room</button>
	      <button show={ !player } class="btn btn-outline-success my-2 my-sm-0" type="button" onclick={ login }>Login</button>
				<button show={ player } class="btn btn-outline-danger my-2 my-sm-0" type="button" onclick={ logout }>Logout</button>
	    </div>
	  </div>
	</nav>

  <script>
		login() {
			var provider = new firebase.auth.GoogleAuthProvider();
			firebase.auth().signInWithPopup(provider);
		}
		logout() {
			firebase.auth().signOut();
		}
		exitRoom() {
			observer.trigger('exitRoom');
		}

		enterRoomCode(event) {
			if (event.keyCode === 13) {
				let roomCode = event.target.value;
				observer.trigger('codeEntered', roomCode);
			}
		}

		this.on('update', () => {
			this.player = opts.player;
			this.room = opts.room;
		});
  </script>

  <style>
    /* CSS */
    :scope {}
		img {
			width: 30px;
		}
  </style>
</navbar>
