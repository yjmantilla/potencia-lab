model circuito3
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 40)  annotation(
    Placement(visible = true, transformation(origin = {-34, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 49e-6)  annotation(
    Placement(visible = true, transformation(origin = {4, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 133e-3)  annotation(
    Placement(visible = true, transformation(origin = {32, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-4, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V = 169.706, f = 60)  annotation(
    Placement(visible = true, transformation(origin = {-66, -22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(sineVoltage.n, ground.p) annotation(
    Line(points = {{-66, -32}, {-4, -32}, {-4, -40}}, color = {0, 0, 255}));
  connect(sineVoltage.p, resistor.p) annotation(
    Line(points = {{-66, -12}, {-55, -12}, {-55, -8}, {-44, -8}}, color = {0, 0, 255}));
  connect(resistor.n, capacitor.p) annotation(
    Line(points = {{-24, -8}, {-15, -8}, {-15, -12}, {-6, -12}}, color = {0, 0, 255}));
  connect(capacitor.n, inductor.p) annotation(
    Line(points = {{14, -12}, {22, -12}}, color = {0, 0, 255}));
  connect(ground.p, inductor.n) annotation(
    Line(points = {{-4, -40}, {42, -40}, {42, -12}}, color = {0, 0, 255}));

annotation(
    uses(Modelica(version = "4.0.0")));
end circuito3;
