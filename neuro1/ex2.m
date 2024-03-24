a = 25; %test a values
A1 = [0.9 a; 0 0.8];
A2 = [0.9 0; a 0.8];
n = length(A1);

cvx_begin sdp
variable P(n, n) symmetric;
A1'*P*A1 - P <= -eye(n);
A2'*P*A2 - P <= -eye(n);
P >= eye(n);
cvx_end



alpha_val = 3; % testing alpha values
Matrix1 = [0.9 alpha_val; 0 0.8];
Matrix2 = [0.9 0; alpha_val 0.8];

for iter = 1 : 8
    initial_state = randn(2);
    for idx = 1 : 1000
        state_component2 = initial_state(idx, 2);
        threshold = min(max(state_component2 - 0.5, 0), 1);
        state_p1 = threshold * Matrix1 * initial_state(idx, :)' + (1 - threshold) * Matrix2' * initial_state(idx, :)';
        initial_state(idx + 1, :) = state_p1;
    end
    plot(initial_state(:, 1), initial_state(:, 2))
    title(sprintf('alpha = %d', alpha_val))
    hold on
end

