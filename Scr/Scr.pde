import ddf.minim.*;              // Import libarary for sound 
/*-----------------------------------------------------------------------------------------
 Projet Name : 2048
 Team Num    :  10
 Team Names  : Ahmed Gamal - Ahmed Tarek - Abd Alrhman Atef - Ramzi Muhmmad - Ola Mohamed 
 ------------------------------------------------------------------------------------------*/

/*---------------------------Global Variables---------------------------------------------*/
int [][] board = new int[4][4];   // 2D array
int boarder = 450;
int blockSize= 100;
int padding = 10;
int score = 0, possibleMoves =0;
int right, down;
String stage="menu";
color box2 = #EFE4DB;
color text2 = #766E64;
color box4 = #EEE1C9;
color text4 = #766E64;
color box8 = #F2B27B;
color text8 = #F9F6F2;
color box16 = #f59563;
color text16 = #f9f6f2;
color box32 = #F67C5E;
color text32 = #F9F6F2;
color box64 = #f65e3b;
color text64 = #f9f6f2;
color box128 = #edcf72;
color text128 = #f9f6f2;
color box256 = #edcc61;
color text256 = #f9f6f2;
color box512 = #edc850;
color text512 = #f9f6f2;
color box1024 = #edc53f;
color text1024 = #f9f6f2;
color box2048 = #edc22e;
color text2048 = #f9f6f2;
color box4096 = #181700;
color text4096 = #FFFFF2;
PImage img1;
PFont guide1, guide2, usual;
String how_to_play = "Use your arrow keys to move the tiles. Tiles with the same number merge into one when they touch. Add them up to reach 2048!";
color box_start = #8E7A67;
color text_start = #F9F6F2;
boolean sound_on = true;
Minim minim;
AudioPlayer losing, while_playing, win;
/*--------------------------------------------------------------------------------------------------------------------------*/

/*---------------------------------------------Funcations-------------------------------------------------------------------*/

void setup() {
  size(475, 600);
  frameRate(30);
  minim = new Minim(this);
  losing = minim.loadFile("Losing.wav");
  losing.setGain(-12);
  while_playing = minim.loadFile("Karaoke_30sec.mp3");
  while_playing.setGain(-12);
  win = minim.loadFile("Winning.wav");
  win.setGain(-12);
  newgame();

  guide2=createFont("Segoe-Print-Font.ttf", 72);
  usual = createFont("impact.ttf", 72);
  textFont(usual, 20);
  background(#FAF9EE);
  noStroke();
  smooth();
}
/*----------------------------------------------------------------------------------------------------------------------*/
void draw() {

  if (stage == "menu") {     //Main Page
    img1 = loadImage("2048_Logo.png");
    image(img1, 112.5, 12.5, 250, 250);

    fill(#766E64);
    textFont(guide2);
    textSize(24);
    text("How to play:", 87.5, 295);

    textFont(guide2);
    textSize(16);
    text(how_to_play, 87.5, 305, 300, 300);   //statment

    fill(box_start);
    rect(137.5, 475, 200, 50, 15);

    fill(text_start);
    textFont(usual);
    textSize(32);
    text("Start", 210, 480, 200, 50);

    fill(box_start);
    textSize(28);
    text("Press m to mute or unmute", 83.5, 575);
  }
  if (stage=="game") {   // Start button was pressed

    background(#FAF9EE);

    fill(#BBACA1);                            
    rect(12.5, 90, boarder, boarder, 15);    //Main Border

    for (int j = 0; j < board.length; j++) {
      for (int i = 0; i < board.length; i++) {
        float x = 12.5 + padding + (padding + blockSize) * i;
        float y = 90 + padding + (padding + blockSize) * j;
        rec(x, y, blockSize, blockSize, 15, #CDC0B5);
        if (board[j][i] == 2) {
          rec(x, y, blockSize, blockSize, 15, box2);        // Block Outline
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text2);
        } else if (board[j][i] == 4) {
          rec(x, y, blockSize, blockSize, 15, box4);        // Block Outline
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text4);
        } else if (board[j][i] == 8) {
          rec(x, y, blockSize, blockSize, 15, box8);        // Block Outline
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text8);
        } else if (board[j][i] == 16) {
          rec(x, y, blockSize, blockSize, 15, box16);        // Block Outline
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text16);
        } else if (board[j][i] == 32) {
          rec(x, y, blockSize, blockSize, 15, box32);        // Block Outline
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text32);
        } else if (board[j][i] == 64) {
          rec(x, y, blockSize, blockSize, 15, box64);        // Block Outline
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text64);
        } else if (board[j][i] == 128) {
          rec(x, y, blockSize, blockSize, 15, box128);        // Block Outline
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text128);
        } else if (board[j][i] == 256) {
          rec(x, y, blockSize, blockSize, 15, box256);        // Block Outline
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text256);
        } else if (board[j][i] == 512) {
          rec(x, y, blockSize, blockSize, 15, box512);        // Block Outline
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text512);
        } else if (board[j][i] == 1024) {
          rec(x, y, blockSize, blockSize, 15, box1024);        // Block Outline
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text1024);
        } else if (board[j][i] == 2048) {
          rec(x, y, blockSize, blockSize, 15, box2048);        // Block Outline
          block_text(CENTER, ""+board[j][i], x, y+25, blockSize, blockSize, 36, text2048);
        }
      }
    }
    fill(box_start);
    rect(15, 15, 200, 50, 15);      // New Game Box

    fill(text_start);
    textFont(usual);
    textSize(32);
    text("New Game", 20, 20, 200, 50);

    fill(box_start);
    textSize(28);
    text("Press m to mute or unmute", 237.5, 575);

    // Update in every game
    update_score(score);
    game_over_text(possibleMoves);
    winning_text(check_winning());
  }
}
/*-------------------------------------------------------------------------------
 [Function Name]: mousePressed
 [Description]:   function to make check stage state
 [Return]:        None
 ---------------------------------------------------------------------------------*/
