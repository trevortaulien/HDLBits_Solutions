module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
    
    assign fan = fan_on | (too_cold & mode) | (too_hot & ~mode);
    assign heater = (too_cold & mode & ~fan_on) | (too_cold & mode & fan_on);
    assign aircon = (too_hot & ~mode & ~fan_on) | (too_hot & ~mode & fan_on);
    
endmodule
​
