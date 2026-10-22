%% lesu random
for k = 1:3
    N =N_values(k) ;
    dt = T/N;
    lesurand = rand(N,1);
    [lesu, J] = fmincon(@cost, lesurand, [], [], [], [], zeros(N,1),ones(N,1), @contrainte)
    [t, x] = ode45(@(time, state)my_ode(time,state,lesu), [0 T], x0);
    P = x(:,1);
    Q = x(:,2);
    S = P+Q;
    figure();
    subplot(2,2,1);
    plot(t,P, 'g');
    xlabel('Time');
    ylabel('P(t)');
    title('P(t)');
    grid on;

    subplot(2,2,2);

    plot(t, Q, 'g');
    xlabel('Time');
    ylabel('Q(t)');
    title('Q(t)');
    grid on;

    subplot(2,2,3);
    plot(t, S, 'g');
    hold on;
    xlabel('Time');
    ylabel('P(t) + Q(t)');
    title('P(t) + Q(t)');
    grid on;

    subplot(2,2,4);
    stairs((0:N)*dt, [lesu(:); lesu(end)], 'g');
    xlabel('Time');
    ylabel('u(t)');
    title('Optimal control');
    grid on;
end
