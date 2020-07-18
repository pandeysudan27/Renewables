within Renewables.Examples;
model HydroSimple "This a hydro model with only a turbine unit."
  extends Modelica.Icons.Example;
  Components.WindPlants.WindSimple windSimple
    "A simple wind turbine unit of rated capacity of "
    annotation (Placement(transformation(extent={{-20,-24},{0,-4}})));
  Components.SolarPlants.PVSimple pVSimple
    annotation (Placement(transformation(extent={{-20,-64},{0,-44}})));
  Modelica.Blocks.Noise.UniformNoise uniformNoise(
    samplePeriod=1000,
    y_min=6.9,
    y_max=6.9)
             annotation (Placement(transformation(extent={{-82,-24},{-62,-4}})));
  Modelica.Blocks.Noise.UniformNoise uniformNoise1(
    samplePeriod=1000,
    y_min=1000,
    y_max=1000)
    annotation (Placement(transformation(extent={{-80,-64},{-60,-44}})));
  Modelica.Blocks.Math.Gain P_w(k=1000)
    annotation (Placement(transformation(extent={{20,-24},{40,-4}})));
  Modelica.Blocks.Math.Gain P_pv(k=0.5E9)
    annotation (Placement(transformation(extent={{20,-64},{40,-44}})));
  Modelica.Blocks.Continuous.Filter filter(f_cut=0.0001)
    annotation (Placement(transformation(extent={{-50,-24},{-30,-4}})));
  Modelica.Blocks.Continuous.Filter filter1(f_cut=0.0001)
    annotation (Placement(transformation(extent={{-50,-64},{-30,-44}})));
  Modelica.Blocks.Math.Add3 P_l
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-20,72},{0,92}})));
  Modelica.Blocks.Math.Gain P_h(k=1)
    annotation (Placement(transformation(extent={{24,8},{44,28}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0.01)
    annotation (Placement(transformation(extent={{60,58},{80,78}})));
  Modelica.Blocks.Continuous.PI PI(k=1e-11, T=3e11)
    annotation (Placement(transformation(extent={{26,68},{46,88}})));
  Modelica.Blocks.Sources.RealExpression P_hydro(y=P_w.y)
    annotation (Placement(transformation(extent={{-74,-92},{-54,-72}})));
  Modelica.Blocks.Sources.RealExpression P_hydro1(y=P_pv.y)
    annotation (Placement(transformation(extent={{-72,-106},{-52,-86}})));
  Modelica.Blocks.Sources.RealExpression P_hydro2(y=hydroDetailed.P_out)
    annotation (Placement(transformation(extent={{-22,-88},{-2,-68}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=3)
    annotation (Placement(transformation(extent={{18,-92},{30,-80}})));
  Components.HydroPlants.HydroDetailed hydroDetailed(
    H_r=2075,
    H_t=5,
    H_i=20,
    L_i=4500,
    Di_i=6,
    Do_i=6,
    H=80,
    L=80,
    D=4,
    h_0=70,
    H_p=300,
    L_p=500,
    Di_p=4,
    Do_p=4,
    H_n=2370,
    Vdot_n=40) annotation (Placement(transformation(extent={{-20,8},{0,28}})));
  Modelica.Blocks.Sources.Step step(
    height=0.5e9,
    offset=1e9,
    startTime=1000)
    annotation (Placement(transformation(extent={{-88,64},{-68,84}})));
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
  connect(P_w.y,P_l. u2) annotation (Line(points={{41,-14},{46,-14},{46,-30},{
          58,-30}}, color={0,0,127}));
  connect(P_pv.y,P_l. u3)
    annotation (Line(points={{41,-54},{41,-38},{58,-38}}, color={0,0,127}));
  connect(P_l.y, add.u2) annotation (Line(points={{81,-30},{88,-30},{88,46},{
          -28,46},{-28,76},{-22,76}}, color={0,0,127}));
  connect(P_l.u1, P_h.y) annotation (Line(points={{58,-22},{52,-22},{52,18},{45,
          18}}, color={0,0,127}));
  connect(add.y, PI.u) annotation (Line(points={{1,82},{12,82},{12,78},{24,78}},
        color={0,0,127}));
  connect(limiter.u, PI.y) annotation (Line(points={{58,68},{52,68},{52,78},{47,
          78}}, color={0,0,127}));
  connect(multiSum.u[1], P_hydro2.y) annotation (Line(points={{18,-83.2},{6,
          -83.2},{6,-78},{-1,-78}}, color={0,0,127}));
  connect(P_hydro.y, multiSum.u[2]) annotation (Line(points={{-53,-82},{-18,-82},
          {-18,-86},{18,-86}}, color={0,0,127}));
  connect(P_hydro1.y, multiSum.u[3]) annotation (Line(points={{-51,-96},{-16,
          -96},{-16,-88.8},{18,-88.8}}, color={0,0,127}));
  connect(P_h.u, hydroDetailed.P_out)
    annotation (Line(points={{22,18},{1,18}}, color={0,0,127}));
  connect(limiter.y, hydroDetailed.u_v) annotation (Line(points={{81,68},{82,68},
          {82,34},{-32,34},{-32,18},{-22,18}}, color={0,0,127}));
  connect(add.u1, step.y) annotation (Line(points={{-22,88},{-48,88},{-48,74},{
          -67,74}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      __Dymola_NumberOfIntervals=50000,
      __Dymola_Algorithm="Dassl"));
end HydroSimple;
