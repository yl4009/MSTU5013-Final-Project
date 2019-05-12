<timer>
  <div id="timer">{ seconds }</div>
  <script>
    var tag = this;
    this.seconds = 5;


    observer.on('timer:start', () => {

      let timerID = setInterval( () => {
        this.seconds--;
        console.log(tag.seconds);
        this.update();
        if (this.seconds === 0) {
          clearInterval(timerID);
          observer.trigger('current:round');
          //if we want to use the timer for several times, it will need the following two lines
          this.seconds = 5;
          // // //setTimeout will run this.update() once after 3 seconds
          setTimeout(()=>{ this.update() }, 2000)
        }
      }, 1000);
    });
  </script>
  <style>
    :scope {
      display: block;
    }
    #timer {
      font-size: 100px;

    }
  </style>
</timer>
