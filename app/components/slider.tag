<slider-tag style="width:{ sliderTagWidth };">
  <div class="slide-wrapper" style="width:{ wrapperWidth };">
    <div class="slide" style="width:{ slideWidth }; float:left;" each="{ opts.locals }">
      <weather-tag local="{ city }, { state ? state : country }" request="http://api.openweathermap.org/data/2.5/weather?q={ city }, { state ? state : country }&APPID=7093bd32bfc85a9e2e6b3318b1e70b61" />
    </div>
  </div>
  <div class="dot-container">
    <div class="dot"></div>
  </div>

  <style scoped>
    :scope {
      overflow-x: scroll;
      position: absolute;
      box-shadow: 0 3px 3px rgba(0,0,0,0.2);
    }
    .slide-wrapper {
      /* width must be set dynamically */
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
    var w = window.innerWidth
    this.sliderTagWidth = w + 'px'
    this.wrapperWidth = (opts.locals.length * w) + 'px'
    this.slideWidth = w + 'px'
  </script>

</slider-tag>