All the lua files in this directory will be imported by lazy.nvim.
This is because of `{ import = plugins }` table passed in as `specs` key to
lazy.nvim configuration.

Each lua file returns a table of "specs" as stipulated by lazy.nvim. Lazy.nvim
builds a table of specs by combining all of these tables.
