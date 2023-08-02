// instr 1; variably noisy pitched ring modulator
// ; by PW based on C. Dodge (2nd ed.) p. 103 - ex 26a


fun void noisemod(float idur, float att, float rel, float dbamp, float bw, float octave, float pc)
{

    // Pitch
    // Map the octave & pitch class to midi pitch: eg [8, 0] -> 60
    (octave * 12) - 36 => float ipitch;
    pc + ipitch => ipitch;
    // Then convert to frequency.
    Std.mtof(ipitch) => float ifreq;

    //////////////////////////////////////////////////////////////////////////////
    // Main audio patch
    Std.dbtorms(dbamp + 5) => float iamp;
    SinOsc oscil => ADSR kenv => Gain outputGain => dac;
    ifreq => oscil.freq;
    iamp => oscil.gain;

    // Envelope
    kenv.set( att::second, 0::second, 1.0, rel::second);

    // outputGain is like a VCA here.
    // Was confusing how to achieve this in chuck since audio-rate signals
    // can't be connected directly to ugen parameters like oscil.gain.
    // The magic `op` value of 3 means multiply the inputs.
    // Result is: oscil output is multiplied by all the other inputs
    // to outputGain.
    // The other way to achieve this would be to make a time loop
    // and set eg oscil.gain once each loop, but that wouldn't achieve
    // something like driving gain with `randi`.
    3 => outputGain.op;

    //////////////////////////////////////////////////////////////////////////////
    // Filtered noise generator.
    //
    // We will use this to modulate the amplitude of the sin wave.
    // This makes a sort of rumbling or ghostly noise if bandwidth of noise
    // is wide, and a clearer pitch sound if bandwidth is narrow.
    //
    // Feed the amplitude envelope into a random # generator.
    // Originally in csound this was:
    //   amp   randi   kenv, ibw
    // kenv determines +/- range over which random numbers are distributed.
    // ibw determines frequency with which new random numbers chosen.
    // randi generates samples linearly interpolated between the random numbers.
    //
    // Dodge describes it as a sort of low-pass filtered random noise,
    // as per Computer Music sections 4.9 & 4.11 ex 26a.
    //
    // If I had a working randi unit generator, then I might wire
    // this into outputGain like:
    // randi(kenv, ibw) => outputGain;
    //
    // For now try filtering SubNoise which is equivalent to RANDH.
    ////////////////////////////////////////////////////////////////////////////////

    // I scale noise bandwidth relative to frequency.
    // This is similar to my csound version, not in Dodge text.
    .01 * bw * ifreq => float ibw;

    SubNoise noise => LPF lpf => outputGain;
    ibw $ int => noise.rate; // Took FOREVER to find the cast operator $
    ibw => lpf.freq;
    10 / bw => float filterQ => lpf.Q;  // Higher Q = narrower noise spectrum = more pitch

    //////////////////////////////////////////////////////////////////////////////////
    // Note control

    <<< "Note start dur", idur, "pitch", ipitch, "db", dbamp, "bw", bw, "scaled bw", ibw, "Q", filterQ >>>;

    Math.fabs((idur - rel))::second => dur timeToRelease;

    // Play for duration, then detach.
    kenv.keyOn();
    timeToRelease => now;
    kenv.keyOff();
    rel::second => now;
    outputGain =< dac;
}


// randi doesn't exist in chuck.
// Could I make one via a Chugraph or Chugen?
// See https://chuck.stanford.edu/extend/
// and examples:
// https://chuck.stanford.edu/doc/examples/extend/chugraph.ck
// and https://chuck.stanford.edu/doc/examples/extend/chugen.ck

/////////////////////////////////////////////////////////////////////////////////////
// Play notes

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
for (0=>int i; i < notes.size(); i++) {
    notes[i] @=> float note[];
    // Easiest polyphony = spork new shreds forever :D :D :D
    // More robust approach in polyphony demo.
    spork ~ noisemod(note[1], note[2], note[3], note[4], note[5], note[6], note[7]);
    // Go to next start time.
    if (i + 1 < notes.size())
    {
        Std.fabs(notes[i + 1][0]) => float nextTime;
        nextTime - timeOffset => float delta;
        nextTime => timeOffset;
        // <<< "Next note in", delta, "seconds" >>>;
        delta::second => now;
    }
}
<<< "Let notes drain..." >>>;
2::second => now;

