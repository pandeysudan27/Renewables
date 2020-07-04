within Renewables.Components.HydroPlants;
model HydroSimple
  "This is a simple hydro unit containing only turbine model."
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
  OpenHPL.Waterway.Reservoir reservoir(H_r=H_n)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  OpenHPL.Waterway.Reservoir tailwater(H_r=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,-10})));
  Modelica.Blocks.Interfaces.RealInput u_t
    "[Guide vane|nozzle] opening of the turbine"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput P_out "Mechanical Output power"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(turbine.i, reservoir.o) annotation (Line(points={{-40,20},{-50,20},{
          -50,50},{-60,50}}, color={28,108,200}));
  connect(turbine.o, tailwater.o) annotation (Line(points={{-20,20},{0,20},{0,
          -10},{20,-10}}, color={28,108,200}));
  connect(turbine.u_t, u_t) annotation (Line(points={{-30,32},{-30,72},{-88,72},
          {-88,0},{-120,0}}, color={0,0,127}));
  connect(turbine.P_out, P_out) annotation (Line(points={{-30,9},{-28,9},{-28,
          -64},{64,-64},{64,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-74,-66},{84,84}}, fileName="modelica://Renewables/Resources/Images/HydroPlants.svg"),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
        Text(lineColor={28,108,200},
          extent={{-148,-68},{152,-108}},
          textStyle={TextStyle.Bold},
          textString="%name
")}),                                                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HydroSimple;
