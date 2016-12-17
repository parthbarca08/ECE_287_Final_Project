//===========================================//
//===========================================//
//===========================================//
/*
FROGGER
_______________________________________________________________________
By Parth Patel, Ian Baker, and Yi Zhan
_______________________________________________________________________
VGA MODULE adopted from BEN SHAFFER...
Utilized Ben's VGA module that he borrowed from OAKLEY KATTERHEINRICH.
_______________________________________________________________________
Isaac Steiger's Keyboard Module, who subsequently obtained it from Funkheld on 
‘http://www.alteraforum.com/forum/showthread.php?t=46549’
*/
//===========================================//
//===========================================//
//===========================================//
module test(clk, PS2_CLOCK, PS2_DATA, VGA_R, VGA_B, VGA_G, VGA_BLANK_N, VGA_SYNC_N , VGA_HS, VGA_VS, rst, VGA_CLK, direction, SWITCH);

//outputs the colors, determined from the color module.
output [7:0] VGA_R, VGA_B, VGA_G;

//Makes sure the screen is synced right.
output VGA_HS, VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_SYNC_N;

input clk, rst, SWITCH; //clk is taken from the onboard clock 50MHz. rst is taken from a switch, SW[17].

wire CLK108; //Clock for the VGA

//keyboard
input PS2_CLOCK,PS2_DATA;

/*
Coordinates of the pixel being assigned. Moves top to bottom, left to right.
*/
wire [30:0]X, Y;
output wire [4:0] direction;
kbInput kbIn(clk,PS2_DATA, PS2_CLOCK, direction);

//Area of screen we want shown
wire wholeArea = ((X >= 75)&&(X <= 1205)&&(Y < 1024));

//Not sure what these are, probably have to do with the display output system.
wire [7:0]countRef;
wire [31:0]countSample;

/*COORDINATES, (X,Y) Starting at the top left hand corner of the monitor. True for all coordinates
in this code block.*/
//X Max Coordinate 1280
//Y Max Coordinate 1024

//"Start"
reg [31:0] startX = 31'd75, startY = 31'd924;
//"Finish"
reg [31:0] finishX = 31'd75, finishY = 31'd0;

//******Vehicles*******Top Row
//"vehicle1"-red
reg [31:0] vehicle1X = 31'd0, vehicle1Y  = 31'd150;
//"vehicle2"-blue
reg [31:0] vehicle2X = 31'd240, vehicle2Y  = 31'd150;
//"vehicle3"
reg [31:0] vehicle3X = 31'd480, vehicle3Y  = 31'd150;
//"vehicle4"
reg [31:0] vehicle4X = 31'd720, vehicle4Y  = 31'd150;
//"vehicle5"
reg [31:0] vehicle5X = 31'd960, vehicle5Y  = 31'd150;

//******Vehicles*******Middle Row
//"vehicle6"
reg [31:0] vehicle6X = 31'd860, vehicle6Y  = 31'd400;
//"vehicle7"
reg [31:0] vehicle7X = 31'd1130, vehicle7Y  = 31'd400;
//"vehicle8"
reg [31:0] vehicle8X = 31'd590, vehicle8Y  = 31'd400;
//"vehicle9"
reg [31:0] vehicle9X = 31'd320, vehicle9Y  = 31'd400;

//******Vehicles*******Bottom Row
//"vehicle10"
reg [31:0] vehicle10X = 31'd200, vehicle10Y  = 31'd600;
//"vehicle11"
reg [31:0] vehicle11X = 31'd860, vehicle11Y  = 31'd800;

//"Frog"-green
reg [31:0] frogX = 31'd590, frogY = 31'd945;

//Win Lose Boxes to signal if the user won or last the last trial
//W
reg [31:0] WX = 31'd200, WY = 31'd945;
//LOSE
reg [31:0] LOSEX = 31'd900, LOSEY = 31'd945;


/* T = Top,  B = Bottom, L = Left, R = Right,  all with respect to the coordinate of where 
your "object" is placed.
T and L params are set to the object's upper lefthand.  
Best if you leave the Left hand side parameters to 0, i.e: Finish_L = 31'd0;
This will determine the available usable display space you have left.
*/

