<?php
require 'simple_html_dom.php';

function getMealsForLocation($location, $mealIds) {
    $returnArray = array();
    
    // danforth, douglass, and eastman all have lunch and dinner
    if($location == "danforth" || $location == "douglass" || $location == "eastman") {
    	array_push($returnArray, $mealIds["lunch"]);
    	array_push($returnArray, $mealIds["dinner"]);
    }
    // only eastman has brunch
    if($location == "eastman") {
    	array_push($returnArray, $mealIds["brunch"]);
    }
    // only douglass has breakfast
    if($location == "douglass") {
    	array_push($returnArray, $mealIds["breakfast"]);
    }
    // only commons has allDay
    if($location == "commons") {
    	array_push($returnArray, $mealIds["allDay"]);
    }
    return $returnArray;
}

function makeTsv($targetUrl, $targetLocation, $targetMeal, $targetDate, $mealIds) {

	$dayArray = array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");

	//the following loads the website 
	$html = new simple_html_dom();
	$html->load_file($targetUrl);

	//stationCount variable helps us find the right food for the day later on
	$stationCount = 0;

	//Finds each station name
	foreach ($html->find(' table.ConceptTab td.ConceptTabText') as $station) {

		//this can be done inline, but for right now this is how it's set up
		// first make the string entirely lowercase. Then, capitalize the first letter in each word.	
		$stationName= ucwords(strtolower($station ->plaintext));
		
		// This is the only way I could work around the days of the week being images with no unique classifiers
		for ($i=0; $i <7 ; $i++) { 

			//daycount is used to move through sets that contain the food for each day
			$dayCount = $i + ($stationCount*7);
			$day = $dayArray[$i];
			
			//retrieves the text for each food item as found within menuTxt
			foreach ($html->find('td.menuBorder', $dayCount)->find('div.menuTxt') as $foodItem ) {
				$foodText = trim(ucwords(strtolower($foodItem->plaintext)));
				if ($targetLocation==="Danforth%20Fresh%20Food%20Company") {
					$targetLocation = "Danforth";
				}
				if ($targetLocation==="Douglass%20Dining%20Center") {
					$targetLocation = "Douglass";
				}
				if ($targetLocation==="Eastman%20Dining%20Center") {
					$targetLocation = "Eastman";
				}
				if ($targetLocation==="The%20Commons") {
					$targetLocation = "The Pit";
				}
				// week, location, mealId, station, day, food
				$tsvLine = "".str_replace("%20"," ",$targetLocation).",".str_replace(","," &amp; ",$foodText)."";
				printf($tsvLine."\n");
			 } 
		} // end foreach day
		//move on to the next station 
		$stationCount++;
	} // end foreach station
} // end makeTsv()

$mealIds = array(
	"breakfast" => 1,
	"lunch" => 16,
	"dinner" => 17,
	"brunch" => 639,
	"allDay" => 727,
);

$locationIds = array(
	"danforth" => "Danforth%20Fresh%20Food%20Company",
	"douglass" => "Douglass%20Dining%20Center",
	"eastman" => "Eastman%20Dining%20Center",
	"commons" => "The%20Commons",
);

$weekArray = array();

// build the week start date in month_day_year form, ex: "4_13_2014"
// if today is sunday
if( date('w') == 0) {
	// build the day as if today is sunday
	$week = mktime(0, 0, 0, date("m"), date("d"), date("Y"));
	array_push($weekArray, date("n",$week)."_".date("j",$week)."_".date("Y",$week));
	$week = mktime(0, 0, 0, date("m"), date("d")+7, date("Y"));
	array_push($weekArray, date("n",$week)."_".date("j",$week)."_".date("Y",$week));
	$week = mktime(0, 0, 0, date("m"), date("d")+14, date("Y"));
	array_push($weekArray, date("n",$week)."_".date("j",$week)."_".date("Y",$week));
} else {
	// build the day using "last sunday"s date
	$lastSundayMonth = date('n',strtotime('last sunday'));
	$lastSundayDay = date('d',strtotime('last sunday'));
	$lastSundayYear = date('Y',strtotime('last sunday'));

	$week = mktime(0, 0, 0, $lastSundayMonth, $lastSundayDay, $lastSundayYear);
	array_push($weekArray, date("n",$week)."_".date("j",$week)."_".date("Y",$week));
	$week = mktime(0, 0, 0, $lastSundayMonth, $lastSundayDay+7, $lastSundayYear);
	array_push($weekArray, date("n",$week)."_".date("j",$week)."_".date("Y",$week));
	$week = mktime(0, 0, 0, $lastSundayMonth, $lastSundayDay+14, $lastSundayYear);
	array_push($weekArray, date("n",$week)."_".date("j",$week)."_".date("Y",$week));
}

// headers for the tsv
header("Content-Disposition: attachment; filename=\"mealinfo.csv\"");
header("Content-Type: text/comma-delimited-values");

// add the header row to the tsv
//printf("week\tlocation\tmealId\tstation\tday\tfood\n");
printf("location,food");

$targetLocation = "";
$targetMeal = 0;
foreach($weekArray as $targetDate) {
	foreach($locationIds as $loc) {
		$mealArray = getMealsForLocation(array_search($loc, $locationIds), $mealIds);
		foreach($mealArray as $meal) {
			$targetLocation = $loc;
			$targetMeal = $meal;
			// build the url
			$targetUrl = 'http://www.campusdish.com/en-US/CSNE/Rochester/Menus/DanforthFreshFoodCompany.htm?LocationName='.$targetLocation.'&MealID='.$targetMeal.'&OrgID=195030&Date='.$targetDate.'&ShowPrice=False&ShowNutrition=True';
			makeTsv($targetUrl, $targetLocation, $targetMeal, $targetDate, $mealIds);
		} // end foreach meal
	} // end foreach location
} // end foreach week

?>
