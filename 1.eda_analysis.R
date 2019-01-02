library(tidyverse)
library(readr)
library(GGally)

####### ROOM LEVEL Analysis

## Importing data and formatting names
data_df = readr::read_csv('data/room_level_data.csv')
data_df = dplyr::select(data_df, -one_of(c('X1')))

new_names = c()
for (name in names(data_df)){
  new_names <- c(new_names, gsub("_", ".", tolower(name), fixed = TRUE))
}
names(data_df) = new_names
new_names

## Formatting features for plotting
data_df = dplyr::mutate(data_df, 
                       n.connections = as.integer(n.connections),
                       build.type.binary = as.factor(building.type),
                       n.connections.log = log10(n.connections + 1),
                       area.log = log10(area + 1),
                       isovistarea.log = log10(isovistarea + 1))


## Pair Plot
plot_df = dplyr::select(data_df, one_of(c('n.connections.log', 'area.log', 
                                          'isovistarea.log', 'build.type.binary')))
names(plot_df) <- c('# Connections (Log10)', 'Area (Log10)', 
                    'Isovist Area (Log10)', 'Building')
ggpairs(plot_df, aes(color = Building, alpha = 0.4), 
        upper = list(continuous = wrap("cor", size = 2))) + 
  ggplot2::theme_bw(base_size = 8)
ggsave(filename='images/eda_room_level.png', dpi=600, height = 6, width = 6)


## KS Test for Area
area_mon <- dplyr::pull(filter(data_df, build.type.binary=='Monasteries'), area.log)
area_mosque <- dplyr::pull(filter(data_df, build.type.binary=='Mosques'), area.log)
ks.test(area_mon, area_mosque)
t.test(area_mon, area_mosque)


# Pair Plot without Isovist Area
plot_df = dplyr::select(data_df, one_of(c('n.connections.log', 'area.log', 
                                          'build.type.binary')))
names(plot_df) <- c('# Connections (Log10)', 'Area (Log10)', 'Building')
ggpairs(plot_df, aes(color = Building, alpha = 0.4), 
        upper = list(continuous = wrap("cor", size = 3))) + 
  ggplot2::theme_bw(base_size = 10)
ggsave(filename='images/eda_room_level_noisovists.png', 
       dpi=600, height = 6, width = 6)



########## BUILDING LEVEL

## Importing data and formatting names
data_df = readr::read_csv('data/building_level_data.csv')
data_df = dplyr::select(data_df, -one_of(c('X1')))

new_names = c()
for (name in names(data_df)){
  new_names <- c(new_names, gsub("_", ".", tolower(name), fixed = TRUE))
}
names(data_df) = new_names
new_names

## Setup Data
data_df = dplyr::mutate(data_df, 
                        bld.type = as.factor(bld.type))

# Pair Plot
names(data_df)
ggpairs(data_df, aes(color = bld.type, alpha = 0.4))
ggsave(filename='images/eda_building_level.png', dpi=600, height = 6, width = 6)
