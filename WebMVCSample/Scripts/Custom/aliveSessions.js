function timedCount() {
    var xhttp = new XMLHttpRequest();
    xhttp.open("POST", "/KeepAliveSessions", true);
    xhttp.send();
    setTimeout("timedCount()", 60000);
}

timedCount();