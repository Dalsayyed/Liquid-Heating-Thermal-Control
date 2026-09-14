

function [t, T, efficiency] = simulateHeating(pipe_diameter,pipe_length,...
    fluid_type, heater_power, flow_rate, T_in, h_loss)

% Physical properties based on fluid type
switch fluid_type
    case 'Water'
        cp = 4186; density = 1000;
    case 'Oil'
        cp = 2000; density = 900;
    case 'Alcohol'
        cp = 2500; density = 790;
    case 'Mercury'
        cp = 140; density = 13500;
    otherwise
        cp = 4186; density = 1000;
end

% Geometric and physical calculations
cross_area = pi * (pipe_diameter / 2)^2;
volume = cross_area * pipe_length;
mass = density * volume;

% Environment parameters (adjust if needed)
T_env = 25; 
surface_area = pi * pipe_diameter * pipe_length;

% Time span
tspan = [0 1500]; % seconds

% ODE Solver
[t, T] = ode45(@(t, T) heatingODE(t, T, T_in, flow_rate, heater_power, ...
    mass, cp, h_loss, surface_area, T_env), tspan, T_in);

% Efficiency calculation
heat_used = flow_rate * cp * (T - T_in);  

if heater_power <= 0
    efficiency = zeros(size(T));
else
    efficiency = (heat_used / heater_power) * 100;
end

end
