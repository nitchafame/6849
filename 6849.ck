// Author Nitcha Tothong and Kengchakaj Kengkarnka
// 6849 composition by Kengchakaj Kengkarnka from "Lak Lan" album
// November 2018

// sound chain
SqrOsc bass => dac;
SawOsc ostA => dac;
SawOsc ostB => dac;
TriOsc ostC => dac;

// Pitch declaration
44 => int Ab2; // MIDI note #44 = Ab2
40 => int E2;  // MIDI note #40 = E2
75 => int Eb5; // MIDI note #75 = Eb5
87 => int Eb6; // MIDI note #87 = Eb6

// array declaration
// Bass Line, bass
[Ab2,0,Ab2,0,Ab2,0,Ab2,0,Ab2,0,Ab2,0,Ab2,0,Ab2,0,E2,0,E2,0,E2,0] @=> int pitchBass[]; // Pitch 
[290,10,290,10,290,10,290,10,290,10,590,10,290,10,590,10,290,10,290,10,440,10] @=> int durBass[]; // Duration in millisecond
[.1,0,.1,0,0,0,.1,0,.1,0,0,0,.1,0,0,0,.1,0,.1,0,.1,0] @=> float volumeBass[]; //Volumes

// Osinato A, ostA
[Eb5,0,Eb5,0,Eb5,0,Eb5,0,Eb5,0,Eb5,0,Eb5,0] @=> int pitchOstA[]; // Pitch 
[590,10,590,10,590,10,590,10,590,10,590,10,440,10] @=> int durOstA[]; // Duration in millisecond
[.1,0,.1,0,.1,0,.1,0,.1,0,.1,0,.1,0] @=> float volumeOstA[]; //Volumes

// Osinato B, ostB
[Eb5,0,Eb5,0,Eb5,0,Eb5,0,Eb5,0,Eb5,0,Eb5,0,Eb5,0,Eb5,0] @=> int pitchOstB[]; // Pitch
[440,10,440,10,440,10,440,10,440,10,440,10,440,10,440,10,440,10] @=> int durOstB[]; // Duration in millisecond
[.1,0,.1,0,.1,0,.1,0,.1,0,.1,0,.1,0,.1,0,.1,0] @=> float volumeOstB[]; //Volumes

// Osinato C, ostC
[Eb6,0,Eb6,0,Eb6,0,Eb6,0,Eb6,0,Eb6,0,Eb6,0,Eb6,0,Eb6,0] @=> int pitchOstC[]; // Pitch
[290,10,290,10,290,10,290,10,290,10,290,10,290,10,290,10,290,10] @=> int durOstC[]; // Duration in millisecond
[.2,0,.2,0,.2,0,.2,0,.2,0,.2,0,.2,0,.2,0,.2,0] @=> float volumeOstC[]; //Volumes


// Event declaration
Event one;
Event two;
Event three;
Event four;

// Bass Line
fun int melody (Event one){
    one => now;
    for( 0 => int j; j < 2; j++){
        for( 0 => int i; i < pitchBass.cap(); i++){
            <<< i, pitchBass[i] >>>; // print index and value
            Std.mtof(pitchBass[i]) => bass.freq;
            volumeBass[i] => bass.gain;
            durBass[i]::ms => now; // advance time 
        }
    }
}

// OsinatoA
fun int OsinatoA (Event two){
    two => now;
    for( 0 => int j; j < 2; j++){
        for( 0 => int i; i < pitchOstA.cap(); i++){
            <<< i, pitchOstA[i] >>>; // print index and value
            Std.mtof(pitchOstA[i]) => ostA.freq;
            volumeOstA[i] => ostA.gain;
            durOstA[i]::ms => now; // advance time 
        }
    }
}


// OsinatoB
fun int OsinatoB (Event three){
    three => now;
    for( 0 => int j; j < 2; j++){
        for( 0 => int i; i < pitchOstB.cap(); i++){
            <<< i, pitchOstB[i] >>>; // print index and value
            Std.mtof(pitchOstB[i]) => ostB.freq;
            volumeOstB[i] => ostB.gain;
            durOstB[i]::ms => now; // advance time 
        }
    }
}

// OsinatoC
fun int OsinatoC (Event four){
    four => now;
    for( 0 => int j; j < 3; j++){
        for( 0 => int i; i < pitchOstC.cap(); i++){
            <<< i, pitchOstC[i] >>>; // print index and value
            Std.mtof(pitchOstC[i]) => ostC.freq;
            volumeOstC[i] => ostC.gain;
            durOstC[i]::ms => now; // advance time 
        }
    }
}


// 6849 composition by Kengchakaj Kengkarnka
// Bass line
for( 0 => int i; i < 2; i++){
    spork ~ melody(one);

    me.yield();
    one.broadcast();
    0 => ostA.gain;
    0 => ostB.gain;
    0 => ostC.gain;
    8100::ms => now;
}


// Bass line + OstA
for( 0 => int i; i < 2; i++){
    spork ~ melody(one);
    spork ~ OsinatoA(two);

    me.yield();
    one.broadcast();
    two.broadcast();
    0 => ostB.gain;
    0 => ostC.gain;
    8100::ms => now;
}


// Bass line + OstB
for( 0 => int i; i < 2; i++){
    spork ~ melody(one);
    spork ~ OsinatoB(three);

    me.yield();
    one.broadcast();
    three.broadcast();
    0 => ostA.gain;
    0 => ostC.gain;
    8100::ms => now;
}

// Bass line + OstB + OstC
for( 0 => int i; i < 2; i++){
    spork ~ melody(one);
    spork ~ OsinatoB(three);
    spork ~ OsinatoC(four);
    
    me.yield();
    one.broadcast();
    three.broadcast();
    four.broadcast();
    0 => ostA.gain;
    0 => ostB.gain;
    8100::ms => now;
}

    
// Bass line
spork ~ melody(one);
        
me.yield();
one.broadcast();
0 => ostA.gain;
0 => ostB.gain;
0 => ostC.gain;
8100::ms => now;
    






