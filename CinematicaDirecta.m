function p = cinematicaDirectaRRR(q)
    % Entrada:
    %   q: vector [theta1, theta2, theta3] en grados
    % Salida:
    %   p: posición [x, y, z] del end effector

    % Parámetros del robot (extraídos del PDF)
    d1 = 15;   % distancia desde base hasta eje 2 (en Z)
    a2 = 7;    % longitud del eslabón 2
    a3 = 3;    % longitud del eslabón 3

    % Extraer ángulos
    theta1 = deg2rad(q(1));
    theta2 = deg2rad(q(2));
    theta3 = deg2rad(q(3));

    % Matrices DH individuales
    T1 = matrizDenavitHartenberg(theta1, d1, 0, 90);     % Desde base hasta eslabón 2
    T2 = matrizDenavitHartenberg(theta2, 0, a2, 0);      % Desde eslabón 2 hasta 3
    T3 = matrizDenavitHartenberg(theta3, 0, a3, 0);      % Desde eslabón 3 al end effector

    % Transformación total
    T = T1 * T2 * T3;

    % Posición del end effector
    p = T(1:3, 4)';
end