///////////////////// Start/Finish Lines //////////////////////////////////////
//Start_localParams
localparam Start_L = 31'd0, Start_R = Start_L + 31'd1205, Start_T = 31'd0, Start_B = Start_T + 31'd100;
assign Start =((X >= Start_L + startX)&&(X <= Start_R + startX)&&(Y >= Start_T+ startY)&&(Y <= Start_B+ startY));
//Finish_localParams
localparam Finish_L = 31'd0, Finish_R = Finish_L + 31'd1205, Finish_T = 31'd0, Finish_B = Finish_T + 31'd100;
assign Finish =((X >= Finish_L + finishX)&&(X <= Finish_R + finishX)&&(Y >= Finish_T+ finishY)&&(Y <= Finish_B+ finishY));

//Win Lose blocks
//W_localParams
localparam W_L = 31'd0, W_R = W_L + 31'd90, W_T = 31'd0, W_B = W_T + 31'd75;
assign W =((X >= W_L + WX)&&(X <= W_R + WX)&&(Y >= W_T+ WY)&&(Y <= W_B + WY));
//LOSE_localParams
localparam LOSE_L = 31'd0, LOSE_R = LOSE_L + 31'd90, LOSE_T = 31'd0, LOSE_B = LOSE_T + 31'd75;
assign LOSE =((X >= LOSE_L + LOSEX)&&(X <= LOSE_R + LOSEX)&&(Y >= LOSE_T+ LOSEY)&&(Y <= LOSE_B + LOSEY));

///////////////////// Cross Screen Objects //////////////////////////////////////
//***Top Row***
//vehicle1_localParams
localparam Vehicle1_L = 31'd0, Vehicle1_R = Vehicle1_L + 31'd75, Vehicle1_T = 31'd0, Vehicle1_B = Vehicle1_T + 31'd75;
assign Vehicle1 =((X >= Vehicle1_L + vehicle1X)&&(X <= Vehicle1_R + vehicle1X)&&(Y >= Vehicle1_T+ vehicle1Y)&&(Y <= Vehicle1_B + vehicle1Y));
//vehicle2_localParams
localparam Vehicle2_L = 31'd0, Vehicle2_R = Vehicle2_L + 31'd75, Vehicle2_T = 31'd0, Vehicle2_B = Vehicle2_T + 31'd75;
assign Vehicle2 =((X >= Vehicle2_L + vehicle2X)&&(X <= Vehicle2_R + vehicle2X)&&(Y >= Vehicle2_T+ vehicle2Y)&&(Y <= Vehicle2_B + vehicle2Y));
//vehicle3_localParams
localparam Vehicle3_L = 31'd0, Vehicle3_R = Vehicle3_L + 31'd75, Vehicle3_T = 31'd0, Vehicle3_B = Vehicle3_T + 31'd75;
assign Vehicle3 =((X >= Vehicle3_L + vehicle3X)&&(X <= Vehicle3_R + vehicle3X)&&(Y >= Vehicle3_T+ vehicle3Y)&&(Y <= Vehicle3_B + vehicle3Y));
//vehicle4_localParams
localparam Vehicle4_L = 31'd0, Vehicle4_R = Vehicle4_L + 31'd75, Vehicle4_T = 31'd0, Vehicle4_B = Vehicle4_T + 31'd75;
assign Vehicle4 =((X >= Vehicle4_L + vehicle4X)&&(X <= Vehicle4_R + vehicle4X)&&(Y >= Vehicle4_T+ vehicle4Y)&&(Y <= Vehicle4_B + vehicle4Y));
//vehicle5_localParams
localparam Vehicle5_L = 31'd0, Vehicle5_R = Vehicle5_L + 31'd75, Vehicle5_T = 31'd0, Vehicle5_B = Vehicle5_T + 31'd75;
assign Vehicle5 =((X >= Vehicle5_L + vehicle5X)&&(X <= Vehicle5_R + vehicle5X)&&(Y >= Vehicle5_T+ vehicle5Y)&&(Y <= Vehicle5_B + vehicle5Y));