public void mousePressed() {
  if (stage == "menu") {
    if (mouseX > 137.5 && mouseX < 337.5 && mouseY > 475 && mouseY < 525) {
      stage="game";
    }
  }
  if (stage == "game") {
    if (mouseX > 15 && mouseX < 215 && mouseY > 15 && mouseY < 65) {
      newgame();
    }
  }
}
/*-------------------------------------------------------------------------------
 [Function Name]: newgame
 [Description]:  prepare the variables to start new game
 [Return]:       None
 ---------------------------------------------------------------------------------*/
void newgame() {
  losing.pause();

  while_playing.rewind();
  while_playing.play();
  while_playing.loop();

  board = new int[4][4];
  score = 0;
  possibleMoves = 1;

  generate_block();                    // First block
  generate_block();                    // Second block
  //board[0][0]=1024;                  // Test for when the game is won
  //board[0][3]=1024;
};
/*-------------------------------------------------------------------------------
 [Function Name]: generate_block
 [Description]:   Generate a '2' or '4' block randomly
 [Return]:        None
 ---------------------------------------------------------------------------------*/
void generate_block() {
  ArrayList<Integer> column = new ArrayList<Integer>();     // For columns
  ArrayList<Integer> row = new ArrayList<Integer>();        // For Rows

  for (int j = 0; j < board.length; j++) {    
    for (int i = 0; i < board.length; i++) {
      if (board[j][i]== 0) {         // IF we have any zero block
        row.add(j);
        column.add(i);
      }
    }
  }

  int randomNum = (int)random(0, row.size());
  int x = row.get(randomNum);
  int y = column.get(randomNum);
  if (random(0, 2) < 1)              // Generate a '2' or '4' block randomly
    board[x][y] =2;
  else
    board[x][y] =4;
};
/*-------------------------------------------------------------------------------
 [Function Name]: Update_score
 [Description]:   Update the score
 [Return]:        None
 ---------------------------------------------------------------------------------*/
void update_score (int score) {
  fill(box_start);
  textSize(32);
  text("Score: "+score, 225, 20, 250, 150);
};
/*-------------------------------------------------------------------------------
 [Function Name]: game_over_text
 [Description]:   Showing the "GameOver"
 [Return]:        None
 ---------------------------------------------------------------------------------*/
