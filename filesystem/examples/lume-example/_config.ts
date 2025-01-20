import lume from "lume/mod.ts";
import check_urls from "lume/plugins/check_urls.ts";
import code_highlight from "lume/plugins/code_highlight.ts";
import eta from "lume/plugins/eta.ts";
import jsx from "lume/plugins/jsx.ts";
import minify_html from "lume/plugins/minify_html.ts";
import purgecss from "lume/plugins/purgecss.ts";
import relative_urls from "lume/plugins/relative_urls.ts";
import sass from "lume/plugins/sass.ts";
import toml from "lume/plugins/toml.ts";

const site = lume({ src: "./src" });

site.use(check_urls());
site.use(code_highlight());
site.use(jsx());
site.use(minify_html());
site.use(sass());
site.use(purgecss());
site.use(relative_urls());
site.use(toml());
site.copy("static", ".")

export default site;
