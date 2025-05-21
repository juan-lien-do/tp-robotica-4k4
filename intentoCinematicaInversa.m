function xd = intentoCinematicaInversa()
  i1 = 0;
  i2 = 0;
  i3 = 0;
  d1 = 15;  % distancia desde base hasta eje 2 (en Z)
  a2 = 7;    % longitud del eslabón 2
  a3 = 3;

  input = [i1,i2,i3];

  resvalida = CinematicaDirecta(input);


  syms px py pz;
  eq1 = px == resvalida(1:4);
  eq2 = py == resvalida(2:4);
  eq3 = pz == resvalida(3:4);

  syms q1 q2 q3 real

  equation1 = px == a3* cos(q3) * cos(q1) * cos(q2) - a3 * sin(q3) * sin(q2) * cos(q1) + cos(q1) * a2 * cos(q2);
  equation2 = py == a3* cos(q3) * sin(q1) * cos(q2) - a3 * sin(q3) * sin(q2) * sin(q1) + sin(q1) * a2 * cos(q2);
  equation3 = pz == a3 * cos(q3) * sin(q2) + a3 * sin(q3) * cos(q2) + a2 * sin(q2) + d1;

  simplify(equation3)
  %resolucion = solve(equation1, equation2, equation3, q1, q2, q3);


  end
