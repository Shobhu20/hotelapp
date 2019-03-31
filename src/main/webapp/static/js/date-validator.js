function compareDate()
{
    var fromdate = document.getElementById("fromdate").value;
    var todate = document.getElementById("todate").value;
    var today = new Date();
    today.setHours(0,0,0,0);
    if (today > new Date(fromdate) || today > new Date(todate) ){

        alert("Cannot Book for a previous date");
        return false;
    }

    else if( (new Date(todate).getTime() <= new Date(fromdate).getTime()))
    {
        alert("To Date cannot be a date before From Date");
        return false;
    }
}