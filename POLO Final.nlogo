globals [time
  parada1x
  parada2x
  parada3x
  parada4x
  parada1y
  parada2y
  parada3y
  parada4y
  reg0x
  reg1x
  reg2x
  reg0y
  reg1y
  reg2y
  cabx
  caby
  espera4e
  espera4o
  espera6e
  espera6o
  esperah17
  esperac17
  esperad20
  esperah20
  last_new_engine_tick
  last_move_tick
]

breed [ pasi pai ]
pasi-own [ saldo compra reg destino disxr0 disxr1 disxr2 disyr0 disyr1 disyr2 disxc disyc disxp1 disyp1 disxp2 disyp2 disxp3 disyp3 disxp4 disyp4 cambio]

breed [ pas pa ]
pas-own [ saldo compra reg destino disxr0 disxr1 disxr2 disyr0 disyr1 disyr2 disxc disyc disxp1 disyp1 disxp2 disyp2 disxp3 disyp3 disxp4 disyp4 cambio]

breed[transms4e transm4e]
transms4e-own [ pasajeros cupo xxp yyp ]

breed[transms4o transm4o]
transms4o-own [ pasajeros cupo xxp yyp ]

breed[transms6e transm6e]
transms6e-own [ pasajeros cupo xxp yyp ]

breed[transms6o transm6o]
transms6o-own [ pasajeros cupo xxp yyp ]

breed[transmsh17 transmh17]
transmsh17-own [ pasajeros cupo xxp yyp ]

breed[transmsc17 transmc17]
transmsc17-own [ pasajeros cupo xxp yyp ]

breed[transmsh20 transmh20]
transmsh20-own [ pasajeros cupo xxp yyp ]

breed[transmsd20 transmd20]
transmsd20-own [ pasajeros cupo xxp yyp ]


to Setup
  clear-all
  estacion
  estacionfuera
  carril
  parada
  registradora
  cabina
  reset-ticks
end

to go
  move-passengers
  move-tm
  cab-reg
  waitbus
  tmllegada
  tick
end

to estacion
  ask patches [ if pycor < 6 and pycor > -6 and pxcor < 31 and pxcor > -18 [ set pcolor gray ] ]
end

to estacionfuera
  ask patches [ if pycor < 6 and pycor > -6 and pxcor < -17 and pxcor > -31 [ set pcolor blue ] ]
end

to parada
  ask patches [ if pycor = 5 and pxcor = 12 [ set pcolor green ] ]
  ask patches [ if pycor = 5 and pxcor = -4 [ set pcolor green ] ]
  ask patches [ if pycor = -5 and pxcor = 12 [ set pcolor green ] ]
  ask patches [ if pycor = -5 and pxcor = -4 [ set pcolor green ] ]
  set parada1x 12
  set parada2x -4
  set parada3x 12
  set parada4x -4
  set parada1y 5
  set parada2y 5
  set parada3y -5
  set parada4y -5
end

to registradora
  ask patches [ if pxcor = -18 and pycor = 3 [ set pcolor red ] ]
  ask patches [ if pxcor = -18 and pycor = 0 [ set pcolor red ] ]
  ask patches [ if pxcor = -18 and pycor = -3 [ set pcolor red ] ]
  set reg0x -18
  set reg0y 3
  set reg1x -18
  set reg1y 0
  set reg2x -18
  set reg2y -3
end

to cabina
  ask patches [ if pycor = -4 and pxcor = -25 [ set pcolor orange ] ]
  set cabx -25
  set caby -4
end

to carril
  ask patches [ if pycor > 5 or pycor < -5 [ set pcolor white ] ]
end

to route-transms4e
  create-transms4e 1
  ask transms4e [ set shape "trnsm2"]
  ask transms4e [ set size 10]
  ask transms4e [set pasajeros pasajeros4e]
  ask transms4e [ set cupo  (250 - pasajeros) ]
  ask transms4e [ setxy 25 7]
  ask transms4e [set heading -90]
  ask transms4e [set xxp -4 set yyp 5]
end

