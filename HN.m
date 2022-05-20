%% initialize random memories
N = 100; % neurons
m = 20; % memories

rng(0, 'twister') % seed
mem = randi([0 1], m, N); % store memories as mxN array
for a = 1:m
    for b = 1:N
        if mem(a,b) == 0
            mem(a,b) = -1; % adjust binary to -1,1
        end
    end
end
%% find weight matrix
W = zeros(N,N);

for i = 1:N
    for j = 1:N
        if i ~= j % non-diagonal (no self-weights)
            sum_ij = 0; % weight incrementer
            for k = 1:m
                sum_ij = sum_ij + mem(k,i) * mem(k,j); % increment down for opposite encoding, up for equal encoding
            end

            weight = sum_ij / m; % normalize
            W(i,j) = weight;
        else
            W(i,j) = 0; % 0 diagonal
        end
    end
end
%% creating erroneus input
mem_e = mem;
forgotten = 20; % number of "forgotten" neurons
for c = 1:m
    forget = randperm(N,forgotten); % flip forgotten neurons
    for n = 1:forgotten
        mem_e(c,forget(n)) = mem_e(c,forget(n))*-1;
    end
end
%% recall
% bias is 0 here
mem_c = 0;
energy = zeros(m,N);
correct = [];
hamming = zeros(m,1);

for d = 1:m
    state_change = true; % check if neurons have changed since the last iteration
    iteration = 0;
   
    while state_change % did we achieve a happy state?
        iteration = iteration + 1; % store iterations / memory
        order = randperm(N); % update in a random order
        mem_e_o = mem_e(d,:); % set original memory to check against

        for e = 1:N
            sum_wstates = 0; % store energy

            for f = 1:N
                sum_wstates = sum_wstates + (W(e,f) * mem_e(d,f)); % sum energies
            end
            if sum_wstates >= 0 % update rule, set neurons to encoded memory (let 0 energy go to 1 arbitrarily)
                mem_e(d,e) = 1;
            else
                mem_e(d,e) = -1; 
            end
        end
        energy(d,iteration) = sum_wstates; % record energy / iteration

        sum_ham = 0; % record Hamming distance / iteration

        for g = 1:N
            if mem_e(d,g) ~= mem_e_o(1,g)
                sum_ham = sum_ham + 1;
            end
        end
        hamming(d, iteration) = sum_ham;

        if mem_e(d,:) == mem_e_o
            state_change = false; % break while loop if states have found local minima
        end
    end

    if mem_e(d,:) == mem(d,:) % check if memory is recalled
        mem_c = mem_c + 1; % tally correct memories
        correct = [correct, d];
    end
end

disp("memories correctly retrieved:" + mem_c)

% plot energies
figure
plot(1:length(energy), energy) % all (not behaving as expected...why is the minima at 0?)
title("Energy, all memories")
xlabel("Iterations")
ylabel("Energy")

figure
plot(1:length(energy), energy(correct,:)) % plot energies of correctly recalled memories
title("Energy, correct memories")
xlabel("Iterations")
ylabel("Energy")

% plot Hamming distance
figure
plot(1:length(hamming), hamming) % appears we are missing the Hamming distance of some memories?
title("Hamming distance, all memories")
xlabel("Iterations")
ylabel("Hamming distance")

figure
plot(1:length(hamming(correct,:)), hamming(correct,:))
title("Hamming distance, correct memories")
xlabel("Iterations")
ylabel("Hamming distance")




