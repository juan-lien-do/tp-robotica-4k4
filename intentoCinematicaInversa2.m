function xd = intentoCinematicaInversa2()
  i1 = 0;
  i2 = 0;
  i3 = 0;
  d1 = 15;  % distancia desde base hasta eje 2 (en Z)
  a2 = 7;    % longitud del eslabón 2
  a3 = 3;

  input = [i1,i2,i3];

  resvalida = CinematicaDirecta(input);


  syms px py pz;
  eq1 = px == resvalida(1,4);
  eq2 = py == resvalida(2,4);
  eq3 = pz == resvalida(3,4);

  syms cq1 cq2 cq3 sq1 sq2 sq3
  xd1 = 1 == cq1 * cq1 + sq1 * sq1;
  xd2 = 1 == cq2 * cq2 + sq2 * sq2;
  xd2 = 1 == cq3 * cq3 + sq3 * sq3;

  syms q1 q2 q3 real

  equation1 = px == a3* cq3 * cq1 * cq2 - a3 * sq3 * sq2 * cq1 + cq1 * a2 * cq2;
  equation2 = py == a3* cq3 * sq1 * cq2 - a3 * sq3 * sq2 * sq1 + sq1 * a2 * cq2;
  equation3 = pz == a3 * cq3 * sq2 + a3 * sq3 * cq2 + a2 * sq2 + d1;

  resolucion = solve(simplify(equation1), simplify(equation2), simplify(equation3), cq1, cq2, cq3);

  simplify(resolucion.cq1)




  end
