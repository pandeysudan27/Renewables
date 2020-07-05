within Renewables.Examples;
model HydroSimple "This a hydro model with only a turbine unit."
  extends Modelica.Icons.Example;
  Components.HydroPlants.HydroDetailed hydroDetailed(
    H_r=50,
    H_t=5,
    H_i=20,
    L_i=4500,
    Di_i=6,
    Do_i=6,
    H=80,
    L=80,
    D=4,
    h_0=70,
    H_p=4,
    L_p=500,
    Di_p=4,
    Do_p=4,
    H_n=370,
    Vdot_n=40)
    annotation (Placement(transformation(extent={{-62,60},{-42,80}})));
  Components.WindPlants.WindSimple windSimple
    "A simple wind turbine unit of rated capacity of "
    annotation (Placement(transformation(extent={{-20,-24},{0,-4}})));
  Components.SolarPlants.PVSimple pVSimple
    annotation (Placement(transformation(extent={{-20,-64},{0,-44}})));
  Modelica.Blocks.Noise.UniformNoise uniformNoise(
    samplePeriod=100,
    y_min=6,
    y_max=8) annotation (Placement(transformation(extent={{-82,-24},{-62,-4}})));
  Modelica.Blocks.Noise.UniformNoise uniformNoise1(
    samplePeriod=100,
    y_min=800,
    y_max=1100)
    annotation (Placement(transformation(extent={{-80,-64},{-60,-44}})));
  Modelica.Blocks.Math.Gain P_w(k=2000)
    annotation (Placement(transformation(extent={{20,-24},{40,-4}})));
  Modelica.Blocks.Math.Gain P_pv(k=1E9)
    annotation (Placement(transformation(extent={{20,-64},{40,-44}})));
  Modelica.Blocks.Continuous.Filter filter(f_cut=0.0001)
    annotation (Placement(transformation(extent={{-50,-24},{-30,-4}})));
  Modelica.Blocks.Continuous.Filter filter1(f_cut=0.0001)
    annotation (Placement(transformation(extent={{-50,-64},{-30,-44}})));
  Controllers.VarController varController
    annotation (Placement(transformation(extent={{52,60},{72,80}})));
  Modelica.Blocks.Sources.RealExpression H_n(y=hydroDetailed.H_n)
    "Nominal head."
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Blocks.Sources.RealExpression V_dotn(y=hydroDetailed.Vdot_n)
    "Nominal discharge."
    annotation (Placement(transformation(extent={{0,44},{20,64}})));
  Modelica.Blocks.Math.Add3 P_h(k2=-1, k3=-1)
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Blocks.Noise.UniformNoise P_load(
    samplePeriod=100,
    y_min=2200,
    y_max=1800) "Load profile"
    annotation (Placement(transformation(extent={{-80,18},{-60,38}})));
  Modelica.Blocks.Continuous.Filter filter2(f_cut=0.0001)
    annotation (Placement(transformation(extent={{-50,18},{-30,38}})));
equation
  connect(windSimple.P_w, P_w.u)
    annotation (Line(points={{1,-14},{18,-14}}, color={0,0,127}));
  connect(pVSimple.P_pv, P_pv.u)
    annotation (Line(points={{1,-54},{18,-54}}, color={0,0,127}));
  connect(uniformNoise.y, filter.u)
    annotation (Line(points={{-61,-14},{-52,-14}}, color={0,0,127}));
  connect(windSimple.v, filter.y)
    annotation (Line(points={{-22,-14},{-29,-14}}, color={0,0,127}));
  connect(uniformNoise1.y, filter1.u)
    annotation (Line(points={{-59,-54},{-52,-54}}, color={0,0,127}));
  connect(pVSimple.k, filter1.y)
    annotation (Line(points={{-22,-54},{-29,-54}}, color={0,0,127}));
  connect(hydroDetailed.u_v, varController.u_v) annotation (Line(points={{-64,
          70},{-66,70},{-66,96},{92,96},{92,70},{73,70}}, color={0,0,127}));
  connect(H_n.y, varController.H_n)
    annotation (Line(points={{21,70},{50,70}}, color={0,0,127}));
  connect(V_dotn.y, varController.Vdot_n) annotation (Line(points={{21,54},{
          44.5,54},{44.5,62},{50,62}}, color={0,0,127}));
  connect(P_load.y, filter2.u)
    annotation (Line(points={{-59,28},{-52,28}}, color={0,0,127}));
  connect(P_w.y, P_h.u2) annotation (Line(points={{41,-14},{46,-14},{46,-30},{
          58,-30}}, color={0,0,127}));
  connect(P_pv.y, P_h.u3)
    annotation (Line(points={{41,-54},{41,-38},{58,-38}}, color={0,0,127}));
  connect(filter2.y, P_h.u1) annotation (Line(points={{-29,28},{50,28},{50,-22},
          {58,-22}}, color={0,0,127}));
  connect(P_h.y, varController.dP) annotation (Line(points={{81,-30},{94,-30},{
          94,46},{-12,46},{-12,84},{36,84},{36,78},{50,78}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      __Dymola_NumberOfIntervals=50000,
      __Dymola_Algorithm="Dassl"));
end HydroSimple;
