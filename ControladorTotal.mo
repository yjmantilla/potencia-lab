model Controlador  
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 350);
  Modelica.Electrical.Analog.Basic.Inductor inductor(L = 89.28e-3);
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 50e-9);
  Modelica.Electrical.Analog.Basic.Resistor resistor(R = 50);
  Modelica.Electrical.Analog.Basic.Ground ground;
  Modelica.Electrical.Analog.Ideal.IdealDiode diode;
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch;
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor;
  Modelica.Blocks.Math.Add add(k1 = -1);
  Modelica.Blocks.Sources.Constant const(k = 100);
  Modelica.Blocks.Continuous.PI pi(T = 7.2E-5, k = 7.2E-5);
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM pwm(f = 20000, useConstantDutyCycle = false);
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 0.02);
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch;
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R = 50);
equation
  connect(capacitor.n, resistor.n);
  connect(constantVoltage.n, capacitor.n);
  connect(ground.p, resistor.n);
  connect(resistor.p, inductor.n);
  connect(capacitor.p, inductor.n);
  connect(diode.p, constantVoltage.n);
  connect(inductor.p, diode.n);
  connect(switch.p, constantVoltage.p);
  connect(inductor.p, switch.n);
  connect(voltageSensor.p, resistor.p);
  connect(voltageSensor.n, resistor.n);
  connect(add.y, pi.u);
  connect(pwm.notFire, switch.control);
  connect(voltageSensor.v, add.u2);
  connect(pi.y, pwm.dutyCycle);
  connect(add.u1, const.y);
  connect(idealClosingSwitch.p, voltageSensor.p);
  connect(resistor1.n, voltageSensor.n);
  connect(resistor1.p, idealClosingSwitch.n);
  connect(booleanStep.y, idealClosingSwitch.control);
end Controlador;

package ModelicaServices  "ModelicaServices (OpenModelica implementation) - Models and functions used in the Modelica Standard Library requiring a tool specific implementation" 
  extends Modelica.Icons.Package;

  package Machine  "Machine dependent constants" 
    extends Modelica.Icons.Package;
    final constant Real eps = 1e-15 "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = 1e-60 "Smallest number such that small and -small are representable on the machine";
    final constant Real inf = 1e60 "Biggest Real number such that inf and -inf are representable on the machine";
    final constant Integer Integer_inf = OpenModelica.Internal.Architecture.integerMax() "Biggest Integer number such that Integer_inf and -Integer_inf are representable on the machine";
  end Machine;
  annotation(version = "4.0.0", versionDate = "2020-06-04", dateModified = "2020-06-04 11:00:00Z"); 
end ModelicaServices;

