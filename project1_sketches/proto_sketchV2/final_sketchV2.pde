//Nathan Grimberg
//212208922
//02.03.2016
//Prototype Visualization

Table table;

void setup() {
  table = loadTable("data.csv", "header");
  size(1200,1020);
  background(255);
  stroke(255);
  int yesterDay = 15;
  int xInput = 0;
  int dayAdvance = 60;
  String lastWeekday = "Fri";
  
  
  
  // New for loop grabs the ammount of calls in a day and adds colored boxes behind the text
  tableShading(table);
  
  // For loop draws boxes and grabs info from table, will need to make a second for loop to draw boxes behind the table
  for (TableRow row : table.rows()) {
    String timeWeekday = row.getString("weekday");
    String callType = row.getString("callType");
    int timeHour = castToHours(row.getString("callTime"));
    int timeMinute = castToMinutes(row.getString("callTime"));
    int timeDuration = castToSeconds(row.getString("duration"));
    int timeDay = row.getInt("day");
    int currentDay = timeDay;
    
    if (timeWeekday.equals(lastWeekday)){
      dayAdvance += 0;
    } else {
      if (timeWeekday.equals("Mon")){
        strokeWeight(1);
        stroke(0,0,0);
        dayAdvance += 40;
        graphText(timeWeekday,dayAdvance);        
        line(dayAdvance,height-20,dayAdvance,20);
      } else {
        dayAdvance += 40;
        graphText(timeWeekday,dayAdvance);
      }
    }
    
    xInput += getX(currentDay,yesterDay);
    drawLines(xInput, timeDuration,timeHour,timeMinute,callType);
    yesterDay = timeDay;
    lastWeekday = timeWeekday;
  }
  graphSetup();
  graphText("Fri",60);
  text("Fri Feb 15 - Thu Mar 14",width/2,15);
} // end setup loop


/*void draw() {
  line(0,mouseY,width,mouseY);
}*/

// loop picks color for each column on table
void tableShading(Table table){
  int currentDay = 15;
  int dayCount = 0;
  int initialX = 60;
  noStroke();
  for (TableRow row : table.rows()){
    int timeDay = row.getInt("day");
    if (currentDay != timeDay){
      println();
      println(dayCount);
      fill(255 - (5 * dayCount),255 - (5 * dayCount),255 - (5 * dayCount)); //change color here
      rect(initialX,20,40,height-60);
      initialX += 40;
      dayCount = 1;
    } else {
      dayCount++;
    }
    print(dayCount);
    currentDay = timeDay;
  }
}// ends table shading loop


//moves forward based on current day and last day 
int getX(int currentDay, int yesterDay){
  if (currentDay == yesterDay){
    return 0;
  } else {
    return 40;
  }
}

//function for drawing shapes
void drawLines(int xInput, int callSeconds, int timeHour, int timeMinute, String callType){
  noStroke();
  fill(60,60,60);
  
  if (callType.equals("MYO")||callType.equals("OUT")) {
    fill(160,0,0);
  } else {
    fill(0,0,160);
  }
  
  float timeMapped = map(timeHour*60 + timeMinute,0,60*24,0,960);
  float secondsMapped = map(callSeconds,0,60*24,0,960);
  rect(xInput + 60, timeMapped + 40 - secondsMapped,40,-secondsMapped);
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
  //stroke(#D3D3D3);
  stroke(255);
  int x = 60;
  for (int i = 0; i < 29; i++){
    strokeWeight(0.5);
    line(x,height-40,x,20);    
    x += 40;
  }
  fill(60);
  for (int i = 0; i < 24; i++){
    text(i + ":00",20,((960/24)*(i + 1))+ 5);
  }
}

// creates labes for weekdays
void graphText(String currentWeekday, int dayAdvance) {
  fill(60);
  text(currentWeekday.substring(0,2),dayAdvance + 3, 1000); 
}