void game_over_text(int possibleMoves) {
  if (!check_winning()) {
    if (possibleMoves == 0) {
      if (while_playing.isPlaying()) {
        while_playing.pause();

        losing.rewind();
        losing.play();
      }

      fill(187, 173, 160, 180);
      rect(12.5, 90, boarder, boarder, 15);

      fill(text_start);          // Gameover text color (White color)
      textSize(36);
      text("Gameover...!", width/2, 315, 30);
    }
  }
}
/*-------------------------------------------------------------------------------
 [Function Name]: winning_text
 [Description]:   Winning show fucing
 [Return]:        None
 ---------------------------------------------------------------------------------*/
void winning_text(boolean trueWinning) {  
  if (trueWinning == true) {
    if (while_playing.isPlaying()) {
      while_playing.pause();

      win.rewind();
      win.play();
    }

    possibleMoves = 0;

    fill(187, 173, 160, 180);
    rect(12.5, 90, boarder, boarder, 15);

    fill(text_start);        // Winning text color
    textSize(36);
    text("YOU have WON!!!", width/2, 315, 30);
  }
}
/*-------------------------------------------------------------------------------
 [Function Name]: check_winning
 [Description]:   Checking the winning state
 [Return]:        Boolean
 ---------------------------------------------------------------------------------*/
boolean check_winning() {  
  boolean Won = false;
  for (int j = 0; j < board.length; j++) {
    for (int i = 0; i < board.length; i++) {
      if (board[i][j] >= 2048)
        Won = true;
    }
  }
  return Won;
}
/*-------------------------------------------------------------------------------
 [Function Name]: no_game_over
 [Description]:  conditions to check if the game is over
 [Return]:       Boolean
 ---------------------------------------------------------------------------------*/
boolean no_game_over() {
  int [] Right = {1, -1, 0, 0}, Down = {0, 0, 1, -1};          // Values for the up, down, left, right keys.
  boolean no_game_over = false;
  // 1 0 right
  // -1 0 left
  // 0 1 down
  // 0 -1 up

  for (int i=0; i < 4; i++) {
    if (play(Down[i], Right[i], false) != null)           // If no movement is possible the function returns null 
      no_game_over = true;
  }
  return no_game_over;
};
/*-------------------------------------------------------------------------------
 [Function Name]: keyPressed
 [Description]:  function to  sound control , select the movement direction
 [Return]:       None
 ---------------------------------------------------------------------------------*/
void keyPressed() {
  if (key=='m'||key=='M') sound_toggle();
  if (possibleMoves != 0) {
    switch (keyCode) {
    case 37:  // LEFT
      right = -1;
      down = 0;
      break;
    case 38:  // UP
      down =-1;
      right =0;
      break; 
    case 39:  // RIGHT
      right = 1;
      down = 0;
      break; 
    case 40:  // DOWN
      down = 1;
      right = 0;
      break; 
    default:  // No other keys can influence the movement
      down = 0;
      right = 0;
      break;
    }
    movement();                // Slide the block if possible
    check_winning();           // Check if we have a winning
  }
  if (no_game_over()) {        // Check if the game is over
    possibleMoves = 1;
  } else
    possibleMoves = 0;
}
/*-------------------------------------------------------------------------------
 [Function Name]: movement
 [Description]:   Slide the block if possible
 [Return]:        Boolean
 ---------------------------------------------------------------------------------*/
boolean movement() {
  int[][] newboard  = play(down, right, true);
  if (newboard != null) {
    board = newboard;
    generate_block();
    return true;
  } else
    return false;
} 
/*-------------------------------------------------------------------------------
 [Function Name]: Play
 [Description]:   Main function 
 [Return]:        Int
 ---------------------------------------------------------------------------------*/
