function calculate_k(plik_wejsciowy, plik_wyjsciowy, n_inf)
% Oblicza ekstynkcję k(lambda)
% na podstawie współczynnika załamania n(lambda)
% przy użyciu dyskretnej relacji Kramersa-Kroniga.
%
% calculate_k('n_database.txt', 'k_calculated.txt', n_inf)

% ============================================
% Wczytanie danych
% ============================================

data = load(plik_wejsciowy);

lambda = data(:,1);
n      = data(:,2);

N = length(lambda);

% ============================================
% Krok siatki
% ============================================

h = lambda(2) - lambda(1);

% ============================================
% Inicjalizacja
% ============================================

k = zeros(N,1);

% ============================================
% Obliczenia KK
% ============================================

for i = 1:N-1

    lambda_i = lambda(i);

    suma = 0;

    if mod(i,2) == 1
        j_set = 2:2:N-1;
    else
        j_set = 1:2:N-1;
    end

    for j = j_set

        if j == i
            continue;
        end

        lambda_j = lambda(j);

        suma = suma + ...
            (n(j) - n_inf) / ...
            (lambda_j^2 - lambda_i^2);

    end

    k(i) = (2/pi) * 2*h * lambda_i * suma;

end

% ============================================
% Zapis wyników
% ============================================

output_data = [lambda, k];

dlmwrite(plik_wyjsciowy, ...
    output_data, ...
    'delimiter', '\t', ...
    'precision', '%.6f');

fprintf('Zapisano dane do pliku: %s\n', ...
    plik_wyjsciowy);

end
