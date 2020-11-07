#takes a dataframe with columns x, y, z and converts to 2D space based on view y and z coordinates (assuming centered)
#TODO: allow shifting on x axis

transform2d <- function(df, viewy, viewz){
  out <- tibble(x = viewy*df$x/(df$y+viewy), y = viewy * (df$z-viewz)/(df$y + viewy) + viewz)
  filter(out, y >= -1.5)
}
