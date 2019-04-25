<app>
	<navbar player={ player } room={ room }></navbar>

  <div class="container">
  	<div class="row">
  		<div class="col">

				<div if={ room }>
					<h1>Room: { room.id }</h1><button class="btn btn-secondary" type="button" onclick={ toggle }>TOGGLE</button>
					<div if={ currentBoard == 'round' }>
						<span class="badge badge-primary">ROUND: { round }</span>
						<span class="badge badge-sm badge-warning">Target of Bidding: <i class="fas fa-coins"></i> { bidValue } </span>
						<span class="badge badge-info"><bidTimer></bidTimer></span>
					</div>
					<div class="table">
						<div if={ currentBoard == 'start' && roomPlayers.length == 3 } class="clock">
							<timer></timer>
						</div>
						<div if={ currentBoard == 'round' }>
							<!-- here need to grab data from database to show the highest and second highest players-->
							<span></span>
							<span></span>
						</div>
						<div id="winnerBoard" if={ currentBoard == 'winner' }>
							<i class="fas fa-crown"></i>
							<div><img id="winnerImg" src={ player.photoURL }></div>
							<div>{ player.displayName }</div>
						</div>
						<div id="rankBoard" if={ currentBoard == 'rank' }>
							<p id="rank">Rank</p>
							<div each={ roomPlayer in roomPlayers}>
								<img id="rankImg" src={ roomPlayer.photo }>
								<span><strong>{ roomPlayer.name }</strong></span>
								<span class="badge badge-info">{ roomPlayer.balance }</span>
							</div>
						</div>
					</div>
					<div if={ currentBoard !== 'rank'} each={ roomPlayer in roomPlayers }>
						<strong>{ roomPlayer.name }</strong>:
						<input id="bidInput" class="mr-sm-2" type="number" min="0" max="50" ref="bidInput" placeholder="Write your bid here" show={ currentBoard == 'round' && roomPlayer.name == this.player.displayName }>
						<button class="btn btn-sm btn-success" type="button" onclick={ bid } show={ currentBoard == 'round' && roomPlayer.name == this.player.displayName }>BID</button>
						<span class="badge badge-info" show={ roomPlayer.name == this.player.displayName }>BALANCE</span>
					</div>
				</div>
  		</div>
  	</div>
  </div>

  <script>
    // JAVASCRIPT
		let roomsRef = database.collection('player-rooms');

		this.room = null;
		this.roomPlayers = [];
		this.currentBoard = 'start';
		this.countNum = "";
		this.round = 1;
		this.bidValue = "";

		firebase.auth().onAuthStateChanged(playerObj => {
			if (playerObj) {
				this.player = playerObj;
			} else {
				this.player = null;
				this.room = null;
			}
			this.update();
		});

		let stopListening;

		observer.on('exitRoom', () => {
			let roomPlayerRef = database.collection('player-rooms').doc(this.room.id).collection('players').doc(this.player.uid);
			roomPlayerRef.delete().then(() => {
				this.room = null;
				this.update();
			});
		});

		observer.on('codeEntered', roomCode => {
			roomsRef.doc(roomCode).get().then(doc => {
				if (!doc.exists) {

					let room = {
						author: this.player.displayName,
						authorID: this.player.uid,
						id: doc.id
					}

					doc.ref.set(room);
					this.room = room;

				} else {
					let room = doc.data();
					this.room = room;
				}
				this.update();

				return doc;

			}).then(doc => {
				let roomPlayersRef = doc.ref.collection('players');
				roomPlayersRef.doc(this.player.uid).set({
					id: this.player.uid,
					name: this.player.displayName,
					photo: this.player.photoURL,
					balance: 50
				});
				return roomPlayersRef;

			}).then(roomPlayersRef => {
				roomPlayersRef.onSnapshot(querySnapshot => {
					this.roomPlayers = [];
					querySnapshot.forEach(doc => {
						this.roomPlayers.push(doc.data());
						if (this.roomPlayers.length === 3) {
							observer.trigger('timer:start');
						}
 					});
					this.update();
				});
			})
		});

		// roomRef.onSnapshot(snapshot => {
		// 	snapshot.forEach(doc => {
		// 		console.log(doc);
		// 	});
		// 	// if () {
		// 	// 	observer.trigger('timer:start')
		// 	// }
		// });

		bid() {
			observer.trigger('bid:start');
		}

    //a funtion to toggle between start page and round page; only for coding process; delete it after finishing the whole project
		toggle() {
			if(this.currentBoard == 'start') {
				this.currentBoard = 'round';
			} else if(this.currentBoard == 'round') {
				this.currentBoard = 'winner';
			} else if(this.currentBoard == 'winner') {
				this.currentBoard = 'rank';
			} else if(this.currentBoard == 'rank') {
				this.currentBoard = 'start';
			}
		}

  </script>

  <style>
    /* CSS */
    :scope {}
		.table {
			width: 600px;
			height: 300px;
			background-color: #f8f9fa;
			text-align: center;
		}
		.clock {
			width: 200px;
			height: 200px;
			background-color: #fff;
			margin: auto;
		}
		#countNum {
			font-size: 100px;
		}
		#bidInput {
			width: 20%;
			border-radius: 30px;
		}
		#winnerBoard {
			padding-top: 50px;
			font-size: 50px;
		}
		#winnerImg {
			width: 60px;
		}
		#rankBoard {
			text-align: center;
			margin-top: 20px;
		}
		#rank {
			font-size: 45px;
			background-color: #4682b4;
		}
		#rankImg {
			width: 30px;
		}

  </style>
</app>