to route-transms4o
  create-transms4o 1
  ask transms4o [ set shape "trnsm"]
  ask transms4o [ set size 10]
  ask transms4o [set pasajeros pasajeros4o]
  ask transms4o [ set cupo  (250 - pasajeros) ]
  ask transms4o [ setxy -25 -7]
  ask transms4o [set heading 90]
  ask transms4o [set xxp -4 set yyp 5]
end

to route-transms6e
  create-transms6e 1
  ask transms6e [ set shape "trnsm2"]
  ask transms6e [ set size 10]
  ask transms6e [set pasajeros pasajeros6e]
  ask transms6e [ set cupo  (250 - pasajeros) ]
  ask transms6e [ setxy 25 7]
  ask transms6e [set heading -90]
  ask transms6e [set xxp 12 set yyp 5]
end

to route-transms6o
  create-transms6o 1
  ask transms6o [ set shape "trnsm2"]
  ask transms6o [ set size 10]
  ask transms6o [set pasajeros pasajeros6o]
  ask transms6o [ set cupo  (250 - pasajeros) ]
  ask transms6o [ setxy -25 -7]
  ask transms6o [set heading 90]
  ask transms6o [set xxp -4 set yyp -5]
end

to route-transmsh17
  create-transmsh17 1
  ask transmsh17 [ set shape "trnsm2"]
  ask transmsh17 [ set size 10]
  ask transmsh17 [set pasajeros pasajerosh17]
  ask transmsh17 [ set cupo  (250 - pasajeros) ]
  ask transmsh17 [ setxy -25 -7]
  ask transmsh17 [set heading 90]
  ask transmsh17 [set xxp -4 set yyp 5]
end

to route-transmsc17
  create-transmsc17 1
  ask transmsc17 [ set shape "trnsm2"]
  ask transmsc17 [ set size 10]
  ask transmsc17 [set pasajeros pasajerosc17]
  ask transmsc17 [ set cupo  (250 - pasajeros) ]
  ask transmsc17 [ setxy 25 7]
  ask transmsc17 [set heading -90]
  ask transmsc17 [set xxp 12 set yyp -5]
end

to route-transmsh20
  create-transmsh20 1
  ask transmsh20 [ set shape "trnsm2"]
  ask transmsh20 [ set size 10]
  ask transmsh20 [set pasajeros pasajerosh20]
  ask transmsh20 [ set cupo  (250 - pasajeros) ]
  ask transmsh20 [ setxy -25 -7]
  ask transmsh20 [set heading 90]
  ask transmsh20 [set xxp 12 set yyp 5]
end

to route-transmsd20
  create-transmsd20 1
  ask transmsd20 [ set shape "trnsm2"]
  ask transmsd20 [ set size 10]
  ask transmsd20 [set pasajeros pasajerosd20]
  ask transmsd20 [ set cupo  (250 - pasajeros) ]
  ask transmsd20 [ setxy 25 7]
  ask transmsd20 [set heading -90]
  ask transmsd20 [set xxp -4 set yyp -5]
end

