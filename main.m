%% main
function main()
    forma = conseguirForma();

    % Preallocate arrays for better performance
    q_basicas = zeros(size(forma,1), 3); % Each row will be [q1,q2,q3]
    matrices_dh = cell(size(forma,1), 1); % Cell array to store 4x4 matrices

    for i = 1:size(forma,1)
        % Get all 3 joint angles from inverse kinematics
        q_temp = intentoCinematicaInversa7(forma(i,1), forma(i,2), forma(i,3));


        % Verify we got 3 angles before proceeding
        if length(q_temp) == 3
            q_basicas(i,:) = q_temp(1,:);
            matrices_dh{i} = CinematicaDirecta(q_basicas(i,:));
        else
            length(q_temp)
            forma(i,1), forma(i,2), forma(i,3)
            error('Inverse kinematics failed to return 3 angles for point %d', i);
        end
    end

    length(matrices_dh);


    %% trayectoria
    pasos = 40;
    %trayectorias = cell(size(forma,1), 1);
    %for i = 1:size(forma,1)-1
    %  for j = 1 : pasos;
    %    trayectorias{j + ((i - 1) * pasos)} = ...
    %      [matrices_dh(i, 1) + ((matrices_dh{i+1, 1} - matrices_dh{i, 1}) * pasos),...
    %      matrices_dh(i, 2) + ((matrices_dh(i+1, 2) - matrices_dh(i, 2)) * pasos),...
    %      matrices_dh(i, 3) + ((matrices_dh(i+1, 3) - matrices_dh(i, 3)) * pasos),...
    %      matrices_dh(i, 4) + ((matrices_dh(i+1, 4) - matrices_dh(i, 4)) * pasos)];
    %  endfor
    %endfor

    % In your main function:
    num_puntos = length(matrices_dh);
    trayectorias = cell((num_puntos-1)*pasos, 1);

    for i = 1:num_puntos-1
        T1 = matrices_dh{i};
        T2 = matrices_dh{i+1};

        % Calculate difference between matrices
        delta_T = (T2 - T1)/pasos;

        for j = 1:pasos
            % Linear interpolation
            T_interp = T1 + (j-1)*delta_T;

            % Force last point to exactly match target (avoid floating point errors)
            if j == pasos
                T_interp = T2;
            end

            trayectorias{j + (i-1)*pasos} = T_interp;
        end
    end



    coolDibujarTrayectorias(trayectorias);
end

