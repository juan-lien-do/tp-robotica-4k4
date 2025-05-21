syms q1 q2 q3
px = 10;
py = 10;
pz = 10;




equation = 300 == 210*sin(q2) + 90*sin(q2 + q3) + 42*cos(q3) + 283;

solve(equation, q2)
