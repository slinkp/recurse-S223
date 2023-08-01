// instr 1; variably noisy pitched ring modulator
// ; by PW based on C. Dodge (2nd ed.) p. 103 - ex 26a


// ;set up an envelope
fun void noisemod(float idur, float att, float rel, float dbamp, float bw, float octave, float pc)
{
    Math.fabs((idur - rel))::second => dur timeToRelease;
    <<< "Note start for dur", idur, "db", dbamp, "bw", bw >>>;

    //   iamp  =       ampdb(p6)
    Std.dbtorms(dbamp + 5) => float iamp;
    <<< "iamp is:", iamp >>>;

    // ; set up note freq & noise bandwidth
    //   ipitch        =       cpspch(p8)
    // Map the octave to midi pitch: 8 -> 60
    (octave * 12) - 36 => float ipitch;
    // Then offset the pitch class:
    pc + ipitch => ipitch;
    // Then convert to frequency.
    Std.mtof(ipitch) => float ifreq;
    <<< "Midi pitch", ipitch, "freq", ifreq>>>;

    .01 * bw * ifreq => float ibw; // Sets noise bandwidth as % of ipitch

    <<< "bandwidth for noise is", ibw >>>;

    // ;feed amplitude kenv into a random # generator
    //   amp   randi   kenv, ibw
    // kenv -> +/- range over which random numbers are distributed.
    // ibw -> frequency with which new random numbers chosen.
    // Interpolates between random numbers.
    // Hmm... is it possible this ends up being a sort of low-pass filtered random noise?
    // Yes, that's how Dodge describes it sections 4.9 & 4.11 ex 26.
    // randi(kenv, ibw) => float amp;

    // For now try filtering SubNoise which is basically RANDH
    SubNoise noise;
    noise => blackhole;
    ibw $ int => noise.rate; // Took FOREVER to find the cast operator $
    // ; random # modulates amp. of oscillator
    //   aout  oscil   amp, ifreq, 1  ; use table 1
    SinOsc oscil => ADSR kenv => Gain outputGain => dac;
    ifreq => oscil.freq;

    // Envelope
    //   kenv  expseg  1, p4, iamp, p5, iamp, idur, 1
    kenv.set( att::second, 0::second, 1.0, rel::second);
    iamp => oscil.gain; // iamp => float kenv;

    // Combine the output factors
    3 => outputGain.op; // Meaning, multiply the inputs.

    kenv.keyOn();
    noise => LPF lpf => outputGain;
    ibw => lpf.freq;

    // Play for duration, then detach.
    timeToRelease => now;
    <<< "Key off, starting decay" >>>;
    kenv.keyOff();
    rel::second => now;
    outputGain =< dac;
    <<< "Note end" >>>;
}


// Utilities from csound that chuck doesn't have

// fun float cpspch(string s)
// {
//     // Converts octave.pitch notation to frequency.
//     // 8.00 -> Midi 60, middle C
//     60.0 => float midi_value; // Fake it for now
//     return Std.mtof(midi_value);
// }

// Ok, chuck DOES have an ampdb equivalent. It's just Std.dbtolin(n)
// fun float ampdb(float n)
// {
//     // Maps db to gain in the range 0-32768ish.
//     // EQUIVALENT: Math.dbtorms(n) * 100000
//     // EQUIVALENT: Std.dbtolin(n)
//     // 60 -> 1000
//     // 90 -> 31622.7
//     // Found in csound source code in aops.c:
//     // EXP(*p->a * LOG10D20)
//     0.11512925 => float LOG10D20;
//     return Math.exp(n * LOG10D20);
// }

// randi doesn't exist in chuck.
// TODO maybe make a Chugraph or Chugen?
// See https://chuck.stanford.edu/extend/
// and examples:
// https://chuck.stanford.edu/doc/examples/extend/chugraph.ck
// and https://chuck.stanford.edu/doc/examples/extend/chugen.ck
fun float randi(float range, float freq)
{
    // range: +/- float range over which random numbers are distributed.
    // freq: how often new random numbers chosen.
    // Generates samples, linearly interpolated between random numbers.
    return range; // Fake it for now
}

