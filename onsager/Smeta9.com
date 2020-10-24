%mem=100GB
%nprocshared=16
%chk=Sm.chk
#p opt=calcfc freq rb3lyp/6-31g(d,p) geom=connectivity scf=(maxcycle=500)

DFT opt

0 1
C      -0.87231792      1.20553040     -1.36838983
C      -1.75116206      1.12967641     -2.47231493
C      -1.38285405      1.79247715     -3.65738133
C      -0.17416917      2.43434027     -3.81526087
C       0.70922331      2.52167741     -2.75467203
C       0.26156362      2.05280411     -1.49404790
S       1.29662463      2.67755243     -0.26247604
C       0.42837433      2.23990654      1.15851331
C       0.80172856      2.76826726      2.38948019
C       0.49795210      2.20020203      3.61380791
C      -0.28672785      1.03490780      3.60570963
C      -0.79385807      0.59524727      2.39544785
C      -0.48441238      1.16041422      1.14449588
C      -1.17376859      0.64277505     -0.03922336
C      -2.17117440     -0.33079609      0.01254969
C      -2.45869649     -1.29005838     -1.04090937
C      -1.49467537     -1.95186618     -1.81634437
C      -0.10650005     -1.49050102     -1.90076132
C       0.69090199     -1.98764593     -2.86234282
C       0.24236395     -3.10933674     -3.63522810
C      -1.06907764     -3.51248592     -3.60406831
C      -1.98487990     -2.97804161     -2.69162056
C      -3.34162814     -3.40454852     -2.64352191
C      -4.22478361     -2.82521817     -1.76073474
C      -3.79421197     -1.80094466     -0.90467081
C      -4.41384158     -1.20241914      0.31842498
C      -3.29478614     -0.37554829      0.96089432
C      -3.82165571      1.02712844      1.33640175
H      -2.68392129      0.57518240     -2.38373425
H      -2.10615127      1.73447395     -4.52410217
H       0.07883065      2.81531974     -4.78774227
H       1.71540122      2.94970055     -2.77559828
H       1.48241495      3.64017203      2.42187276
H       0.87482899      2.51464813      4.60684755
H      -0.59608164      0.52498790      4.54757180
H      -1.41434262     -0.30154830      2.39780773
H      -4.64850550     -2.13436677      0.95063799
H      -5.33673473     -0.64680743      0.10127716
H      -2.99153108     -0.86833225      1.94797542
H      -4.49875322      1.28515990      0.49921382
H      -4.40303882      0.96535265      2.26907842
H      -3.01770975      1.75723811      1.30969722
H       0.19787968     -0.68658682     -1.23980115
H      -5.24646762     -3.24600404     -1.78648182
H       1.72215827     -1.71093499     -3.02185580
H      -1.36456709     -4.28523034     -4.25921978
H      -3.64589427     -4.23610966     -3.34191202
H       0.93878834     -3.61153661     -4.29637277