to move-tm
  ask transms4e
  [
    ifelse not can-move? 1 [
      die
    ]

    [

      if xcor > parada2x [
      fd 1
        ]
      if xcor = parada2x [
        every ticks [ set espera4e espera4e + 1 ]
      if espera4e = esperar4e [
      fd 1
      set espera4e 0
        ]
      ]
      if xcor < parada2x [
      fd 0.5
        ]
    ]
  ]
  ask transms4o
 [
    ifelse not can-move? 1 [
      die
    ]

    [

      if xcor > parada4x [
      fd 0.5
        ]
      if xcor = parada4x [
        every ticks [ set espera4o espera4o + 1 ]
      if espera4o = esperar4o [
      fd 1
      set espera4o 0
        ]
      ]
      if xcor < parada4x [
      fd 0.5
        ]
    ]
  ]
  ask transms6e
   [
    ifelse not can-move? 1 [
      die
    ]

    [

      if xcor > parada2x [
      fd 0.5
        ]
      if xcor = parada2x [
        every ticks [ set espera6e espera6e + 1 ]
      if espera6e = esperar6e [
      fd 1
      set espera6e 0
        ]
      ]
      if xcor < parada2x [
      fd 0.5
        ]
    ]
  ]
  ask transms6o
  [
    ifelse not can-move? 1 [
      die
    ]

    [

      if xcor > parada4x [
      fd 0.5
        ]
      if xcor = parada4x [
        every ticks [ set espera6o espera6o + 1 ]
      if espera6o = esperar6o [
      fd 1
      set espera6o 0
        ]
      ]
      if xcor < parada4x [
      fd 0.5
        ]
    ]
  ]
  ask transmsh17
    [
    ifelse not can-move? 1 [
      die
    ]

    [

      if xcor > parada1x [
      fd 0.5
        ]
      if xcor = parada1x [
        every ticks [ set esperah17 esperah17 + 1 ]
      if esperah17 = esperarh17 [
      fd 1
      set esperah17 0
        ]
      ]
      if xcor < parada1x [
      fd 0.5
        ]
    ]
  ]
  ask transmsc17
    [
    ifelse not can-move? 1 [
      die
    ]

    [

      if xcor > parada3x [
      fd 0.5
        ]
      if xcor = parada3x [
        every ticks [ set esperac17 esperac17 + 1 ]
      if esperac17 = esperarc17 [
      fd 1
      set esperac17 0
        ]
      ]
      if xcor < parada3x [
      fd 0.5
        ]
    ]
  ]

  ask transmsh20
   [
    ifelse not can-move? 1 [
      die
    ]

    [

      if xcor > parada1x [
      fd 0.5
        ]
      if xcor = parada1x [
        every ticks [ set esperah20 esperah20 + 1 ]
      if esperah20 = esperarh20 [
      fd 1
      set esperah20 0
        ]
      ]
      if xcor < parada1x [
      fd 0.5
        ]
    ]
  ]
  ask transmsd20
    [
    ifelse not can-move? 1 [
      die
    ]

    [

      if xcor > parada3x [
      fd 0.5
        ]
      if xcor = parada3x [
        every ticks [ set esperad20 esperad20 + 1 ]
      if esperad20 = esperard20 [
      fd 0.5
      set esperad20 0
        ]
      ]
      if xcor < parada3x [
      fd 0.5
        ]
    ]
  ]
end

to create-passengersi
  create-pasi #Pasajeros
  set-default-shape turtles "person"
  ask pasi [ set color black ]
  ask pasi [ setxy -30 random 5 ]
  ask pasi [ set saldo random 2 ]
  ask pasi [ set reg random 3 ]
  ask pasi [ set destino random 8 ]
  tick
end

to pasi-pas
  ask pasi [
    every ticks [ set cambio cambio + 1 ]
    if cambio = 1 [ set breed pas ]
    set cambio 0
  ;if xcor = -24 [ set breed pas ]
  ]
end

to move-passengers
    ask pas[
    set disxr0 xcor - reg0x
    set disxr1 xcor - reg1x
    set disxr2 xcor - reg2x
    set disyr0 ycor - reg0y
    set disyr1 ycor - reg1y
    set disyr2 ycor - reg2y
    set disxc xcor - cabx
    set disyc ycor - caby
    if xcor < reg0x + 1 and reg = 0 and saldo = 1 [
      if ycor > reg0y [
        set heading 180 - atan abs(disxr0) abs(disyr0)
      forward 0.5
        ;if xcor = reg0x and ycor = reg0y [stop]
      ]
      if ycor = reg0y [
        set heading 90
      forward 0.5
        ;if xcor = reg0x and ycor = reg0y [stop]
      ]
      if ycor < reg0y [
        set heading atan abs(disxr0) abs(disyr0)
      forward 0.5
        ;if xcor = reg0x and ycor = reg0y [stop]
      ]
    ]
    if xcor < reg1x and reg = 1 and saldo = 1 [
      if ycor > reg1y [
        set heading 180 - atan abs(disxr1) abs(disyr1)
      forward 0.5
      ;  if xcor = reg1x and ycor = reg1y [stop]
      ]
      if ycor = reg1y [
        set heading 90
      forward 0.5
      ;  if xcor = reg1x and ycor = reg1y [stop]
      ]
    ]
    if xcor < reg2x and reg = 2 and saldo = 1 [
      if ycor > reg2y [
        set heading 180 - atan abs(disxr2) abs(disyr2)
      forward 0.5
      ;  if xcor = reg2x and ycor = reg2y [stop]
      ]
    ]
    if xcor < cabx and ycor > caby and saldo = 0 [
      set heading 180 - atan abs(disxc) abs(disyc)
      forward 1.5
    ]
  ifelse show-reg?
    [ set label reg ] ;; the label is set to be the value of the energy
    [ set label "" ]
  ]
