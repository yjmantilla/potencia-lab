model circuito2B
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 133e-3)  annotation(
    Placement(visible = true, transformation(origin = {50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 40)  annotation(
    Placement(visible = true, transformation(origin = {-8, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage annotation(
    Placement(visible = true, transformation(origin = {-68, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-20, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sineVoltage.p, resistor.p) annotation(
    Line(points = {{-68, 18}, {-18, 18}}, color = {0, 0, 255}));
  connect(resistor.n, inductor.p) annotation(
    Line(points = {{2, 18}, {23, 18}, {23, 20}, {50, 20}}, color = {0, 0, 255}));
  connect(sineVoltage.n, ground.p) annotation(
    Line(points = {{-68, -2}, {-20, -2}, {-20, -14}}, color = {0, 0, 255}));
  connect(ground.p, inductor.n) annotation(
    Line(points = {{-20, -14}, {50, -14}, {50, 0}}, color = {0, 0, 255}));

annotation(
    uses(Modelica(version = "4.0.0")));
end circuito2B;
