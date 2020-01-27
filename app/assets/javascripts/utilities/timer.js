document.addEventListener('turbolinks:load', function() {
	var timerValue = document.getElementById("timer");
	var timer = timerValue.dataset.timer;
	var counter = 0;
	timerFormat(timer);
	var interval = setInterval(timeIt, 1000);

	function timeIt() {
		if(timer>counter){
			counter++;
			timerFormat(timer - counter);
		} else {
			clearInterval(interval);
			timerValue.style.color="red";
			timerValue.innerHTML = "time is up!";
		}
	}

	function timerFormat(value) {
		var min = Math.floor(value / 60);
		var sec = value % 60;
		if(min < 10) {
			min = "0" + min;
		}
		if(sec < 10) {
			sec = "0" + sec;
		}
		timerValue.innerHTML = min + ':' + sec;
	}
})
