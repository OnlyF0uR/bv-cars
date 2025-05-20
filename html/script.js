function CloseShop() {
  $("#wrapper").html('');
  $("#shopmenu").hide();
  $.post('https://fu_cars/CloseMenu');
}

$(document).keyup(function (e) {
  if (e.key === "Escape" || e.key === "Backspace") {
      CloseShop()
  }
});

$(document).ready(function () {
  var page = 1;
  var mpage = 0;
  var categories = []
  var cars = []
  var result

  function LoadCarsPage() {
      let index = 0
      let count = 1
      var html = ``
      page = 1
      mpage = 0

      $('#price_min').attr('value', result[0].price)
      $('#price_max').attr('value', result[result.length - 1].price)
      $("#shopmenu").show();
      $("#wrapper").html(' ');

      mpage = Math.ceil(result.length / 6)

      for (let n_page = 0; n_page < Math.ceil(result.length / 6); n_page++) {
          count = 0;
          html += `
              <div id="page-`+ (n_page + 1) + `">
              <div class="row row-cols-1 row-cols-md-3">`
          while (index < result.length && count < 6) {

              var car = result[index];

              html += `<div class="col-4 mb-4">
                              <div class="card h-100">
                                  <img src="`+ car.imglink + `" class="card-img-top" alt="` + car.name + `">
                                  <div class="card-body">
                                      <h5 class="card-title">`+ car.name + `</h5>
                                      <p class="card-text">Klasse: <b>`+ categories[car.category] + `</b></p>
                                      <p class="card-text">Prijs: <b>`+ car.price + `€</b></p>
                                  </div>
                                  <div class="card-footer bg-white border-0 ">
                                      <button type="button" id="action1" data-value="buy" data-model="`+ car.model + `" class="btn btn-danger w-auto btn-lg buy">Kopen</button>
                                      <button type="button" id="action2" data-value="test-drive" data-model="`+ car.model + `" class="btn btn-success w-auto float-right btn-lg test-drive">Testrit</button>
                                  </div>
                              </div>
                          </div>`
              index++;
              count++;
          }

          html += `</div> </div>`

          $("#wrapper").append(html)
          html = ``
          if (n_page + 1 != page) {
              $("#page-" + (n_page + 1)).hide();
          }
      }
      
      $('#n-pag').html(page + '/' + mpage)
  }

  $("#body").on('click', ':button', function () {
      if ($(this).data('value') == null)
          return;
      $("#shopmenu").hide();
      $("#wrapper").html('');

      if ($(this).data('value') == "buy")
          $.post('https://fu_cars/BuyVehicle', JSON.stringify({ model: $(this).data('model') }));
      else if ($(this).data('value') == "test-drive")
          $.post('https://fu_cars/TestDrive', JSON.stringify({ model: $(this).data('model') }));
  });

  $('#search').click(function () {
      var min = $('#price_min').val()
      var max = $('#price_max').val()
      
      result = cars.filter(a => a.price >= min && a.price <= max)
      LoadCarsPage()
  })

  $("#page-prv").click(function () {

      $("#page-" + page).hide();
      if (page > 1) {
          page--;
      }
      $("#page-" + page).show();
      $('#n-pag').html(page + '/' + mpage)

  });

  $('#brand').on('change', function () {
      var brand = this.value
      if (brand != -1)
          result = cars.filter(c => c.category == brand)
      else
          result = cars
      LoadCarsPage()
  })

  // Next page stuff
  $("#page-nxt").click(function () {
      $("#page-" + page).hide();
      if (page < mpage) {
          page++;
      }
      $("#page-" + page).show();
      $('#n-pag').html(page + '/' + mpage)
  });

  // ====================================================
  window.addEventListener('message', function (event) {
      // Set some variables
      categories = event.data.categories
      cars = event.data.cars
      result = cars

      // Sort by price
      result.sort(function (a, b) {
          return a.price - b.price
      });

      // Category stuff
      $('#brand').html(`<option selected value="-1">Alle categorieën</option>`)
      for (let key in categories) {
          $('#brand').append(`<option value="${key}">${categories[key]}</option>`)
      }

      // Load the actual page
      LoadCarsPage()
  })

  // Close the shop
  $("#close").click(function () {
      CloseShop()
  })

})