end

to cab-reg
  ask pas [
  if xcor > cabx and saldo = 0 [
    set saldo 1
    ]
    ifelse show-saldo?
    [ set label saldo ] ;; the label is set to be the value of the energy
    [ set label "" ]
  ]
  ask pas [
  if xcor < reg0x and saldo = 1 and reg = 0 [
      if ycor < reg0y [
        set heading atan abs(disxr0) abs(disyr0)
      forward 0.5
      ;  if xcor = reg0x and ycor = reg0y [stop]
      ]
  ]
  if xcor < reg1x and saldo = 1 and reg = 1 [
      if ycor < reg1y [
        set heading atan abs(disxr1) abs(disyr1)
      forward 0.5
      ;  if xcor = reg1x and ycor = reg1y [stop]
      ]
  ]
  if xcor < reg2x and saldo = 1 and reg = 2 [
      if ycor < reg2y [
        set heading atan abs(disxr2) abs(disyr2)
      forward 0.5
      ;  if xcor = reg2x and ycor = reg2y [stop]
      ]
    ]
  ]

end
to waitbus
ask pas [
  set disxp1 xcor - parada1x
  set disyp1 ycor - parada1y
  set disxp2 xcor - parada2x
  set disyp2 ycor - parada2y
  set disxp3 xcor - parada3x
  set disyp3 ycor - parada3y
  set disxp4 xcor - parada4x
  set disyp4 ycor - parada4y
  ]
ask pas [
    ifelse destino = 0 or destino = 1 and xcor < parada1x [
    set heading 90 - atan abs(disyp1) abs(disxp1)
        forward 0.5
    ][stop]
  ]
ask pas [
    ifelse destino = 2 or destino = 3 and xcor < parada2x [
    set heading 90 - atan abs(disyp2) abs(disxp2)
        forward 0.5
    ][stop]
  ]
ask pas [
    ifelse destino = 4 or destino = 5 and xcor < parada3x [
    set heading 90 + atan abs(disyp3) abs(disxp3)
        forward 0.5
    ][stop]
  ]
ask pas [
    ifelse destino = 6 or destino = 7 and xcor < parada4x [
    set heading 90 + atan abs(disyp4) abs(disxp4)
        forward 0.5
    ][stop]
  ]
end

