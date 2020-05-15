$(function() {
        console.log("Loading apartments");

        function loadApartments() {
                $.getJSON( "/api/apartments/", function( apartments ) {
                        console.log(apartments);
                        var message = apartments[0].postcode + " " + apartments[0].city;

                        $(".text-muted").text(message);
                });
        };
        loadApartments();
        setInterval( loadApartments, 2000 );
});

