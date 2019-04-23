<app>
	<navbar player={ player } room={ room }></navbar>

  <div class="container">
  	<div class="row">
  		<div class="col">
				<div if={ room }>
					<h1>Room: { room.id }</h1>
					<div each={ roomPlayer in roomPlayers }>
						<strong>{ roomPlayer.name }</strong>: { roomPlayer.id }
					</div>
					<!-- <p>
						...are in the room.
					</p> -->
				</div>
  		</div>
  	</div>
  </div>

  <script>
    // JAVASCRIPT
		let roomsRef = database.collection('player-rooms');

		this.room = null;
		this.roomPlayers = [];

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
				});
				return roomPlayersRef;

			}).then(roomPlayersRef => {
				stopListening = roomPlayersRef.onSnapshot(querySnapshot => {
					this.roomPlayers = [];
					querySnapshot.forEach(doc => {
						this.roomPlayers.push(doc.data());
					});

					// console.log(this.roomPlayers);

					this.update();
				});
			});
		});

  </script>

  <style>
    /* CSS */
    :scope {}
  </style>
</app>
