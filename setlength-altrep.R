library(data.table)

parse_tex0 <- function(tex_lines) {
  nchar_tex_lines <- nchar(tex_lines)
  Tex_line_split_unlist <- unlist(strsplit(tex_lines, split = "", fixed = TRUE),
                                  use.names = FALSE, recursive = FALSE)
  n_char <- sum(nchar_tex_lines)

  opener <- Tex_line_split_unlist == "{"
  closer <- Tex_line_split_unlist == "}"
  opener_optional <- Tex_line_split_unlist == "["
  closer_optional <- Tex_line_split_unlist == "]"
  tex_group <- cumsum(opener) - cumsum(closer) + closer
  optional_tex_group <- cumsum(opener_optional) - cumsum(closer_optional) + closer_optional
  openers <- NULL

  out <- data.table(char_no = seq_len(n_char),
                    line_no = rep(seq_along(tex_lines), times = nchar_tex_lines),
                    column = unlist(lapply(nchar_tex_lines, seq_len), use.names = FALSE),
                    char = Tex_line_split_unlist,
                    openers = opener,
                    closers = closer,
                    opener_optional = opener_optional,
                    closer_optional = closer_optional,
                    tex_group = tex_group,
                    optional_tex_group = optional_tex_group)

  seq_max_tex_group <- seq_len(5)

  tg <- sprintf("tg%s", seq_max_tex_group)
  GROUP_IDz <- sprintf("GROUP_ID%s", seq_max_tex_group)

  # Identify tex groups
  # A [b] \\cde[fg][hi]{jk} \\mn[o[p]]{q}.
  # 0000000000000000000111100000000000222

  setindexv(out, "tex_group")
  for (j in seq_len(5)) {
    tgj <- tg[j]
    out[, (tgj) := 1L]
    GROUP_IDj <- GROUP_IDz[j]
    out[tex_group == j, (GROUP_IDj) := .GRP, by = c(tgj)]
  }
  out
}
parse_tex0(c("A{}"))
parse_tex0(c("A{}", "B[a]{b{c}{d}}z"))

update.dev.pkg()
library(data.table)

DT <- data.table(x = 1:10,
                 y = 1:2)

DT[, v := cumsum(x), by = "y"]






