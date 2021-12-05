model circuito2
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 40)  annotation(
    Placement(visible = true, transformation(origin = {-10, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {6, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 169.706, f = 60)  annotation(
    Placement(visible = true, transformation(origin = {-52, -22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 133e-3)  annotation(
    Placement(visible = true, transformation(origin = {30, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(sineVoltage.n, ground.p) annotation(
    Line(points = {{-52, -32}, {6, -32}}, color = {0, 0, 255}));
  connect(sineVoltage.p, resistor.p) annotation(
    Line(points = {{-52, -12}, {-20, -12}}, color = {0, 0, 255}));
  connect(resistor.n, inductor.p) annotation(
    Line(points = {{0, -12}, {14, -12}, {14, -2}, {30, -2}, {30, -8}}, color = {0, 0, 255}));
  connect(ground.p, inductor.n) annotation(
    Line(points = {{6, -32}, {30, -32}, {30, -28}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end circuito2;
