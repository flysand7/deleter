package main

import "core:os"
import path "core:path/slashpath"
import "core:slice"
import "core:strings"
import "core:fmt"

import "sqlite3"

DB_PATH :: "Google/Chrome/User Data/Default/History"

main :: proc() {
    base_path := os.get_env("LOCALAPPDATA")
    db_path := path.join([]string{base_path, DB_PATH})
    fmt.printf("Opening path: %s\n", db_path)
    if !os.exists(db_path) {
        fmt.eprintf("Path doesn't exist: %s\n", db_path)
        os.exit(1)
    }
    db: ^sqlite3.Sqlite3
    status := sqlite3.open_v2(strings.clone_to_cstring(db_path), &db, {.Read_Write, .Create}, nil)
    if status != nil {
        fmt.eprintf("Error opening database: %s\n", db_path)
        os.exit(2)
    }
    defer sqlite3.close_v2(db)
    status = sql_exec(db, `
        delete from urls where url like '%pornhub.com%';
        commit;
    `)
    if status != nil {
        fmt.eprintf("Error running DB query: %s\n", status_explain(status))
        os.exit(1)
    }
    status = sql_exec(db, `
        delete from visited_links
        where top_level_url like '%pornhub.com%';
        commit;
    `)
    if status != nil {
        fmt.eprintf("Error running DB query: %s\n", status_explain(status))
        os.exit(1)
    }
    fmt.printf("Success\n")
}