package Modelica  "Modelica Standard Library - Version 4.0.0" 
  extends Modelica.Icons.Package;

  package Blocks  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)" 
    extends Modelica.Icons.Package;
    import Modelica.Units.SI;

    package Continuous  "Library of continuous control blocks with internal states" 
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.Package;

      block PI  "Proportional-Integral controller" 
        import Modelica.Blocks.Types.Init;
        parameter Real k(unit = "1") = 1 "Gain";
        parameter SI.Time T(start = 1, min = Modelica.Constants.small) "Time Constant (T>0 required)";
        parameter Init initType = Init.NoInit "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation(Evaluate = true);
        parameter Real x_start = 0 "Initial or guess value of state";
        parameter Real y_start = 0 "Initial value of output";
        extends Interfaces.SISO;
        output Real x(start = x_start) "State of block";
      initial equation
        if initType == Init.SteadyState then
          der(x) = 0;
        elseif initType == Init.InitialState then
          x = x_start;
        elseif initType == Init.InitialOutput then
          y = y_start;
        end if;
      equation
        der(x) = u / T;
        y = k * (x + u);
      end PI;
    end Continuous;

    package Discrete  "Library of discrete input/output blocks with fixed sample period" 
      extends Modelica.Icons.Package;

      block ZeroOrderHold  "Zero order hold of a sampled-data system" 
        extends Interfaces.DiscreteSISO;
        output Real ySample(start = 0, fixed = true);
      equation
        when {sampleTrigger, initial()} then
          ySample = u;
        end when;
        y = pre(ySample);
      end ZeroOrderHold;
    end Discrete;

    package Interfaces  "Library of connectors and partial models for input/output blocks" 
      extends Modelica.Icons.InterfacesPackage;
      connector RealInput = input Real "'input Real' as connector";
      connector RealOutput = output Real "'output Real' as connector";
      connector BooleanInput = input Boolean "'input Boolean' as connector";
      connector BooleanOutput = output Boolean "'output Boolean' as connector";

      partial block SO  "Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealOutput y "Connector of Real output signal";
      end SO;

      partial block SISO  "Single Input Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealInput u "Connector of Real input signal";
        RealOutput y "Connector of Real output signal";
      end SISO;

      partial block SI2SO  "2 Single Input / 1 Single Output continuous control block" 
        extends Modelica.Blocks.Icons.Block;
        RealInput u1 "Connector of Real input signal 1";
        RealInput u2 "Connector of Real input signal 2";
        RealOutput y "Connector of Real output signal";
      end SI2SO;

      partial block SignalSource  "Base class for continuous signal source" 
        extends SO;
        parameter Real offset = 0 "Offset of output signal y";
        parameter SI.Time startTime = 0 "Output y = offset for time < startTime";
      end SignalSource;

      partial block DiscreteBlock  "Base class of discrete control blocks" 
        extends Modelica.Blocks.Icons.DiscreteBlock;
        parameter SI.Time samplePeriod(min = 100 * Modelica.Constants.eps, start = 0.1) "Sample period of component";
        parameter SI.Time startTime = 0 "First sample time instant";
      protected
        output Boolean sampleTrigger "True, if sample time instant";
        output Boolean firstTrigger(start = false, fixed = true) "Rising edge signals first sample instant";
      equation
        sampleTrigger = sample(startTime, samplePeriod);
        when sampleTrigger then
          firstTrigger = time <= startTime + samplePeriod / 2;
        end when;
      end DiscreteBlock;

      partial block DiscreteSISO  "Single Input Single Output discrete control block" 
        extends DiscreteBlock;
        Modelica.Blocks.Interfaces.RealInput u "Connector of Real input signal";
        Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal";
      end DiscreteSISO;

      partial block partialBooleanSISO  "Partial block with 1 input and 1 output Boolean signal" 
        extends Modelica.Blocks.Icons.PartialBooleanBlock;
        Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal";
        Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal";
      end partialBooleanSISO;

      partial block partialBooleanSource  "Partial source block (has 1 output Boolean signal and an appropriate default icon)" 
        extends Modelica.Blocks.Icons.PartialBooleanBlock;
        Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal";
      end partialBooleanSource;

      partial block partialBooleanComparison  "Partial block with 2 Real input and 1 Boolean output signal (the result of a comparison of the two Real inputs)" 
        Blocks.Interfaces.RealInput u1 "Connector of first Real input signal";
        Blocks.Interfaces.RealInput u2 "Connector of second Real input signal";
        Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal";
      end partialBooleanComparison;
    end Interfaces;

    package Logical  "Library of components with Boolean input and output signals" 
      extends Modelica.Icons.Package;

      block Not  "Logical 'not': y = not u" 
        extends Blocks.Interfaces.partialBooleanSISO;
      equation
        y = not u;
      end Not;

      block Less  "Output y is true, if input u1 is less than input u2" 
        extends Blocks.Interfaces.partialBooleanComparison;
      equation
        y = u1 < u2;
      end Less;
    end Logical;

    package Math  "Library of Real mathematical functions as input/output blocks" 
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.Package;

      block Add  "Output the sum of the two inputs" 
        extends Interfaces.SI2SO;
        parameter Real k1 = +1 "Gain of input signal 1";
        parameter Real k2 = +1 "Gain of input signal 2";
      equation
        y = k1 * u1 + k2 * u2;
      end Add;
    end Math;

    package Nonlinear  "Library of discontinuous or non-differentiable algebraic control blocks" 
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.Package;

      block Limiter  "Limit the range of a signal" 
        parameter Real uMax(start = 1) "Upper limits of input signals";
        parameter Real uMin = -uMax "Lower limits of input signals";
        parameter Boolean strict = false "= true, if strict limits with noEvent(..)" annotation(Evaluate = true);
        parameter Types.LimiterHomotopy homotopyType = Modelica.Blocks.Types.LimiterHomotopy.Linear "Simplified model for homotopy-based initialization" annotation(Evaluate = true);
        extends Interfaces.SISO;
      protected
        Real simplifiedExpr "Simplified expression for homotopy-based initialization";
      equation
        assert(uMax >= uMin, "Limiter: Limits must be consistent. However, uMax (=" + String(uMax) + ") < uMin (=" + String(uMin) + ")");
        simplifiedExpr = if homotopyType == Types.LimiterHomotopy.Linear then u else if homotopyType == Types.LimiterHomotopy.UpperLimit then uMax else if homotopyType == Types.LimiterHomotopy.LowerLimit then uMin else 0;
        if strict then
          if homotopyType == Types.LimiterHomotopy.NoHomotopy then
            y = smooth(0, noEvent(if u > uMax then uMax else if u < uMin then uMin else u));
          else
            y = homotopy(actual = smooth(0, noEvent(if u > uMax then uMax else if u < uMin then uMin else u)), simplified = simplifiedExpr);
          end if;
        else
          if homotopyType == Types.LimiterHomotopy.NoHomotopy then
            y = smooth(0, if u > uMax then uMax else if u < uMin then uMin else u);
          else
            y = homotopy(actual = smooth(0, if u > uMax then uMax else if u < uMin then uMin else u), simplified = simplifiedExpr);
          end if;
        end if;
      end Limiter;
    end Nonlinear;

    package Sources  "Library of signal source blocks generating Real, Integer and Boolean signals" 
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.SourcesPackage;

      block Constant  "Generate constant signal of type Real" 
        parameter Real k(start = 1) "Constant output value";
        extends Interfaces.SO;
      equation
        y = k;
      end Constant;

      block SawTooth  "Generate saw tooth signal" 
        parameter Real amplitude = 1 "Amplitude of saw tooth";
        parameter SI.Time period(final min = Modelica.Constants.small, start = 1) "Time for one period";
        parameter Integer nperiod = -1 "Number of periods (< 0 means infinite number of periods)";
        extends Interfaces.SignalSource;
      protected
        SI.Time T_start(final start = startTime) "Start time of current period";
        Integer count "Period count";
      initial algorithm
        count := integer((time - startTime) / period);
        T_start := startTime + count * period;
      equation
        when integer((time - startTime) / period) > pre(count) then
          count = pre(count) + 1;
          T_start = time;
        end when;
        y = offset + (if time < startTime or nperiod == 0 or nperiod > 0 and count >= nperiod then 0 else amplitude * (time - T_start) / period);
      end SawTooth;

      block BooleanStep  "Generate step signal of type Boolean" 
        parameter SI.Time startTime = 0 "Time instant of step start";
        parameter Boolean startValue = false "Output before startTime";
        extends Interfaces.partialBooleanSource;
      equation
        y = if time >= startTime then not startValue else startValue;
      end BooleanStep;
    end Sources;

    package Types  "Library of constants, external objects and types with choices, especially to build menus" 
      extends Modelica.Icons.TypesPackage;
      type Init = enumeration(NoInit "No initialization (start values are used as guess values with fixed=false)", SteadyState "Steady state initialization (derivatives of states are zero)", InitialState "Initialization with initial states", InitialOutput "Initialization with initial outputs (and steady state of the states if possible)") "Enumeration defining initialization of a block" annotation(Evaluate = true);
      type LimiterHomotopy = enumeration(NoHomotopy "Homotopy is not used", Linear "Simplified model without limits", UpperLimit "Simplified model fixed at upper limit", LowerLimit "Simplified model fixed at lower limit") "Enumeration defining use of homotopy in limiter components" annotation(Evaluate = true);
    end Types;

    package Icons  "Icons for Blocks" 
      extends Modelica.Icons.IconsPackage;

      partial block Block  "Basic graphical layout of input/output block" end Block;

      partial block DiscreteBlock  "Graphical layout of discrete block component icon" end DiscreteBlock;

      partial block PartialBooleanBlock  "Basic graphical layout of logical block" end PartialBooleanBlock;
    end Icons;
  end Blocks;

  package Electrical  "Library of electrical models (analog, digital, machines, polyphase)" 
    extends Modelica.Icons.Package;
    import Modelica.Units.SI;

    package Analog  "Library for analog electrical models" 
      extends Modelica.Icons.Package;

      package Basic  "Basic electrical components" 
        extends Modelica.Icons.Package;

        model Ground  "Ground node" 
          Interfaces.Pin p;
        equation
          p.v = 0;
        end Ground;

        model Resistor  "Ideal linear electrical resistor" 
          parameter SI.Resistance R(start = 1) "Resistance at temperature T_ref";
          parameter SI.Temperature T_ref = 300.15 "Reference temperature";
          parameter SI.LinearTemperatureCoefficient alpha = 0 "Temperature coefficient of resistance (R_actual = R*(1 + alpha*(T_heatPort - T_ref))";
          extends Modelica.Electrical.Analog.Interfaces.OnePort;
          extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
          SI.Resistance R_actual "Actual resistance = R*(1 + alpha*(T_heatPort - T_ref))";
        equation
          assert(1 + alpha * (T_heatPort - T_ref) >= Modelica.Constants.eps, "Temperature outside scope of model!");
          R_actual = R * (1 + alpha * (T_heatPort - T_ref));
          v = R_actual * i;
          LossPower = v * i;
        end Resistor;

        model Capacitor  "Ideal linear electrical capacitor" 
          extends Interfaces.OnePort(v(start = 0));
          parameter SI.Capacitance C(start = 1) "Capacitance";
        equation
          i = C * der(v);
        end Capacitor;

        model Inductor  "Ideal linear electrical inductor" 
          extends Interfaces.OnePort(i(start = 0));
          parameter SI.Inductance L(start = 1) "Inductance";
        equation
          L * der(i) = v;
        end Inductor;
      end Basic;

      package Ideal  "Ideal electrical elements such as switches, diode, transformer, operational amplifier" 
        extends Modelica.Icons.Package;

        model IdealDiode  "Ideal diode" 
          extends Modelica.Electrical.Analog.Interfaces.IdealSemiconductor;
        equation
          off = s < 0;
        end IdealDiode;

        model IdealClosingSwitch  "Ideal electrical closer" 
          extends Modelica.Electrical.Analog.Interfaces.IdealSwitch;
          Modelica.Blocks.Interfaces.BooleanInput control "true => p--n connected, false => switch open";
        equation
          off = not control;
        end IdealClosingSwitch;
      end Ideal;

      package Interfaces  "Connectors and partial models for Analog electrical components" 
        extends Modelica.Icons.InterfacesPackage;

        connector Pin  "Pin of an electrical component" 
          SI.ElectricPotential v "Potential at the pin" annotation(unassignedMessage = "An electrical potential cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
          flow SI.Current i "Current flowing into the pin" annotation(unassignedMessage = "An electrical current cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
        end Pin;

        connector PositivePin  "Positive pin of an electrical component" 
          SI.ElectricPotential v "Potential at the pin" annotation(unassignedMessage = "An electrical potential cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
          flow SI.Current i "Current flowing into the pin" annotation(unassignedMessage = "An electrical current cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
        end PositivePin;

        connector NegativePin  "Negative pin of an electrical component" 
          SI.ElectricPotential v "Potential at the pin" annotation(unassignedMessage = "An electrical potential cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
          flow SI.Current i "Current flowing into the pin" annotation(unassignedMessage = "An electrical current cannot be uniquely calculated.
        The reason could be that
        - a ground object is missing (Modelica.Electrical.Analog.Basic.Ground)
          to define the zero potential of the electrical circuit, or
        - a connector of an electrical component is not connected.");
        end NegativePin;

        partial model TwoPin  "Component with two electrical pins" 
          SI.Voltage v "Voltage drop of the two pins (= p.v - n.v)";
          PositivePin p "Positive electrical pin";
          NegativePin n "Negative electrical pin";
        equation
          v = p.v - n.v;
        end TwoPin;

        partial model OnePort  "Component with two electrical pins p and n and current i from p to n" 
          extends TwoPin;
          SI.Current i "Current flowing from pin p to pin n";
        equation
          0 = p.i + n.i;
          i = p.i;
        end OnePort;

        partial model ConditionalHeatPort  "Partial model to include a conditional HeatPort in order to describe the power loss via a thermal network" 
          parameter Boolean useHeatPort = false "= true, if heatPort is enabled" annotation(Evaluate = true, HideResult = true);
          parameter SI.Temperature T = 293.15 "Fixed device temperature if useHeatPort = false";
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final T = T_heatPort, final Q_flow = -LossPower) if useHeatPort "Conditional heat port";
          SI.Power LossPower "Loss power leaving component via heatPort";
          SI.Temperature T_heatPort "Temperature of heatPort";
        equation
          if not useHeatPort then
            T_heatPort = T;
          end if;
        end ConditionalHeatPort;

        partial model IdealSemiconductor  "Ideal semiconductor" 
          extends Modelica.Electrical.Analog.Interfaces.OnePort;
          parameter SI.Resistance Ron(final min = 0) = 1e-5 "Forward state-on differential resistance (closed resistance)";
          parameter SI.Conductance Goff(final min = 0) = 1e-5 "Backward state-off conductance (opened conductance)";
          parameter SI.Voltage Vknee(final min = 0) = 0 "Forward threshold voltage";
          extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort;
          Boolean off(start = true) "Switching state";
        protected
          Real s(start = 0, final unit = "1") "Auxiliary variable for actual position on the ideal diode characteristic";
          constant SI.Voltage unitVoltage = 1 annotation(HideResult = true);
          constant SI.Current unitCurrent = 1 annotation(HideResult = true);
        equation
          v = s * unitCurrent * (if off then 1 else Ron) + Vknee;
          i = s * unitVoltage * (if off then Goff else 1) + Goff * Vknee;
          LossPower = v * i;
        end IdealSemiconductor;

        partial model IdealSwitch  "Ideal electrical switch" 
          extends Modelica.Electrical.Analog.Interfaces.OnePort;
          parameter SI.Resistance Ron(final min = 0) = 1e-5 "Closed switch resistance";
          parameter SI.Conductance Goff(final min = 0) = 1e-5 "Opened switch conductance";
          extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T = 293.15);
        protected
          Boolean off "Indicates off-state";
          Real s(final unit = "1") "Auxiliary variable";
          constant SI.Voltage unitVoltage = 1 annotation(HideResult = true);
          constant SI.Current unitCurrent = 1 annotation(HideResult = true);
        equation
          v = s * unitCurrent * (if off then 1 else Ron);
          i = s * unitVoltage * (if off then Goff else 1);
          LossPower = v * i;
        end IdealSwitch;
      end Interfaces;

      package Sensors  "Potential, voltage, current, and power sensors" 
        extends Modelica.Icons.SensorsPackage;

        model VoltageSensor  "Sensor to measure the voltage between two pins" 
          extends Modelica.Icons.RoundSensor;
          Interfaces.PositivePin p "Positive pin";
          Interfaces.NegativePin n "Negative pin";
          Modelica.Blocks.Interfaces.RealOutput v(unit = "V") "Voltage between pin p and n (= p.v - n.v) as output signal";
        equation
          p.i = 0;
          n.i = 0;
          v = p.v - n.v;
        end VoltageSensor;
      end Sensors;

      package Sources  "Time-dependent and controlled voltage and current sources" 
        extends Modelica.Icons.SourcesPackage;

        model ConstantVoltage  "Source for constant voltage" 
          parameter SI.Voltage V(start = 1) "Value of constant voltage";
          extends Interfaces.OnePort;
          extends Modelica.Electrical.Analog.Icons.VoltageSource;
        equation
          v = V;
        end ConstantVoltage;
      end Sources;

      package Icons  "Icons for analog electrical models" 
        extends Modelica.Icons.IconsPackage;

        partial model VoltageSource  "Icon for voltage sources" end VoltageSource;
      end Icons;
    end Analog;

    package PowerConverters  "Rectifiers, Inverters, DC/DC and AC/AC converters" 
      extends Modelica.Icons.Package;

      package DCDC  "DC to DC converters" 
        extends Modelica.Icons.Package;

        package Control  "Control components for DC to DC converters" 
          extends Modelica.Icons.Package;

          model SignalPWM  "Generates a pulse width modulated (PWM) boolean fire signal" 
            extends Icons.Control;
            parameter Boolean useConstantDutyCycle = true "Enables constant duty cycle";
            parameter Real constantDutyCycle = 0 "Constant duty cycle";
            parameter SI.Frequency f = 1000 "Switching frequency";
            parameter SI.Time startTime = 0 "Start time";
            Modelica.Blocks.Interfaces.RealInput dutyCycle if not useConstantDutyCycle "Duty cycle";
            Modelica.Blocks.Interfaces.BooleanOutput fire "Firing PWM signal";
            Modelica.Blocks.Interfaces.BooleanOutput notFire "Firing PWM signal";
            Modelica.Blocks.Sources.Constant const(final k = constantDutyCycle) if useConstantDutyCycle;
            Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1, uMin = 0);
            Modelica.Blocks.Logical.Less greaterEqual;
            Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(final startTime = startTime, final samplePeriod = 1 / f);
            Modelica.Blocks.Sources.SawTooth sawtooth(final period = 1 / f, final amplitude = 1, final nperiod = -1, final offset = 0, final startTime = startTime);
            Modelica.Blocks.Logical.Not inverse;
          equation
            connect(const.y, limiter.u);
            connect(dutyCycle, limiter.u);
            connect(limiter.y, zeroOrderHold.u);
            connect(zeroOrderHold.y, greaterEqual.u2);
            connect(sawtooth.y, greaterEqual.u1);
            connect(greaterEqual.y, inverse.u);
            connect(greaterEqual.y, fire);
            connect(inverse.y, notFire);
          end SignalPWM;
        end Control;
      end DCDC;

      package Icons  "Icons" 
        extends Modelica.Icons.Package;

        partial block Control  "Control icon" end Control;
      end Icons;
    end PowerConverters;
  end Electrical;

  package Thermal  "Library of thermal system components to model heat transfer and simple thermo-fluid pipe flow" 
    extends Modelica.Icons.Package;
    import Modelica.Units.SI;

    package HeatTransfer  "Library of 1-dimensional heat transfer with lumped elements" 
      extends Modelica.Icons.Package;

      package Interfaces  "Connectors and partial models" 
        extends Modelica.Icons.InterfacesPackage;

        partial connector HeatPort  "Thermal port for 1-dim. heat transfer" 
          SI.Temperature T "Port temperature";
          flow SI.HeatFlowRate Q_flow "Heat flow rate (positive if flowing from outside into the component)";
        end HeatPort;

        connector HeatPort_a  "Thermal port for 1-dim. heat transfer (filled rectangular icon)" 
          extends HeatPort;
        end HeatPort_a;
      end Interfaces;
    end HeatTransfer;
  end Thermal;

  package Math  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices" 
    extends Modelica.Icons.Package;

    package Icons  "Icons for Math" 
      extends Modelica.Icons.IconsPackage;

      partial function AxisCenter  "Basic icon for mathematical function with y-axis in the center" end AxisCenter;
    end Icons;

    function asin  "Inverse sine (-1 <= u <= 1)" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u "Independent variable";
      output Modelica.Units.SI.Angle y "Dependent variable y=asin(u)";
      external "builtin" y = asin(u);
    end asin;

    function exp  "Exponential, base e" 
      extends Modelica.Math.Icons.AxisCenter;
      input Real u "Independent variable";
      output Real y "Dependent variable y=exp(u)";
      external "builtin" y = exp(u);
    end exp;
  end Math;

  package Constants  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)" 
    extends Modelica.Icons.Package;
    import Modelica.Units.SI;
    import Modelica.Units.NonSI;
    final constant Real pi = 2 * Modelica.Math.asin(1.0);
    final constant Real eps = ModelicaServices.Machine.eps "Biggest number such that 1.0 + eps = 1.0";
    final constant Real small = ModelicaServices.Machine.small "Smallest number such that small and -small are representable on the machine";
    final constant SI.Velocity c = 299792458 "Speed of light in vacuum";
    final constant SI.ElectricCharge q = 1.602176634e-19 "Elementary charge";
    final constant Real h(final unit = "J.s") = 6.62607015e-34 "Planck constant";
    final constant Real k(final unit = "J/K") = 1.380649e-23 "Boltzmann constant";
    final constant Real N_A(final unit = "1/mol") = 6.02214076e23 "Avogadro constant";
    final constant Real mu_0(final unit = "N/A2") = 4 * pi * 1.00000000055e-7 "Magnetic constant";
  end Constants;

  package Icons  "Library of icons" 
    extends Icons.Package;

    partial package Package  "Icon for standard packages" end Package;

    partial package InterfacesPackage  "Icon for packages containing interfaces" 
      extends Modelica.Icons.Package;
    end InterfacesPackage;

    partial package SourcesPackage  "Icon for packages containing sources" 
      extends Modelica.Icons.Package;
    end SourcesPackage;

    partial package SensorsPackage  "Icon for packages containing sensors" 
      extends Modelica.Icons.Package;
    end SensorsPackage;

    partial package TypesPackage  "Icon for packages containing type definitions" 
      extends Modelica.Icons.Package;
    end TypesPackage;

    partial package IconsPackage  "Icon for packages containing icons" 
      extends Modelica.Icons.Package;
    end IconsPackage;

    partial class RoundSensor  "Icon representing a round measurement device" end RoundSensor;
  end Icons;

  package Units  "Library of type and unit definitions" 
    extends Modelica.Icons.Package;

    package SI  "Library of SI unit definitions" 
      extends Modelica.Icons.Package;
      type Angle = Real(final quantity = "Angle", final unit = "rad", displayUnit = "deg");
      type Time = Real(final quantity = "Time", final unit = "s");
      type Velocity = Real(final quantity = "Velocity", final unit = "m/s");
      type Acceleration = Real(final quantity = "Acceleration", final unit = "m/s2");
      type Frequency = Real(final quantity = "Frequency", final unit = "Hz");
      type Power = Real(final quantity = "Power", final unit = "W");
      type ThermodynamicTemperature = Real(final quantity = "ThermodynamicTemperature", final unit = "K", min = 0.0, start = 288.15, nominal = 300, displayUnit = "degC") "Absolute temperature (use type TemperatureDifference for relative temperatures)" annotation(absoluteValue = true);
      type Temperature = ThermodynamicTemperature;
      type LinearTemperatureCoefficient = Real(final quantity = "LinearTemperatureCoefficient", final unit = "1/K");
      type HeatFlowRate = Real(final quantity = "Power", final unit = "W");
      type ElectricCurrent = Real(final quantity = "ElectricCurrent", final unit = "A");
      type Current = ElectricCurrent;
      type ElectricCharge = Real(final quantity = "ElectricCharge", final unit = "C");
      type ElectricPotential = Real(final quantity = "ElectricPotential", final unit = "V");
      type Voltage = ElectricPotential;
      type Capacitance = Real(final quantity = "Capacitance", final unit = "F", min = 0);
      type Inductance = Real(final quantity = "Inductance", final unit = "H");
      type Resistance = Real(final quantity = "Resistance", final unit = "Ohm");
      type Conductance = Real(final quantity = "Conductance", final unit = "S");
      type FaradayConstant = Real(final quantity = "FaradayConstant", final unit = "C/mol");
    end SI;

    package NonSI  "Type definitions of non SI and other units" 
      extends Modelica.Icons.Package;
      type Temperature_degC = Real(final quantity = "ThermodynamicTemperature", final unit = "degC") "Absolute temperature in degree Celsius (for relative temperature use Modelica.Units.SI.TemperatureDifference)" annotation(absoluteValue = true);
    end NonSI;
  end Units;
  annotation(version = "4.0.0", versionDate = "2020-06-04", dateModified = "2020-06-04 11:00:00Z"); 
end Modelica;

model Controlador_total
  extends Controlador;
end Controlador_total;
