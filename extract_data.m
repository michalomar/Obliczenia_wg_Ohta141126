function [wavelengths, values, material] = ...
    extract_data(filename, sheet, row_num)

% ============================================
% Korekta numeru wiersza
% ============================================

row_num = row_num - 1;

% ============================================
% Wczytanie tabeli
% ============================================

T = readtable(filename, 'Sheet', sheet);

% ============================================
% Nazwa materia³u
% ============================================

material = T{row_num, 3}{1};

% ============================================
% Nazwy kolumn
% ============================================

varNames = T.Properties.VariableNames;

wavelengths = [];
values = [];

% ============================================
% Odczyt danych
% ============================================

for i = 5:length(varNames)

    name = varNames{i};

    if startsWith(name, 'w_')

        lambda_str = erase(name, 'w_');

        lambda_str = strrep(lambda_str, '_', '.');

        lambda = str2double(lambda_str);

        val = T{row_num, i};
% disp(['Kolumna: ', num2str(i)])
% 
% disp(val)
% 
% disp(class(val))
% ============================================
% CELL -> zawartoœæ
% ============================================

if iscell(val)

    if isempty(val)
        val = NaN;
    else
        val = val{1};
    end
end

% ============================================
% STRING / CHAR -> liczba
% ============================================

if ischar(val) || isstring(val)

    val = strtrim(val);

    if isempty(val)

        val = NaN;

    else

        val = strrep(val, ',', '.');

        val = str2double(val);

    end
end

% ============================================
% ZAPIS POPRAWNYCH LICZB
% ============================================

if isnumeric(val)

    if ~isnan(val)

        wavelengths(end+1) = lambda;

        values(end+1) = val;

    end
end
    end
end

% ============================================
% Sortowanie
% ============================================

[wavelengths, idx] = sort(wavelengths);

values = values(idx);

end