<bidtimer>
  <div id="timer">{ seconds }</div>

  <script>
    var tag = this;
    this.seconds = 15;
    let timerID;

    observer.on('bid:start', () => {

      clearInterval(timerID);
      this.seconds = 15;

      timerID = setInterval(() => {
        this.seconds--;
        console.log(this.seconds);
        this.update();

        if (this.seconds == 0) {
          clearInterval(timerID);
          this.parent.round++;
          this.parent.currentBoard = 'winner';
          this.parent.update();
        }
      }, 1000);
    })
    changeBoard();

    console.log(this.parent.currentBoard);

    function changeBoard() {
      if (this.parent.currentBoard == 'winner') {
        setTimeout(() => {
          this.parent.currentBoard = 'round';
        }, 3000);
        this.parent.update();
  }
    }</script>
  <style>
    :scope {
      display: block;
    }
    #timer {
      font-size: 30px;
    }
  </style>
</bidtimer>
