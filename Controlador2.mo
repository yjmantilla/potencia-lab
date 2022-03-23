model Controlador2
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 350) annotation(
    Placement(visible = true, transformation(origin = {-86, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 89.28e-3) annotation(
    Placement(visible = true, transformation(origin = {-46, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 50e-9) annotation(
    Placement(visible = true, transformation(origin = {-28, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 50) annotation(
    Placement(visible = true, transformation(origin = {-6, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-6, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
    Placement(visible = true, transformation(origin = {-56, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {56, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch annotation(
    Placement(visible = true, transformation(origin = {72, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 50) annotation(
    Placement(visible = true, transformation(origin = {84, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R = 50) annotation(
    Placement(visible = true, transformation(origin = {116, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanStep booleanStep1(startTime = 0.2) annotation(
    Placement(visible = true, transformation(origin = {94, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1 annotation(
    Placement(visible = true, transformation(origin = {104, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
    Placement(visible = true, transformation(origin = {-76, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period = 1 / 20000, width = 28.57)  annotation(
    Placement(visible = true, transformation(origin = {-104, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(capacitor.n, resistor.n) annotation(
    Line(points = {{-28, -30}, {-28, -38}, {-6, -38}, {-6, -26}}, color = {0, 0, 255}));
  connect(constantVoltage.n, capacitor.n) annotation(
    Line(points = {{-86, -40}, {-28, -40}, {-28, -30}}, color = {0, 0, 255}));
  connect(ground.p, resistor.n) annotation(
    Line(points = {{-6, -44}, {-6, -26}}, color = {0, 0, 255}));
  connect(resistor.p, inductor.n) annotation(
    Line(points = {{-6, -6}, {-6, 6}, {-36, 6}}, color = {0, 0, 255}));
  connect(capacitor.p, inductor.n) annotation(
    Line(points = {{-28, -10}, {-28, 6}, {-36, 6}}, color = {0, 0, 255}));
  connect(diode.p, constantVoltage.n) annotation(
    Line(points = {{-56, -34}, {-70, -34}, {-70, -40}, {-86, -40}}, color = {0, 0, 255}));
  connect(inductor.p, diode.n) annotation(
    Line(points = {{-56, 6}, {-56, -14}}, color = {0, 0, 255}));
  connect(resistor1.p, idealClosingSwitch.n) annotation(
    Line(points = {{84, -6}, {84, 6}, {82, 6}}, color = {0, 0, 255}));
  connect(booleanStep.y, idealClosingSwitch.control) annotation(
    Line(points = {{68, 48}, {72, 48}, {72, 18}}, color = {255, 0, 255}));
  connect(switch1.n, resistor2.p) annotation(
    Line(points = {{114, 6}, {116, 6}, {116, 0}}, color = {0, 0, 255}));
  connect(resistor2.n, resistor1.n) annotation(
    Line(points = {{116, -20}, {116, -40}, {84, -40}, {84, -26}}, color = {0, 0, 255}));
  connect(switch1.p, idealClosingSwitch.n) annotation(
    Line(points = {{94, 6}, {82, 6}}, color = {0, 0, 255}));
  connect(booleanStep1.y, switch1.control) annotation(
    Line(points = {{106, 48}, {104, 48}, {104, 18}}, color = {255, 0, 255}));
  connect(switch.p, constantVoltage.p) annotation(
    Line(points = {{-86, 8}, {-86, -20}}, color = {0, 0, 255}));
  connect(inductor.p, switch.n) annotation(
    Line(points = {{-56, 6}, {-60, 6}, {-60, 8}, {-66, 8}}, color = {0, 0, 255}));
  connect(idealClosingSwitch.p, resistor.p) annotation(
    Line(points = {{62, 6}, {-6, 6}, {-6, -6}}, color = {0, 0, 255}));
  connect(ground.p, resistor1.n) annotation(
    Line(points = {{-6, -44}, {84, -44}, {84, -26}}, color = {0, 0, 255}));
  connect(booleanPulse.y, switch.control) annotation(
    Line(points = {{-93, 48}, {-76, 48}, {-76, 20}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "");
end Controlador2;
