within Renewables.Components.HydroPlants;
model HydroDetailed
  "This is a hydro power plant model with details about resorvoir, intake, surge tank, penstock, turbine and tail water."
  // Resorvoir
  parameter Modelica.SIunits.Height H_r = 50 "Height difference of resorvoir" annotation (
    Dialog(group = "Geometry"));
    // Tailrace
  parameter Modelica.SIunits.Height H_t = 50 "Height difference of tailwater" annotation (
    Dialog(group = "Geometry"));
    // Intake
  parameter Modelica.SIunits.Length H_i = 25 "Height difference of intake" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L_i = 6600 "Length of the intake" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter Di_i = 5.8 "Diameter of the inlet side of intake" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter Do_i = 6 "Diameter of the outlet side of intake" annotation (
    Dialog(group = "Geometry"));
    // surge tank
  parameter Modelica.SIunits.Length H = 80 "Height of the surge tank" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 85 "Length of the surge tank" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D = 4 "Diameter of the surge tank" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Height h_0 = 50 "Initial water level at the surge tank" annotation (
    Dialog(group = "Geometry"));
    //penstock
    parameter Modelica.SIunits.Length H_p = 25 "Height difference of penstock" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L_p = 6600 "Length of the penstock" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter Di_p = 5.8 "Diameter of the inlet side of penstock" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter Do_p = 6 "Diameter of the outlet side of penstock" annotation (
    Dialog(group = "Geometry"));
    //Turbine
  parameter Boolean ValveCapacity =  true "If checked the guide vane capacity C_v should be specified, otherwise specify the nominal turbine parameters (net head and flow rate)" annotation (
    Dialog(group = "Turbine nominal parameters"), choices(checkBox = true));
  parameter Real C_v = 3.7 "Guide vane 'valve capacity'" annotation (
    Dialog(group = "Turbine nominal parameters", enable = ValveCapacity));
  parameter Modelica.SIunits.Height H_n = 460 "Turbine nominal net head" annotation (
    Dialog(group = "Turbine nominal parameters", enable = not ValveCapacity));
  parameter Modelica.SIunits.VolumeFlowRate Vdot_n = 23.4 "Turbine nominal flow rate" annotation (
    Dialog(group = "Turbine nominal parameters", enable = not ValveCapacity));
  parameter Real u_n = 0.95 "Turbine guide vane nominal opening, pu" annotation (
    Dialog(group = "Turbine nominal parameters", enable = not ValveCapacity));

  OpenHPL.ElectroMech.Turbines.Turbine turbine(
    ValveCapacity=false,
    C_v=C_v,
    H_n=H_n,
    Vdot_n=Vdot_n,
    u_n=u_n)
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Interfaces.RealInput u_v "Turbine valve signal" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  OpenHPL.Waterway.Reservoir reservoir(H_r=H_r)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  OpenHPL.Waterway.Reservoir tailwater(H_r=H_t)
                                              annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,10})));
  Modelica.Blocks.Interfaces.RealOutput P_out "Mechanical Output power"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
  OpenHPL.Waterway.Pipe intake(
    H=H_i,
    L=L_i,
    D_i=Di_i,
    D_o=Do_i)
    annotation (Placement(transformation(extent={{-68,60},{-48,80}})));
  OpenHPL.Waterway.SurgeTank surgeTank(
    H=H,
    L=L,
    D=D,
    h_0=h_0)
    annotation (Placement(transformation(extent={{-38,60},{-18,80}})));
  OpenHPL.Waterway.Pipe penstock(
    H=H_p,
    L=L_p,
    D_i=Di_p,
    D_o=Do_p)
    annotation (Placement(transformation(extent={{-64,16},{-44,36}})));
equation
  connect(turbine.o, tailwater.o) annotation (Line(points={{-20,20},{0,20},{0,10},
          {-1.77636e-15,10}}, color={28,108,200}));
  connect(reservoir.o, intake.i)
    annotation (Line(points={{-80,70},{-68,70}}, color={28,108,200}));
  connect(surgeTank.i, intake.o)
    annotation (Line(points={{-38,70},{-48,70}}, color={28,108,200}));
  connect(turbine.i, penstock.o) annotation (Line(points={{-40,20},{-42,20},{-42,
          26},{-44,26}}, color={28,108,200}));
  connect(surgeTank.o, penstock.i) annotation (Line(points={{-18,70},{-16,70},{-16,
          40},{-64,40},{-64,26}}, color={28,108,200}));
  connect(turbine.u_t, u_v) annotation (Line(points={{-30,32},{-30,46},{-82,46},
          {-82,0},{-120,0}}, color={0,0,127}));
  connect(turbine.P_out, P_out) annotation (Line(points={{-30,9},{-30,-10},{64,
          -10},{64,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-74,-66},{84,84}}, fileName="modelica://Renewables/Resources/Images/HydroPlants.svg"),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
        Text(lineColor={28,108,200},
          extent={{-148,-68},{152,-108}},
          textStyle={TextStyle.Bold},
          textString="%name
")}),                                                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HydroDetailed;
