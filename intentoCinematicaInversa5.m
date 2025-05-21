function xd = intentoCinematicaInversa5()
  pkg load optim  % Para usar fsolve

  % Parámetros del robot
  d1 = 15;
  a2 = 7;
  a3 = 3;

  % Entrada conocida (ángulos en grados)
  input = [0, 0, 0];
  T = CinematicaDirecta(input);

  px_val = T(1,4);
  py_val = T(2,4);
  pz_val = T(3,4);

  % Función a resolver: sistema de ecuaciones no lineales
  function F = sistema(q)
    q1 = q(1); q2 = q(2); q3 = q(3);
    F(1) = a3*cos(q3)*cos(q1)*cos(q2) - a3*sin(q3)*sin(q2)*cos(q1) + a2*cos(q1)*cos(q2) - px_val;
    F(2) = a3*cos(q3)*sin(q1)*cos(q2) - a3*sin(q3)*sin(q2)*sin(q1) + a2*sin(q1)*cos(q2) - py_val;
    F(3) = a3*cos(q3)*sin(q2) + a3*sin(q3)*cos(q2) + a2*sin(q2) + d1 - pz_val;
  end

  % Valores iniciales (en radianes)
  q0 = deg2rad([0, 0, 0]);

  % Resolver
  opciones = optimset("MaxIter", 2000, "TolFun", 1e-6);
  [sol, fval, info] = fsolve(@sistema, q0, opciones);

  if info <= 0
    error("No se pudo resolver el sistema.");
  end

  % Convertir a grados
  xd.q1 = rad2deg(sol(1));
  xd.q2 = rad2deg(sol(2));
  xd.q3 = rad2deg(sol(3));
end

