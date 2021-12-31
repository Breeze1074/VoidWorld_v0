################################################################################


# Author: CrazyBreeze1074
# Date: August 22, 2021
# Purpose: Generated a voided minecraft bedrock world which includes:
# 1. defined biome diversity
# 2. hard codes spawn spots for each structure type
# 3. world border to block players traveling to the non-voided chunks
# 4. nether ceiling and border for cave spawns defining nether spawn rules
# The world will be further modified by Rayth for a complete and
# challenging Skyblock map.


################################################################################


################################################################################
# Load the required R packages
################################################################################
library(tidyverse)
library(rbedrock)

################################################################################
# Create the empty world
################################################################################
dbpath <- create_world(id = "~/Downloads/voidWorld_CrazyBreeze1074",
                       LevelName = "voidWorld_CrazyBreeze1074_1.07",
                       showcoordinates = TRUE,
                       GameType = 1L,
                       SpawnX = 0L,
                       SpawnY = 65535L,
                       SpawnZ = 0L, worlds_dir = "~/Downloads/")
db <- bedrockdb(fs::path_real(dbpath))

################################################################################
# Add the voided overworld chunks
################################################################################
g <- expand_grid(x = -528:527, z = -528:527)
biomes <- biome_id("plains")
put_chunk_version_values(db, g$x, g$z, 0, 16L)
put_finalization_values(db, g$x, g$z, 0, 2L)
put_2dmaps_values(db, g$x, g$z, 0, list(list(
  height_map = 0L,
  biome_map = biomes
)))

################################################################################
# Add the voided nether chunks
################################################################################
g <- expand_grid(x = -96:95, z = -96:95)
biomes <- biome_id("basalt_deltas")
put_chunk_version_values(db, g$x, g$z, 1, 16L)
put_finalization_values(db, g$x, g$z, 1, 2L)
put_2dmaps_values(db, g$x, g$z, 1, list(list(
  height_map = 0L,
  biome_map = biomes
)))

################################################################################
# Add a scratch overworld island
################################################################################
blocks <- array("minecraft:air", c(16,16,16))
blocks[,16,] <- "minecraft:grass"
put_subchunk_blocks_value(db, 0, 0, 0, 4, blocks)

################################################################################
# Add a scratch nether island
################################################################################
blocks[,16,] <- "minecraft:netherrack"
put_subchunk_blocks_value(db, 0, 0, 1, 4, blocks)

################################################################################
# Place the biomes
################################################################################

# List the biome names
tibble(list_biomes()$name) %>% rename("biome" = 1) %>% print(n = 100)

#river
g <- expand_grid(x = -13:12, z = -13:12)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "river")

#cold_taiga
g <- expand_grid(x = -12:11, z = -12:11)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "cold_taiga")

#desert
g <- expand_grid(x = -12:11, z = -37:-14)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "desert")

#bamboo_jungle
g <- expand_grid(x = -37:-14, z =	-37:-14)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "bamboo_jungle")

#flower_forest
g <- expand_grid(x = 38:61, z =	-12:11)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "flower_forest")

#swampland
g <- expand_grid(x = 38:61, z =	38:61)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "swampland")

#savanna
g <- expand_grid(x = -140:-117, z	= -12:11)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "savanna")

#ocean
g <- expand_grid(x = 116:139, z =	-12:11)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "ocean")

#frozen_ocean
g <- expand_grid(x = -12:11, z =	-140:-117)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "frozen_ocean")

#warm_ocean
g <- expand_grid(x = 116:139, z =	116:139)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "warm_ocean")

#ice_mountains
g <- expand_grid(x = -12:11, z =	116:139)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "ice_mountains")

#mushroom_island
g <- expand_grid(x = -12:11, z =	-204:-181)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "mushroom_island")

#frozen_river
g <- expand_grid(x = -140:-117, z =	-204:-181)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "frozen_river")

#beach
g <- expand_grid(x = 116:139, z =	-204:-181)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "beach")

#hell
g <- expand_grid(x = -13:12, z =	-13:12)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 1, value = "hell")

#warped_forest
g <- expand_grid(x = 38:61, z =	-61:-38)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 1, value = "warped_forest")

#soulsand_valley
g <- expand_grid(x = -61:-38, z =	-61:-38)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 1, value = "soulsand_valley")

#crimson_forest
g <- expand_grid(x = 38:61, z =	38:61)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 1, value = "crimson_forest")

#warm_ocean
g <- expand_grid(x = -140:-117, z =	-140:-117)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "warm_ocean")

#frozen_ocean
g <- expand_grid(x = -140:-117, z =	116:139)
put_biomes_values(db = db, x = g$x, z = g$z, dimension = 0, value = "frozen_ocean")

################################################################################
# Add hard codes spawn spots for each structure type
################################################################################
# define each structure location