//***Middle Row***
//vehicle6_localParams
localparam Vehicle6_R = 31'd75, Vehicle6_L = Vehicle6_R - 31'd75, Vehicle6_T = 31'd0, Vehicle6_B = Vehicle6_T + 31'd75;
assign Vehicle6 =((X >= Vehicle6_L + vehicle6X)&&(X <= Vehicle6_R + vehicle6X)&&(Y >= Vehicle6_T+ vehicle6Y)&&(Y <= Vehicle6_B + vehicle6Y));
//vehicle7_localParams
localparam Vehicle7_R = 31'd75, Vehicle7_L = Vehicle7_R - 31'd75, Vehicle7_T = 31'd0, Vehicle7_B = Vehicle7_T + 31'd75;
assign Vehicle7 =((X >= Vehicle7_L + vehicle7X)&&(X <= Vehicle7_R + vehicle7X)&&(Y >= Vehicle7_T+ vehicle7Y)&&(Y <= Vehicle7_B + vehicle7Y));
//vehicle8_localParams
localparam Vehicle8_R = 31'd75, Vehicle8_L = Vehicle8_R - 31'd75, Vehicle8_T = 31'd0, Vehicle8_B = Vehicle8_T + 31'd75;
assign Vehicle8 =((X >= Vehicle8_L + vehicle8X)&&(X <= Vehicle8_R + vehicle8X)&&(Y >= Vehicle8_T+ vehicle8Y)&&(Y <= Vehicle8_B + vehicle8Y));
//vehicle9_localParams
localparam Vehicle9_R = 31'd75, Vehicle9_L = Vehicle9_R - 31'd75, Vehicle9_T = 31'd0, Vehicle9_B = Vehicle9_T + 31'd75;
assign Vehicle9 =((X >= Vehicle9_L + vehicle9X)&&(X <= Vehicle9_R + vehicle9X)&&(Y >= Vehicle9_T+ vehicle9Y)&&(Y <= Vehicle9_B + vehicle9Y));

//***Bottom Row***
//vehicle10_localParams
localparam Vehicle10_L = 31'd0, Vehicle10_R = Vehicle10_L + 31'd75, Vehicle10_T = 31'd0, Vehicle10_B = Vehicle10_T + 31'd75;
assign Vehicle10 =((X >= Vehicle10_L + vehicle10X)&&(X <= Vehicle10_R + vehicle10X)&&(Y >= Vehicle10_T+ vehicle10Y)&&(Y <= Vehicle10_B + vehicle10Y));
//vehicle11_localParams
localparam Vehicle11_R = 31'd75, Vehicle11_L = Vehicle11_R - 31'd75, Vehicle11_T = 31'd0, Vehicle11_B = Vehicle11_T + 31'd75;
assign Vehicle11 =((X >= Vehicle11_L + vehicle11X)&&(X <= Vehicle11_R + vehicle11X)&&(Y >= Vehicle11_T+ vehicle11Y)&&(Y <= Vehicle11_B + vehicle11Y));

///////////////////// la Frog //////////////////////////////////////
//frog_localParams
localparam Frog_L = 31'd0, Frog_R = Frog_L + 31'd75, Frog_T = 31'd0, Frog_B = Frog_T + 31'd75;
assign Frog =((X >= Frog_L + frogX)&&(X <= Frog_R + frogX)&&(Y >= Frog_T+ frogY)&&(Y <= Frog_B + frogY));


//======Borrowed Code======//
//==========DO NOT EDIT BELOW==========//
countingRefresh(X, Y, clk, countRef );
clock108(rst, clk, CLK_108, locked);

wire hblank, vblank, clkLine, blank;

//Sync the display
H_SYNC(CLK_108, VGA_HS, hblank, clkLine, X);
V_SYNC(clkLine, VGA_VS, vblank, Y);
//==========DO NOT EDIT ABOVE==========//


//======DISPLAY CODE IN ORDER OF LAYER IMPORTANCE======//
/*This block sets the priority of what to display in order, best to list in order of importance.
The lowercase variables translate the object-to-be-displayed decision to the color module.
*/
reg box1, box2, box3, box4, box5, box6, box7, box8, box1_1, box1_2, box1_3, box1_4, box2_1, box2_2, blockW, blockL;

//Drawing shapes	
always@(*)
begin
	if(Frog) //frog -> box4
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b1; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(W) //W -> blockW
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b1;
		end
	else if(LOSE) //LOSE -> blockL
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b1; blockW = 1'b0;
		end
	else if(Vehicle1&&wholeArea) //vehicle1 -> box2
		begin
		box1 = 1'b0; box2 = 1'b1; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Vehicle2&&wholeArea) //vehicle2 -> box3
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b1; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Vehicle3&&wholeArea) //vehicle3 -> box6
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b1; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Vehicle4&&wholeArea) //vehicle4 -> box7
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b1; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Vehicle5&&wholeArea) //vehicle5 -> box8
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b1; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Vehicle6&&wholeArea) //vehicle6 -> box1_1
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b1; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Vehicle7&&wholeArea) //vehicle7 -> box1_2
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b1; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Vehicle8&&wholeArea) //vehicle8 -> box1_3
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b1; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Vehicle9&&wholeArea) //vehicle9 -> box1_4
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b1; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Vehicle10&&wholeArea) //vehicle10 -> box2_1
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b1; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Vehicle11&&wholeArea) //vehicle11 -> box2_2
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b1; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Finish&&wholeArea) //Finsih -> box1
		begin
		box1 = 1'b1; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else if(Start&&wholeArea) //Start -> box5
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b1; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	else	//background
		begin
		box1 = 1'b0; box2 = 1'b0; box3 = 1'b0; box4 = 1'b0; box5 = 1'b0; box6 = 1'b0; box7 = 1'b0; box8 = 1'b0; box1_1 = 1'b0; box1_2 = 1'b0; box1_3 = 1'b0; box1_4 = 1'b0; box2_1 = 1'b0; box2_2 = 1'b0; blockL = 1'b0; blockW = 1'b0;
		end
	end 
				
