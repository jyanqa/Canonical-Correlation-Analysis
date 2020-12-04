# AMS ASSIGNMENT 4
- **Name**: Quynh Anh Nguyen
- **Student ID**: 947097
- **Course**: Advanced Multivariate Statistics

# Part2: Canonical correlation analysis

## Import 2 files dataset.

`dietary.csv` : dataset concerning protein consumption (grams/ person/ day) in 22 European countries
</br> 
`sectors.csv`: dataset concerning the distribution in percentage of  the workforce  employed in nine different industry sectors in  the same 22 countries.
</br> 
Drop the column **Country** in each datset. Thus, the datasets now include only numerical values.
</br> 
**Code**
``` 
diet <- read.csv("./dietary.csv",sep =';')
sectors <- read.csv("./sectors.csv",sep =';')
df1 <- subset(diet, select = -c(Country))
df2 <- subset(sectors, select = -c(Country))
```
## Import the required packages
- `CCA` is a library used for canonical correlation analysis.
</br>
- `CCP` is a library to test if the canonical variates are significance.

```
install.packages("CCA")
install.packages('CCP')
library(lme4)
library(CCA) 
library(CCP)
```

- We can use the `matcor()` function on library CCA to check the associations of each dataset and between two dataset.
</br>
- We can explore the correlation index within study correlations 2 datasets between  set associations using `cormat$Ycor`, `cormat$Xcor`, `cormat$XYcor`.

```
cormat<-matcor(df1,df2)
round(cormat$Ycor, 3)
round(cormat$Xcor, 3)
round(cormat$XYcor, 3)
```
**Output**