# Here I used chunk coordinates then multiplied * 16 
# to convert to block positions
dat1 <- data.frame(x1 = 50*16, x2 = 51*16, z1 = 50*16, z2 = 51*16,
                   y1 = 40, y2 = 60, tag = "SwampHut")
dat2 <- data.frame(x1 = -128*16, x2 = -129*16, z1 = 0*16, z2 = 1*16,
                   y1 = 40, y2 = 60, tag = "PillagerOutpost")
dat3 <- data.frame(x1 = 125*16, x2 = 128*16+15, z1 = -2*16, z2 = 1*16+15,
                   y1 = 40, y2 = 60, tag = "OceanMonument")

# Here I used block coordinates directly without converting from chunks
dat4 <- data.frame(x1 = -816, x2 = -768, z1 = 768, z2 = 822,
                   y1 = 40, y2 = 60, tag = "NetherFortress")

# Write structures to the world database
put_hsa_data(db, dat1, merge = TRUE)
put_hsa_data(db, dat2, merge = TRUE)
put_hsa_data(db, dat3, merge = TRUE)
put_hsa_data(db, dat4, merge = TRUE)

# Verify HSS and write the positions to a .csv file
get_hsa_data(db = db) %>% arrange(tag) %>% 
  write_csv("structures.csv")

################################################################################
# Add the overworld border barrier
################################################################################
blocks <- array("minecraft:air", c(16, 16, 16))
blocks[,1,1] <- "minecraft:border_block"
g <- expand_grid(x = -520:520, z = -520, value = list(blocks))
put_subchunk_blocks_values(db = db, x = g$x, z = g$z, dimension = 0, 
                           subchunk = 0, value = g$value)

blocks <- array("minecraft:air", c(16, 16, 16))
blocks[,1,16] <- "minecraft:border_block"
g <- expand_grid(x = -520:520, z = 519, value = list(blocks))
put_subchunk_blocks_values(db = db, x = g$x, z = g$z, dimension = 0, 
                           subchunk = 0, value = g$value)

blocks <- array("minecraft:air", c(16, 16, 16))
blocks[1,1,] <- "minecraft:border_block"
g <- expand_grid(x = -520, z = -520:520, value = list(blocks))
put_subchunk_blocks_values(db = db, x = g$x, z = g$z, dimension = 0, 
                           subchunk = 0, value = g$value)

blocks <- array("minecraft:air", c(16, 16, 16))
blocks[16,1,] <- "minecraft:border_block"
g <- expand_grid(x = 519, z = -520:520, value = list(blocks))
put_subchunk_blocks_values(db = db, x = g$x, z = g$z, dimension = 0, 
                           subchunk = 0, value = g$value)

################################################################################
# Add the nether border barrier
################################################################################
blocks <- array("minecraft:air", c(16, 16, 16))
blocks[,1,1] <- "minecraft:border_block"
g <- expand_grid(x = -65:65, z = -64, value = list(blocks))
put_subchunk_blocks_values(db = db, x = g$x, z = g$z, dimension = 1, 
                           subchunk = 0, value = g$value)

blocks <- array("minecraft:air", c(16, 16, 16))
blocks[,1,16] <- "minecraft:border_block"
g <- expand_grid(x = -65:65, z = 63, value = list(blocks))
put_subchunk_blocks_values(db = db, x = g$x, z = g$z, dimension = 1, 
                           subchunk = 0, value = g$value)

blocks <- array("minecraft:air", c(16, 16, 16))
blocks[1,1,] <- "minecraft:border_block"
g <- expand_grid(x = -64, z = -65:65, value = list(blocks))
put_subchunk_blocks_values(db = db, x = g$x, z = g$z, dimension = 1, 
                           subchunk = 0, value = g$value)

blocks <- array("minecraft:air", c(16, 16, 16))
blocks[16,1,] <- "minecraft:border_block"
g <- expand_grid(x = 63, z = -65:65, value = list(blocks))
put_subchunk_blocks_values(db = db, x = g$x, z = g$z, dimension = 1, 
                           subchunk = 0, value = g$value)

################################################################################
# Add the nether ceiling
################################################################################
g <- expand_grid(x = -96:95, z = -96:95)
blocks <- array("minecraft:air", c(16, 16, 16))
# blocks[,15,] <- "minecraft:barrier"
blocks[,16,] <- "minecraft:bedrock"
g <- expand_grid(x = -96:95, z = -96:95, value = list(blocks))
put_subchunk_blocks_values(db = db, x = g$x, z = g$z, dimension = 1, 
                           subchunk = 7, value = g$value)

################################################################################
# Close the world database and export the compressed file
################################################################################
close(db)
export_world(id = "./RaythSkyBlock_2.07/", worlds_dir = "./",
             file = "./RaythSkyBlock_2.07.mcworld",
             replace = TRUE)
