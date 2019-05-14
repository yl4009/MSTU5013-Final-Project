<navbar>
	<!-- HTML -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="#">Bidding Game</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto"></ul>
			<div class="form-inline my-2 my-lg-0">
				<span if={ player } class="navbar-text mr-3"><img src={ player.photoURL } id="personImage"></span>
				<span if={ player } class="navbar-text mr-3">{ player.displayName }</span>
				<input if={ player && !room } class="form-control mr-sm-2" ref="roomCode" placeholder="Room Code" onkeypress={ enterRoomCode }>
				<button show={ room } class="btn btn-outline-warning my-2 my-sm-0 mr-sm-2" type="button" onclick={ exitRoom }>Exit Room</button>
				<button show={ !player } class="btn btn-outline-success my-2 my-sm-0" type="button" onclick={ login }>Login</button>
				<button show={ player } class="btn btn-outline-danger my-2 my-sm-0" type="button" onclick={ logout }>Logout</button>
			</div>
		</div>
	</nav>

	<div if={!room} class="container-fluid" id="rules">
		<!-- <img src="assets\pics\AutionBG.jpg" alt="Auction" width="1200" height="1000"> -->
		<div id="ruleContent">
			<h1>Welcome to our game!</h1>
			<p>1. Decide a room code for your group and enter the room.</p>
			<p>2. The game has 3 rounds, and for each round, you will auction off a random dollar bill ($10 -- $100)</p>
			<p>3. Each player will have $100 principle, but you can bid more than what you have in principle. Bids must be made in integer increment.</p>
			<p>4. If no new bidding is called in 15 second,  the bill goes to the auctioneer who bid the highest. However, remember the second-highest bidder also pay the last bid he/she made, but receive nothing in
				return. The remaining auctioneers gain nothing and lose nothing. Who has the most money in their balance after 3 rounds will win the game.</p>

		</div>
		<img src="./assets/pics/aution4.png" id="autionBG"></img>
	</div>
</body>

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
	#personImage {
		width: 30px;
	}

	h1 {
		text-align: center;
	}

	p {
		font-size: 18px;
	}

	#rules {
		background-color: #63a69f;
		font-family: 'Gugi', cursive;
		background-position: middle;
		margin: 0 auto;
	}

	#ruleContent {
		padding: 40px;

	}

	#autionBG {
		/* background-image:url("./assets/pics/aution4.png"); */
		background-color: #63a69f;
		/* Used if the image is unavailable  */
		height: 260px;
		width: 150px;
		display: block;
		margin-left: auto;
		margin-right: auto;
		width: 50%;
		background-repeat: no-repeat;
		background-size: cover;
	}
</style>
</navbar>
