%% verificar formulas de Cinematica Directa
function res = verificar()
  i1 = 20;
  i2 = 30;
  i3 = 50;
  d1 = 15;  % distancia desde base hasta eje 2 (en Z)
  a2 = 7;    % longitud del eslabón 2
  a3 = 3;
  q1 = deg2rad(i1 + 90);
  q2 = deg2rad(i2);
  q3 = deg2rad(i3);

  input = [i1,i2,i3];

  resvalida = CinematicaDirecta(input);



  % JUAN: la creación de estas fórmulas se llevó consigo parte de mi alma.
  otraRes(1) = a3* cos(q3) * cos(q1) * cos(q2) - a3 * sin(q3) * sin(q2) * cos(q1) + cos(q1) * a2 * cos(q2);
  otraRes(2) = a3* cos(q3) * sin(q1) * cos(q2) - a3 * sin(q3) * sin(q2) * sin(q1) + sin(q1) * a2 * cos(q2);
  otraRes(3) = a3 * cos(q3) * sin(q2) + a3 * sin(q3) * cos(q2) + a2 * sin(q2) + d1;





  end