// Hacky table of note data copy/munged from old csound version
float notes[][];
//start         duration         atk  rel    db    bw   octave.pitch
[[25.9459459459, 0.430947295709, 0.1, 0.001, 76.0, 10.0, 7, 0],
[26.4448482707, 0.241319036428, 0.02, 0.1, 81.0, 8.0, 7.0, 3],
[26.5820826849, 0.279766252739, 0.2, 0.001, 83.0, 7.0, 6.0, 9],
// [27.3315336488, 1.98030139423, 0.005, 0.1, 78.0, 30.0, 8.0, 7],
[28.0905453044, 2.09066440118, 1.0, 1.0, 90.0, 80.0, 5.0, 6],
[28.648119859, 2.16791850605, 1.5, 2.0, 37.0, 60.0, 11.0, 5],
[28.8113999428, 3.14324165529, 1.0, 2.5, 33.0, 60.0, 11.0, 8],
[29.0179832153, 0.209342347636, 0.3, 0.001, 60.0, 10.0, 10.0, 9],
[31.9546415981, 0.643285721091, 0.1, 0.001, 76.0, 10.0, 7.0, 0],
[32.9011191126, 0.410436052974, 0.2, 0.001, 83.0, 7.0, 6.0, 09],
[33.9935783022, 2.7969876457, 0.005, 2.7, 78.0, 30.0, 8.0, 07],
[35.0792644583, 2.90735065265, 1.0, 1.0, 90.0, 80.0, 5.0, 06],
[35.8655111633, 2.98460475752, 1.5, 2.0, 37.0, 60.0, 11.0, 05],
[36.0941261473, 4.28660240734, 1.0, 2.5, 33.0, 60.0, 11.0, 08],
[36.3823780449, 0.291010972782, 0.3, 0.001, 60.0, 10.0, 10.0, 09],
[40.3807285546, 0.855624146473, 0.1, 0.001, 76.0, 10.0, 7.0, 0],
[41.0372455299, 0.332397100391, 0.05, 0.001, 79.0, 12.0, 7.0, 02],
[41.3696426303, 0.469991186839, 0.02, 0.1, 81.0, 8.0, 7.0, 03],
[41.6375468447, 0.541105853209, 0.2, 0.001, 83.0, 7.0, 6.0, 09],
[42.1106281958, 0.685211357068, 0.01, 0.001, 66.0, 10.0, 8.0, 09],
[42.5204306539, 1.25324578397, 0.005, 0.001, 73.0, 15.0, 8.0, 1],
[43.0730142599, 3.61367389716, 0.005, 0.1, 78.0, 30.0, 8.0, 07],
[44.4853749166, 3.72403690412, 1.0, 1.0, 90.0, 80.0, 5.0, 06],
[45.500293772, 3.80129100899, 1.5, 2.0, 37.0, 60.0, 11.0, 05],
[45.7942436561, 5.4299631594, 1.0, 4.4, 33.0, 60.0, 11.0, 08],
[46.1641641789, 0.372679597929, 0.3, 0.001, 60.0, 10.0, 10.0, 09],
[51.2242068155, 1.06796257186, 0.1, 1.001, 76.0, 10.0, 7.0, 0],
[52.0440610411, 0.414065725538, 0.05, 0.001, 79.0, 12.0, 7.0, 02],
[52.4581267666, 0.584327262045, 0.02, 0.1, 81.0, 8.0, 7.0, 03],
[52.7913658812, 0.671775653444, 0.2, 0.001, 83.0, 7.0, 6.0, 09],
[53.3787833074, 0.848548607362, 0.01, 0.001, 66.0, 10.0, 8.0, 09],
[53.8865881157, 1.5472528345, 0.005, 0.001, 73.0, 15.0, 8.0, 1],
[54.5698415219, 4.43036014863, 0.005, 0.1, 78.0, 30.0, 8.0, 07],
[56.3088766793, 4.54072315559, 1.0, 1.0, 90.0, 80.0, 5.0, 06],
[57.5524676851, 4.61797726046, 1.5, 2.0, 37.0, 60.0, 11.0, 05],
[57.9117524693, 6.57332391146, 1.0, 2.5, 33.0, 60.0, 11.0, 08],
[58.3633416172, 0.454348223076, 0.3, 0.001, 60.0, 10.0, 10.0, 09],
[64.4850763807, 1.28030099724, 0.1, 0.001, 76.0, 10.0, 7.0, 0],
[65.4682678566, 0.495734350684, 0.05, 0.001, 79.0, 12.0, 7.0, 02],
[65.9640022073, 0.69866333725, 0.02, 0.1, 81.0, 8.0, 7.0, 03],
[66.3625762219, 0.802445453679, 0.2, 0.001, 83.0, 7.0, 6.0, 09],
[67.0643297234, 1.01188585766, 0.01, 0.001, 66.0, 10.0, 8.0, 09],
[67.6701368819, 1.84125988503, 0.005, 0.001, 73.0, 15.0, 8.0, 1],
[68.4840600883, 5.2470464001, 0.005, 0.1, 78.0, 30.0, 8.0, 07],
[70.5497697462, 5.35740940706, 1.0, 1.0, 90.0, 80.0, 5.0, 06],
[72.0220329025, 5.43466351193, 1.5, 2.0, 37.0, 60.0, 11.0, 05],
[72.4466525868, 7.71668466351, 1.0, 2.5, 33.0, 60.0, 11.0, 08],
[72.9799103598, 0.536016848223, 0.3, 0.001, 60.0, 10.0, 10.0, 09],
[80.1633372503, 1.49263942262, 0.1, 0.001, 76.0, 10.0, 7.0, 0],
[81.3098659764, 0.577402975831, 0.05, 0.001, 79.0, 12.0, 7.0, 02],
[81.8872689523, 0.812999412456, 0.02, 0.1, 81.0, 8.0, 7.0, 03],
[82.3511778671, 0.933115253914, 0.2, 0.001, 83.0, 7.0, 6.0, 09],
[83.1672674437, 1.17522310795, 0.01, 0.001, 66.0, 10.0, 8.0, 09],
[83.8710769524, 2.13526693556, 0.005, 0.001, 73.0, 15.0, 8.0, 1],
[84.815669959, 6.06373265157, 0.005, 0.1, 78.0, 30.0, 8.0, 07],
[87.2080541176, 6.17409565853, 1.0, 1.0, 90.0, 80.0, 5.0, 06],
[88.9089894242, 6.25134976339, 1.5, 2.0, 37.0, 60.0, 11.0, 05],
[89.3989440086, 8.86004541557, 1.0, 2.5, 33.0, 60.0, 11.0, 08],
[90.0138704068, 0.61768547337, 0.3, 0.001, 60.0, 10.0, 10.0, 09]
] @=> notes;

notes[0][0] @=> float timeOffset;

// Play notes
//for (0=>int i; i < notes.size(); i++) {
for (0=>int i; i < 4; i++) {
    notes[i] @=> float note[];
    // Easiest polyphony = spork new shreds forever :D :D :D
    spork ~ noisemod(note[1], note[2], note[3], note[4], note[5], note[6], note[7]);
    0.5::second => now;
    // Go to next start time.
    // if (i + 1 < notes.size())
    // {
    //     Std.fabs(notes[i + 1][0]) => float nextTime;
    //     nextTime - timeOffset => float delta;
    //     nextTime => timeOffset;
    //     <<< "Next note in", delta, "seconds" >>>;
    //     delta::second => now;
    // }
}
<<< "Let notes drain..." >>>;
10::second => now;

