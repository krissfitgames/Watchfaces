using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Timer as Timer;
using Toybox.Time.Gregorian as Calendar;

class SuperDuperDigitalView extends Ui.WatchFace {

	var customFont = null;
	var customSmallFont = null;
	
	// Creates a new instance of watchface. This is not necessarily needed but it's probably good to have it. 
	function initialize() {
        WatchFace.initialize();
    }

	// Resources are loaded here.
    function onLayout(dc) {
    	customFont = Ui.loadResource(Rez.Fonts.StationaryFont);
    	customSmallFont = Ui.loadResource(Rez.Fonts.smallStationaryFont);
    }

	// onUpdate is called to update the view. For watchfaces I think it's every second.
    function onUpdate(dc) {
    // this sets the colour of the foreground and the background. 
    // At this point it is the background of the watchface.
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
    	// clear will clear the screen using the background colour just specified.
    	dc.clear();
    	
    	// get the time of the system
        var clockTime = Sys.getClockTime();
        var hour = clockTime.hour;
        if (!Sys.getDeviceSettings().is24Hour) {
        	hour = hour % 12;
        	if (hour == 0) {
        		hour = 12;
        	}
        }
        
        // Info returns all the information needed to display a date from a gregorian calendar. But I probably don't need the day of the week.
        // SHORT will provide numbers instead of days for day of week and month
        var info = Calendar.info(Time.now(), Time.FORMAT_SHORT);
        // This formats the string to represent the date. in this case it's like a regular watch that only shows the day.
        var dateString = Lang.format("$1$", [info.day]);
        
        //sets the colour of the text and then the background of the display box
        // this draws the hour and the minute separately so they can both be displayed in different colours
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 22, customFont, hour.toString(), Gfx.TEXT_JUSTIFY_RIGHT);
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 22, customFont, Lang.format("$1$", [clockTime.min.format("%02d")]), Gfx.TEXT_JUSTIFY_LEFT);
        
        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 150, customSmallFont, Lang.format("$1$", [dateString]), Gfx.TEXT_JUSTIFY_LEFT);
    }

    function onShow() {
    }
    
    function onHide() {
    }

    function onExitSleep() {
    }


    function onEnterSleep() {
    }

}
