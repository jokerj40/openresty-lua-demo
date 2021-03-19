ngx.header.content_type = 'text/html'

local args = ngx.decode_args(ngx.var.args or '')

if not next(args) then
return ngx.print[[
<html>
    <head>
    <script>
        function upd() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/api/?getData=1", true);
            xhr.onload = function (e) {
                if (xhr.readyState === 4) {
                    if (xhr.status == 200) {
                        document.getElementById("demo").innerHTML = xhr.responseText;
                    } 
                    else {
                        alert("error!" + xhr)
                    }
                }
            };
            xhr.onerror = function (e) {
                console.error(xhr.statusText);
            };
            xhr.send(null);
        }
    </script>
    </head>
    
    <body>
    <h1>Hello, World!!!</h1>
    <button onclick="upd()">Click me</button>
    <div id="demo">data</div>
    </body>
</html>]]
end

local template = require'resty.template'
local pgmoon = require"pgmoon"
pg = pgmoon.new({
    host = "db",
    port = "5432",
    database = "luadb",
    user = "lua_user",
    password = "mypostgre"
})

assert(pg:connect())

local gen = template.compile_string[[
    <div>{{data[1]["C"]}}</div>
]]

pg:query("CREATE TABLE IF NOT EXISTS mytable(i integer)")
pg:query("INSERT INTO mytable (i) VALUES (1)")
local stuff = pg:query('SELECT COUNT(*) as "C" FROM mytable')
local htmltext = gen{data = stuff}

ngx.print(htmltext)
