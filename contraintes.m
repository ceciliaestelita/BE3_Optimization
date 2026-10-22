global gamma alpha beta lambda delta T rho mu x0 N dt 
gamma = 1.47;
alpha = 5.64;
lambda = 0.16;
delta = 0;
beta = 0.48;
T = 30;
rho = 0.35;
mu = 0.1;
x0 = [0.5, 0.5];

%% functions
function x_dot = my_ode(t,x,lesu)
    global dt N gamma alpha beta lambda delta
    i = min (floor(t/dt) + 1 , N);
    u = lesu (i);
    x_dot = zeros(2,1);
    x_dot(1) = (gamma - delta - alpha - u)*x(1) + beta* x(2);
    x_dot(2) = alpha * x(1) - (lambda + beta) * x(2);
end

function [J, t, x] = cost(lesu)
    global T mu x0 dt 
    total_drug = dt*sum(lesu);
    [t, x] = ode45(@(time, state)my_ode(time,state,lesu), [0 T], x0);
    J = x(end,1) + mu * total_drug;
end

function [C, Ceq] = contrainte (lesu)
    global rho 
    [J, t, x] =  cost (lesu);
    C = max(rho -( x(:,1)+x(:,2)));
    Ceq = [];
end
