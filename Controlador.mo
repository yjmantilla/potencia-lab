model Controlador
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 350) annotation(
    Placement(visible = true, transformation(origin = {-114, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 89.28e-3) annotation(
    Placement(visible = true, transformation(origin = {-44, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 50e-9) annotation(
    Placement(visible = true, transformation(origin = {-30, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 50) annotation(
    Placement(visible = true, transformation(origin = {-2, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-4, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
    Placement(visible = true, transformation(origin = {-60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(
    Placement(visible = true, transformation(origin = {30, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Add add(k1 = +1, k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {12, 26}, extent = {{-8, -8}, {8, 8}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const(k = 100)  annotation(
    Placement(visible = true, transformation(origin = {-35, 25}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM pwm(constantDutyCycle = 0.2857,f = 20000, useConstantDutyCycle = false)  annotation(
    Placement(visible = true, transformation(origin = {-74, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {56, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch annotation(
    Placement(visible = true, transformation(origin = {72, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 50) annotation(
    Placement(visible = true, transformation(origin = {82, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R = 50) annotation(
    Placement(visible = true, transformation(origin = {118, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanStep booleanStep1(startTime = 0.2) annotation(
    Placement(visible = true, transformation(origin = {94, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1 annotation(
    Placement(visible = true, transformation(origin = {104, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
    Placement(visible = true, transformation(origin = {-76, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI pi(T = 7.2E-5, initType = Modelica.Blocks.Types.Init.NoInit, k = 7.2E-5)  annotation(
    Placement(visible = true, transformation(origin = {12, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(capacitor.n, resistor.n) annotation(
    Line(points = {{-30, -36}, {-16, -36}, {-16, -26}, {-2, -26}}, color = {0, 0, 255}));
  connect(constantVoltage.n, capacitor.n) annotation(
    Line(points = {{-114, -36}, {-30, -36}}, color = {0, 0, 255}));
  connect(ground.p, resistor.n) annotation(
    Line(points = {{-4, -44}, {-4, -40}, {-2, -40}, {-2, -26}}, color = {0, 0, 255}));
  connect(resistor.p, inductor.n) annotation(
    Line(points = {{-2, -6}, {-2, 6}, {-34, 6}}, color = {0, 0, 255}));
  connect(capacitor.p, inductor.n) annotation(
    Line(points = {{-30, -16}, {-30, -5}, {-34, -5}, {-34, 6}}, color = {0, 0, 255}));
  connect(diode.p, constantVoltage.n) annotation(
    Line(points = {{-60, -30}, {-86, -30}, {-86, -36}, {-114, -36}}, color = {0, 0, 255}));
  connect(inductor.p, diode.n) annotation(
    Line(points = {{-54, 6}, {-54, -1}, {-60, -1}, {-60, -10}}, color = {0, 0, 255}));
  connect(voltageSensor.p, resistor.p) annotation(
    Line(points = {{30, -8}, {30, 6}, {-2, 6}, {-2, -6}}, color = {0, 0, 255}));
  connect(voltageSensor.n, resistor.n) annotation(
    Line(points = {{30, -28}, {30, -40}, {-2, -40}, {-2, -26}}, color = {0, 0, 255}));
  connect(voltageSensor.v, add.u2) annotation(
    Line(points = {{19, -18}, {16, -18}, {16, 16}}, color = {0, 0, 127}));
  connect(add.u1, const.y) annotation(
    Line(points = {{8, 16}, {6, 16}, {6, 10}, {-16, 10}, {-16, 26}, {-30, 26}}, color = {0, 0, 127}));
  connect(idealClosingSwitch.p, voltageSensor.p) annotation(
    Line(points = {{62, 6}, {62, -8}, {30, -8}}, color = {0, 0, 255}));
  connect(resistor1.n, voltageSensor.n) annotation(
    Line(points = {{82, -30}, {82, -40}, {30, -40}, {30, -28}}, color = {0, 0, 255}));
  connect(resistor1.p, idealClosingSwitch.n) annotation(
    Line(points = {{82, -10}, {82, 6}}, color = {0, 0, 255}));
  connect(booleanStep.y, idealClosingSwitch.control) annotation(
    Line(points = {{68, 48}, {72, 48}, {72, 18}}, color = {255, 0, 255}));
  connect(switch1.n, resistor2.p) annotation(
    Line(points = {{114, 6}, {114, -1}, {118, -1}, {118, -10}}, color = {0, 0, 255}));
  connect(resistor2.n, resistor1.n) annotation(
    Line(points = {{118, -30}, {118, -40}, {82, -40}, {82, -30}}, color = {0, 0, 255}));
  connect(switch1.p, idealClosingSwitch.n) annotation(
    Line(points = {{94, 6}, {82, 6}}, color = {0, 0, 255}));
  connect(booleanStep1.y, switch1.control) annotation(
    Line(points = {{106, 48}, {104, 48}, {104, 18}}, color = {255, 0, 255}));
  connect(switch.p, constantVoltage.p) annotation(
    Line(points = {{-86, 8}, {-86, -5}, {-114, -5}, {-114, -16}}, color = {0, 0, 255}));
  connect(inductor.p, switch.n) annotation(
    Line(points = {{-54, 6}, {-54, 8}, {-66, 8}}, color = {0, 0, 255}));
  connect(pwm.fire, switch.control) annotation(
    Line(points = {{-68, 43}, {-68, 32.5}, {-76, 32.5}, {-76, 20}}, color = {255, 0, 255}));
  connect(pi.u, add.y) annotation(
    Line(points = {{12, 50}, {12, 34}}, color = {0, 0, 127}));
  connect(pwm.dutyCycle, pi.y) annotation(
    Line(points = {{-62, 54}, {-14, 54}, {-14, 78}, {12, 78}, {12, 74}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "");
end Controlador;
