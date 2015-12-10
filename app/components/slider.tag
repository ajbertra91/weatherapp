<slider-tag style="width:{ sliderTagWidth };">
  <div class="slide-wrapper" style="width:{ wrapperWidth };">
    <div class="slide" style="width:{ slideWidth }; float:left;" each="{ opts.locals }">
      <weather-tag local="{ city } { state ? state : country }" request="lat={ lat }&lon={ lon }" />
    </div>
  </div>
  <!-- <div class="dot-container">
    <div class="dot"></div>
  </div> -->

  <style scoped>
    :scope {
      overflow-x: scroll;
      position: absolute;
      box-shadow: 0 3px 3px rgba(0,0,0,0.2);
      -webkit-overflow-scrolling: touch;
    }
    .slide-wrapper {
      /* width must be set dynamically */
      white-space: nowrap;
      scroll-snap-points-x: repeat(100%);
      scroll-snap-type: mandatory;
    }
    .slide {}
    .dot-container {
      outline: 1px solid red;
      position: absolute;
      bottom: 15px;
      width: 50%;
      left: 25%;
    }
    .dot {
      background-color: rgba(255,255,255,0.2);
      height: 10px;
      width: 10px;
    }
    .dot.current {
      background-color: rgba(255,255,255,0.9);
    }
  </style>

  <script>
    console.debug('opts.locals: ', opts.locals);
    var w = window.innerWidth
    this.sliderTagWidth = w + 'px'
    this.wrapperWidth = (opts.locals.length * w) + 'px'
    this.slideWidth = w + 'px'


  </script>

</slider-tag>