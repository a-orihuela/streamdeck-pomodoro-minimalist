import { execSync } from "node:child_process";
import { createRequire } from "node:module";

const { uuid } = createRequire(import.meta.url)("../project.config.json");
execSync(`streamdeck restart ${uuid}`, { stdio: "inherit" });
