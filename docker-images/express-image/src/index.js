var Chance = require('chance');
var chance = new Chance();

var express = require('express');
var app = express();


app.get('/', function(req, res) {
	res.send( generateApartments() );
});


app.listen(3000, function () {
	console.log('Accepting HTTP requets  on port 3000!');
});

function generateApartments() {
	var numberOfApartments = chance.integer({
	min: 1,
	max: 10
	});
	console.log(numberOfApartments);
	var apartments = [];
	for(var i = 0; i < numberOfApartments; i++) {
        var postcode = chance.postcode();
		var city = chance.city();
		var price = chance.euro({
			min: 400,
			max: 9000
		});
        var nbRooms = chance.integer({
            min: 2,
            max: 7
        });
		apartments.push({
            postcode: postcode,
			city: city,
            rooms: nbRooms,
            price: price
		});
	};
	console.log(apartments);
	return apartments;
}

