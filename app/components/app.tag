<app-tag>
  
  <slider-tag locals="{ locals }"></slider-tag>

  <!-- <div class="btn btn-warning add-button">+</div> -->

  <style scoped>
    :scope {
      background: url('./app/images/small_steps.png') repeat 0 0;
      position: absolute;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
    }
    .add-button {
      position: absolute;
      bottom: 50px;
      right: 50px;
      box-shadow: 0 3px 3px rgba(0,0,0,0.2);
      opacity: 1;
      transition: transform 200ms ease-in, opacity 200ms ease-in;
      transform: translate3d(0, 0, 0);
    }

  </style>
  
  <script>
    // setTimeout(function() {
    //   console.log('do an animation')
    // }, 500)
    this.locals = [
      {
        city: 'Canton'
        ,state: 'CT'
        ,country: 'US'
      }
      ,{
        city: 'London'
        ,state: ''
        ,country: 'UK'
      }
      ,{
        city: 'Las Vegas'
        ,state: 'NV'
        ,country: 'US'
      }
      ,{
        city: 'Wichita'
        ,state: 'KS'
        ,country: 'US'
      }
      ,{
        city: 'Concord'
        ,state: 'NE'
        ,country: 'US'
      }
      ,{
        city: 'Sioux Falls'
        ,state: 'SD'
        ,country: 'US'
      }
      ,{
        city: 'Havana'
        ,state: ''
        ,country: 'CUB'
      }
    ];
  </script>
</app-tag>