// La fonction principale
function processData(event) {
	var file = event.target.files[0]; // On récupère le fichier

	// La variable config contient la configuration de la lecture du fichier
	config = {
		delimiter: ";", // Le délimiteur csv
		complete: function(results) { // La fonction a exécuter après le chargement du fichier
			var output = [];
			for(var i=0; i<results.data.length; i++) { // On parcourt chaque ligne du fichier csv
				var coord = getCoordinates(results.data[i][0]);
				 // On lance une requête pour récupérer les coordonnées
				if (coord) { // Si les coordonnées sont bien définies
				    // On écrit dans output le résultat (la ligne du fichier de départ + les coordonnées, le tout séparé par des ';')
				    output.push(results.data[i]+ ';' +coord.name+';'+coord.geometry.location.lat + ';' + coord.geometry.location.lng+';'+coord.types[0]+';'+coord.vicinity);
				}
				else{
					output.push(results.data[i]+ ';' +'NOT FOUND'+';'+'NOT FOUND'+ ';' + 'NOT FOUND');
				}
			}
			// A la fin de la lecture du fichier, on écrit tout ça sur la page web
			document.getElementById('output').innerHTML = output.join('<br>');
		}
	}

	// On charge le fichier avec Papaparse (c'est la bibliothèque qu'on a ajouté dans le 'head' de index.html)
	Papa.parse(file, config);

	function getCoordinates(address) {
	    //var SAMPLE_POST ='http://www.mapquestapi.com/geocoding/v1/address?key=YOUR_KEY_HERE&location='+address+'&callback=';
	    //https://maps.googleapis.com/maps/api/place/details/output?parameters
	    //placeid=ChIJN1t_tDeuEmsRUsoyG83frY4&key=
	    //http://cors.io/?u=
	    var SAMPLE_POST = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=48.856614,2.352222&radius=5000&name=' + address + '&key=YOUR_KEY_HERE';
	    //https://maps.googleapis.com/maps/api/place/details/json?placeid='Pont neuf Paris'&key=AIzaSyDHaN53GQ3QkHt9izaBfWN4zLa-nYZCmjw
	    //https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=48.856614,2.352222&radius=500&name=Pont neuf 75001 Paris&key=AIzaSyDHaN53GQ3QkHt9izaBfWN4zLa-nYZCmjw
		// autocomplete

		xmlhttp=new XMLHttpRequest();
	    //var URL = SAMPLE_POST.replace('YOUR_KEY_HERE', 'YAPd7JrbZC8eD1G6lo9TdhAMF1oH8VYG');//mapquest key
		var URL = SAMPLE_POST.replace('YOUR_KEY_HERE', 'AIzaSyDHaN53GQ3QkHt9izaBfWN4zLa-nYZCmjw');
		alert(URL);
		xmlhttp.open("GET",URL,false);
		xmlhttp.send();
		var xmlDoc = xmlhttp.responseText;
		//alert(xmlDoc);
		//alert(xmlDoc);
		//xmlDoc = xmlDoc.slice(1, -1);
		var j = JSON.parse(xmlDoc);
		//var j = xmlhttp.response.location;
		//alert(j.results[0])
		if(j.results[0]) {
			return j.results[0];
		}
		return undefined;
	}
}

// On dit que dès que 'file' change (càd qu'il y a un nouveau fichier), on exécute la fonction processData
document.getElementById('file').addEventListener('change', processData, false);