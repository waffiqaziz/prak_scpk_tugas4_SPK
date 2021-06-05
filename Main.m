% clear terminal
clc
clear

% link penilaian untuk design : https://www.kimovil.com/en/compare-smartphones
% link penilaian untuk kamera,battery : https://www.dxomark.com/category/smartphone-reviews/

disp("Penyelesaian Kasus dengan Algoritma Fuzzy AHP ");
disp("Kasus : Smartphone Paling Direkomendasikan Tahun 2021");
disp("Diasumsikan data Smartphone sebagai berikut");
disp("+-------------------------+-------------------+-------+---------+");
disp("| Nama Smartphone         | Design & Material | Camera| Battery |");
disp("+-------------------------+-------------------+-------+---------+");
disp("|Phone 12 Pro Max         | 87                | 130   | 78      |");
disp("|Xiaomi Mi 11 Ultra       | 98                | 143   | 85      |");
disp("|Samsung Galaxy S21 Ultra | 90                | 123   | 85      |");
disp("|Huawei Mate 40 Pro+      | 88                | 139   | 76      |");
disp("+-------------------------+-------------------+-------+---------+");

namaSmarphone = {'iPhone 12 Pro Max' 'Xiaomi Mi 11 Ultra' 'Samsung Galaxy S21 Ultra' 'Huawei Mate 40 Pro+'};
data = [ 87 130 78
         98 143 85
         90 123 85
         88 139 76 ];

% batas maksimal
    maksDesign = 100;
    maksCamera = 150;
    maksBattery = 85;

% normalisasi data
    data(:,1) = data(:,1) / maksDesign;
    data(:,2) = data(:,2) / maksCamera;
    data(:,3) = data(:,3) / maksBattery;

% Tentukan relasi antar kriteria
    % design 0.5 kali lebih penting daripada camera
    % design 0.5 kali lebih penting daripada battery
    % battery 0.25 kali lebih penting daripada camera

% Buat matriks dari relasi antar kriteria tersebut
% Dengan asumsi diatas, maka matriks yang dihasilkan adalah sebagai berikut:
    %                     | Design & Material | Camera | Battery |
    % Design & Material   | 1                 | 2      | 2       |
    % Camera              | 0.5               | 1      | 4       |
    % Battery             | 0.25              | 0.25   | 1       |
   
    relasiAntarKriteria = [ 1     2     2
                            0     1     4
                            0     0     1 ];
                    
% Tentukan TFN, yaitu Triangular Fuzzy Number
    TFN = {[-100/3 0     100/3] 	[3/100  0     -3/100]
           [0      100/3 200/3] 	[3/200  3/100 0     ]
           [100/3  200/3 300/3] 	[3/300  3/200 3/100 ]
           [200/3  300/3 400/3] 	[3/400  3/300 3/200 ]};
   
% Lakukan perhitungan rasio konsistensi
    RasioKonsistensi = HitungKonsistensiAHP(relasiAntarKriteria);

% Jika rasio konsistensi < 0.10, maka lakukan perhitungan berikutnya
    if RasioKonsistensi < 0.10
        % perhitungan bobot menggunakan metode Fuzzy AHP
        [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);

        % Hitung nilai skor akhir 
        ahp = data * bobotAntarKriteria';

        disp(" ")
        disp('Hasil Perhitungan dengan metode Fuzzy AHP')
        disp("+--------------------------+------------+-------------------------+");
        disp('| Nama Smarphone           | Skor Akhir | Kesimpulan              |')
        disp("+--------------------------+------------+-------------------------+");
        for i = 1:size(ahp, 1)
            % rentang kesimpulan nilai yang digunakan dalam perhitungan
                %   < 0.75     -> Kurang Direkomendasikan
                % 0.74 – 0.84  -> Cukup Direkomendasikan
                % 0.85 – 0.94  -> Direkomendasikan
                %   >= 0.95    -> Sangat Direkomendasikan
            
            if ahp(i) < 0.75
                status = 'Kurang Direkomendasikan';
            elseif ahp(i) < 0.85
                status = 'Cukup Direkomendasikan ';
            elseif ahp(i) < 0.95
                status = 'Direkomendasikan       ';
            else
                status = 'Sangat Direkomendasikan';
            end

            disp(['| ', char(namaSmarphone(i)), blanks(25 - cellfun('length',namaSmarphone(i))), '| ', ... 
                 num2str(ahp(i)), blanks(11 - length(num2str(ahp(i)))), '| ', ...
                 char(status),' |'])
        end
        disp("+--------------------------+------------+-------------------------+");
    end
    
% referensi
% modul praktikum
% https://piptools.net/algoritma-fuzzy-ahp/


    
    