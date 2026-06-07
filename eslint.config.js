import { config } from "@elgato/eslint-config";

export default [
	{
		ignores: ["*.sdPlugin/bin/**", "*.sdPlugin/logs/**", "node_modules/**"]
	},
	...config.recommended
];
