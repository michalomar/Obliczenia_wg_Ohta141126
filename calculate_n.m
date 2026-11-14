function calculate_n(plik_wejsciowy, plik_wyjsciowy,n_inf)
% Oblicza wspó³czynnik za³amania n(lambda)
% na podstawie interpolowanej funkcji ekstynkcji k(lambda),
% korzystaj¹c z podanego wzoru sumacyjnego (odd/even j).
%
%   oblicz_n_dyskretne('kforcalc.txt', 'ncalculated.txt')

    % Wczytanie danych: [lambda, k]
    data = load(plik_wejsciowy);

    lambda = data(:,1);  % d³ugoœæ fali [um]
    k      = data(:,2);  % ekstynkcja

    N = length(lambda);  % liczba punktów

    % Obliczenie skoku d³ugoœci fali (h)
    h = lambda(2) - lambda(1); 

    % Inicjalizacja tablicy n
    n = zeros(N,1);

    % Obliczanie n(lambda_i) wg wzoru
    for i = 1:N-1
        lambda_i = lambda(i);
        suma = 0;

        if mod(i,2) == 1  % i nieparzyste: sumuj po j parzystych
            j_set = 2:2:N-1;
        else              % i parzyste: sumuj po j nieparzystych
            j_set = 1:2:N-1;
        end
        
        for j = j_set
            if j == i  % pomijamy j = i (dzielenie przez zero)
                continue;
            end
            lambda_j = lambda(j);
            suma = suma + ((1.0/lambda_j) * k(j)) / (lambda_j^2 - lambda_i^2);
        end
         % ZWRÓCIÆ UWAGÊ NA MINUS PONI¯EJ - jest niezgodnoœæ, której nie
         % potrafiê wyjaœniæ
         n(i) = n_inf - (2/pi) * 2.0*h * lambda_i^2 * suma; 
    end

    % Zapisanie wyniku do pliku wyjœciowego
     output_data = [lambda, n];
     dlmwrite(plik_wyjsciowy, output_data, 'delimiter', '\t', 'precision', '%.6f');
     %dlmwrite(plik_wyjsciowy, output_data, 'delimiter', ' ', '\t', 'precision', '%.6f');
    
     fprintf('Zapisano dane do pliku: %s\n', plik_wyjsciowy);
    
    % --- RYSOWANIE WYKRESU ---
    figure;
    plot(lambda, n, 'b-', 'LineWidth', 1.5);
    grid on;
    xlabel('D³ugoœæ fali \lambda [\mum]');
    ylabel('Wspó³czynnik za³amania n');
    title('Wykres n(\lambda)');
    xlim([min(lambda), max(lambda)]);
end
