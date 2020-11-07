#' Creating summary plot of each at bat
#'
#' Creates a strike zone plot of a given at bat
#'
#' @param d a dataframe containing trackman data with numbered at bats
#' @param pa the plate appearance number
#' @return a dataframe containing trackman data with extra columns
#' @todo bases/outs state

abplot <- function(gamed, pa){

  require(tidyverse)
  require(gridExtra)
  gamed %>% tmadjsimple() %>%
    tmplus() -> d
  traj<-NULL
  d %>% filter(PAofGame == pa) -> pitches
  for(i in 1:nrow(pitches)){
    pitch = pitches[i,]
    t <- seq(from = 0, to = pitch$tf, by = (.01))
    y <- pos(59.083-pitch$Extension, pitch$vyr, pitch$ay0, t)
    x <- 10*pos(-pitch$RelSide, pitch$vxr, pitch$ax0, t)/(y+10)
    z <- 10*(pos(pitch$RelHeight, pitch$vzr, pitch$az0, t)-3.2)/(y+10)+3.2
    t <- append(t,pitch$tf)
    x <- append(x,-pitch$PlateLocSide)
    y <- append(y,0)
    z <- append(z,pitch$PlateLocHeight)
    rows <- length(t)
    traj<-rbind(traj, tibble(t=t,y=y,x=x,z=z,pitch_type=rep(pitch$TaggedPitchType, rows),pitchno=rep(pitch$PitchofPA, rows)))  #add velo and spin
  }

  plate_width <- 17 + 2 * (9 / pi) #in inches
  plate <-
    data.frame(x = c(-.7083, .7083, .7, 0,-.7,-.7083),
               z = c(0, 0,-.1,-.2,-.1, 0))

  cols <- c("Fastball" = "#cc0000", "Cutter" = "#800080", "Curveball" = "#ff8c00", "Slider" = "#1e90ff", "ChangeUp" = "#008000") #Define colors for pitches
  pitchstats = select(pitches, TaggedPitchType, RelSpeed, SpinRate, Tilt, PitchCall, PlayResult, KorBB, InducedVertBreak, HorzBreak, Extension, VertApprAngle)
  play <- NULL
  for(i in 1:nrow(pitchstats)){
    play[i] <- ifelse(pitchstats[i,]$KorBB == 'Undefined', ifelse(pitchstats[i,]$PlayResult == 'Undefined', '', pitchstats[i,]$PlayResult), pitchstats[i,]$KorBB)
  }

  mound <-
    tibble(y = c(70.5833,70.0833,69.5833,69.0833,68.5833,68.0833,67.5833,67.0833,66.5833,66.0833,65.5833,65.0833,64.5833,64.0833,63.5833,63.0833,62.5833,62.0833,61.5833,61.0833,60.5833,60.0833,60.5833,61.0833,61.5833,62.0833,62.5833,63.0833,63.5833,64.0833,64.5833,65.0833,65.5833,66.0833,66.5833,67.0833,67.5833,68.0833,68.5833,69.0833,69.5833,70.0833,70.5833,70.5833,70.5833,70.5833),
           x=c(8.874,8.944,8.986,9,8.986,8.944,8.874,8.775,8.646,8.485,8.292,8.062,7.794,7.483,7.124,6.708,6.225,5.657,4.975,4.123,2.958,0,-2.958,-4.123,-4.975,-5.657,-6.225,-6.708,-7.124,-7.483,-7.794,-8.062,-8.292,-8.485,-8.646,-8.775,-8.874,-8.944,-8.986,-9,-8.986,-8.944,-8.874,-2.5,2.5, 8.874),
           z=c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.833,0.833, 0))
  adjmound <- transform2d(mound, 10, 3.2)
  leftbox <-
    tibble(x = c(-1.208,-1.208, -5.20833, -5.20833, -5.20833, -3.708, -7),
           y = c(-17/12, 2.292,2.292, -1, 2.292, 2.292, 5.583),
           z = c(0,0,0,0,0,0,0))
  lbadj <- transform2d(leftbox, 10, 3.2)
  rightbox <-
    tibble(x = c(1.208, 1.208,5.20833, 5.20833, 5.20833, 3.708, 7),
           y = c(-17/12, 2.292, 2.292, 2.292, -1, 2.292, 5.583),
           z = c(0,0,0,0,0,0,0))
  rbadj <- transform2d(rightbox, 10, 3.2)

  plate <- tibble(
    x = c(-8.5 / 12,-8.5 / 12, 0, 8.5 / 12, 8.5 / 12, -8.5/12),
    y = c(0, - 8.5 / 12, - 17 / 12, - 8.5 / 12, 0, 0),
    z = c(0, 0, 0, 0, 0, 0)
  )
  plateadj <- transform2d(plate, 10, 3.2)
  inplay <- filter(pitches, PitchCall == "InPlay")

  pitchstats %>%
    mutate(RelSpeed = round(RelSpeed, 1), SpinRate = round(SpinRate), Play = play, V_Break = round(InducedVertBreak,1), H_Break = round(HorzBreak,1), Ext = round(Extension,2), Plane = round(VertApprAngle,2)) -> pitchstats
  pitchstats %>%
    select(-one_of(c('PlayResult', 'KorBB', 'InducedVertBreak', 'HorzBreak', 'VertApprAngle', 'Extension'))) -> pitchstats

  hpview <-
    ggplot(data = NULL, aes(x,y)) + #empty plot for pitch locations
    geom_path(data = plateadj, mapping = aes(x = x, y = y)) + #insert home plate
    geom_path(
      data = adjmound,
      mapping = aes(x = x, y = y), color = 'black'
    ) +
    geom_path(
      data = lbadj,
      mapping = aes(x = x, y = y), color = 'black'
    ) +
    geom_path(
      data = rbadj,
      mapping = aes(x = x, y = y), color = 'black'
    ) +
    geom_rect(
      xmin = -(plate_width / 2) / 12,
      #defining strike zone, convert to feet
      xmax = (plate_width / 2) / 12,
      ymin = 1.5,
      #strike zone heights
      ymax = 3.5,
      fill = 'lightgrey',
      alpha = .05
    ) +
    geom_segment(aes(x = -.3157, y = 1.5, xend = -.3157, yend = 3.5),  color = "white", alpha = 1) +
    geom_segment(aes(x = .3157, y = 1.5, xend = .3157, yend = 3.5),  color = "white", alpha = 1) +
    geom_segment(aes(x = -.947, y = 1.5 + 2/3, xend = .947, yend = 1.5 + 2/3),  color = "white", alpha = 1) +
    geom_segment(aes(x = -.947, y = 3.5 - 2/3, xend = .947, yend =  3.5 - 2/3),  color = "white", alpha = 1) +
    geom_path(
      data = traj,
      mapping = aes(x = x, y = z, color = pitch_type, group = pitchno),
      size = 1.25,
      alpha = .9
    ) +
    geom_rect(
      xmin = -(plate_width / 2) / 12,
      #defining strike zone, convert to feet
      xmax = (plate_width / 2) / 12,
      ymin = 1.5,
      #strike zone heights
      ymax = 3.5,
      color = "black",
      alpha = 0
    ) +
    #insert pitch
    geom_point(
      data = inplay,
      mapping = aes(x = -PlateLocSide -.001, y = PlateLocHeight, color = TaggedPitchType, group = PitchofPA),
      size = 7.2,
      alpha = .75,
      color = 'yellow') +
    geom_point(
      data = pitches,
      mapping = aes(x = -PlateLocSide, y = PlateLocHeight, color = TaggedPitchType, group = PitchofPA),
      size = 6,
      alpha = .75)+
      scale_color_manual(
        values = cols
      ) +
    geom_text(
      data = pitches,
      mapping = aes(x = -PlateLocSide, y = PlateLocHeight+.03, label = PitchofPA),
      size = 3.4,
      alpha = 1,
      color = 'white'
    ) +
    geom_text(
      data = inplay,
      mapping = aes(x=0, y=-1.25, label = ifelse(nrow(inplay)>0, paste('EV:', round(ExitSpeed,1), 'LA:', round(Angle,1)),''))
    ) +
    scale_x_continuous("", #set scale for strike zone
                       limits = c(-5, 5)) +
    scale_y_continuous("",
                       limits = c(-7, ifelse(max(pitches['PlateLocHeight']) > 3.9, max(pitches['PlateLocHeight']) +.1, 4))) + #.1 prevents label from getting cut off
    coord_equal() +

    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = 'white'),
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks=element_blank(),
      legend.title=element_blank(),
      legend.position="top",
      plot.title = element_text(hjust = 0.5)
    ) +
    ggtitle(paste(pitches[1,]$Pitcher, 'vs', pitches[1,]$Batter, '// Inning:', pitches[1,]$Inning)) +
    annotation_custom(tableGrob(pitchstats, theme = ttheme_minimal()), xmin=-2.5, xmax=2.5, ymin=-5, ymax=-1)
  hpview
}

pos <- function(x0, v0, a0, t) { #simple kinematics equation
  x0 + v0 * t + .5 * a0 * t ^ 2
}
