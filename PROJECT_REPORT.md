# ECE_287_Final_Project
Project Overview:
	The goal of our project was to create a timeless classic arcade game using the tools we have learned in this class. We created the game Frogger™ in verilog that utilizes the VGA port,  ps/2 port, and other skills that we learned in class.

Project Description:
	This game involves moving a “frog”, represented as a green block, from the bottom of the screen to the top of the screen without having any sort of collision. In the case of a collision, the frog will be sent back to a loss block, and if the frog crosses the white bar on the top of the screen, the frog will respawn in a win block. This decides the win state or loss state and is a fun indicator for the player.
Border:  
	For this game, we also needed to keep the frog from moving off screen so we implemented a border which allows the frog to stay within the visible area of the screen. This was implemented by using basic if statements. If the defined region of the frog reached an area within a few pixels of the end of the screen, to reset the frog a pixel back from where it was. This gives the appearance that the frog is unable to move past the border of the game. This feature is very seamless and to the naked eye it is near impossible to tell what is happening to the frog. Within this there will be an indicator that will show a win state or a loss state represented as a green or red, respectively.	


Peripherals Used:








![test](https://github.com/parthbarca08/ECE_287_Final_Project/blob/master/Pic_correct.jpg)







VGA:  
	Obtained from Ben Shaffer and Oakley Katterheinrich.
	VGA was one of the peripherals that require more time and effort to understand. At first our group attempted to do enough research so that we could build our own module, but we soon found out that reverse engineering was a faster route to understanding the peripheral. As soon as we learned how to “draw” images to the screen we then spent more time on how to change the colors and speeds of individual objects. We learned that to “initialize” the starting point of the squares that we wanted to draw, that we would need a register to define the (x,y) coordinates on the screen. To fill out the squares we had to create parameters for the top, bottom, left , and right sides of the intended square. We then assigned this to a variable and used this variable for the order of importance and the color of the square. Inside of our main module we had separate sections to allow for “initializing” the object we wanted to draw, the order of importance in which it is displayed, and its color. We had to do a lot of testing to figure out how and why some combinations of these would work and why some of these would not. This was one drawback of using someone else's VGA module. Realizing the importance of how we wanted to make the objects appear on the screen was a challenge. This was one of the more difficult aspects of VGA.  This led to us realizing that the order and the colors were linked in importance, because if we had two objects, the later object would need to be defined before the first object so that it could retain its color when we assigned it the proper R,G,B values. Giving the objects a value for color was tricky. The module that we had worked for its most basic purpose, however any overload or any miss use of the module would crash the whole project. One of these overloads came when we changed the RGB values for the various objects that we were displaying. 
	One of our coolest features was the wrapping feature in which the line of objects,”cars”, would wrap around the screen in a seamless fashion. This was achieved by having the objects reach the very end of the screen, and it would trigger an if-statement (attach the if statement here).   
	When we completed the overall mechanics of the game, there was a small feature that we felt was lacking. This feature was a win state or loss state. Albeit not the most important mechanic in the game, it add a more cohesive feel and encouragement and serves as a very important indicator to the player.




![Keyboard Bits](https://cdn.instructables.com/ORIG/F66/QZKD/IHI3N2NP/F66QZKDIHI3N2NP.jpg)




Keyboard:
	We obtained the keyboard module from Isaac Steiger @steigeia, who subsequently obtained it from Funkheld on : http://www.alteraforum.com/forum/showthread.php?t=46549

	

The other one of our peripherals was to interface a keyboard with the fpga in a useful way for our game. We decided to interface a Ps/2 keyboard because the difficulty level of USB was out of the scope of our understanding and was much more than we needed for our purposes. Over the course of this project we had used at least three different keyboard modules for our project, however none of them worked in our favour. Initially our problem was to figure out how to stop the keyboard module from sending input values even after a key was done being pressed. Once this problem was resolved, we needed to figure out how to resolve the problem of having the keyboard stop working for no reason. This was the most frustrating part of working with keyboard. The reason this was happening was because of a fault in the keyboard clock and the rate at which it was taking in inputs. After looking at a SignalTap of this issue, it was apparent that the module was not grabbing the input values at the correct instance and therefore it would completely stop working. The final keyboard module that we tested works like a charm. This module accounts for those small instances where the input will not align with the negedge of the 20 Hz keyboard clock. The new and improved module includes something called synchronization, which is simply just synchronizing the 20 Hz keyboard clock with the 50 MHz FPGA clock. This is a brilliant work around to the problem because the faster FPGA clock, the inputs will always be passed through only when the FPGA tells the keyboard to collect the information therefore reducing/eliminating the errors that we were encountering. 
	The keyboard overall mechanics of the keyboard are very interesting as well. The keyboard sends an 11-bit signal to be processed and converted to allow the module to tell our case statement what button was pressed and what action to take. They include  1 start bit, this is always 0, 8 data bits, and the least significant bits being 1 parity bit and 1 stop bit.Only the middle 8-bits of that code are important for us, which is called the make code. The value after the make code is what is most important in our game, the break code which is always denoted as hex value, 8’hF0, this tells the keyboard to stop sending the input signal and wait for another signal.  If a key is held down without being released, the make code for that key will be sent continuously. The break code is sent when the key is released, hence stopping any input data to be accessed or sent. 

Challenges/Conclusion:
	Over the course of this project we had incurred some challenges that really made us think about the problem at hand. One of those challenges was RGB values displayed on the VGA monitor. As before mentioned, our VGA module was borrowed, and we modified it to be used as a general purpose VGA template. After having done that, the background would not display correct values and would more times than not crash.
	Another challenge was wrapping and integrating the wrapping feature with our FSM for the different level changes. The FSM allows for speed change, a switch is HIGH to indicate level 2 or LOW to indicate level 1. Sometimes when we revert the switch back from level 2 to level 1 all of our blocks that originally wrap disappear, and the same is true for when we switch from level 1 to level 2. This was very confusing because the only major thing that was changed was the speed at which the objects moved across the screen, and did not change any values for displaying each individual object. 
	Finally our most frustrating challenge was the keyboard. Although we eventually got the keyboard to work with different keyboard modules, the keyboard would freeze and not allow any more input values to go through. Total to get the keyboard to work we must have spent  15-20 hours alone.
	In conclusion, this project was a very interesting project to work on. All group members enjoyed spending time on the project and were willing to spend time on it. This document serves as both a summary of our project and a guide of to play this game. We have also included a video link below to show the game and the peripherals used.
	
Video of Project: (click play button below)

[![Link to Project Video](http://www.iconsdb.com/icons/preview/gray/video-play-xxl.png)](https://youtu.be/kDbHcJRV_Cg)

Instructions to Playing the Game:
-For movement
	Up: W key
	Down: S key
	Left: A key
	Right: D key
-Controlling Levels
	Level 1: SW16... LOW
	Level 2: SW16... HIGH
-Note on level two: Rarely objects on row two and row four go off the screen and don’t return, in this case the user needs to reupload the program to the board.

