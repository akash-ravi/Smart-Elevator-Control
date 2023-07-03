module elevator(input clk, reset, input [3:0] floor_sel, input[5:0]Time, input up, input down, output reg [3:0] floor, input [10:0]weight, input[6:0]password, output reg light_fan, output reg limit, output reg sleepmode, output reg passwordcheck, output reg [3:0] direction);
  reg [3:0] next_floor;
  integer i;

  always @(posedge clk or negedge reset) begin
    if (reset) begin
      floor <= 4'b0000;
      end
    else begin
      if (next_floor == floor_sel) begin
        direction <= 4'b0000;
      end else if (next_floor > floor_sel) begin
        direction <= 4'b0001;
      end else begin
        direction <= 4'b0010;
      end
    end 
  end

  always @(*) begin
    if((Time>=6) && (Time<= 22) ) begin
      sleepmode <= 1'b0;
      if (password == 69) begin
          passwordcheck <= 1'b1;
      floor <= floor_sel;
      end
      else begin
      passwordcheck <= 1'b0;
      end
      if((weight<=480)) begin
        light_fan <= 1'b1;
        limit <= 1'b0;
        if(weight<30)begin
          light_fan <= 1'b0;
          limit <= 1'b1;
        end
        if (reset) begin
          next_floor <= 4'b0000;
        end else if (up) begin
          next_floor <= 4'b0000;
          for (i = 0; i < 4; i = i + 1) begin
            if (floor_sel[i] == 1'b1) next_floor <= i;
          end
        end else if (down) begin
          next_floor <= 4'b0000;
          for (i = 3; i >= 0; i = i - 1) begin
            if (floor_sel[i] == 1'b1) next_floor <= i;
          end
        end
      end
      else  begin
        light_fan <= 1'b1;
        limit <= 1'b1;
      end
    end

    else begin
      if(password != 69 && ((Time>=6) && (Time<= 22)))begin
        passwordcheck <= 1'b0;      
        sleepmode <= 1'b0;
      end
      else if(( password !=69 ) && (Time>22 || Time<6)) begin      
        passwordcheck <= 1'b0;      
        sleepmode <= 1'b1;
      end  
      else begin
        passwordcheck <= 1'b1;      
        sleepmode <= 1'b1;
      end
        floor <= 4'b0000;
        end
  end

endmodule

module elevator_testbench;
  reg clk, reset, up, down;
  reg[5:0] Time;
  reg[10:0] weight;
  reg[6:0] password; 
  reg [3:0] floor_sel;
  wire [3:0] floor , direction;
  wire light_fan, limit, sleepmode, passwordcheck;

  elevator dut(clk, reset, floor_sel, Time, up, down, floor, weight, password, light_fan, limit, sleepmode, passwordcheck, direction);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("elevator.vcd");
    $dumpvars();
    $monitor("\n\nFloor sleceted :%d Time :%02d Weight :%d Password :%b Floor :%d \nLights and fan :%b Sleep mode :%b Overweight/Underweight: %b Password check :%b ", floor_sel, Time, weight, password, floor, light_fan, sleepmode, limit, passwordcheck );
    reset = 1;
    Time = 8;
    up = 0;
    down = 0;
    #10 reset = 0;    

    floor_sel = 2;
    password = 69;
    weight = 80;
    up = 1;
    #5 up = 0;

    #20 floor_sel = 4'b0100;
    password = 68;
    weight = 80;
    up = 1;
    #5 up = 0;
    Time = 9;

    #20 floor_sel = 4'b0010;
    password = 69;
    weight = 481;
    down = 1;
    #5 down = 0;
    Time = 13;

    #20 floor_sel = 4'b0100;
    password = 69;
    weight = 8;
    up = 1;
    #5 up = 0;
    Time = 23;

    #20 floor_sel = 4'b0001;
    password = 69;
    weight = 80;
    down = 1;
    #5 down = 0;
    Time = 7;

    #20 floor_sel = 4'b1000;
    password = 69;
    weight = 80;
    up = 1;
    #5 up = 0;
    Time = 9;

    #20 floor_sel = 4'b0100;
    password = 69;
    weight = 80;
    down = 1;
    #5 down = 0;
    Time = 23;

    #20 floor_sel = 4'b0100;
    password = 69;
    weight = 80;
    down = 1;
    #5 down = 0;
    Time = 2;

    #20 floor_sel = 4'b1000;
    password = 69;
    weight = 80;
    up = 1;
    #5 up = 0;
    Time = 9;

    #20 floor_sel = 4'b0010;
    password = 60;
    weight = 80;
    down = 1;
    #5 down = 0;
    Time = 13;
    #20 $finish;
  end
endmodule