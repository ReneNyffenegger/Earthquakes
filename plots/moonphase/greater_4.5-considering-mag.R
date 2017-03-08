library(oce)

# X11()

phase = numeric()

for (year in 2010:2016) {
  csv_file <- paste0(Sys.getenv('digitales_backup'), 'Development/Daten/Earthquakes/', year, '_4.5.csv')
  quakes <- read.csv(csv_file, stringsAsFactors = FALSE)




# quakes <- quakes[quakes$depth > 0 & quakes$depth < 100, ]
# quakes <- quakes[quakes$mag   > 8                     , ]

  utc <- as.POSIXct(substring(quakes$time, 1, 19), format="%Y-%m-%dT%H:%M:%S", tz="UTC")

  moon  <- moonAngle(t=utc, longitude=0, latitude=0)

  phase_ <- moon$phase - floor(moon$phase)

  phase <- c(phase, phase_)


}

png('images/Earthquakes_2010-2016_gt_4.5.png', width=1000, height=500)
hist(phase_, 
     main='Erdbeben 2010-2016, Mag >= 4.5',
     sub ='0 = Neumond, 0.5 = Vollmond')
# invisible(locator(1))
invisible(dev.off())

quakes$power = 10 ^ (quakes$mag-4.5)
#
# http://renenyffenegger.ch/notes/development/languages/R/graphics/data-visualization/bar-chart/mean-of-bins
#
bins <- cut(phase_, 0:28/28)
mean_ <- tapply(quakes$power, bins, mean)

png('images/Earthquakes_2010-2016_gt_4.5_full_moon.png', width=1000, height=500)
barplot(
  mean_,
  main = 'Erdbeben 2010-2016, Mag >= 4.5, Nähe zu Voll/Leermond',
  sub  = '0= 1., 3. Viertel; 1 = Leer/Vollmond',
  ylab = 'mean(p); p = 10^(mag-4.5)',

)
# invisible(locator(1))
invisible(dev.off())
