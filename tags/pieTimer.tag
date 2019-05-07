<pieTimer>
  <!--  html part-->
  <svg width="250" height="250" viewbox="0 0 250 250">
    <path id="border" ref="myborder" transform="translate(125, 125)"/>
    <path id="loader" ref="myloader" transform="translate(125, 125) scale(.84)"/>
  </svg>

  <script>
    var tag = this;
    var α = 0
      , π = Math.PI
      , t = 41.67;
    var that=this;
    var isbid=false
    draw() {
      α++;
      α %= 360;
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
      // if (!isbid) {
      //   α = 0
      // }

      setTimeout(that.draw, t); // Redraw
    }

    setTimeout(this.draw,t)

  </script>
  <style>
  /* CSS part */
   svg {
     display: block;
     margin: 50px auto;
    }

    #loader
     { fill: #0088cc }

   #border
     { fill: #00517a }

  </style>

</pieTimer>
