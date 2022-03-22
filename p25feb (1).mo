model p25feb
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 350)  annotation(
    Placement(visible = true, transformation(origin = {-70, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 3e-3)  annotation(
    Placement(visible = true, transformation(origin = {8, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 1e-6)  annotation(
    Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 50)  annotation(
    Placement(visible = true, transformation(origin = {68, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {54, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period = 1 / 20000, width = 28.5)  annotation(
    Placement(visible = true, transformation(origin = {-60, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
    Placement(visible = true, transformation(origin = {-14, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
    Placement(visible = true, transformation(origin = {-40, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(capacitor.n, resistor.n) annotation(
    Line(points = {{40, 10}, {40, -8}, {68, -8}, {68, 10}}, color = {0, 0, 255}));
  connect(constantVoltage.n, capacitor.n) annotation(
    Line(points = {{-70, 4}, {-70, -8}, {40, -8}, {40, 10}}, color = {0, 0, 255}));
  connect(ground.p, resistor.n) annotation(
    Line(points = {{54, -16}, {68, -16}, {68, 10}}, color = {0, 0, 255}));
  connect(resistor.p, inductor.n) annotation(
    Line(points = {{68, 30}, {68, 42}, {18, 42}}, color = {0, 0, 255}));
  connect(capacitor.p, inductor.n) annotation(
    Line(points = {{40, 30}, {40, 42}, {18, 42}}, color = {0, 0, 255}));
  connect(diode.p, constantVoltage.n) annotation(
    Line(points = {{-14, 8}, {-14, -8}, {-70, -8}, {-70, 4}}, color = {0, 0, 255}));
  connect(inductor.p, diode.n) annotation(
    Line(points = {{-2, 42}, {-14, 42}, {-14, 28}}, color = {0, 0, 255}));
  connect(switch.p, constantVoltage.p) annotation(
    Line(points = {{-50, 42}, {-70, 42}, {-70, 24}}, color = {0, 0, 255}));
  connect(inductor.p, switch.n) annotation(
    Line(points = {{-2, 42}, {-30, 42}}, color = {0, 0, 255}));
  connect(booleanPulse.y, switch.control) annotation(
    Line(points = {{-49, 70}, {-40, 70}, {-40, 54}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end p25feb;
