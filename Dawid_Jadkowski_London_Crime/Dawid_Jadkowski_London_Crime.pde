import org.gicentre.geomap.*;
GeoMap geoMap;
Table crime_table;
Table house_prices;
int tempCount;
Table tempT  = new Table();
PImage bg;
PImage bg2;
color c1 = color(140, 236, 251);
color c2 = color(95, 207, 225);
color c3 = color(82, 183, 200);
color c4 = color(62, 143, 157);
color c5 = color(54, 122, 134);
color c6 = color(40, 88, 97);
color c7 = color(20, 45, 51);
color c8 = color(12, 23, 26);
boolean called = false;
boolean did = false;
int whatpressed = 1;
PFont font;
String theYear = "2013";
String theMonth = "11";
int yearPressedPosition = 1;
int monthPressedPosition = 11;
boolean playMode = false;
int time;
int wait = 2000;
int pageNumber;

ImageButtons button;
ImageButtons button2;
ImageButtons button3;
ImageButtons button4;
ImageButtons button5;
ImageButtons button6;
ImageButtons button7;
ImageButtons button8;
ImageButtons button9;

ImageButtons yr1;
ImageButtons yr2;
ImageButtons yr3;
ImageButtons m1;
ImageButtons m2;
ImageButtons m3;
ImageButtons m4;
ImageButtons m5;
ImageButtons m6;
ImageButtons m7;
ImageButtons m8;
ImageButtons m9;
ImageButtons m10;
ImageButtons m11;
ImageButtons m12;

ImageButtons btn_play;
ImageButtons btn_stop;
ImageButtons btn_map;
ImageButtons btn_graph;
ImageButtons btn_date1;
ImageButtons btn_date2;
ImageButtons btn_date3;
ImageButtons btn_date4;

void loadCrimeData() {
  crime_table = loadTable("ward.csv", "header");
}

void loadHousePrices() {
  house_prices = loadTable("average-house-prices-borough.csv", "header");
}

String getAverageHousePrice(String date, String borough){
   String money = "";
  for (TableRow row : house_prices.rows()) {
    if ( row.getString("Area").equals(borough)) {
      money= row.getString(date);
    }
  }
  return money;
}

int getNumberOfAllCrimesButThis(int date, String borough) {
  int crimesCounter = 0;
  for (TableRow row : crime_table.rows()) {
    if (row.getInt("Month") == date && row.getString("LANAME").equals(borough)) {
      crimesCounter += row.getInt("Count");
    }
  }
  return crimesCounter;
}

/*@date = has to be in format yyyyMM
 *@crimeType = has to be on of the cimes avaliabe in datasheet
 *@borough = has to be one of the boroughs avaliable in datasheet
 */
int getNumOfCrimesOverall(int date, String crimeType, String borough) {
  int crimesCounter = 0;
  tempT.clearRows();
  tempT.addColumn("Month");
  tempT.addColumn("MajorText");
  tempT.addColumn("LANAME");
  tempT.addColumn("Count");

  for (TableRow row : crime_table.rows()) {
    if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeType)
      && row.getString("LANAME").equals(borough)) {
      crimesCounter += row.getInt("Count");
      TableRow newRow = tempT.addRow();
      newRow.setInt("Month", row.getInt("Month"));
      newRow.setString("MajorText", row.getString("MajorText"));
      newRow.setString("LANAME", row.getString("LANAME"));
      newRow.setInt("Count", row.getInt("Count"));
    }
  }
  return crimesCounter;
}

int getNumOfCrimesSpecific(int date, String crimeType, String borough) {
  int crimesCounter = 0;
  for (TableRow row : tempT.rows()) {
    if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeType)
      && row.getString("LANAME").equals(borough)) {
      crimesCounter += row.getInt("Count");
    }
  }
  return crimesCounter;
}

