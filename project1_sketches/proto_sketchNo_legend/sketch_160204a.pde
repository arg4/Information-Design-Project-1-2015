//Nathan Grimberg
//212208922
//02.03.2016
//Prototype Visualization

Table table;

void setup() {
  table = loadTable("data.csv", "header");
  size(1160,1000);
  background(255);
  noFill();
  stroke(255);
  int yesterDay = 15;
  int xInput = 0;
  int dayAdvance = 20;
  String lastWeekday = "Fri";
  
  graphSetup();
  graphText(lastWeekday);
  
  //could probably encapsulate this, who needs oop
  for (TableRow row : table.rows()) {
    String timeWeekday = row.getString("weekday");
    int timeHour = castToHours(row.getString("callTime"));
    int timeMinute = castToMinutes(row.getString("callTime"));
    int timeDuration = castToSeconds(row.getString("duration"));
    int timeDay = row.getInt("day");
  
    int currentDay = timeDay;
    
    if (timeWeekday.equals(lastWeekday)){
      dayAdvance += 0;
    } else {
      if (timeWeekday.equals("Mon")){
        stroke(255,0,0);
        dayAdvance += 40;
        line(dayAdvance,height-20,dayAdvance,20);
      } else {
        dayAdvance += 40;
      }
    }
    
    xInput += getX(currentDay,yesterDay);
    //String callFrom = row.getString("callFrom"); Charts callType(INCOMMING OUTGOING)
    //String callType = row.getString("callType"); Charts callType(MYO MYI ...)
    drawLines(xInput, timeDuration,timeHour,timeMinute);
    yesterDay = timeDay;
    lastWeekday = timeWeekday;
  }  
}

int getX(int currentDay, int yesterDay){
  if (currentDay == yesterDay){
    return 0;
  } else {
    return 40;
  }
}

//function for drawing shapes
void drawLines(int xInput, int callSeconds, int timeHour, int timeMinute){
  noStroke();
  fill(60,60,60);
  
  float timeMapped = map(timeHour*60 + timeMinute,0,60*24,0,960);
  float secondsMapped = map(callSeconds,0,60*24,0,960);
  rect(xInput + 20, height - timeMapped - 20 - secondsMapped,40,secondsMapped);
}


//functions for casting to variables
int castToHours(String timeString) {
  if (timeString.length() < 5){
      timeString = "0"+timeString;
    }
    int timeF = Integer.parseInt(timeString.substring(0,2));
    return timeF;
}

int castToMinutes(String timeString) {
  if (timeString.length() < 5){
      timeString = "0"+timeString;
    }
    int timeF = Integer.parseInt(timeString.substring(3));
    return timeF;
}

int castToSeconds(String timeString) {
  if (timeString.length() < 5){
      timeString = timeString.substring(0,1);
    } else {
      timeString = timeString.substring(0,2);
    }
    int timeF = Integer.parseInt(timeString);
    return timeF;
}


//graph setup functions
void graphSetup() {
  //axis setup
  stroke(#D3D3D3);
  int x = 20;
  for (int i = 0; i < 29; i++){
    strokeWeight(0.5);
    line(x,height-20,x,20);
    x += 40;
  }
}


void graphText(String lastWeekday) {
  
}