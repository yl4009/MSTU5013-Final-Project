<pieTimer>
  <!--  html part-->
  <svg width="60" height="60" viewbox="0 0 360 360">
    <path id="border" ref="myborder" transform="translate(125, 125)"/>
    <path id="loader" ref="myloader" transform="translate(125, 125) scale(.84)"/>
  </svg>

  <script>
    var α = 0
      , π = Math.PI
      , t = 41.67;
    var that = this;
    let timeId;

    draw() {

      α++;
      // α %= 360;
      var r = ( α * π / 180 )
      , x = Math.sin( r ) * 125
      , y = Math.cos( r ) * - 125
      , mid = ( α > 180 ) ? 1 : 0
      , anim = 'M 0 0 v -125 A 125 125 1 '
           + mid + ' 1 '
           +  x  + ' '
           +  y  + ' z';
//[x,y].forEach(function( d ){
//  d = Math.round( d * 1e3 ) / 1e3;
//});
      that.refs.myloader.setAttribute( 'd', anim );
      that.refs.myborder.setAttribute( 'd', anim );

      if (α>=360) {
        that.parent.round=that.parent.round + 1;
        clearInterval(timeId);
        that.parent.recalculateScores();
        that.parent.currentBoard = 'winner';
        that.parent.update();
        if(that.parent.round<=3) {
          setTimeout(()=>{
            that.parent.currentBoard = 'round';
            that.parent.update();
          },5000)
        } else {
          setTimeout(()=>{
            that.parent.currentBoard = 'rank';
            that.parent.update();
          },5000)
        }
      }
    }

    observer.on('bid:start', () => {
      α = 0;
      clearInterval(timeId);
      timeId=setInterval(this.draw, t);
      this.parent.update();
    })

    timeId=setInterval(this.draw, t)
    console.log(timeId)
  </script>
  <style>
  /* CSS part */
   svg {
     display: block;
    }

    #loader
     { fill: #0088cc }

   #border
     { fill: #00517a }

  </style>

</pieTimer>
