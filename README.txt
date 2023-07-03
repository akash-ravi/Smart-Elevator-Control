README FILE

To run the Logisim and verily code the prerequisites are having icarus verily and Logisim downloaded and installed on your system

For Logisim 
Next download the 2 Logisim files Elevator_control.circ and Sleep_mode.circ.
Open the Elevator_control.circ file and load the Sleep_mode.circ file as a Logisim module.
Enable the time check to see time on the 7 set display.
Then to enable the circuit the clock will have to be enabled.
Enable Simulation and set clock tick frequency to an appropriate frequency(maybe 64Hz).
If sleep mode is enabled(a input with 1 and 0 as states) then the circuit will work only in active hours( 6:00 to 22:00)
Then enter the password (binary password is 1000101) to enable calls to the lift from outside the lift.
Then you may test the normal functionality of the lift by checking various test cases that you would encounter with using an elevator in daily life.(door must be closed to serve further calls)
Current floor and direction can be seen on the 2 7-segment displays.

For Verilog
Download the file  elevator.v and run it on system using appropriate commands in terminal or install a verily extension to run the file easier.
The output will be in the output screen after running for a few test cases that were tested in the testbench module of the verily code