```
> round(cormat$Xcor, 2)
                 read_meat white_meat   egg  milk  fish cereals starchy_foods nuts_oilseeds
read_meat             1.00       0.15  0.53  0.50  0.00   -0.43          0.17         -0.37
white_meat            0.15       1.00  0.56  0.31 -0.25   -0.37          0.35         -0.65
egg                   0.53       0.56  1.00  0.65 -0.05   -0.61          0.44         -0.54
milk                  0.50       0.31  0.65  1.00  0.14   -0.62          0.27         -0.66
fish                  0.00      -0.25 -0.05  0.14  1.00   -0.51          0.46         -0.07
cereals              -0.43      -0.37 -0.61 -0.62 -0.51    1.00         -0.68          0.60
starchy_foods         0.17       0.35  0.44  0.27  0.46   -0.68          1.00         -0.45
nuts_oilseeds        -0.37      -0.65 -0.54 -0.66 -0.07    0.60         -0.45          1.00
fruit_vegetables     -0.13      -0.12 -0.28 -0.46  0.20    0.15          0.09          0.42
                 fruit_vegetables
read_meat                   -0.13
white_meat                  -0.12
egg                         -0.28
milk                        -0.46
fish                         0.20
cereals                      0.15
starchy_foods                0.09
nuts_oilseeds                0.42
fruit_vegetables             1.00
```
```
> round(cormat$Ycor, 2)
                         agriculture mining manufacturing power_water construction services
agriculture                     1.00   0.33         -0.28       -0.01        -0.36    -0.73
mining                          0.33   1.00         -0.78       -0.17        -0.16    -0.48
manufacturing                  -0.28  -0.78          1.00        0.54         0.26     0.21
power_water                    -0.01  -0.17          0.54        1.00        -0.06    -0.30
construction                   -0.36  -0.16          0.26       -0.06         1.00     0.47
services                       -0.73  -0.48          0.21       -0.30         0.47     1.00
finance                        -0.04  -0.34         -0.15       -0.45        -0.17     0.23
social_services                -0.86  -0.34          0.10       -0.08         0.02     0.54
transport_communications       -0.52   0.11         -0.01        0.36        -0.09     0.12
                         finance social_services transport_communications
agriculture                -0.04           -0.86                    -0.52
mining                     -0.34           -0.34                     0.11
manufacturing              -0.15            0.10                    -0.01
power_water                -0.45           -0.08                     0.36
construction               -0.17            0.02                    -0.09
services                    0.23            0.54                     0.12
finance                     1.00            0.13                    -0.37
social_services             0.13            1.00                     0.55
transport_communications   -0.37            0.55                     1.00
```
```
> round(cormat$XYcor, 2)
                         read_meat white_meat   egg  milk  fish cereals starchy_foods
read_meat                     1.00       0.15  0.53  0.50  0.00   -0.43          0.17
white_meat                    0.15       1.00  0.56  0.31 -0.25   -0.37          0.35
egg                           0.53       0.56  1.00  0.65 -0.05   -0.61          0.44
milk                          0.50       0.31  0.65  1.00  0.14   -0.62          0.27
fish                          0.00      -0.25 -0.05  0.14  1.00   -0.51          0.46
cereals                      -0.43      -0.37 -0.61 -0.62 -0.51    1.00         -0.68
starchy_foods                 0.17       0.35  0.44  0.27  0.46   -0.68          1.00
nuts_oilseeds                -0.37      -0.65 -0.54 -0.66 -0.07    0.60         -0.45
fruit_vegetables             -0.13      -0.12 -0.28 -0.46  0.20    0.15          0.09
agriculture                  -0.32      -0.48 -0.63 -0.45 -0.40    0.64         -0.53
mining                       -0.25       0.13 -0.23 -0.37 -0.40    0.29         -0.09
manufacturing                -0.01       0.01  0.07  0.07  0.11    0.10          0.00
power_water                  -0.11      -0.05 -0.05 -0.11 -0.18    0.51         -0.20
construction                  0.06      -0.05  0.10 -0.04  0.25   -0.18          0.31
services                      0.30       0.15  0.48  0.29  0.41   -0.60          0.36
finance                       0.63      -0.04  0.25  0.42  0.17   -0.60          0.04
social_services               0.27       0.39  0.59  0.57  0.51   -0.68          0.54
transport_communications     -0.06       0.30  0.33  0.31  0.05   -0.02          0.07
                         nuts_oilseeds fruit_vegetables agriculture mining manufacturing
read_meat                        -0.37            -0.13       -0.32  -0.25         -0.01
white_meat                       -0.65            -0.12       -0.48   0.13          0.01
egg                              -0.54            -0.28       -0.63  -0.23          0.07
milk                             -0.66            -0.46       -0.45  -0.37          0.07
fish                             -0.07             0.20       -0.40  -0.40          0.11
cereals                           0.60             0.15        0.64   0.29          0.10
starchy_foods                    -0.45             0.09       -0.53  -0.09          0.00
nuts_oilseeds                     1.00             0.42        0.57   0.07         -0.05
fruit_vegetables                  0.42             1.00       -0.05  -0.11          0.17
agriculture                       0.57            -0.05        1.00   0.33         -0.28
mining                            0.07            -0.11        0.33   1.00         -0.78
manufacturing                    -0.05             0.17       -0.28  -0.78          1.00
power_water                      -0.01            -0.18       -0.01  -0.17          0.54
construction                     -0.05             0.36       -0.36  -0.16          0.26
services                         -0.12             0.40       -0.73  -0.48          0.21
finance                          -0.20            -0.32       -0.04  -0.34         -0.15
social_services                  -0.60            -0.09       -0.86  -0.34          0.10
transport_communications         -0.25            -0.29       -0.52   0.11         -0.01
                         power_water construction services finance social_services
read_meat                      -0.11         0.06     0.30    0.63            0.27
white_meat                     -0.05        -0.05     0.15   -0.04            0.39
egg                            -0.05         0.10     0.48    0.25            0.59
milk                           -0.11        -0.04     0.29    0.42            0.57
fish                           -0.18         0.25     0.41    0.17            0.51
cereals                         0.51        -0.18    -0.60   -0.60           -0.68
starchy_foods                  -0.20         0.31     0.36    0.04            0.54
nuts_oilseeds                  -0.01        -0.05    -0.12   -0.20           -0.60
fruit_vegetables               -0.18         0.36     0.40   -0.32           -0.09
agriculture                    -0.01        -0.36    -0.73   -0.04           -0.86
mining                         -0.17        -0.16    -0.48   -0.34           -0.34
manufacturing                   0.54         0.26     0.21   -0.15            0.10
power_water                     1.00        -0.06    -0.30   -0.45           -0.08
construction                   -0.06         1.00     0.47   -0.17            0.02
services                       -0.30         0.47     1.00    0.23            0.54
finance                        -0.45        -0.17     0.23    1.00            0.13
social_services                -0.08         0.02     0.54    0.13            1.00
transport_communications        0.36        -0.09     0.12   -0.37            0.55
                         transport_communications
read_meat                                   -0.06
white_meat                                   0.30
egg                                          0.33
milk                                         0.31
fish                                         0.05
cereals                                     -0.02
starchy_foods                                0.07
nuts_oilseeds                               -0.25
fruit_vegetables                            -0.29
agriculture                                 -0.52
mining                                       0.11
manufacturing                               -0.01
power_water                                  0.36
construction                                -0.09
services                                     0.12
finance                                     -0.37
social_services                              0.55
transport_communications                     1.00
```
## Canonical Correlations
**Find the canonical correlations**
```
can_cor1=cc(df1,df2)
can_cor1$cor #the canonical correlations
can_cor1[3:4] #raw canonical coefficients
```
**Computing the canonical loadings**
```
can_cor2=comput(df1,df2,can_cor1)
can_cor2[3:6] #displays the canonical loadings
```
**Output**
```
> can_cor1$cor
[1] 0.98997889 0.96451127 0.91495684 0.85120774 0.77008456 0.57073484 0.33326979 0.12281991
[9] 0.02074961
```
```
> can_cor1[3:4]
$xcoef
                        [,1]        [,2]        [,3]        [,4]          [,5]        [,6]
read_meat        -0.15487698  0.09744221 -0.10117137  0.02227878 -0.1080382381 -0.07117388
white_meat       -0.06086299  0.16132960  0.02828382 -0.05442099  0.3129217610 -0.13826069
egg               0.54134075 -0.75102446 -0.31236091  0.47576520 -0.3679295873 -1.04696215
milk              0.02451412  0.02991679  0.07930205  0.11151544  0.1205557891  0.06674214
fish              0.09315373 -0.03788372 -0.14806012  0.18827831  0.1591490331 -0.06625001
cereals           0.14971607  0.03193746 -0.08770643  0.07104883  0.0169389474 -0.03853491
starchy_foods     0.23685873  0.01850434 -0.18910412 -0.04146285 -0.1834594992  0.25047509
nuts_oilseeds    -0.23010137  0.30567906  0.49729636  0.28478171  0.2080748499 -0.19701727
fruit_vegetables  0.15383213 -0.40638320  0.26135313 -0.14872791  0.0002511125  0.01787658
                         [,7]         [,8]         [,9]
read_meat         0.182340139 -0.120048277 -0.235888302
white_meat        0.038941111 -0.009425495 -0.290005283
egg              -0.219339033  0.555683481  0.604272209
milk             -0.006275798 -0.155528155 -0.008540311
fish              0.162752049  0.211206753 -0.226151185
cereals           0.046457857 -0.051784556 -0.067212118
starchy_foods    -0.496527537 -0.544790154 -0.474592779
nuts_oilseeds    -0.327115925 -0.116524165 -0.613295944
fruit_vegetables  0.266738503 -0.205710411  0.232764657

$ycoef
                              [,1]     [,2]     [,3]      [,4]     [,5]     [,6]     [,7]
agriculture              -6.057652 10.40917 6.450472 -17.59399 30.40978 13.03446 29.79290
mining                   -6.134817 10.45105 6.366869 -17.82554 30.46864 12.91557 29.82409
manufacturing            -6.112887 10.46036 6.410633 -17.76409 30.52661 12.93641 29.83239
power_water              -5.798778 10.39636 5.299720 -17.65406 29.44806 12.50722 31.47422
construction             -6.063335 10.30792 6.211384 -17.51145 30.24393 13.32936 29.76112
services                 -6.105961 10.33308 6.595435 -17.70430 30.43303 12.79294 29.93058
finance                  -6.365796 10.58110 6.305527 -17.69102 30.48791 12.95980 29.95334
social_services          -6.056157 10.31929 6.311543 -17.65154 30.42396 13.08318 29.77567
transport_communications -6.201333 11.00796 6.714147 -16.92815 31.00035 12.74570 29.41618
                             [,8]      [,9]
agriculture              19.45016 -18.70685
mining                   19.40919 -18.71566
manufacturing            19.27083 -18.65948
power_water              21.42671 -19.27441
construction             19.23403 -19.16423
services                 19.60707 -18.74899
finance                  19.39158 -18.83281
social_services          19.47743 -18.64190
transport_communications 18.95065 -19.29530
```
## Test of canonical dimensions
We are going to find the no of observations, no of variables in df1 and number of variablesin df2.
</br> Then we can compute the F approximations using different test statistics using Wilks Test.
```
rho=can_cor1$cor
n=dim(df1)[1]
p=length(df1)
q=length(df2)
p.asym(rho,n,p,q,tstat="Wilks")
```
**Output**
```
> p.asym(rho,n,p,q,tstat="Wilks")
Wilks' Lambda, using F-approximation (Rao's F):
                 stat      approx df1      df2    p.value
1 to 9:  1.497661e-05 1.968305272  81 34.81913 0.01400819
2 to 9:  7.510166e-04 1.369510908  64 35.33047 0.15644429
3 to 9:  1.077220e-02 1.025923768  49 34.88353 0.47468186
4 to 9:  6.614640e-02 0.796633720  36 33.50004 0.74830939
5 to 9:  2.401434e-01 0.584642336  25 31.22060 0.91403499
6 to 9:  5.900768e-01 0.331387986  16 28.13308 0.98813111
7 to 9:  8.751450e-01 0.153262027   9 24.48798 0.99694523
8 to 9:  9.844912e-01 0.043151730   4 22.00000 0.99620252
9 to 9:  9.995695e-01 0.005168784   1 12.00000 0.94387043
```
Tests of dimensionality for the canonical correlation analysis output indicate that only 1 of the 9 canonical dimensions are statistically significant at the .05 level Dimension 1 had a canonical correlation very low which is 0.00000149766.