to tmllegada
ask transms4e [
if xcor = parada2x and cupo >= 1 [
   let ypoint-2 ycor - 2
   let xpoint xcor
      ask patches with [ pxcor = xpoint and pycor = ypoint-2 ]
      [ every ticks [ ask one-of pas with [ destino = 2 ] [die] ] ]
      every ticks [set cupo cupo - 1]]]

  ask transms4o [
if xcor = parada4x and cupo >= 1 [
   let ypoint-2 round ycor + 2
   let xpoint xcor
      ask patches with [ pxcor = xpoint and pycor = ypoint-2 ]
      [ every ticks [ ask one-of pas with [ destino = 6 ] [die] ] ]
      every ticks [set cupo cupo - 1]]]

  ask transms6e [
if xcor = parada2x and cupo >= 1 [
   let ypoint-2 round ycor - 2
   let xpoint xcor
      ask patches with [ pxcor = xpoint and pycor = ypoint-2 ]
      [ every ticks [ ask one-of pas with [ destino = 3 ] [die] ] ]
      every ticks [set cupo cupo - 1]]]

  ask transms6o [
if xcor = parada4x and cupo >= 1 [
   let ypoint-2 round ycor + 2
   let xpoint xcor
      ask patches with [ pxcor = xpoint and pycor = ypoint-2 ]
      [ every ticks [ ask one-of pas with [ destino = 7 ] [die] ] ]
      every ticks [set cupo cupo - 1]]]

  ask transmsc17 [
if xcor = parada1x and cupo >= 1 [
   let ypoint-2 ycor - 2
   let xpoint xcor
      ask patches with [ pxcor = xpoint and pycor = ypoint-2 ]
      [ every ticks [ ask one-of pas with [ destino = 0 ] [die] ] ]
      every ticks [set cupo cupo - 1]]]

  ask transmsh17 [
if xcor = parada3x and cupo >= 1 [
   let ypoint-2 round ycor + 2
   let xpoint xcor
      ask patches with [ pxcor = xpoint and pycor = ypoint-2 ]
      [ every ticks [ ask one-of pas with [ destino = 4 ] [die] ] ]
      every ticks [set cupo cupo - 1]]]

  ask transmsd20 [
if xcor = parada1x and cupo >= 1 [
   let ypoint-2 round ycor - 2
   let xpoint xcor
      ask patches with [ pxcor = xpoint and pycor = ypoint-2 ]
      [ every ticks [ ask one-of pas with [ destino = 1 ] [die] ] ]
      every ticks [set cupo cupo - 1]]]

  ask transmsh20 [
if xcor = parada3x and cupo >= 1 [
   let ypoint-2 round ycor + 2
   let xpoint xcor
      ask patches with [ pxcor = xpoint and pycor = ypoint-2 ]
      [ every ticks [ ask one-of pas with [ destino = 5 ] [die] ] ]
      every ticks [set cupo cupo - 1]]]


end
to subir
;if
end
@#$#@#$#@
GRAPHICS-WINDOW
306
10
1077
431
-1
-1
12.51
1
10
1
1
1
0
0
1
1
-30
30
-16
16
1
1
1
ticks
30.0

BUTTON
0
0
64
33
NIL
Setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
0
33
172
66
#Pasajeros
#Pasajeros
0
1000
3.0
1
1
NIL
HORIZONTAL

BUTTON
64
1
127
34
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
0
99
113
132
show-reg?
show-reg?
1
1
-1000

MONITOR
172
33
253
78
pre-Decisión
count pasi
17
1
11

SWITCH
0
66
124
99
show-saldo?
show-saldo?
0
1
-1000

SLIDER
0
133
172
166
pasajeros4e
pasajeros4e
0
250
248.0
1
1
NIL
HORIZONTAL

SLIDER
0
166
172
199
pasajeros4o
pasajeros4o
0
250
248.0
1
1
NIL
HORIZONTAL

SLIDER
0
201
172
234
pasajeros6e
pasajeros6e
0
250
248.0
1
1
NIL
HORIZONTAL

SLIDER
0
234
172
267
pasajeros6o
pasajeros6o
0
250
248.0
1
1
NIL
HORIZONTAL

SLIDER
0
267
172
300
pasajerosc17
pasajerosc17
0
250
248.0
1
1
NIL
HORIZONTAL

SLIDER
0
300
172
333
pasajerosh17
pasajerosh17
0
250
248.0
1
1
NIL
HORIZONTAL

SLIDER
0
333
172
366
pasajerosd20
pasajerosd20
0
250
248.0
1
1
NIL
HORIZONTAL

SLIDER
1
366
173
399
pasajerosh20
pasajerosh20
0
250
248.0
1
1
NIL
HORIZONTAL

SWITCH
114
99
249
132
show-destino?
show-destino?
1
1
-1000