void drawPopup(int date, int x, int y, String name, int total, String crimeName) {
  fill(240, 200);  
  rect(x, y, 260, 193);  
  fill(180, 200);
  rect(x, y, 260, 30);
  fill(0);
  font = loadFont("SegoeUI-16.vlw");
  textFont(font);
  text(name, x + 3, y+25);
  font = loadFont("SegoeUI-12.vlw");
  textFont(font);
  text("Total of " + crimeName + " crimes: " + total, x + 3, y+50);

  if (whatpressed == 1) {
    int counter1 = 0;
    int counter2 = 0;  
    for (TableRow row : crime_table.rows()) {
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Burglary In A Dwelling")) {
        counter1 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Burglary In Other Buildings")) {
        counter2 += row.getInt("Count");
      }
    }

    text("Burglary In A Dwelling: " + counter1, x + 3, y+70);
    text("Burglary In Other Buildings: " + counter2, x + 3, y+85);
    text("Average house price: " + getAverageHousePrice(String.valueOf(date).substring(0,4),name), x + 3, y+100);
  } else if (whatpressed == 2) {
    int counter1 = 0;
    int counter2 = 0;  
    int counter3 = 0;  
    int counter4 = 0;  
    for (TableRow row : crime_table.rows()) {
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Criminal Damage To Dwelling")) {
        counter1 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Criminal Damage To Motor Vehicle")) {
        counter2 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Criminal Damage To Other Building")) {
        counter3 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Other Criminal Damage")) {
        counter4 += row.getInt("Count");
      }
    }

    text("Criminal Damage To Dwelling: " + counter1, x + 3, y+70);
    text("Criminal Damage To Motor Vehicle: " + counter2, x + 3, y+85);
    text("Criminal Damage To Other Building: " + counter3, x + 3, y+100);
    text("Other Criminal Damage: " + counter4, x + 3, y+115);
    text("Average house price: " + getAverageHousePrice(String.valueOf(date).substring(0,4),name), x + 3, y+130);
  } else if (whatpressed == 3) {
    int counter1 = 0;
    int counter2 = 0;  
    int counter3 = 0;  
    for (TableRow row : crime_table.rows()) {
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Drug Trafficking")) {
        counter1 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Other Drugs")) {
        counter2 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Possession Of Drugs")) {
        counter3 += row.getInt("Count");
      }
    }

    text("Drug Trafficking: " + counter1, x + 3, y+70);
    text("Other Drugs: " + counter2, x + 3, y+85);
    text("Possession Of Drugs: " + counter3, x + 3, y+100);
    text("Average house price: " + getAverageHousePrice(String.valueOf(date).substring(0,4),name), x + 3, y+115);
  } else if (whatpressed == 4) {
    int counter1 = 0;
    for (TableRow row : crime_table.rows()) {
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Other Fraud & Forgery")) {
        counter1 += row.getInt("Count");
      }
    }

    text("Other Fraud & Forgery: " + counter1, x + 3, y+70);
    text("Average house price: " + getAverageHousePrice(String.valueOf(date).substring(0,4),name), x + 3, y+85);
  } else if (whatpressed == 5) {
    int counter1 = 0;
    int counter2 = 0;  
    for (TableRow row : crime_table.rows()) {
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Going Equipped")) {
        counter1 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Other Notifiable")) {
        counter2 += row.getInt("Count");
      }
    }

    text("Going Equipped: " + counter1, x + 3, y+70);
    text("Other Notifiable: " + counter2, x + 3, y+85);
    text("Average house price: " + getAverageHousePrice(String.valueOf(date).substring(0,4),name), x + 3, y+100);
  } else if (whatpressed == 6) {
    int counter1 = 0;
    int counter2 = 0;  
    for (TableRow row : crime_table.rows()) {
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Business Property")) {
        counter1 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Personal Property")) {
        counter2 += row.getInt("Count");
      }
    }

    text("Business Property: " + counter1, x + 3, y+70);
    text("Personal Property: " + counter2, x + 3, y+85);
    text("Average house price: " + getAverageHousePrice(String.valueOf(date).substring(0,4),name), x + 3, y+100);
  } else if (whatpressed == 7) {
    int counter1 = 0;
    int counter2 = 0;  
    for (TableRow row : crime_table.rows()) {
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Other Sexual")) {
        counter1 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Rape")) {
        counter2 += row.getInt("Count");
      }
    }

    text("Other Sexual: " + counter1, x + 3, y+70);
    text("Rape: " + counter2, x + 3, y+85);
    text("Average house price: " + getAverageHousePrice(String.valueOf(date).substring(0,4),name), x + 3, y+100);
  } else if (whatpressed == 8) {

    int counter1 = 0;
    int counter2 = 0;  
    int counter3 = 0;  
    int counter4 = 0;  
    int counter5 = 0;  
    int counter6 = 0;  
    int counter7 = 0;  
    int counter8 = 0;  
    for (TableRow row : crime_table.rows()) {
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Handling Stolen Goods")) {
        counter1 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Motor Vehicle Interference & Tampering")) {
        counter2 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Other Theft")) {
        counter3 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Other Theft Person")) {
        counter4 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Theft From Motor Vehicle")) {
        counter5 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Theft From Shops")) {
        counter6 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Theft/Taking Of Motor Vehicle")) {
        counter7 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Theft/Taking Of Pedal Cycle")) {
        counter8 += row.getInt("Count");
      }
    }

    text("Handling Stolen Goods: " + counter1, x + 3, y+70);
    text("Motor Vehicle Interference & Tampering: " + counter2, x + 3, y+85);
    text("Other Theft: " + counter3, x + 3, y+100);
    text("Other Theft Person: " + counter4, x + 3, y+115);
    text("Theft From Motor Vehicle: " + counter5, x + 3, y+130);
    text("Theft From Shops: " + counter6, x + 3, y+145);
    text("Theft/Taking Of Motor Vehicle: " + counter7, x + 3, y+160);
    text("Theft/Taking Of Pedal Cycle: " + counter8, x + 3, y+175);
    text("Average house price: " + getAverageHousePrice(String.valueOf(date).substring(0,4),name), x + 3, y+190);
  } else if (whatpressed == 9) {
    int counter1 = 0;
    int counter2 = 0;  
    int counter3 = 0;  
    int counter4 = 0;  
    int counter5 = 0;  
    int counter6 = 0;  
    int counter7 = 0;  
    for (TableRow row : crime_table.rows()) {
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Assault With Injury")) {
        counter1 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Common Assault")) {
        counter2 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Harassment")) {
        counter3 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Murder")) {
        counter4 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Offensive Weapon")) {
        counter5 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Other Violence")) {
        counter6 += row.getInt("Count");
      }
      if (row.getInt("Month") == date && row.getString("MajorText").equals(crimeName)
        && row.getString("LANAME").equals(name) && row.getString("MinorText").equals("Wounding/GBH")) {
        counter7 += row.getInt("Count");
      }
    }

    text("Assault With Injury: " + counter1, x + 3, y+70);
    text("Common Assault: " + counter2, x + 3, y+85);
    text("Harassment: " + counter3, x + 3, y+100);
    text("Murder: " + counter4, x + 3, y+115);
    text("Offensive Weapon: " + counter5, x + 3, y+130);
    text("Other Violence: " + counter6, x + 3, y+145);
    text("Wounding/GBH: " + counter7, x + 3, y+160);
    text("Average house price: " + getAverageHousePrice(String.valueOf(date).substring(0,4),name), x + 3, y+175);
  }
}

