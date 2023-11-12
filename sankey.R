library(ggsankey)
library(ggplot2)
library(dplyr)

FungiData <- read.csv("fungi_sankey_data.csv")
names(FungiData) <- c('disease', 'transmission', 'risk.factor')

# Step 1
df <- FungiData %>%
  make_long(disease, transmission, risk.factor)

# Chart 1
pl <- ggplot(df, aes(x = x,
                     next_x = next_x,
                     node = node,
                     next_node = next_node,
                     fill = factor(node),
                     label = node)) +
  geom_sankey(flow.alpha = 0.5,
              node.color = "black",
              show.legend = FALSE) +
  geom_sankey_label(size = 3, color = "black", fill = "white", hjust = -0.2, vjust = 0.5) +
  theme_bw() +
  theme(legend.position = "none",
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank()) +
  scale_fill_viridis_d(option = "inferno")
pl + theme(plot.margin = margin(0, 0, 0, 0, "cm"))  # Adjust the values as needed

ggsave(
  filename = "fungi_sankey.png",
  plot = pl,
  width = 50,
  height = 50,
  units = "cm",
  dpi = 300
)
