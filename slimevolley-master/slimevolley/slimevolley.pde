//scores, what r1 r2 and resetballs


import fisica.*;

color blue   = color(142, 247, 245);
color brown  = color(166, 120, 24);
color green  = color(74, 163, 57);
color red    = color(252, 199, 246);
color yellow = color(242, 215, 16);
//color gpink = color(242, 215, 16);
//color gblue  = color(242, 215, 16);
//keyboard booleans
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey;

int timer, rscore, lscore;

//fisica
FBox lground, rground, net, leftWall, rightWall, celling;
FCircle lplayer, rplayer, ball;
FWorld world;

PImage beach;
PImage volleyb;
PImage blueplayer;
PImage pinkplayer;
PImage nett;
//Physics
boolean leftCanJump, rightCanJump, BallResetRight, BallResetLeft;

void setup() {
  size(800, 600);
  beach = loadImage("beach.jpg");
  beach.resize (800, 600);
  volleyb = loadImage("volleyball.png");
  volleyb.resize (50, 50);
  pinkplayer = loadImage("pinkplayer.png");
  pinkplayer.resize (80, 80);
  blueplayer = loadImage("blueplayer.png");
  blueplayer.resize (80,80);
  nett = loadImage("net.jpg");
  nett.resize (20,100);

  


  timer = 60;

  //init world
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 980);


  ball = new FCircle (50);
  ball.attachImage(volleyb);
  ball.setPosition(width/2+320, 50);
  ball.setStatic(false);
  ball.setDensity(0.5);
  ball.setFriction(1);
  ball.setRestitution(1.1);
  world.add(ball);

  lground = new FBox(400, 100);
  lground.setFillColor(blue);
  lground.setNoStroke();
  lground.setPosition(200, 550);
  lground.setStatic(true);
  lground.setFriction(0);
  world.add(lground);

  rground = new FBox(400, 100);
  rground.setFillColor(red);
  rground.setNoStroke();
  rground.setPosition(600, 550);
  rground.setStatic(true);
  rground.setFriction(0);
  world.add(rground);

  net = new FBox(20, 100);
  net.attachImage(nett);
  net.setFill(255);
  net.setNoStroke();
  net.setPosition(400, 450);
  net.setStatic(true);
  world.add(net);

  lplayer = new FCircle(80);
  lplayer.attachImage(pinkplayer);
  //lplayer.setFillColor(red);
  lplayer.setNoStroke();
  lplayer.setPosition(200, 400);
  world.add(lplayer);

  rplayer = new FCircle(80);
  rplayer.attachImage(blueplayer);
  //rplayer.setFillColor(blue);
  rplayer.setNoStroke();
  rplayer.setPosition(600, 400);
  world.add(rplayer);

  celling = new FBox (width, 2);
  celling.setPosition(width/2, 0);
  celling.setStatic(true);
  celling.setFillColor(0);
  world.add(celling);

  leftWall = new FBox (2, height);
  leftWall.setPosition(-width/2 +width/2, height/2);
  leftWall.setStatic(true);
  leftWall.setFillColor(blue);
  world.add(leftWall);

  rightWall = new FBox (2, height);
  rightWall.setPosition(width, height/2);
  rightWall.setStatic(true);
  rightWall.setFillColor(blue);
  world.add(rightWall);



  //stroke(128, 0, 255, 128); //color purple semi-transparent
  //rect(10, 10, 50, 50)
}

void draw() {
  timer--;
  if (timer<0) {
    background(beach);

    leftCanJump = false;
    ArrayList<FContact> lcontacts = lplayer.getContacts();

    int i = 0;
    while (i < lcontacts.size()) {
      FContact c = lcontacts.get(i);
      if (c.contains(lground)) leftCanJump = true;
      i++;
    }
    //for (FContact c : contacts) {
    //  if (c.contains(lground)) leftCanJump = true;
    //}

    if (wkey && leftCanJump) lplayer.addImpulse(0, -2500);
    if (akey) lplayer.addImpulse(-200, 0);
    if (skey) ;
    if (dkey) lplayer.addImpulse(200, 0);

    rightCanJump = false;
    ArrayList<FContact> rcontacts = rplayer.getContacts();

    int j = 0;
    while (j < rcontacts.size()) {
      FContact c = rcontacts.get(j);
      if (c.contains(rground)) rightCanJump = true;
      j++;
    }

    if (lplayer.getX()>=375) {
      lplayer.setPosition(375, lplayer.getY());
    }

    if (rplayer.getX()<=425) {
      rplayer.setPosition(425, rplayer.getY());
    }

    if (upkey && rightCanJump) rplayer.addImpulse(0, -2500);
    if (leftkey) rplayer.addImpulse(-200, 0);
    if (downkey) ;
    if (rightkey) rplayer.addImpulse(200, 0);

    ArrayList<FContact> ballcontacts = ball.getContacts();

    int q = 0;
    while (q < ballcontacts.size()) {
      FContact c = ballcontacts.get(q);
      if (c.contains(lground)) {
        rscore++;
        ball.setVelocity(0, 0);
        timer = 60;
        if (timer>= 0) {
          ball.setPosition(600, 100);
          lplayer.setPosition(200, 485);
          lplayer.setVelocity(0, 0);
          rplayer.setPosition(600, 485 );
          rplayer.setVelocity(0, 0);
        }
      }
      if (c.contains(rground)) {
        lscore++;
        ball.setVelocity(0, 0);
        timer=60;
        if (timer >= 0) {
          ball.setPosition(200, 100);
          lplayer.setPosition(200, 485);
          lplayer.setVelocity(0, 0);
          rplayer.setPosition(600, 485 );
          rplayer.setVelocity(0, 0);
        }
      }
      q++;
    }
    world.step();
    world.draw();
  }

  fill(255);
  textSize(25);
  text("PINK KIRBY:"+lscore, 50, 60);
  text("BLUE KIRBY:"+rscore, 580, 60);

  if (lscore==3) {
    text("PINK KIRBY WINS", 100, 250);
    timer=100;
    timer++;
    text("click for a rematch", 290, height/2);
    if (mousePressed) {
      lscore=0;
      rscore=0;
      lplayer.setPosition(200, 485);
      rplayer.setPosition(600, 485);
      ball.setPosition(200, 100);
      timer=60;
    }
  }
  if (rscore==3) {
    text("BLUE KIRBY WINS", 520, 250);
    text("restart", 350, height/2);
    if (mousePressed) { 
      lscore=0;
      rscore=0;
      lplayer.setPosition(200, 485);
      rplayer.setPosition(600, 485);
      ball.setPosition(600, 100);
      timer=60;
    }

    timer=100;
    timer++;
  }
}





void keyPressed() {
  if (key == 'w' || key == 'W') wkey = true;
  if (key == 'a' || key == 'A') akey = true;
  if (key == 's' || key == 'S') skey = true;
  if (key == 'd' || key == 'D') dkey = true;

  if (keyCode == DOWN) downkey = true;
  if (keyCode == UP) upkey = true;
  if (keyCode == RIGHT) rightkey = true;
  if (keyCode == LEFT) leftkey = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') wkey = false;
  if (key == 'a' || key == 'A') akey = false;
  if (key == 's' || key == 'S') skey = false;
  if (key == 'd' || key == 'D') dkey = false;

  if (keyCode == DOWN) downkey = false;
  if (keyCode == UP) upkey = false;
  if (keyCode == RIGHT) rightkey = false;
  if (keyCode == LEFT) leftkey = false;
}