void showScale() {
  PImage img;
  img = loadImage("scale.png");
  image(img, width -150, (height/2)-300);
}

void showPoint(int x, int y) {
  PImage img;
  img = loadImage("point.png");
  image(img, x+35, 375+y);
}

void showDateYearPoint(int x, int y) {
  PImage img;
  img = loadImage("point.png");
  image(img, x+563, 562+y);
}

void showDateMonthPoint(int x, int y) {
  PImage img;
  img = loadImage("point2.png");
  image(img, x+563, 645+y);
}

void setMapColourOverall(int date, String crimeType, GeoMap map) {
  int count;
  int highest = -1;
  String highestName = "";
  int lowest = -1;
  String lowestName = "";
  for (int i= 1; i <= map.getAttributes().getRowCount(); i++) {   
    String name = geoMap.getAttributes().getString(i, 2);
    count = getNumOfCrimesOverall(date, crimeType, name);
    if ( count <= 0) {
      fill(c1);  

      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count >= 1 && count <= 50) {
      fill(c2);  
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 50 && count <= 100) {
      fill(c3);    
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 100 && count <= 250) {
      fill(c4);
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 250 && count <= 400) {
      fill(c5);
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 400 && count <= 550) {
      fill(c6);
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 550 && count <= 750) {
      fill(c7);
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 750) {
      fill(c8);
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else {
      fill(c1);   
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    }

    if (lowest == -1) {
      lowest = count;
      lowestName = geoMap.getAttributes().getString(i, 2);
    } else if (lowest > count) {
      lowest = count;
      lowestName = geoMap.getAttributes().getString(i, 2);
    }

    if (highest == -1) {
      highest = count;
      highestName = geoMap.getAttributes().getString(i, 2);
    } else if (highest < count) {
      highest = count;
      highestName = geoMap.getAttributes().getString(i, 2);
    }
  }
  //avoid showing if there's no data
  if (highest != 0) {
    fill(50);
    font = loadFont("SegoeUI-16.vlw");
    textFont(font);
    text(highestName, 773, 435);
    text("Crimes: " + highest, 773, 450);
    text(lowestName, 773, 375);
    text("Crimes: " + lowest, 773, 390);
  } else {
    fill(50);
    font = loadFont("SegoeUI-16.vlw");
    textFont(font);
    text("N/A", 773, 435);
    text("N/A", 773, 375);
  }
}

void setMapColourSpecific(int date, String crimeType, GeoMap map) {
  int count;

  for (int i= 1; i <= map.getAttributes().getRowCount(); i++) {   
    String name = geoMap.getAttributes().getString(i, 2);
    count = getNumOfCrimesSpecific(date, crimeType, name);
    if ( count <= 0) {
      fill(c1);  
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count >= 1 && count <= 50) {
      fill(c2);  
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 50 && count <= 100) {
      fill(c3);    
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 100 && count <= 250) {
      fill(c4);
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 250 && count <= 400) {
      fill(c5);
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 400 && count <= 550) {
      fill(c6);
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 550 && count <= 750) {
      fill(c7);
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else if ( count > 750) {
      fill(c8);
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    } else {
      fill(c1);   
      geoMap.draw(geoMap.getAttributes().getInt(i, 0));
    }
  }
}

void drawMainTitle() {
  fill(50);
  font = loadFont("SegoeUI-Bold-28.vlw");
  textFont(font);
  text(theYear + "/" + theMonth, 70, 50);
  text("Crimes of London", 10, 80);
}

void drawCrimeTypeTitle() {
  fill(50);
  font = loadFont("SegoeUI-28.vlw");
  textFont(font);
  text("Crime Type", 50, 525);
}

void drawDatePickerTitle() {
  fill(50);
  font = loadFont("SegoeUI-28.vlw");
  textFont(font);
  text("Date Picker", 547, 555);
}

void drawLowHighCrimeTitle() {
  fill(50);
  font = loadFont("SegoeUI-Bold-16.vlw");
  textFont(font);
  text("Lowest Crime:", 773, 355);
  text("Highest Crime:", 773, 415);
}

void drawDescription() {
  fill(50);
  font = loadFont("SegoeUI-14.vlw");
  textFont(font);
  text("Explore the crime\nstatistics of different\nboroughs of London\nbased on the data from\n2013/11 - 2015/10\n\nPlease select the crime type\nto get its view on\nmap of London.\n\nHover the mouse over\nthe map to get the\nactual numbers of crime.\n\nUse the provided date\npicker to change the data\nbased on date.\n\nUse the navigation buttons\nto see other representations\nof data.", 30, 450);
}

void createCrimeButtons() {
  // Define and create image buttons
  PImage b = loadImage("data/btn_1_1.png");
  PImage r = loadImage("data/btn_1_2.png");
  int y = (height+100)/2 - b.height/2; 
  int w = b.width;
  int h = b.height;
  button = new ImageButtons(50, y+170, w, h, b, r);

  PImage b2 = loadImage("data/btn_2_1.png");
  PImage r2 = loadImage("data/btn_2_2.png");
  button2 = new ImageButtons(50+160, y+170, w, h, b2, r2);

  PImage b3 = loadImage("data/btn_3_1.png");
  PImage r3 = loadImage("data/btn_3_2.png");
  button3 = new ImageButtons(50+320, y+170, w, h, b3, r3);

  PImage b4 = loadImage("data/btn_4_1.png");
  PImage r4 = loadImage("data/btn_4_2.png");
  button4 = new ImageButtons(50, y+215, w, h, b4, r4);

  PImage b5 = loadImage("data/btn_5_1.png");
  PImage r5 = loadImage("data/btn_5_2.png");
  button5 = new ImageButtons(50+160, y+215, w, h, b5, r5);

  PImage b6 = loadImage("data/btn_6_1.png");
  PImage r6 = loadImage("data/btn_6_2.png");
  button6 = new ImageButtons(50+320, y+215, w, h, b6, r6);

  PImage b7 = loadImage("data/btn_7_1.png");
  PImage r7 = loadImage("data/btn_7_2.png");
  button7 = new ImageButtons(50, y+260, w, h, b7, r7);

  PImage b8 = loadImage("data/btn_8_1.png");
  PImage r8 = loadImage("data/btn_8_2.png");
  button8 = new ImageButtons(50+160, y+260, w, h, b8, r8);

  PImage b9 = loadImage("data/btn_9_1.png");
  PImage r9 = loadImage("data/btn_9_2.png");
  button9 = new ImageButtons(50+320, y+260, w, h, b9, r9);
}

void createDatePickerButtons() {
  //create sldider buttons
  PImage bb = loadImage("data/scroll_images/btn_s__01.gif");
  PImage rr = loadImage("data/scroll_images/btn_s2__01.gif");
  int xx = 550;
  int yy = 570; 
  int ww = bb.width;
  int hh = bb.height;
  yr1 = new ImageButtons(xx, yy, ww, hh, bb, rr);

  PImage bb2 = loadImage("data/scroll_images/btn_s__02.gif");
  PImage rr2 = loadImage("data/scroll_images/btn_s2__02.gif");
  yr2 = new ImageButtons(xx+37, yy, ww, hh, bb2, rr2);

  PImage bb3 = loadImage("data/scroll_images/btn_s__03.gif");
  PImage rr3 = loadImage("data/scroll_images/btn_s2__03.gif");
  yr3 = new ImageButtons(xx+73, yy, ww, hh, bb3, rr3);

  PImage bb4 = loadImage("data/scroll_images/btn_s__14.gif");
  PImage rr4 = loadImage("data/scroll_images/btn_s2__14.gif");
  m1 = new ImageButtons(xx, yy+37, ww, hh, bb4, rr4);

  PImage bb5 = loadImage("data/scroll_images/btn_s__15.gif");
  PImage rr5 = loadImage("data/scroll_images/btn_s2__15.gif");
  m2 = new ImageButtons(xx+37, yy+37, ww, hh, bb5, rr5);

  PImage bb6 = loadImage("data/scroll_images/btn_s__16.gif");
  PImage rr6 = loadImage("data/scroll_images/btn_s2__16.gif");
  m3 = new ImageButtons(xx+73, yy+37, ww, hh, bb6, rr6);

  PImage bb7 = loadImage("data/scroll_images/btn_s__05.gif");
  PImage rr7 = loadImage("data/scroll_images/btn_s2__05.gif");
  m4 = new ImageButtons(xx+109, yy+36, ww, hh, bb7, rr7);

  PImage bb8 = loadImage("data/scroll_images/btn_s__06.gif");
  PImage rr8 = loadImage("data/scroll_images/btn_s2__06.gif");
  m5 = new ImageButtons(xx+142, yy+36, ww, hh, bb8, rr8);

  PImage bb9 = loadImage("data/scroll_images/btn_s__07.gif");
  PImage rr9 = loadImage("data/scroll_images/btn_s2__07.gif");
  m6 = new ImageButtons(xx+179, yy+36, ww, hh, bb9, rr9);

  PImage bb10 = loadImage("data/scroll_images/btn_s__08.gif");
  PImage rr10 = loadImage("data/scroll_images/btn_s2__08.gif");
  m7 = new ImageButtons(xx+214, yy+36, ww, hh, bb10, rr10);

  PImage bb11 = loadImage("data/scroll_images/btn_s__09.gif");
  PImage rr11 = loadImage("data/scroll_images/btn_s2__09.gif");
  m8 = new ImageButtons(xx+250, yy+36, ww, hh, bb11, rr11);

  PImage bb12 = loadImage("data/scroll_images/btn_s__10.gif");
  PImage rr12 = loadImage("data/scroll_images/btn_s2__10.gif");
  m9 = new ImageButtons(xx+287, yy+36, ww, hh, bb12, rr12);

  PImage bb13 = loadImage("data/scroll_images/btn_s__11.gif");
  PImage rr13 = loadImage("data/scroll_images/btn_s2__11.gif");
  m10 = new ImageButtons(xx+323, yy+36, ww, hh, bb13, rr13);

  PImage bb14 = loadImage("data/scroll_images/btn_s__12.gif");
  PImage rr14 = loadImage("data/scroll_images/btn_s2__12.gif");
  m11 = new ImageButtons(xx+359, yy+36, ww, hh, bb14, rr14);

  PImage bb15 = loadImage("data/scroll_images/btn_s__13.png");
  PImage rr15 = loadImage("data/scroll_images/btn_s2__13.png");
  m12 = new ImageButtons(xx+395, yy+36, ww, hh, bb15, rr15);

  PImage btnplay1 = loadImage("data/btn_play.png");
  PImage btnplay2 = loadImage("data/btn_play2.png");
  btn_play = new ImageButtons(xx+394, yy, ww, hh, btnplay1, btnplay2);

  PImage btnpstop1 = loadImage("data/btn_stop.png");
  PImage btnpstop2 = loadImage("data/btn_stop2.png");
  btn_stop = new ImageButtons(xx+394, yy, ww, hh, btnpstop1, btnpstop2);

  PImage btnmap1 = loadImage("data/btn_map1.png");
  PImage btnmap2 = loadImage("data/btn_map2.png");
  int ww2 = btnmap1.width;
  int hh2 = btnmap1.height;
  btn_map = new ImageButtons(xx+184, yy-570, ww2, hh2, btnmap1, btnmap2);

  PImage btngrp1 = loadImage("data/btn_graph1.png");
  PImage btngrp2 = loadImage("data/btn_graph2.png");
  btn_graph = new ImageButtons(xx+328, yy-570, ww2, hh2, btngrp1, btngrp2);
}
void updateDateBtns() {
  btn_date1.display();
  btn_date1.update();
  btn_date2.display();
  btn_date2.update();
}
void updateDateBtns2() {
  btn_date3.display();
  btn_date3.update();
  btn_date4.display();
  btn_date4.update();
}

void drawDateBtns() {
  PImage btndate1 = loadImage("data/btn_date1_1.png");
  PImage btndate11 = loadImage("data/btn_date_1_2.png");

  int ww2 = btndate1.width;
  int hh2 = btndate1.height;
  btn_date1 = new ImageButtons(57, 69, ww2, hh2, btndate1, btndate11);

  PImage btndate2 = loadImage("data/btn_date2_1.png");
  PImage btndate22 = loadImage("data/btn_date2_2.png");
  btn_date2 = new ImageButtons(356, 69, ww2, hh2, btndate2, btndate22);
}

void drawDateBtns2() {
  PImage btndate1 = loadImage("data/btn_grph2_1_1.png");
  PImage btndate11 = loadImage("data/btn_grph2_1_2.png");

  int ww2 = btndate1.width;
  int hh2 = btndate1.height;
  btn_date3 = new ImageButtons(587, 362, ww2, hh2, btndate1, btndate11);

  PImage btndate2 = loadImage("data/btn_grph2_2_1.png");
  PImage btndate22 = loadImage("data/btn_grph2_2_2.png");
  btn_date4 = new ImageButtons(886, 362, ww2, hh2, btndate2, btndate22);
}


void setup()
{
  size(1024, 680);
  bg = loadImage("bg.png");
  bg2 = loadImage("bg2.png");
  geoMap = new GeoMap(250, 10, 600, 500, this);    
  geoMap.readFile("londonBoroughs");

  // Set up text appearance.
  textAlign(LEFT, BOTTOM);
  textSize(18);
  pageNumber = 1;
  background(bg);
  loadCrimeData();
  loadHousePrices();
  setMapColourOverall(Integer.parseInt(theYear + theMonth), "Burglary", geoMap);
  createCrimeButtons();
  showScale();
  showPoint(80, 160);
  showDateYearPoint(0, 0);
  showDateMonthPoint(359, 0);
  drawMainTitle();
  drawCrimeTypeTitle();
  drawDatePickerTitle();
  drawLowHighCrimeTitle();
  drawDescription();
  createDatePickerButtons();
  drawDateBtns();
  drawDateBtns2();
}

void updatePlayButton() {
  if (!playMode) {  
    btn_play.display(); 
    btn_play.update();
  } else {
    btn_stop.display();
    btn_stop.update();
  }
}

void updateScrollButtons() {
  yr1.display(); 
  yr1.update();   
  yr2.display();
  yr2.update();
  yr3.display();
  yr3.update();
  m1.display();
  m1.update();
  m2.display();
  m2.update();
  m3.display();
  m3.update();
  m4.display();
  m4.update();
  m5.display();
  m5.update();
  m6.display();
  m6.update();
  m7.display();
  m7.update();
  m8.display();
  m8.update();
  m9.display();
  m9.update();
  m10.display();
  m10.update();
  m11.display();
  m11.update();
  m12.display();  
  m12.update();
}

void updateNavBtn() {

  //update also nav buttons
  btn_map.display();
  btn_map.update();
  btn_graph.display();
  btn_graph.update();
}
void updateCrimeButtons() {
  button.update();
  button.display();
  button2.update();   
  button2.display();
  button3.update();
  button3.display();
  button4.update();
  button4.display();
  button5.update();
  button5.display();
  button6.update();
  button6.display();
  button7.update();
  button7.display();
  button8.update();
  button8.display();
  button9.update();
  button9.display();
}

void mouseClicked() {

  if (btn_play.pressed && playMode == false) {    
    playMode = true;  
    time = millis();//also update the stored time
  } else  if (btn_stop.pressed && playMode == true) {
    playMode = false;           
    time = millis();//also update the stored time
  }

  if (btn_map.pressed)
  {
    drawnFirstGraph =1; 
    pageNumber = 1;
    did = false;
    called = true;
    found = false;
    isFinished = false;
    graphTwoDrawn = false;
  } else if (btn_graph.pressed)
  {
    drawnFirstGraph = 0;
    pageNumber = 2;
    graphTwoDrawn= false;

    PFont font = createFont("SegoeUI-10", 10);
    textInput = new TextInput(this, font, 10);
    isFinished = false;
    if (found) barChart.draw(579, 137, 400, 180);
  }

  if (btn_date1.pressed)
  {
    theYear2a = "201311";
    theYear2b = "201411";
    drawnFirstGraph = 0;
    isFinished = false;
    graphTwoDrawn= false;
  } else  if (btn_date2.pressed)
  {
    theYear2a = "201410";
    theYear2b = "201510";
    drawnFirstGraph = 0;
    isFinished = false;
    graphTwoDrawn= false;
  }

  if (btn_date3.pressed)
  {
    theYear3a = "2013";
    theYear3b = "2014";    
    graphTwoDrawn= false;
  } else  if (btn_date4.pressed)
  {
    theYear3a = "2014";
    theYear3b = "2015";   
    graphTwoDrawn= false;
  }
}

void datesAutoPlay() {
  if (playMode) {

    //check the difference between now and the previously stored time is greater than the wait interval
    if (millis() - time >= wait) {       
      if (theMonth.equals("12")) {

        if (theYear.equals("2013")) {
          theYear = "2014";
          showDateYearPoint(37, 0);
          yearPressedPosition = 2;          
          did = false;
          called= true;
        } else if (theYear.equals("2014")) {
          theYear = "2015";
          showDateYearPoint(72, 0);
          yearPressedPosition = 3;
          did = false;
          called= true;
        } else {
          theYear = "2013";
          showDateYearPoint(0, 0);
          yearPressedPosition = 1;
          did = false;
          called= true;
        }
        theMonth = "01";
        showDateMonthPoint(0, 0);
        monthPressedPosition = 1;
        did = false;
        called= true;
      } else if (theMonth.equals("01")) {
        theMonth = "02";
        showDateMonthPoint(37, 0);
        monthPressedPosition = 2;
        did = false;
        called= true;
      } else if (theMonth.equals("02")) {
        theMonth = "03";
        showDateMonthPoint(72, 0);
        monthPressedPosition = 3;
        did = false;
        called= true;
      } else if (theMonth.equals("03")) {
        theMonth = "04";
        showDateMonthPoint(108, 0);
        monthPressedPosition = 4;
        did = false;
        called= true;
      } else if (theMonth.equals("04")) {
        theMonth = "05";
        showDateMonthPoint(143, 0);
        monthPressedPosition = 5;
        did = false;
        called= true;
      } else if (theMonth.equals("05")) {
        theMonth = "06";
        showDateMonthPoint(179, 0);
        monthPressedPosition = 6;
        did = false;
        called= true;
      } else if (theMonth.equals("06")) {
        theMonth = "07";
        showDateMonthPoint(215, 0);
        monthPressedPosition = 7;
        did = false;
        called= true;
      } else if (theMonth.equals("07")) {
        theMonth = "08";
        showDateMonthPoint(251, 0);
        monthPressedPosition = 8;
        did = false;
        called= true;
      } else if (theMonth.equals("08")) {
        theMonth = "09";
        showDateMonthPoint(287, 0);
        monthPressedPosition = 9;
        did = false;
        called= true;
      } else if (theMonth.equals("09")) {
        theMonth = "10";
        showDateMonthPoint(323, 0);
        monthPressedPosition = 10;
        did = false;
        called= true;
      } else if (theMonth.equals("10")) {
        theMonth = "11";
        showDateMonthPoint(359, 0);
        monthPressedPosition = 11;
        did = false;
        called= true;
      } else if (theMonth.equals("11")) {
        theMonth = "12";
        showDateMonthPoint(396, 0);  
        monthPressedPosition = 12;
        did = false;
        called= true;
      }

      time = millis();//also update the stored time
    }
  }
}

void chkWhichCrimeBtnPresses() {
  if (button.pressed) {
    whatpressed = 1;
    did = false;
    called= true;
  } else if (button2.pressed) {
    whatpressed = 2;
    did = false;
    called= true;
  } else if (button3.pressed) {
    whatpressed = 3;
    did = false;
    called= true;
  } else if (button4.pressed) {
    whatpressed = 4;
    did = false;
    called= true;
  } else if (button5.pressed) {
    whatpressed = 5;
    did = false;
    called= true;
  } else if (button6.pressed) {
    whatpressed = 6;
    did = false;
    called= true;
  } else if (button7.pressed) {
    whatpressed = 7;
    did = false;
    called= true;
  } else if (button8.pressed) {
    whatpressed = 8;
    did = false;
    called= true;
  } else if (button9.pressed) {
    whatpressed = 9;
    did = false;
    called= true;
  }
}

void chkWhichDateBtnPressed() {
  if (yr1.pressed) {
    theYear = "2013";
    showDateYearPoint(0, 0);
    yearPressedPosition = 1;
    did = false;
    called= true;
  } else if (yr2.pressed) {
    theYear = "2014";
    showDateYearPoint(37, 0);
    yearPressedPosition = 2;
    did = false;
    called= true;
  } else if (yr3.pressed) {
    theYear = "2015";
    showDateYearPoint(72, 0);
    yearPressedPosition = 3;
    did = false;
    called= true;
  } else if (m1.pressed) {
    theMonth = "01";
    showDateMonthPoint(0, 0);
    monthPressedPosition = 1;
    did = false;
    called= true;
  } else if (m2.pressed) {
    theMonth = "02";
    showDateMonthPoint(37, 0);
    monthPressedPosition = 2;
    did = false;
    called= true;
  } else if (m3.pressed) {
    theMonth = "03";
    showDateMonthPoint(72, 0);
    monthPressedPosition = 3;
    did = false;
    called= true;
  } else if (m4.pressed) {
    theMonth = "04";
    showDateMonthPoint(108, 0);
    monthPressedPosition = 4;
    did = false;
    called= true;
  } else if (m5.pressed) {
    theMonth = "05";
    showDateMonthPoint(143, 0);
    monthPressedPosition = 5;
    did = false;
    called= true;
  } else if (m6.pressed) {
    theMonth = "06";
    showDateMonthPoint(179, 0);
    monthPressedPosition = 6;
    did = false;
    called= true;
  } else if (m7.pressed) {
    theMonth = "07";
    showDateMonthPoint(215, 0);
    monthPressedPosition = 7;
    did = false;
    called= true;
  } else if (m8.pressed) {
    theMonth = "08";
    showDateMonthPoint(251, 0);
    monthPressedPosition = 8;
    did = false;
    called= true;
  } else if (m9.pressed) {
    theMonth = "09";
    showDateMonthPoint(287, 0);
    monthPressedPosition = 9;
    did = false;
    called= true;
  } else if (m10.pressed) {
    theMonth = "10";
    showDateMonthPoint(323, 0);
    monthPressedPosition = 10;
    did = false;
    called= true;
  } else if (m11.pressed) {
    theMonth = "11";
    showDateMonthPoint(359, 0);
    monthPressedPosition = 11;
    did = false;
    called= true;
  } else if (m12.pressed) {
    theMonth = "12";
    showDateMonthPoint(396, 0);  
    monthPressedPosition = 12;
    did = false;
    called= true;
  }
}

void changeDatePointerLoc() {
  if (yearPressedPosition == 1) {
    showDateYearPoint(0, 0);
  } else if (yearPressedPosition == 2) {
    showDateYearPoint(37, 0);
  } else if (yearPressedPosition == 3) {
    showDateYearPoint(72, 0);
  } 

  if (monthPressedPosition == 1) {
    showDateMonthPoint(0, 0);
  } else if (monthPressedPosition == 2) {
    showDateMonthPoint(37, 0);
  } else if (monthPressedPosition == 3) {
    showDateMonthPoint(72, 0);
  } else if (monthPressedPosition == 4) {
    showDateMonthPoint(108, 0);
  } else if (monthPressedPosition == 5) {
    showDateMonthPoint(143, 0);
  } else if (monthPressedPosition == 6) {
    showDateMonthPoint(179, 0);
  } else if (monthPressedPosition == 7) {
    showDateMonthPoint(215, 0);
  } else if (monthPressedPosition == 8) {
    showDateMonthPoint(251, 0);
  } else if (monthPressedPosition == 9) {
    showDateMonthPoint(287, 0);
  } else if (monthPressedPosition == 10) {
    showDateMonthPoint(323, 0);
  } else if (monthPressedPosition == 11) {
    showDateMonthPoint(359, 0);
  } else if (monthPressedPosition == 12) {
    showDateMonthPoint(396, 0);
  }
}

void draw()
{

  if (pageNumber == 1)
  {
  } else if (pageNumber == 2)
  {
    drawPage2();
    return;
  }

  updateScrollButtons();
  updateCrimeButtons();
  updateNavBtn();
  updatePlayButton();
  datesAutoPlay();
  chkWhichCrimeBtnPresses();
  chkWhichDateBtnPressed();
  changeDatePointerLoc();

  int id = geoMap.getID(mouseX, mouseY);
  stroke(0, 150);               // Boundary colour

  if (did == false) {
    if (called && id == -1) {
      background(bg);
      showScale();
      drawMainTitle();
      drawCrimeTypeTitle();
      drawDatePickerTitle();
      drawLowHighCrimeTitle();
      drawDescription();
      updateScrollButtons();
      updatePlayButton();
      updateCrimeButtons();
      updateNavBtn();

      if (whatpressed == 1) {
        setMapColourOverall(Integer.parseInt(theYear + theMonth), "Burglary", geoMap); 
        showPoint(80, 160);
      } else if (whatpressed == 2) {
        setMapColourOverall(Integer.parseInt(theYear + theMonth), "Criminal Damage", geoMap);  
        showPoint(240, 160);
      } else if (whatpressed == 3) {
        setMapColourOverall(Integer.parseInt(theYear + theMonth), "Drugs", geoMap);  
        showPoint(400, 160);
      } else if (whatpressed == 4) {
        setMapColourOverall(Integer.parseInt(theYear + theMonth), "Fraud & Forgery", geoMap);  
        showPoint(80, 205);
      } else if (whatpressed == 5) {
        setMapColourOverall(Integer.parseInt(theYear + theMonth), "Other Notifiable Offences", geoMap);  
        showPoint(240, 205);
      } else if (whatpressed == 6) {
        setMapColourOverall(Integer.parseInt(theYear + theMonth), "Robbery", geoMap);  
        showPoint(400, 205);
      } else if (whatpressed == 7) {
        setMapColourOverall(Integer.parseInt(theYear + theMonth), "Sexual Offences", geoMap);
        showPoint(80, 250);
      } else if (whatpressed == 8) {
        setMapColourOverall(Integer.parseInt(theYear + theMonth), "Theft & Handling", geoMap);  
        showPoint(240, 250);
      } else if (whatpressed == 9) {
        setMapColourOverall(Integer.parseInt(theYear + theMonth), "Violence Against The Person", geoMap);  
        showPoint(400, 250);
      }
      called = false;
      did = true;
    }
  }

  // Query the county at the mouse position.
  if (id != -1)
  {

    String name = geoMap.getAttributes().getString(id, 2); 
    background(bg);
    showScale();
    drawMainTitle();
    drawCrimeTypeTitle();
    drawDatePickerTitle();
    drawLowHighCrimeTitle();
    drawDescription();
    updateScrollButtons();
    updateCrimeButtons();
    updateNavBtn();
    updatePlayButton();
    if (whatpressed == 1) {
      setMapColourSpecific(Integer.parseInt(theYear + theMonth), "Burglary", geoMap); 
      showPoint(80, 160);
    } else if (whatpressed == 2) {
      setMapColourSpecific(Integer.parseInt(theYear + theMonth), "Criminal Damage", geoMap);  
      showPoint(240, 160);
    } else if (whatpressed == 3) {
      setMapColourSpecific(Integer.parseInt(theYear + theMonth), "Drugs", geoMap);  
      showPoint(400, 160);
    } else if (whatpressed == 4) {
      setMapColourSpecific(Integer.parseInt(theYear + theMonth), "Fraud & Forgery", geoMap);  
      showPoint(80, 205);
    } else if (whatpressed == 5) {
      setMapColourSpecific(Integer.parseInt(theYear + theMonth), "Other Notifiable Offences", geoMap);  
      showPoint(240, 205);
    } else if (whatpressed == 6) {
      setMapColourSpecific(Integer.parseInt(theYear + theMonth), "Robbery", geoMap);  
      showPoint(400, 205);
    } else if (whatpressed == 7) {
      setMapColourSpecific(Integer.parseInt(theYear + theMonth), "Sexual Offences", geoMap);
      showPoint(80, 250);
    } else if (whatpressed == 8) {
      setMapColourSpecific(Integer.parseInt(theYear + theMonth), "Theft & Handling", geoMap);  
      showPoint(240, 250);
    } else if (whatpressed == 9) {
      setMapColourSpecific(Integer.parseInt(theYear + theMonth), "Violence Against The Person", geoMap);  
      showPoint(400, 250);
    }

    fill(0);

    if (whatpressed == 1) {
      //  text(name  + " " +  getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Burglary", name) + "\n out of " + getNumberOfAllCrimesButThis(Integer.parseInt(theYear + theMonth), name) + " Crimes", mouseX+5, mouseY +5);
      drawPopup(Integer.parseInt(theYear + theMonth), mouseX +20, mouseY-5, name, getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Burglary", name), "Burglary");
    } else if (whatpressed == 2) {
      //  text(name  + " " +  getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Criminal Damage", name) + "\n out of " + getNumberOfAllCrimesButThis(Integer.parseInt(theYear + theMonth), name) + " Crimes", mouseX+5, mouseY +5);
      drawPopup(Integer.parseInt(theYear + theMonth), mouseX +20, mouseY-5, name, getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Criminal Damage", name), "Criminal Damage");
    } else if (whatpressed == 3) {
      drawPopup(Integer.parseInt(theYear + theMonth), mouseX +20, mouseY-5, name, getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Drugs", name), "Drugs");
    } else if (whatpressed == 4) {
      //text(name  + " " +  getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Fraud & Forgery", name) + "\n out of " + getNumberOfAllCrimesButThis(Integer.parseInt(theYear + theMonth), name) + " Crimes", mouseX+5, mouseY +5);
      drawPopup(Integer.parseInt(theYear + theMonth), mouseX +20, mouseY-5, name, getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Fraud & Forgery", name), "Fraud & Forgery");
    } else if (whatpressed == 5) {
      //  text(name  + " " +  getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Other Notifiable Offences", name) + "\n out of " + getNumberOfAllCrimesButThis(Integer.parseInt(theYear + theMonth), name) + " Crimes", mouseX+5, mouseY +5);
      drawPopup(Integer.parseInt(theYear + theMonth), mouseX +20, mouseY-5, name, getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Other Notifiable Offences", name), "Other Notifiable Offences");
    } else if (whatpressed == 6) {
      //  text(name  + " " +  getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Robbery", name) + "\n out of " + getNumberOfAllCrimesButThis(Integer.parseInt(theYear + theMonth), name) + " Crimes", mouseX+5, mouseY +5);
      drawPopup(Integer.parseInt(theYear + theMonth), mouseX +20, mouseY-5, name, getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Robbery", name), "Robbery");
    } else if (whatpressed == 7) {
      //   text(name  + " " +  getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Sexual Offences", name) + "\n out of " + getNumberOfAllCrimesButThis(Integer.parseInt(theYear + theMonth), name) + " Crimes", mouseX+5, mouseY +5);
      drawPopup(Integer.parseInt(theYear + theMonth), mouseX +20, mouseY-5, name, getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Sexual Offences", name), "Sexual Offences");
    } else if (whatpressed == 8) {
      // text(name  + " " +  getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Theft & Handling", name) + "\n out of " + getNumberOfAllCrimesButThis(Integer.parseInt(theYear + theMonth), name) + " Crimes", mouseX+5, mouseY +5);
      drawPopup(Integer.parseInt(theYear + theMonth), mouseX +20, mouseY-5, name, getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Theft & Handling", name), "Theft & Handling");
    } else if (whatpressed == 9) {
      // text(name + " " + getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Violence Against The Person", name) + "\n out of " + getNumberOfAllCrimesButThis(Integer.parseInt(theYear + theMonth), name) + " Crimes", mouseX+5, mouseY +5);
      drawPopup(Integer.parseInt(theYear + theMonth), mouseX +20, mouseY-5, name, getNumOfCrimesOverall(Integer.parseInt(theYear + theMonth), "Violence Against The Person", name), "Violence Against The Person");
    }

    changeDatePointerLoc();
    called = true;
    did = false;
  }
}

//code used for creating image buttons
//comes from http://processingjs.org/learning/topic/imagebutton/
//written by Casey Reas and Ben Fry
class Button
{
  int x, y;
  int w, h;
  color basecolor, highlightcolor;
  color currentcolor;
  boolean over = false;
  boolean pressed = false;

  void pressed() {
    if (over && mousePressed) {
      pressed = true;
    } else {
      pressed = false;
    }
  }

  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}

//code used for creating image buttons
//comes from http://processingjs.org/learning/topic/imagebutton/
//written by Casey Reas and Ben Fry
class ImageButtons extends Button
{
  PImage base;
  PImage roll;
  PImage down;
  PImage currentimage;

  ImageButtons(int ix, int iy, int iw, int ih, PImage ibase, PImage iroll) 
  {
    x = ix;
    y = iy;
    w = iw;
    h = ih;
    base = ibase;
    roll = iroll;
    currentimage = base;
  }

  void update() 
  {
    over();
    pressed();
    if (pressed) {      
      currentimage = roll;
    } else if (over) {     
      currentimage = roll;
    } else {
      currentimage = base;
    }
  }

  void over() 
  {
    if ( overRect(x, y, w, h) ) {
      over = true;
    } else {
      over = false;
    }
  }

  void display() {
    image(currentimage, x, y);
  }
}