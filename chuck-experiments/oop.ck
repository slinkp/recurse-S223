class Foo {
    fun void go() {
        <<< "Calling go from foo" >>>;
    }
}

class Bar extends Foo {
    fun void go() {
        <<< "Calling go from bar" >>>;
    }
}

Foo @ things[2];
new Foo @=> things[0];
new Bar @=> things[1];

// Yes polymorphism works
for (Foo thingy : things) {
    thingy.go();
}