BUTTON
175
136
299
169
NIL
route-transms4e
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
178
171
302
204
NIL
route-transms4o
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
179
207
303
240
NIL
route-transms6e
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
177
242
301
275
NIL
route-transms6o
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
177
279
308
312
NIL
route-transmsh17
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
178
316
307
349
NIL
route-transmsc17
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
179
350
310
383
NIL
route-transmsh20
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
178
386
309
419
NIL
route-transmsd20
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
1078
10
1250
43
esperar4e
esperar4e
0
30
5.0
1
1
segundos
HORIZONTAL

SLIDER
1078
43
1250
76
esperar4o
esperar4o
0
30
5.0
1
1
segundos
HORIZONTAL

SLIDER
1078
76
1250
109
esperar6e
esperar6e
0
30
5.0
1
1
segundos
HORIZONTAL

SLIDER
1078
109
1250
142
esperar6o
esperar6o
0
30
5.0
1
1
segundos
HORIZONTAL

SLIDER
1078
142
1250
175
esperarh17
esperarh17
0
30
5.0
1
1
segundos
HORIZONTAL

SLIDER
1078
175
1250
208
esperarc17
esperarc17
0
30
5.0
1
1
segundos
HORIZONTAL

SLIDER
1078
208
1250
241
esperarh20
esperarh20
0
30
5.0
1
1
segundos
HORIZONTAL

SLIDER
1078
241
1250
274
esperard20
esperard20
0
30
5.0
1
1
segundos
HORIZONTAL

BUTTON
128
0
263
33
Pasajeros
every 1 / Passengersps [\ncreate-passengersi\npasi-pas\n]
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
232
33
299
78
Pasajeros
count pas
17
1
11

CHOOSER
1
433
139
478
Passengersps
Passengersps
2 1 0.75 0.5 0.25
4

PLOT
502
457
767
631
Pasajeros vs. time
ticks
passengers
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"C17" 1.0 0 -16777216 true "" "plot count turtles with [ destino = 0 ]"
"D20" 1.0 0 -7500403 true "" "plot count turtles with [ destino = 1 ]"
"4E" 1.0 0 -2674135 true "" "plot count turtles with [ destino = 2 ]"
"6E" 1.0 0 -955883 true "" "plot count turtles with [ destino = 3 ]"
"H17" 1.0 0 -6459832 true "" "plot count turtles with [ destino = 4 ]"
"H20" 1.0 0 -1184463 true "" "plot count turtles with [ destino = 5 ]"
"4O" 1.0 0 -10899396 true "" "plot count turtles with [ destino = 6 ]"
"6O" 1.0 0 -13840069 true "" "plot count turtles with [ destino = 7 ]"

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

trnsm
false
0
Rectangle -2674135 true false 30 120 285 180
Circle -16777216 true false 45 165 30
Circle -16777216 true false 75 165 30
Circle -16777216 true false 210 165 30
Circle -16777216 true false 240 165 30
Rectangle -7500403 true true 135 120 165 180
Rectangle -1184463 true false 30 150 135 165
Rectangle -1184463 true false 165 150 285 165
Rectangle -11221820 true false 270 120 285 150
Rectangle -1 true false 45 135 60 150
Rectangle -1 true false 180 135 195 150
Rectangle -1 true false 105 135 120 150
Rectangle -1 true false 75 135 90 150
Rectangle -1 true false 240 135 255 150
Rectangle -1 true false 210 135 225 150

trnsm2
false
0
Rectangle -2674135 true false 15 120 270 180
Circle -16777216 true false 225 165 30
Circle -16777216 true false 195 165 30
Circle -16777216 true false 60 165 30
Circle -16777216 true false 30 165 30
Rectangle -7500403 true true 135 120 165 180
Rectangle -1184463 true false 165 150 270 165
Rectangle -1184463 true false 15 150 135 165
Rectangle -11221820 true false 15 120 30 150
Rectangle -1 true false 240 135 255 150
Rectangle -1 true false 105 135 120 150
Rectangle -1 true false 180 135 195 150
Rectangle -1 true false 210 135 225 150
Rectangle -1 true false 45 135 60 150
Rectangle -1 true false 75 135 90 150

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
