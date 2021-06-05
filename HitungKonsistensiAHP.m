function [RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria)
    % nilai yang nantinya dipakai adalah nilai pada indeks sebanyak jumlah kriteria yang ada
        indeksAcak = [0.11 0.2 0.34 0.58 0.9 1.12 1.28 1.49 1.6];

    % Hitung jumlah kriteria, yaitu sesuai dengan ukuran matriks relasi antar kriteria
        [~, jumlahKriteria] = size(relasiAntarKriteria);

    % Hitung nilai lambda, yaitu nilai eigenvalue dengan menggunakan fungsi eigenvector
        [~, lambda] = eig(relasiAntarKriteria);

    % Tentukan maksimal nilai lambda yang telah dihitung sebelumnya
        maksLambda = max(max(lambda));

    % Hitung nilai indeks konsistensi dengan rumus (maksLambda - n) / (n - 1)
        IndeksKonsistensi = (maksLambda - jumlahKriteria)/(jumlahKriteria-1);

    % Hitung rasio konsistensi untuk mendapatkan jawaban akhir
        RasioKonsistensi = IndeksKonsistensi/indeksAcak(1,jumlahKriteria);

    % jika rasio konsistensi lebih dari 0.10, maka tampilkan pesan error
        if RasioKonsistensi < 0.10
            fprintf('\nRasio Konsistensi adalah %1.2f. Matriks yang dievaluasi konsisten!\n',RasioKonsistensi);
        else
            fprintf('\nRasio Konsistensi adalah %1.2f. Matriks yang dievaluasi tidak konsisten!\n',RasioKonsistensi);
        end
end