

function dTdt = heatingODE(t, T, T_in, flow_rate, Q, mass, cp, ...
                             h_loss, surface_area, T_env)

if mass < 1e-6
    dTdt = 0;
else

% Heat loss term 
q_loss = h_loss * surface_area * (T - T_env); 
    
% Energy balance
dTdt = (Q - q_loss - flow_rate * cp * (T - T_in)) / (mass * cp);

end
end


