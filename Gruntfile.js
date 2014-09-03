module.exports = function(grunt) {
    "use strict";

    grunt.initConfig({
        libFiles: [ "bower_components/**/src/**/*.purs", "src/**/*.purs" ],
        testFiles: [ "tests/**/*.purs" ],

        pscMake: {
            lib: {
                src: ["<%=libFiles%>"]
            },
        },

        psc: {
            tests: {
                src: ["<%=testFiles%>", "<%=libFiles%>"],
                dest: "output/Main.js"
            }
        },

        dotPsci: ["<%=libFiles%>"],

        docgen: {
            readme: {
                src: ["src/**/*.purs"],
                dest: "API.md"
            }
        }
    });

    grunt.loadNpmTasks("grunt-purescript");

    grunt.registerTask("build", ["pscMake:lib", "docgen", "dotPsci"]);
    grunt.registerTask("test", ["psc:tests"]);
    grunt.registerTask("default", ["build", "test"]);
};

