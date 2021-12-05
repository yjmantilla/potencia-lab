model circuito1
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 40)  annotation(
    Placement(visible = true, transformation(origin = {-36, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 49e-6)  annotation(
    Placement(visible = true, transformation(origin = {14, -22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-24, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 169.706, f = 60)  annotation(
    Placement(visible = true, transformation(origin = {-66, -22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(sineVoltage.n, ground.p) annotation(
    Line(points = {{-66, -32}, {-24, -32}, {-24, -44}}, color = {0, 0, 255}));
  connect(sineVoltage.p, resistor.p) annotation(
    Line(points = {{-66, -12}, {-46, -12}, {-46, 2}}, color = {0, 0, 255}));
  connect(resistor.n, capacitor.p) annotation(
    Line(points = {{-26, 2}, {9, 2}, {9, -12}, {14, -12}}, color = {0, 0, 255}));
  connect(capacitor.n, ground.p) annotation(
    Line(points = {{14, -32}, {-24, -32}, {-24, -44}}, color = {0, 0, 255}));

annotation(
    uses(Modelica(version = "4.0.0")));
end circuito1;
