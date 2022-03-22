model p25feb
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
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
    Placement(visible = true, transformation(origin = {-76, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(
    Placement(visible = true, transformation(origin = {18, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Add add(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {12, 26}, extent = {{-8, -8}, {8, 8}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const(k = 100)  annotation(
    Placement(visible = true, transformation(origin = {-13, 17}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI pi(T = 0.0011, k = 0.0782826)  annotation(
    Placement(visible = true, transformation(origin = {12, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM pwm(constantDutyCycle = 0,f = 20000, useConstantDutyCycle = false)  annotation(
    Placement(visible = true, transformation(origin = {-54, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
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
  connect(switch.p, constantVoltage.p) annotation(
    Line(points = {{-86, 8}, {-86, -20}}, color = {0, 0, 255}));
  connect(inductor.p, switch.n) annotation(
    Line(points = {{-56, 6}, {-60, 6}, {-60, 8}, {-66, 8}}, color = {0, 0, 255}));
  connect(voltageSensor.p, resistor.p) annotation(
    Line(points = {{18, -4}, {18, 6}, {-6, 6}, {-6, -6}}, color = {0, 0, 255}));
  connect(voltageSensor.n, resistor.n) annotation(
    Line(points = {{18, -24}, {18, -38}, {-6, -38}, {-6, -26}}, color = {0, 0, 255}));
  connect(voltageSensor.v, add.u2) annotation(
    Line(points = {{8, -14}, {8, 4}, {17, 4}, {17, 16}}, color = {0, 0, 127}));
  connect(const.y, add.u1) annotation(
    Line(points = {{-7.5, 17}, {-2.5, 17}, {-2.5, 16}, {7, 16}}, color = {0, 0, 127}));
  connect(add.y, pi.u) annotation(
    Line(points = {{12, 34}, {12, 44}}, color = {0, 0, 127}));
  connect(pi.y, pwm.dutyCycle) annotation(
    Line(points = {{12, 68}, {-42, 68}, {-42, 48}}, color = {0, 0, 127}));
  connect(pwm.notFire, switch.control) annotation(
    Line(points = {{-60, 38}, {-76, 38}, {-76, 20}}, color = {255, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end p25feb;
