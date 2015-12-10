<forecast-tag>
  <div class="card forecast">
    <h4>Forecast</h4>
    <div class="fday--container">
      <span class="fday" each="{ fdays }">{ day }</span>
    </div>
    <div class="ftemp--container">
      <span class="ftemp" each="{ ftemps }">{ Math.round( high ) }˚</span>
    </div>
  </div>
  
  <style scoped>
    :scope .card {
      background-color: hsla(360, 50%, 50%, 0.5);
      margin-top: 30px;
      padding: 30px;
      text-align: center;
      font-weight: 100;
      color: hsla(360, 100%, 100%, 1);
    }
    .ftemp--container,
    .fday--container {
      overflow: hidden;
      display: flex;
    }
    .fday,
    .ftemp {
      flex: 1 0 auto;
      display: inline-block;
      float: left;
      padding: 10px 20px;
      min-width: 77px;
    }
    .ftemp {
      border-top: 1px solid hsla(360, 100%, 100%, 0.2);
      font-size: 30px;
    }
    .fday {
    }
  </style>

  <script>
    var view = this
    var now = new Date();
    var day = ('0' + now.getDate()).slice(-2);
    var month = ('0' + (now.getMonth() + 1)).slice(-2);
    view.today = (month) + '-' + (day) + '-' + now.getFullYear();
    
    function getData(req) {
      // callAjax().done(model)
      reqEncoded = encodeURIComponent(req)
      callAjax(reqEncoded).done(model)
      console.debug('http://api.openweathermap.org/data/2.5/forecast?q='+ req +'&APPID=7093bd32bfc85a9e2e6b3318b1e70b61&units=imperial');
    }

    function callAjax(req) {
      return $.ajax({
        url: 'http://api.openweathermap.org/data/2.5/forecast?q='+ req +'&APPID=7093bd32bfc85a9e2e6b3318b1e70b61&units=imperial'
        ,type: 'GET'
        ,dataType: 'json'
      })
    }

    // calculate the model
    function model(data) {
      console.debug('forecast data: ', data);
      view.days = data.list
      view.ftemps = data.list.map(function(item) {
        //console.debug('item: ', item);
        var temp = {}
        if (item.dt_txt.match('12:00:00')) {
          temp.high = item.main.temp
        }
        return temp
      }).filter(function(item) {
        return item.high;
      });
      view.fdays = data.list.map(function(item) {
        return item.dt_txt.slice(0, -9)
      }).filter(function(item, index, inputArray) {
        return inputArray.indexOf(item) === index;
      }).map(function(item) {
        return {day: item.slice(-2)}
      })
      
      console.debug('view.ftemps: ', view.ftemps);
      // view.fdays = [{day:parseInt(day)},{day:parseInt(day)+1},{day:parseInt(day)+2},{day:parseInt(day)+3},{day:parseInt(day)+4}]
      console.debug('view.fdays: ', view.fdays);
      // update the view
      riot.update(view) // MUST run the update to get the view ("this") to render
    }


    getData(opts.local)
  </script>
</forecast-tag>