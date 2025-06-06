function xd = intentoCinematicaInversa3()
  pkg load optim  % Asegurar que 'fsolve' esté disponible

  % Valores iniciales conocidos (ángulos en grados)
  i1 = 50; % +90
  i2 = 20;
  i3 = 30;

  % Parámetros del robot
  d1 = 15;
  a2 = 7;
  a3 = 3;

  % Posición objetivo desde cinemática directa
  input = [i1, i2, i3];
  T = CinematicaDirecta(input);
  px_val = T(1,4);
  py_val = T(2,4);
  pz_val = T(3,4);
  objetivo = [px_val; py_val; pz_val];

  % Función error entre cinemática directa y objetivo
  function err = errorCinInv(q)
    theta1 = deg2rad(q(1));
    theta2 = deg2rad(q(2));
    theta3 = deg2rad(q(3));

    x = a3*cos(theta3)*cos(theta1)*cos(theta2) - a3*sin(theta3)*sin(theta2)*cos(theta1) + a2*cos(theta1)*cos(theta2);
    y = a3*cos(theta3)*sin(theta1)*cos(theta2) - a3*sin(theta3)*sin(theta2)*sin(theta1) + a2*sin(theta1)*cos(theta2);
    z = a3*cos(theta3)*sin(theta2) + a3*sin(theta3)*cos(theta2) + a2*sin(theta2) + d1;

    err = [x; y; z] - objetivo;
  end

  % Resolver usando fsolve
  options = optimset('Display','off'); % silenciar salida
  q_sol = fsolve(@errorCinInv, [i1, i2, i3], options); % valores iniciales

  xd.q1 = q_sol(1);
  xd.q2 = q_sol(2);
  xd.q3 = q_sol(3);
end

