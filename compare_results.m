clc;
clear;

% ============================================
% Wczytanie danych
% ============================================

n_db  = load('n_database.txt');
n_cal = load('n_calculated.txt');

k_db  = load('k_database.txt');
k_cal = load('k_calculated.txt');

% ============================================
% WYKRES n(lambda)
% ============================================

figure;

plot(n_cal(:,1), n_cal(:,2), ...
    'b-', 'LineWidth', 1.5);

hold on;

plot(n_db(:,1), n_db(:,2), ...
    'ks', ...
    'MarkerSize', 5, ...
    'LineWidth', 1.0);

grid on;

xlabel('Długość fali \lambda [\mum]');
ylabel('Współczynnik załamania n');

title('Porównanie n(\lambda)');

legend('n obliczone', ...
    'n z bazy', ...
    'Location', 'best');

xlim([min(n_db(:,1)) max(n_db(:,1))]);

% ============================================
% WYKRES k(lambda)
% ============================================

figure;

plot(k_cal(:,1), k_cal(:,2), ...
    'r-', 'LineWidth', 1.5);

hold on;

plot(k_db(:,1), k_db(:,2), ...
    'ko', ...
    'MarkerSize', 5, ...
    'LineWidth', 1.0);

grid on;

xlabel('Długość fali \lambda [\mum]');
ylabel('Ekstynkcja k');

title('Porównanie k(\lambda)');

legend('k obliczone', ...
    'k z bazy', ...
    'Location', 'best');

xlim([min(k_db(:,1)) max(k_db(:,1))]);