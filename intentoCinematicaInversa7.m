function q = intentoCinematicaInversa7(px, py, pz)
    % Parámetros del robot e
    d1 = 15;
    a2 = 7;
    a3 = 3;

    % Solución para q1
    q1 = atan2(py, px);

    % Coordenadas en el plano XZ del eslabón 2
    px_prime = sqrt(px^2 + py^2);
    pz_prime = pz - d1;

    % Usando la ley de cosenos para encontrar q3
    D = (px_prime^2 + pz_prime^2 - a2^2 - a3^2)/(2*a2*a3);

    % Dos soluciones posibles (codo arriba y codo abajo)
    q3_pos1 = atan2(sqrt(1-D^2), D);
    q3_pos2 = atan2(-sqrt(1-D^2), D);

    % Solución para q2 (para cada q3)
    q2_pos1 = atan2(pz_prime, px_prime) - atan2(a3*sin(q3_pos1), a2 + a3*cos(q3_pos1));
    q2_pos2 = atan2(pz_prime, px_prime) - atan2(a3*sin(q3_pos2), a2 + a3*cos(q3_pos2));

    % Devolver ambas configuraciones posibles
    q = [(q1*180/pi), q2_pos1*180/pi, q3_pos1*180/pi;
         (q1*180/pi), q2_pos2*180/pi, q3_pos2*180/pi];
end
