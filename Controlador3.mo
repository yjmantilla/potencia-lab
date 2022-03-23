model Controlador3
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 350) annotation(
    Placement(visible = true, transformation(origin = {-86, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 89.28e-3, i(fixed = false, start = 0)) annotation(
    Placement(visible = true, transformation(origin = {-46, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 50e-9, v(fixed = false)) annotation(
    Placement(visible = true, transformation(origin = {-28, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 50) annotation(
    Placement(visible = true, transformation(origin = {52, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {70, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode annotation(
    Placement(visible = true, transformation(origin = {-66, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 0.05)  annotation(
    Placement(visible = true, transformation(origin = {56, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch annotation(
    Placement(visible = true, transformation(origin = {72, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 50) annotation(
    Placement(visible = true, transformation(origin = {84, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R = 50) annotation(
    Placement(visible = true, transformation(origin = {116, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanStep booleanStep1(startTime = 0.06) annotation(
    Placement(visible = true, transformation(origin = {94, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1 annotation(
    Placement(visible = true, transformation(origin = {104, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM pwm( constantDutyCycle = 0.2857,f = 20000, useConstantDutyCycle = false)  annotation(
    Placement(visible = true, transformation(origin = {-90, 65}, extent = {{16, 19}, {-16, -19}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(
    Placement(visible = true, transformation(origin = {14, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Math.Add add(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {21, 41}, extent = {{-9, -9}, {9, 9}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant ref(k = 100)  annotation(
    Placement(visible = true, transformation(origin = {-9, 17}, extent = {{-5, -5}, {5, 5}}, rotation = 90)));
  Modelica.Blocks.Continuous.PI pi(T = 9.7 * 1e-5, initType = Modelica.Blocks.Types.Init.NoInit, k =  1080 * 9.7 * 1e-5)  annotation(
    Placement(visible = true, transformation(origin = {-24, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch annotation(
    Placement(visible = true, transformation(origin = {-76, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(constantVoltage.n, capacitor.n) annotation(
    Line(points = {{-86, -40}, {-28, -40}, {-28, -30}}, color = {0, 0, 255}));
  connect(resistor.p, inductor.n) annotation(
    Line(points = {{52, -8}, {52, 6}, {-36, 6}}, color = {0, 0, 255}));
  connect(capacitor.p, inductor.n) annotation(
    Line(points = {{-28, -10}, {-28, 6}, {-36, 6}}, color = {0, 0, 255}));
  connect(diode.p, constantVoltage.n) annotation(
    Line(points = {{-66, -30}, {-66, -40}, {-86, -40}}, color = {0, 0, 255}));
  connect(resistor1.p, idealClosingSwitch.n) annotation(
    Line(points = {{84, -6}, {84, 6}, {82, 6}}, color = {0, 0, 255}));
  connect(booleanStep.y, idealClosingSwitch.control) annotation(
    Line(points = {{68, 48}, {72, 48}, {72, 18}}, color = {255, 0, 255}));
  connect(switch1.n, resistor2.p) annotation(
    Line(points = {{114, 6}, {116, 6}, {116, -6}}, color = {0, 0, 255}));
  connect(resistor2.n, resistor1.n) annotation(
    Line(points = {{116, -26}, {116, -40}, {84, -40}, {84, -26}}, color = {0, 0, 255}));
  connect(switch1.p, idealClosingSwitch.n) annotation(
    Line(points = {{94, 6}, {82, 6}}, color = {0, 0, 255}));
  connect(booleanStep1.y, switch1.control) annotation(
    Line(points = {{106, 48}, {104, 48}, {104, 18}}, color = {255, 0, 255}));
  connect(ground.p, resistor1.n) annotation(
    Line(points = {{70, -40}, {84, -40}, {84, -26}}, color = {0, 0, 255}));
  connect(idealClosingSwitch.p, resistor.p) annotation(
    Line(points = {{62, 6}, {52, 6}, {52, -8}}, color = {0, 0, 255}));
  connect(add.u1, ref.y) annotation(
    Line(points = {{16, 30}, {16, 25.5}, {-9, 25.5}, {-9, 22.5}}, color = {0, 0, 127}));
  connect(add.y, pi.u) annotation(
    Line(points = {{21, 51}, {-12, 51}, {-12, 76}}, color = {0, 0, 127}));
  connect(pwm.dutyCycle, pi.y) annotation(
    Line(points = {{-70, 66}, {-41.5, 66}, {-41.5, 76}, {-35, 76}}, color = {0, 0, 127}));
  connect(voltageSensor.p, resistor.p) annotation(
    Line(points = {{14, -8}, {52, -8}}, color = {0, 0, 255}));
  connect(voltageSensor.n, resistor.n) annotation(
    Line(points = {{14, -28}, {52, -28}}, color = {0, 0, 255}));
  connect(switch.p, constantVoltage.p) annotation(
    Line(points = {{-86, 6}, {-86, -20}}, color = {0, 0, 255}));
  connect(inductor.p, switch.n) annotation(
    Line(points = {{-56, 6}, {-66, 6}}, color = {0, 0, 255}));
  connect(pwm.notFire, switch.control) annotation(
    Line(points = {{-100, 44}, {-100, 18}, {-76, 18}}, color = {255, 0, 255}));
  connect(add.u2, voltageSensor.v) annotation(
    Line(points = {{26, 30}, {26, 10}, {0, 10}, {0, -18}, {4, -18}}, color = {0, 0, 127}));
  connect(switch.n, diode.n) annotation(
    Line(points = {{-66, 6}, {-66, -10}}, color = {0, 0, 255}));
  connect(resistor.n, ground.p) annotation(
    Line(points = {{52, -28}, {52, -40}, {70, -40}}, color = {0, 0, 255}));
  connect(ground.p, capacitor.n) annotation(
    Line(points = {{70, -40}, {-28, -40}, {-28, -30}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "");
end Controlador3;