//==========================================================================================movement=======================================================================================//
//Box control (move left---->right on the screen for top/bottom row + reverse for middle)
//counter initialization
reg temp;
reg[31:0]counter;
//Speed
reg [2:0]speed_vehicle = 2'd1;
reg [1:0]fsm0;
reg [1:0]fsm1;
reg [1:0]fsm2;

always@(posedge clk)

begin
	if(SWITCH == 1'b1)
	begin
		fsm0 <= 1'b1;
		fsm1 <= 1'b1;
		fsm2 <= 1'b1;
	end
	else
	begin
		fsm0 <= 1'b0;
		fsm1 <= 1'b0;
		fsm2 <= 1'b0;
	end
	
	if(counter >= 32'd100010)
		counter <= 0;
	else
		begin 
		counter <= counter + 1;
		end
		
	//COLISON DETECTION
		if ((Frog)&&(Vehicle1|Vehicle2|Vehicle3|Vehicle4|Vehicle5|Vehicle6|Vehicle7|Vehicle8|Vehicle9|Vehicle10|Vehicle11))
		begin
			frogX <= 32'd905;
			frogY <= 32'd945;
		end
		else
		begin
			//Left x boundary
			if (frogX <= 32'd74)
				frogX <= 32'd75;
			else
				temp <= temp;
			//right x boundary
			if (frogX >= 32'd1130)
				frogX <= 32'd1129;
			else
				temp <= temp;
			//bottom y boundary
			if (frogY >= 32'd948)
				frogY <= 32'd947;
			else
				temp <= temp;
			//top y boundary
			if (frogY <= 32'd5)
			begin
				frogX <= 32'd205;
				frogY <= 32'd945;
			end
			else
				temp <= temp;		
				
	//case statement for keyboard(frog movement)
	case(direction)
	5'b00010: if (counter == 32'd100000)
					frogY <= (frogY - 32'd02);
				 else
					temp <= temp;
	5'b00100: if (counter == 32'd100000)
			      frogX <= (frogX - 32'd02);
				 else 
					temp <= temp;
	5'b01000: if (counter == 32'd100000)
					frogY <= (frogY + 32'd02);
				 else
					temp <= temp;
	5'b10000: if (counter == 32'd100000)
					frogX <= (frogX + 32'd02);
				else
					temp <= temp;
	endcase	
			
	//Shift all boxes left by the same distance as their separation to make the illusion of infinite boxes
		//Vehicle 1
		if(vehicle1X >= 32'd1280)
		begin
			vehicle1X <= vehicle1X - 1205;
			// starts scrolling from the left boundary
		end
		else 
			temp <= temp;
		//Vehicle 2
		if(vehicle2X >= 32'd1280)
		begin
			vehicle2X <= vehicle2X - 1205;
		end
		else 
			temp <= temp;
		//Vehicle 3
		if(vehicle3X >= 32'd1280)
		begin
			vehicle3X <= vehicle3X - 1205;
		end
		else 
			temp <= temp;
		//Vehicle 4
		if(vehicle4X >= 32'd1280)
		begin
			vehicle4X <= vehicle4X - 1205;
		end
		else 
			temp <= temp;
		//Vehicle 5
		if(vehicle5X >= 32'd1280)
		begin
			vehicle5X <= vehicle5X - 1205;
		end
		else 
			temp <= temp;
		//Vehicle 6 *********Start of Middle Row************
		if(vehicle6X <= 32'd0)
		begin
			vehicle6X <= vehicle6X + 1130;
		end
		else 
			temp <= temp;
		//Vehicle 7
		if(vehicle7X <= 32'd0)
		begin
			vehicle7X <= vehicle7X + 1130;
		end
		else 
			temp <= temp;
		//Vehicle 8
		if(vehicle8X <= 32'd0)
		begin
			vehicle8X <= vehicle8X + 1130;
		end
		else 
			temp <= temp;
		//Vehicle 9
		if(vehicle9X <= 32'd0)
		begin
			vehicle9X <= vehicle9X + 1130;
		end
		else 
			temp <= temp;
		//Vehicle 10 **************Start of Bottom Row***************
		if(vehicle10X >= 32'd1280)
		begin
			vehicle10X <= vehicle10X - 1205;
		end
		else 
			temp <= temp;
		//Vehicle 11
		if(vehicle11X <= 32'd0)
		begin
			vehicle11X <= vehicle11X + 1130;
		end
		else 
			temp <= temp;
			
//Vehicle movement
		//moving the "object" in the X direction by shifting the "object" to the next available pixel
		//Vehicle 1
		if(counter == 32'd10000 && speed_vehicle == 3'd5)
			begin
				vehicle1X <= vehicle1X + 1'd1 + fsm0;
			end
		else 
			begin
			temp <= temp;
			speed_vehicle <= speed_vehicle + 1'd1;
			end
		//Vehicle 2
		if(counter == 32'd10000 && speed_vehicle == 3'd5)
			begin
				vehicle2X <= vehicle2X + 1'd1 + fsm0;
			end
		else 
			begin
			temp <= temp;
			speed_vehicle <= speed_vehicle + 1'd1;
			end
		//Vehicle 3
		if(counter == 32'd10000 && speed_vehicle == 3'd5)
			begin
				vehicle3X <= vehicle3X + 1'd1 + fsm0;
			end
		else 
			begin
			temp <= temp;
			speed_vehicle <= speed_vehicle + 1'd1;
			end
		//Vehicle 4
		if(counter == 32'd10000 && speed_vehicle == 3'd5)
			begin
				vehicle4X <= vehicle4X + 1'd1 + fsm0;
			end
		else 
			begin
			temp <= temp;
			speed_vehicle <= speed_vehicle + 1'd1;
			end
		//Vehicle 5
		if(counter == 32'd10000 && speed_vehicle == 3'd5)
			begin
				vehicle5X <= vehicle5X + 1'd1 + fsm0;
			end
		else 
			begin
			temp <= temp;
			speed_vehicle <= speed_vehicle + 1'd1;
			end
		//Vehicle 6  *********Start of Middle Row************
		if(counter == 32'd10000 && speed_vehicle == 3'd5)
			begin
			if(fsm1 == 1'b1)
				vehicle6X <= vehicle6X - 2'b10;
			else
				vehicle6X <= vehicle6X - 2'b01;
			end
		else 
			begin
			temp <= temp;
			speed_vehicle <= speed_vehicle + 1'd1;
			end
		//Vehicle 7
		if(counter == 32'd10000 && speed_vehicle == 3'd5)
			begin
			if(fsm1 == 1'b1)
				vehicle7X <= vehicle7X - 2'b10;
			else
				vehicle7X <= vehicle7X - 2'b01;
			end
		else 
			begin
			temp <= temp;
			speed_vehicle <= speed_vehicle + 1'd1;
			end
		//Vehicle 8
		if(counter == 32'd10000 && speed_vehicle == 3'd5)
			begin
			if(fsm1 == 1'b1)
				vehicle8X <= vehicle8X - 2'b10;
			else
				vehicle8X <= vehicle8X - 2'b01;
			end
		else 
			begin
			temp <= temp;
			speed_vehicle <= speed_vehicle + 1'd1;
			end
		//Vehicle 9
		if(counter == 32'd10000 && speed_vehicle == 3'd5)
			begin
			if(fsm1 == 1'b1)
				vehicle9X <= vehicle9X - 2'b10;
			else
				vehicle9X <= vehicle9X - 2'b01;
			end
		else 
			begin
			temp <= temp;
			speed_vehicle <= speed_vehicle + 1'd1;
			end
		
		//Vehicle 10 **********Start of Bottom Row************
		if(counter == 32'd10000 && speed_vehicle == 3'd5)
			vehicle10X <= vehicle10X + 3'd6 + fsm0;
		else
			begin
			temp <= temp;
			speed_vehicle <= speed_vehicle + 1'd1;
			end
		//Vehicle 11
		if(counter == 32'd10000 && speed_vehicle == 3'd5)
			if(fsm2 == 1'b1)
				vehicle11X <= vehicle11X - 2'd10;
			else
				vehicle11X <= vehicle11X - 2'd01;
		else
			begin
			temp <= temp;
			speed_vehicle <= speed_vehicle + 1'd1;
			end
	end
end	
//==========================================================================================Testing movement=======================================================================================//

//======Modified Borrowed Code======//
//Determines the color output based on the decision from the priority block
color(clk, VGA_R, VGA_B, VGA_G, box1, box2, box3, box4, box5, box6, box7, box8, box1_1, box1_2, box1_3, box1_4, box2_1, box2_2, blockW, blockL);

//======Borrowed code======//
//======DO NOT EDIT========//
assign VGA_CLK = CLK_108;
assign VGA_BLANK_N = VGA_VS&VGA_HS;
assign VGA_SYNC_N = 1'b0;
endmodule

//Controls the counter
module countingRefresh(X, Y, clk, count);
input [31:0]X, Y;
input clk;
output [7:0]count;
reg[7:0]count;
always@(posedge clk)
begin
	if(X==0 &&Y==0)
		count<=count+1;
	else if(count==7'd11)
		count<=0;
	else
		count<=count;
end
endmodule

//======Formatted like Borrowed code, adjust you own parameters======//
//============================//
//========== COLOR ===========//
//============================//
module color(clk, red, blue, green, box1, box2, box3, box4, box5, box6, box7, box8, box1_1, box1_2, box1_3, box1_4, box2_1, box2_2, blockW, blockL);

input clk, box1, box2, box3, box4, box5, box6, box7, box8, box1_1, box1_2, box1_3, box1_4, box2_1, box2_2, blockW, blockL;

output [7:0] red, blue, green;
reg[7:0] red, green, blue;

always@(*)
begin
	if(box4)
		begin
		red = 8'd000;
		blue = 8'd000;
		green = 8'd255;
		end
	else if(blockL)
		begin
		red = 8'd255;
		blue = 8'd000;
		green = 8'd000;
		end
	else if(blockW)
		begin
		red = 8'd200;
		blue = 8'd000;
		green = 8'd255;
		end
	else if(box2_2)
		begin
		red = 8'd100;
		blue = 8'd100;
		green = 8'd100;
		end
	else if(box2_1)
		begin
		red = 8'd100;
		blue = 8'd100;
		green = 8'd100;
		end
	else if(box1_4)
		begin
		red = 8'd000;
		blue = 8'd150;
		green = 8'd100;
		end
	else if(box1_3)
		begin
		red = 8'd155;
		blue = 8'd100;
		green = 8'd000;
		end
	else if(box1_2)
		begin
		red = 8'd255;
		blue = 8'd000;
		green = 8'd255;
		end
	else if(box1_1)
		begin
		red = 8'd255;
		blue = 8'd255;
		green = 8'd255;
		end
	else if(box8)
		begin
		red = 8'd255;
		blue = 8'd255;
		green = 8'd255;
		end
	else if(box7)
		begin
		red = 8'd255;
		blue = 8'd000;
		green = 8'd255;
		end
	else if(box6)
		begin
		red = 8'd155;
		blue = 8'd100;
		green = 8'd000;
		end
	else if(box5)
		begin
		red = 8'd000;
		blue = 8'd150;
		green = 8'd100;
		end
	else if(box3)
		begin
		red = 8'd000;
		blue = 8'd255;
		green = 8'd000;
		end
	else if(box2)
		begin
		red = 8'd255;
		blue = 8'd000;
		green = 8'd000;
		end
	else if(box1)
		begin
		red = 8'd255;
		blue = 8'd255;
		green = 8'd255;
		end
	else
		begin
		red = 8'd0;
		blue = 8'd0;
		green = 8'd0;
		end
	end
	
endmodule

//====================================//
//========DO NOT EDIT PAST HERE=======//
//====================================//

/* 
 * --PS/2 CONTROLLER MODULES--
 */

module kbInput(

input clk,

input PS2_DATA,

input PS2_CLOCK,

output reg [4:0] direction

);

//from Isaac Steiger*********************************************

parameter idle = 2'b01;
parameter receive = 2'b10;
parameter ready = 2'b11;

reg [7:0] keycode;
reg [7:0] previousKey;
reg [1:0] state=idle;
reg [15:0] rxtimeout=16'b0000000000000000;
reg [10:0] rxregister=11'b11111111111;
reg [1:0] datasr=2'b11;
reg [1:0] clksr=2'b11;
reg [7:0] rxdata;

reg datafetched;
reg rxactive;
reg dataready;

always @(posedge clk )
begin
	if(datafetched==1)
	begin
		if(previousKey != 8'hF0)
		begin
			keycode<=rxdata;
		end
			previousKey <=rxdata;
	end
end

always@(keycode)
begin
		if( keycode == 8'h1D)
		begin
			direction = 5'b00010;
		
		end
		else if(keycode == 8'h1C)
		begin
			direction = 5'b00100;
		 
		end
		else if(keycode == 8'h1B)
		begin
			direction = 5'b01000;
		
		end
		else if(keycode == 8'h23)
		begin
			direction = 5'b10000;
		
		end

		else 
			direction = 5'b00000;	
end

always @(posedge clk )
begin
	rxtimeout<=rxtimeout+1;
	datasr <= {datasr[0],PS2_DATA};
	clksr <= {clksr[0],PS2_CLOCK};

	if(clksr==2'b10)
	rxregister<= {datasr[1],rxregister[10:1]};

	case (state)
		idle:
		begin
			rxregister <=11'b11111111111;
			rxactive <=0;
			dataready <=0;
			datafetched <=0;
			rxtimeout <=16'b0000000000000000;
			if(datasr[1]==0 && clksr[1]==1)
			begin
				state<=receive;
				rxactive<=1;
			end
		end
		receive:
		begin
			if(rxtimeout==50000)
				state<=idle;
			else if(rxregister[0]==0)
			begin
				dataready<=1;
				rxdata<=rxregister[8:1];
				state<=ready;
				datafetched<=1;
			end
		end
		ready:
		begin
			if(datafetched==1)
			begin
				state <=idle;
				dataready <=0;
				rxactive <=0;
				datafetched <=0;
			end
		end

	endcase

end

endmodule






/* --VGA CONTROLLER MODULES--
 * Controls vga output syncs and clk
 */
module H_SYNC(clk, hout, bout, newLine, Xcount);

input clk;
output hout, bout, newLine;
output [31:0] Xcount;
	
reg [31:0] count = 32'd0;
reg hsync, blank, new1;

always @(posedge clk) 
begin
	if (count <  1688)
		count <= Xcount + 1;
	else 
      count <= 0;
   end 

always @(*) 
begin
	if (count == 0)
		new1 = 1;
	else
		new1 = 0;
   end 

always @(*) 
begin
	if (count > 1279) 
		blank = 1;
   else 
		blank = 0;
   end

always @(*) 
begin
	if (count < 1328)
		hsync = 1;
   else if (count > 1327 && count < 1440)
		hsync = 0;
   else    
		hsync = 1;
	end

assign Xcount=count;
assign hout = hsync;
assign bout = blank;
assign newLine = new1;

endmodule


module V_SYNC(clk, vout, bout, Ycount);

input clk;
output vout, bout;
output [31:0]Ycount; 
	  
reg [31:0] count = 32'd0;
reg vsync, blank;

always @(posedge clk) 
begin
	if (count <  1066)
		count <= Ycount + 1;
   else 
            count <= 0;
   end 

always @(*) 
begin
	if (count < 1024) 
		blank = 1;
   else 
		blank = 0;
   end

always @(*) 
begin
	if (count < 1025)
		vsync = 1;
	else if (count > 1024 && count < 1028)
		vsync = 0;
	else    
		vsync = 1;
	end

assign Ycount=count;
assign vout = vsync;
assign bout = blank;

endmodule

//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module clock108 (areset, inclk0, c0, locked);

input     areset;
input     inclk0;
output    c0;
output    locked;

`ifndef ALTERA_RESERVED_QIS
 //synopsys translate_off
`endif

tri0      areset;

`ifndef ALTERA_RESERVED_QIS
 //synopsys translate_on
`endif

wire [0:0] sub_wire2 = 1'h0;
wire [4:0] sub_wire3;
wire  sub_wire5;
wire  sub_wire0 = inclk0;
wire [1:0] sub_wire1 = {sub_wire2, sub_wire0};
wire [0:0] sub_wire4 = sub_wire3[0:0];
wire  c0 = sub_wire4;
wire  locked = sub_wire5;
	 
altpll  altpll_component (
            .areset (areset),
            .inclk (sub_wire1),
            .clk (sub_wire3),
            .locked (sub_wire5),
            .activeclock (),
            .clkbad (),
            .clkena ({6{1'b1}}),
            .clkloss (),
            .clkswitch (1'b0),
            .configupdate (1'b0),
            .enable0 (),
            .enable1 (),
            .extclk (),
            .extclkena ({4{1'b1}}),
            .fbin (1'b1),
            .fbmimicbidir (),
            .fbout (),
            .fref (),
            .icdrclk (),
            .pfdena (1'b1),
            .phasecounterselect ({4{1'b1}}),
            .phasedone (),
            .phasestep (1'b1),
            .phaseupdown (1'b1),
            .pllena (1'b1),
            .scanaclr (1'b0),
            .scanclk (1'b0),
            .scanclkena (1'b1),
            .scandata (1'b0),
            .scandataout (),
            .scandone (),
            .scanread (1'b0),
            .scanwrite (1'b0),
            .sclkout0 (),
            .sclkout1 (),
            .vcooverrange (),
            .vcounderrange ());
defparam
    altpll_component.bandwidth_type = "AUTO",
    altpll_component.clk0_divide_by = 25,
    altpll_component.clk0_duty_cycle = 50,
    altpll_component.clk0_multiply_by = 54,
    altpll_component.clk0_phase_shift = "0",
    altpll_component.compensate_clock = "CLK0",
    altpll_component.inclk0_input_frequency = 20000,
    altpll_component.intended_device_family = "Cyclone IV E",
    altpll_component.lpm_hint = "CBX_MODULE_PREFIX=clock108",
    altpll_component.lpm_type = "altpll",
    altpll_component.operation_mode = "NORMAL",
    altpll_component.pll_type = "AUTO",
    altpll_component.port_activeclock = "PORT_UNUSED",
    altpll_component.port_areset = "PORT_USED",
    altpll_component.port_clkbad0 = "PORT_UNUSED",
    altpll_component.port_clkbad1 = "PORT_UNUSED",
    altpll_component.port_clkloss = "PORT_UNUSED",
    altpll_component.port_clkswitch = "PORT_UNUSED",
    altpll_component.port_configupdate = "PORT_UNUSED",
    altpll_component.port_fbin = "PORT_UNUSED",
    altpll_component.port_inclk0 = "PORT_USED",
    altpll_component.port_inclk1 = "PORT_UNUSED",
    altpll_component.port_locked = "PORT_USED",
    altpll_component.port_pfdena = "PORT_UNUSED",
    altpll_component.port_phasecounterselect = "PORT_UNUSED",
    altpll_component.port_phasedone = "PORT_UNUSED",
    altpll_component.port_phasestep = "PORT_UNUSED",
    altpll_component.port_phaseupdown = "PORT_UNUSED",
    altpll_component.port_pllena = "PORT_UNUSED",
    altpll_component.port_scanaclr = "PORT_UNUSED",
    altpll_component.port_scanclk = "PORT_UNUSED",
    altpll_component.port_scanclkena = "PORT_UNUSED",
    altpll_component.port_scandata = "PORT_UNUSED",
    altpll_component.port_scandataout = "PORT_UNUSED",
    altpll_component.port_scandone = "PORT_UNUSED",
    altpll_component.port_scanread = "PORT_UNUSED",
    altpll_component.port_scanwrite = "PORT_UNUSED",
    altpll_component.port_clk0 = "PORT_USED",
    altpll_component.port_clk1 = "PORT_UNUSED",
    altpll_component.port_clk2 = "PORT_UNUSED",
    altpll_component.port_clk3 = "PORT_UNUSED",
    altpll_component.port_clk4 = "PORT_UNUSED",
    altpll_component.port_clk5 = "PORT_UNUSED",
    altpll_component.port_clkena0 = "PORT_UNUSED",
    altpll_component.port_clkena1 = "PORT_UNUSED",
    altpll_component.port_clkena2 = "PORT_UNUSED",
    altpll_component.port_clkena3 = "PORT_UNUSED",
    altpll_component.port_clkena4 = "PORT_UNUSED",
    altpll_component.port_clkena5 = "PORT_UNUSED",
    altpll_component.port_extclk0 = "PORT_UNUSED",
    altpll_component.port_extclk1 = "PORT_UNUSED",
    altpll_component.port_extclk2 = "PORT_UNUSED",
    altpll_component.port_extclk3 = "PORT_UNUSED",
    altpll_component.self_reset_on_loss_lock = "OFF",
    altpll_component.width_clock = 5;

endmodule