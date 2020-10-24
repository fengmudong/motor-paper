%mem=100GB
%nprocshared=16
%chk=Om.chk
#p opt=calcfc freq rb3lyp/6-31g(d,p) geom=connectivity scf=(maxcycle=500)

DFT opt

0 1
C       0.66156612      0.32418966     -0.38472221
C      -0.26246826     -0.69734684     -0.16074030
C      -1.61096029     -0.42939652     -0.01411272
C      -2.11000178      0.85846193     -0.10720994
C      -1.25768647      1.94866297     -0.28655922
C       0.08478092      1.63240678     -0.43695025
O       0.89990247      2.71032865     -0.64027934
C       2.03930109      2.70287563      0.11425214
C       2.44559216      3.92891588      0.63377529
C       3.62128911      3.85354759      1.42174950
C       4.41653975      2.74289522      1.47625238
C       3.98073394      1.51631642      0.97032392
C       2.72243653      1.50460784      0.35647309
C       2.10100602      0.25849532     -0.15190604
C       2.70294176     -0.94060924     -0.41720236
C       2.04682241     -1.93609341     -1.32599277
C       1.10490837     -1.80513399     -2.40834043
C       0.71544119     -0.56495117     -2.96604584
C      -0.24253923     -0.45006733     -4.00025517
C      -0.76975863     -1.64118689     -4.54379412
C      -0.30019862     -2.86275917     -4.06455253
C       0.56228088     -2.99283552     -2.96708216
C       0.96954611     -4.28851224     -2.51194884
C       1.90492649     -4.37848083     -1.50803913
C       2.44097423     -3.20039935     -0.90833885
C       3.57199864     -3.08632008      0.03950868
C       3.95488901     -1.60069828      0.19263305
C       4.36734029     -1.33532557      1.64358233
H       0.04870807     -1.76103928     -0.02674261
H      -2.27840812     -1.28838991      0.15437958
H      -3.21219624      0.96684978     -0.07517458
H      -1.62929609      2.99546321     -0.28301670
H       1.99020741      4.91110039      0.39428409
H       3.93535966      4.77406396      1.96412033
H       5.38188630      2.82907523      1.94055517
H       4.63380493      0.69139723      0.99360258
H       4.47825032     -3.70128847     -0.24697634
H       3.24746811     -3.50818701      1.00044113
H       4.80235307     -1.30589999     -0.50250666
H       3.49030721     -1.05148537      2.25272537
H       4.71023784     -2.28672410      2.04039247
H       5.28327635     -0.68634698      1.73052991
H       1.20024194      0.34157888     -2.61617732
H       2.28589023     -5.32235714     -1.08489325
H      -0.45133644      0.54540270     -4.45273145
H      -0.82152402     -3.77965137     -4.45620497
H       0.52910453     -5.22158686     -2.93840973
H      -1.50930981     -1.56120789     -5.33245421