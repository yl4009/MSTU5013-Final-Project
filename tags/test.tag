<test>

  <script>
    var tag = this;

    let bidRoomsRef = database.collection('bid-rooms');
    let roomKey = database.collection('bid-rooms').doc().id;
    bidRoomsRef.doc(roomKey).get().then(doc => {

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

    });
  </script>
    <style>
      :scope {
        display: block;
      }
    </style>
</test>
