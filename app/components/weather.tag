<weather-tag>
  <div class="card { main } { isEditing ? 'is-editing' : '' }">
    <div class="location-container">
      <h1 class="location location-text">{ newLocal || 'Today' } <i class="glyphicon glyphicon-pencil edit-icon" onclick="{ toggleEdit }"></i></h1>
      <h1 class="location location-input">
        <input name="cityInput" class="city-input" type="text" value="{ newLocal }" onchange="{ cityUpdate }">
        <i class="glyphicon glyphicon-download save-icon" onclick="{ toggleEdit }"></i>
      </h1>
    </div>

    <div class="date">{ today }</div>
    <div class="temp { tempClass }">{ temp }</div>
    <div class="condition">{ main }</div>
    <div class="wind">Wind: { windDir } { windSpeed }mph</div>
  
    <forecast-tag local="{ newLocal }" />

  </div>

  <style>
    .card {
      background-color: #ddd;
      padding: 30px;
      text-align: center;
      font-weight: 100;
      color: hsla(360, 100%, 100%, 1);
    }
    .card.Clear {
      background: radial-gradient(hsla(171, 100%, 80%, 1) 0%, hsla(200, 100%, 50%, 1) 100%);
    }
    .card.Clouds {
      background: radial-gradient(hsla(179, 21%, 84%, 1) 0%, hsla(179, 0%, 64%, 1) 100%);
    }
    .card.Rain {
      background: radial-gradient(hsla(179, 21%, 84%, 1) 0%, hsla(220, 15%, 45%, 1) 100%);
    }
    .location-container {
      position: relative;
      height: 76px;
    }
    .location {
      font-size: 42px;
      font-weight: 100;
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
    }
    .location-text,
    .temp,
    .date,
    .condition,
    .wind,
    .card.forecast {
      transition: transform 300ms cubic-bezier(.17,.67,.22,1.21),
                  opacity 300ms cubic-bezier(.17,.67,.22,1.21);
      transform: translate3d(0, 0, 0);
      opacity: 1;
    }
    .location input {
      width: 100%;
      font-size: 28px;
      padding: 10px;
      border-radius: 3px;
    }
    .location-input {
      transition: transform 300ms cubic-bezier(.17,.67,.22,1.21),
                  opacity 300ms cubic-bezier(.17,.67,.22,1.21);
      transform: translate3d(0, -100%, 0);
      opacity: 0;
    }
    .is-editing .location-text,
    .is-editing .temp,
    .is-editing .date,
    .is-editing .condition,
    .is-editing .wind,
    .is-editing .card.forecast {
      transform: translate3d(0, 100%, 0);
      opacity: 0;
    }
    .is-editing .location-input{
      transform: translate3d(0, 0, 0);
      opacity: 1;
    }
    .is-editing input {
      border: 1px solid hsla(305, 100%, 50%, 1);
      box-shadow: 0 3px 3px rgba(0,0,0,0.2); 
    }
    .is-editing input:focus {
      outline: none;
    }
    .city-input {
      color: hsla(0, 20%, 20%, 1);
    }
    .edit-icon {
      color: rgba(0,0,0,0.3);
      font-size: 30px;
      float: right;
      line-height: 42px;
    }
    .save-icon {
      color: rgba(0,0,0,0.3);
      position: absolute;
      top: 8px;
      right: 9px;
      transform: rotate(-90deg);
    }
    .temp {
      height: 200px;
      width: 200px;
      border-radius: 50%;
      border: 4px solid hsla(360, 100%, 100%, 1);
      overflow: hidden;
      font-size: 72px;
      font-weight: 100;
      line-height: 190px;
      text-align: center;
      display: inline-block;
    }
    .temp.xhot {
      border-color: hsla(0, 100%, 50%, 1);
    }
    .temp.hot {
      border-color: hsla(30, 100%, 50%, 1);
    }
    .temp.perfect {
      border-color: hsla(52, 100%, 50%, 1);
    }
    .temp.cool {
      border-color: hsla(153, 100%, 50%, 1);
    }
    .temp.chilly {
      border-color: hsla(172, 100%, 50%, 1);
    }
    .temp.freezing {
      border-color: hsla(204, 100%, 50%, 1);
    }
    .temp.subzero {
      border-color: hsla(360, 100%, 100%, 1);
    }
    .condition {
      font-size: 42px;
      font-weight: 100;
    }
    .wind {
      font-size: 18px;
      font-weight: 200;
    }
  </style>


  <script>
    var view = this
    var now = new Date();
    var day = ('0' + now.getDate()).slice(-2);
    var month = ('0' + (now.getMonth() + 1)).slice(-2);
    view.today = (month) + '-' + (day) + '-' + now.getFullYear();
    view.isEditing = false;

    view.toggleEdit = function toggleEdit() {
      view.isEditing = !view.isEditing;
    }

    view.cityUpdate = function(e) {
      view.newLocal = view.cityInput.value
      getData(view.newLocal)
    }

    function getData(req) {
      view.newLocal = req || opts.local;
      reqEncoded = encodeURIComponent(req)
      callAjax(reqEncoded).done(model)
    }
    // helpers
    function callAjax(req) {
      return $.ajax({
        url: 'http://api.openweathermap.org/data/2.5/weather?q='+ req +'&APPID=7093bd32bfc85a9e2e6b3318b1e70b61'
        ,type: 'GET'
        ,dataType: 'json'
      })
    }

    // calculate the model
    function model(data) {
      console.debug('data: ', data);
      
      // current weather condition
      view.main = data.weather[0].main

      // temp
      view.temp = Math.round((data.main.temp - 273.15) * 1.8 + 32)
      // temp class
      if (view.temp < 0) view.tempClass = 'subzero'
      else if (view.temp > 0 && view.temp <= 32) view.tempClass = 'freezing'
      else if (view.temp > 32 && view.temp <= 50) view.tempClass = 'chilly'
      else if (view.temp > 50 && view.temp <= 70) view.tempClass = 'cool'
      else if (view.temp > 70 && view.temp <= 82) view.tempClass = 'perfect'
      else if (view.temp > 82 && view.temp <= 95) view.tempClass = 'hot'
      else if (view.temp > 95) view.tempClass = 'xhot'

      // wind speed
      view.windSpeed = Math.round(data.wind.speed * 2.23694)
      
      // determine the wind direction
      var deg = data.wind.deg
      if (deg <= 30) view.windDir = 'N'
      else if (deg > 30 && deg < 60) view.windDir = 'NE'
      else if (deg >= 60 && deg < 120) view.windDir = 'E'
      else if (deg >= 120 && deg < 150) view.windDir = 'SE'
      else if (deg >= 150 && deg < 210) view.windDir = 'S'
      else if (deg >= 210 && deg < 240) view.windDir = 'SW'
      else if (deg >= 240 && deg < 300) view.windDir = 'W'
      else if (deg >= 300 && deg < 330) view.windDir = 'NW'
      else if (deg >= 330 && deg < 360) view.windDir = 'N'
      
      // update the view
      //view.update(console.debug('update called')) // MUST run the update to get the view ("this") to render
    }

    // view.update(getData(opts.request)
    getData(opts.request)
    
  </script>
  
</weather-tag>