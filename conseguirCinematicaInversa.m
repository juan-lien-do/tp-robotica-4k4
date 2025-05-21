function ci = conseguirCinematicaInversa()

  q = [0, 0, 0];
  d1 = 15;  % distancia desde base hasta eje 2 (en Z)
  a2 = 7;    % longitud del eslabón 2
  a3 = 3;    % longitud del eslabón 3

  % Extraer ángulos
  theta1 = deg2rad(q(1) + 90);
  theta2 = deg2rad(q(2));
  theta3 = deg2rad(q(3));

  % Matrices DH individuales
  T1 = matrizDenavitHartenberg(theta1, d1, 0, deg2rad(90));     % Desde base hasta eslabón 2
  T2 = matrizDenavitHartenberg(theta2, 0, a2, 0);      % Desde eslabón 2 hasta 3
  T3 = matrizDenavitHartenberg(theta3, 0, a3, 0);      % Desde eslabón 3 al end effector

  % Transformación total
  T = T1 * T2 * T3;
  %% Modelo cinemático inverso
  syms px py pz
  eq1 = px == T(1,4);
  eq2 = py == T(2,4);
  eq3 = pz == T(3,4);

  % Solución de d1.
  % La solución es trivial: d1 = pz - l1
  sd1 = pz - l1;
  % Solución de q2 y q3
  sq3 = solve(simplify(eq1^2+eq2^2),q3)


 end
