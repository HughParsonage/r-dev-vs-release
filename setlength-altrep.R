library(data.table)

# parse_tex0 <- function(tex_lines) {
#   out <- data.table(tex_group = c(0L, 1L, 1L))
#   out[, z1 := .GRP, by = "tex_group"]
#   out[tex_group == 0L]
#   out[, z2 := .GRP, by = "tex_group"]
#
#   tg <- sprintf("tg%s", seq_max_tex_group)
#   GROUP_IDz <- sprintf("GROUP_ID%s", seq_max_tex_group)
#   setindexv(out, "tex_group")
#   for (j in seq_len(5)) {
#     tgj <- tg[j]
#     out[, (tgj) := 1L]
#     GROUP_IDj <- GROUP_IDz[j]
#     out[tex_group == j, (GROUP_IDj) := .GRP, by = c(tgj)]
#   }
#   out
# }
out <- data.table(tex_group = c(0L, 1L, 1L))
out[, z1 := .GRP, by = "tex_group"]

