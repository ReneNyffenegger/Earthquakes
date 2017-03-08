library(oce)

# At least two major quakes may suppoort Berkland's theory.
# The December 26, # 2004, magnitude 9.1 in Sumatra, Indonesia, occurred on the day of a full # moon.
# Likewise, the March 27, 1964, magnitude 9.2 earthquake in Alaska occurred on the day of maximum high tide.  (Vollmond = 28. März)

# X11()

csv_file <- paste0(Sys.getenv('digitales_backup'), 'Development/Daten/Earthquakes/1900-2016_7.5.csv');
quakes <- read.csv(csv_file, stringsAsFactors = FALSE)
# quakes <- quakes[quakes$mag >= 8.0,]
utc <- as.POSIXct(substring(quakes$time, 1, 19), format="%Y-%m-%dT%H:%M:%S", tz="UTC")
moon  <- moonAngle(t=utc, longitude=0, latitude=0)
phase_ <- moon$phase - floor(moon$phase)


plot_ <- function(main_, sub_, breaks_, png_name) {
  png(paste0('images/', png_name, '_plot.png'), width=1000, height=500)
  plot(
       x    = phase_, 
       y    = jitter(quakes$mag, 2),
       type ='p',
       bg   ='blue',
       pch  = 21,
       main = main_,
       sub  = sub_,
       xlab ="Mondphase",
       ylab ="Magnitude",
  )
# invisible(locator(1))
  invisible(dev.off())

  png(paste0('images/', png_name, '_hist.png'), width=1000, height=500)
  hist(
     phase_,
     breaks = breaks_,
     main   = main_,
     sub    = sub_
  )
# invisible(locator(1))
  invisible(dev.off())
}

plot_("Erdbeben 1900-2016 > 7.5 - Mondphase", "0 = Neumond, 0.5 = Vollmond", 28, "Earthquakes_1900-2016_gt_7.5_phase")
   
# http://stackoverflow.com/questions/42646460/is-there-a-more-elegant-way-to-project-x-between-0-and-1-to-a-w-shape
phase_ <- abs(abs(2 - 4 * phase_) - 1)

plot_("Erdbeben 1900-2016 > 7.5 - Nähe zu Voll/Leermond", "0= 1., 3. Viertel; 1 = Leer/Vollmond", 7, "Earthquakes_1900-2016_gt_7.5_close") 