int[][] play(int vertical, int horizontal, boolean scoreupdate) {
  // Left(vertical = 0, horizontal = -1)  
  // Right(vertical = 0, horizontal = +1)
  // Down(vertical = +1, horizontal = 0)                                           
  // Up(vertical = -1, horizontal = 0)

  int[][] backup = new int[4][4];    // Generate a copy of the board
  boolean moved = false;

  for (int j = 0; j < board.length; j++) {    
    for (int i = 0; i < board.length; i++) {
      backup[j][i] = board[j][i];    // Copy the current board
    }
  }

  // True step_direction = horizontal     
  // False step_direction = vertical 
  // Step direction contain -1 or 1
  // Slide all the blocks to the corresponding directions(up, down, right, left)
  if (vertical !=0 || horizontal !=0) {      //
    int step_direction = horizontal !=0 ? horizontal : vertical;  

    //(step_direction > 0) == true  --> means there is move right or down 2 1 0, till -1 
    //(step_direction > 0) == false --> means there is move left or up    1 2 3, till 4

    for (int n_row = 0; n_row < board.length; n_row++)
      for (int n_column = (step_direction > 0 ? board.length-2 : 1); n_column != (step_direction > 0 ? -1: board.length); n_column -= step_direction) {        //nth-cloumn (n=0,1,2,3)
        int y = horizontal != 0 ? n_row : n_column;                //determine the coordinate xy of the block for (right and left) and (up and down)
        int x = horizontal != 0 ? n_column : n_row;
        int dx = x;                                                   // Change in the direction -x
        int dy = y;                                                   // Change in the direction -y    

        // If the block is zero then skip the steps to the next column
        if (backup[y][x] == 0) continue;

        // Calculate how many blocks the current block should slide in the direction
        // x and y are the current block position, dx and dy are where the block is sliding into
        for (int i = (horizontal != 0 ? x : y) + step_direction; i != (step_direction > 0 ? board.length : -1); i += step_direction) {
          int a = horizontal != 0 ? y : i;                          // XY-Coordinate
          int b = horizontal != 0 ? i : x;

          // Stop sliding if blocks are not empty and the value is not equal
          if (backup[a][b] != 0 && backup[a][b] != board[y][x]) break;
          // Change in direction
          if (horizontal != 0) 
            dx = i;
          else
            dy = i;
        }
        // If the block stays at the same positon; no movement in that direction, then skip
        if ((horizontal != 0 && dx == x) || (vertical != 0 && dy == y)) continue;

        // If the block moves into new position then merge the blocks if they have the same values
        else if (backup[dy][dx] == board[y][x]) {                    // Means blocks are equal
          backup[dy][dx] *= 2;
          if (scoreupdate) 
            score += backup[dy][dx];
          moved =true;
        }
        // Switch the block with the empty position
        else if ((horizontal != 0 && dx != x ) || (vertical !=0 && dy != y)) { 
          backup[dy][dx] = backup[y][x];
          moved =true;
        }
        if (moved)                                
          backup[y][x]= 0;                       // Clear the block
      }
  }
  return moved ? backup : null;
}

/*-------------------------------------------------------------------------------
 [Function Name]: rec
 [Description]:   Making a custom rectangle
 [Return]:        None
 ---------------------------------------------------------------------------------*/
void rec (float rec_x, float rec_y, float rec_width, float rec_height, float roundEdge, color clr)
{
  fill(clr);
  rect(rec_x, rec_y, rec_width, rec_height, roundEdge);
};

/*-------------------------------------------------------------------------------
 [Function Name]: block_text
 [Description]:   function to make custom block text 
 [Return]:        None
 ---------------------------------------------------------------------------------*/
void block_text(int alignment, String text_string, float text_x, float text_y, float text_width, float text_height, float text_Size, color textColor) {
  fill(textColor);
  textAlign(alignment);
  textSize(text_Size);
  text(text_string, text_x, text_y+2, text_width, text_height);
};

/*-------------------------------------------------------------------------------
 [Function Name]:  sound_toggle
 [Description]:    Toggle the state of sound
 [Return]:         None
 ---------------------------------------------------------------------------------*/
public void sound_toggle() {
  sound_on =! sound_on;
  sound_control();
}
/*-------------------------------------------------------------------------------
 [Function Name]:  sound_control
 [Description]:    Mute/Unmute
 [Return]:         None
 ---------------------------------------------------------------------------------*/
public void sound_control() {
  if (!sound_on) {
    // Mute all sounds
    win.mute();
    while_playing.mute();
    losing.mute();
  }
  if (sound_on) {
    // Unmute all sounds
    win.unmute();
    while_playing.unmute();
    losing.unmute();
  }
}
/*-------------------------------------------------------------------------------------------------------------------------------------*/
