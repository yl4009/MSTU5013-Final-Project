<bidTimer>
  <div id="timer">{ seconds }</div>
  <script>
    var tag = this;
    this.seconds = 15;
    let timerID;

    observer.on('bid:start', () => {

       clearInterval(timerID);
       this.seconds = 15;

       timerID = setInterval( () => {
        this.seconds--;
        console.log(this.seconds);
        this.update();
        // observer.on('bidButton:pressed', => {
        //   clearInterval(timerID);
        // });
        if (this.seconds == 0) {
          clearInterval(timerID);
          setTimeout(()=>{
            this.seconds = 15;
            this.update();
          }, 300)
        }
      }, 1000);
    });
  </script>
  <style>
    :scope {
      display: block;
    }
    #timer {
      font-size: 30px;
    }
  </style>
</bidTimer>
