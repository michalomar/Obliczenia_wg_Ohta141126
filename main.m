clc;
clear;

% ============================================
% MAIN PROGRAM
% ============================================

% --- Numer wiersza odpowiadaj¹cy materia³owi ---
row_num = input('Podaj numer linii z bazy danych: ');

% --- Parametr n_inf ---
n_inf = input('Podaj wartosc n_inf: ');

pause_after_export = input( ...
    'Czy zatrzymac program po utworzeniu plikow danych? (t/n): ', ...
    's');

% --- Nazwa pliku bazy ---
filename = 'C:\Users\p539526\Downloads\baza2KG.xlsx';

% ============================================
% EKSTRAKCJA CZÊŒCI RZECZYWISTEJ
% ============================================

[wavelengths_R, values_R, material] = ...
    extract_data(filename, 'RefractiveR', row_num);

data_R = [wavelengths_R(:), values_R(:)];

plik_R = 'n_database.txt';

dlmwrite(plik_R, data_R, ...
    'delimiter', ' ', ...
    'precision', '%.8f');

fprintf('Zapisano Re(n) do pliku %s\n', plik_R);

% ============================================
% EKSTRAKCJA CZÊŒCI UROJONEJ
% ============================================

[wavelengths_I, values_I, material] = ...
    extract_data(filename, 'RefractiveI', row_num);

disp(length(wavelengths_I))
disp(length(values_I))

data_I = [wavelengths_I(:), values_I(:)];

plik_I = 'k_database.txt';

dlmwrite(plik_I, data_I, ...
    'delimiter', ' ', ...
    'precision', '%.8f');

fprintf('Zapisano Im(n)=k do pliku %s\n', plik_I);

% ============================================
% OPCJONALNA PAUZA
% ============================================

if strcmpi(pause_after_export,'t')

    fprintf('\n');
    fprintf('====================================\n');
    fprintf('Program zatrzymany.\n');
    fprintf('Mozesz teraz zmodyfikowac:\n');
    fprintf('  n_database.txt\n');
    fprintf('  k_database.txt\n');
    fprintf('Po zakonczeniu nacisnij ENTER.\n');
    fprintf('====================================\n');

    pause;

end

% ============================================
% OBLICZENIE KK
% ============================================

plik_wyjsciowy = 'n_calculated.txt';
calculate_n(plik_I, plik_wyjsciowy, n_inf);

plik_wyjsciowy_k = 'k_calculated.txt';
calculate_k(plik_R, plik_wyjsciowy_k, n_inf);

fprintf('\n');
fprintf('====================================\n');
fprintf('Materia³: %s\n', material);
fprintf('Proces zakoñczony poprawnie.\n');
fprintf('====================================\n');