// Sonification Test writen by Daniel Maszkowicz
// Part of Beginner SuperCollider Workshop
// SZKMD production - ooo.szkmd.ooo
//
// Synth Sinegrane found in The Sonification Handbook - Chapter 10 - Laboratory Methods for Experimental Sonification, chapter by Till Bovermann, Julian Rohrhuber and Alberto de Campo

// Full book in open access
// https://sonification.de/handbook/


s.boot;
s.quit

s.record
s.stopRecording;

(
SynthDef(\sinegrain, {
	|out = 0, attack = 0.101, decay = 0.01, freq=200, pan = 0, amp = 0.5|
	var sound, env;
	// an amplitude envelope with fixed duration
	env = EnvGen.ar(Env.perc(attack, decay), doneAction: 2);
	// the underlying sound
	sound = FSinOsc.ar(freq);
	// use the envelope to control sound amplitude:.
	sound = sound*(env*amp);
	// add stereo panning
	sound = Pan2.ar(sound, pan);
	// write to output bus
	Out.ar(out, sound)
}).add;
)

//test the synth!

p=Synth(\sinegrain,[\out,0,\freq,100,\attack,0.01,\decay,2,\amp,0.3,\dur,0.2]);

// Run a pattern (\dur is a variable used in Pbind)
(
p=Pbind(\instrument, \sinegrain,
	\freq, Pseq([100,400,370,330],1),
	\attack, 0.5,
	\decay, 20,
	\pan, Pseq([-1,1],inf),
	\dur, 0.5,
	\amp, 0.1
).play;
)
p.stop;

//Let's grab the Data



// Relative path to the CSV file
~mycsv=CSVFileReader.readInterpret("../../csv/22DataTone.csv",true,true); // Assuming header is true, interpret is true

~mycsv.size; // Good for checking if file was read
// ~mycsv.at(0).postln; // Post the first row to see its structure

// ~mycsv is an array of arrays (if interpret is true and CSV has multiple columns per row without further delimiter spec)
// Or an array of Floats/Integers if it's a single column or not interpreted as multi-column.
// Assuming 22DataTone.csv has: positive,negative,neutral
// And CSVFileReader.readInterpret reads each value into successive elements if not grouped by a specific per-row delimiter
// If readInterpret with true, true gives an array of single numbers, we might need to adjust how it's read or parsed.
// For now, let's assume it reads rows, and each row is an array.

// Extract columns for positive, negative, neutral
// Column 0: positive, Column 1: negative, Column 2: neutral
~mycsv_0=Array.fill(~mycsv.size,{arg i;~mycsv.at(i).asArray.at(0)}); // positive
~mycsv_1=Array.fill(~mycsv.size,{arg i;~mycsv.at(i).asArray.at(1)}); // negative
~mycsv_2=Array.fill(~mycsv.size,{arg i;~mycsv.at(i).asArray.at(2)}); // neutral

// Normalize the data and map them to sound parameters
~freq1 = ~mycsv_0.normalize(200, 1000);   // Positive mapped to frequency
~levels1 = ~mycsv_1.normalize(0.1, 0.8); // Negative mapped to amplitude
~dur1 = ~mycsv_2.normalize(0.1, 1.0);    // Neutral mapped to duration

// Test it in the Synth (simplified Pbind)
// s.record // Uncomment to record
(
p=Pbindef(\soniData, // Using Pbindef to allow easy update/stop
	\instrument, \sinegrain, // Using the later defined sinegrain with Out.kr
	\freq, Pseq(~freq1, inf), // Loop indefinitely for testing
	\attack, Pseq(~mycsv_2.normalize(0.01, 0.2), inf), // Neutral mapped to attack (example alternative)
	\decay, Pseq(~mycsv_2.normalize(0.1, 0.5), inf),   // Neutral mapped to decay (example alternative)
	                                                    // If ~dur1 is used for \dur, attack/decay might be fixed or dynamic
	\pan, Pwhite(-0.5, 0.5, inf), // Random pan
	\dur, Pseq(~dur1, inf),       // Neutral mapped to event duration
	\amp, Pseq(~levels1, inf)
).play;
);
// p.stop; // To stop Pbindef(\soniData).stop; or Cmd+.

// The following Ppar and later Slew section are commented out to focus on the first Pbind.
// You can uncomment and adapt them later if needed.
/*
//Let's switch collumns and play two data sets at a time!

~freq1=~mycsv_0.normalize(100,1000);
~levels1=~mycsv_1.normalize(0.1,1);
~attack1=~mycsv_2.normalize(0.01,0.1); // This was mycsv_2, now neutral
// ~decay1=~mycsv_3.normalize(0.1,0.2); // mycsv_3 removed
// ~dur1=~mycsv_4.normalize(1,2);       // mycsv_4 removed

// ~freq2=~mycsv_4.normalize(200,5000); // mycsv_4 removed
// ~levels2=~mycsv_3.normalize(0.01,0.1); // mycsv_3 removed
// ~attack2=~mycsv_0.normalize(0.01,0.1);
// ~decay2=~mycsv_2.normalize(0.1,0.2);
// ~dur2=~mycsv_1.normalize(1,2);
// s.record
// s.stoprecord

(
p=Ppar([
	Pbind(\instrument, \sinegrain,
	\freq, Pseq(~freq1,inf),
	\attack, Pseq(~attack1,inf),
	// \decay, Pseq(~decay1,inf),
	\pan, 0,
	// \dur, Pseq(~dur1,inf)*Pseq(~freq1,inf),
	\amp, Pseq(~levels1,inf)
	),
	Pbind(\instrument, \sinegrain,
	// \freq, Pseq(~freq2,inf),
	// \attack, Pseq(~attack2,inf),
	// \decay, Pseq(~decay2,inf),
	\pan, 0,
	// \dur, Pseq(~dur2,inf),
	// \amp, Pseq(~levels2,inf)*10
	)
]).play;
)
p.stop;


// Let's add another Synth with a Slew rate.
// Warning, Pbind is creating another Synth at each time it is called,
*/

// The Slew section might use the redefined sinegrain and ~ctrlbus
// Ensure ~mycsv_0, ~mycsv_1, ~mycsv_2 are used here if this section is to be used.
// For now, this part is also effectively commented out by the block comment above.
// If you want to use it, you'll need to move it out of the block comment and ensure
// the data arrays (~freq, ~levels, ~attack, ~decay, ~dur) are defined from
// ~mycsv_0, ~mycsv_1, ~mycsv_2 as done for the first Pbindef.

// Example for Slew section if used:
/*
~ctrlbus = Bus.control(s,1);

(
SynthDef(\sinegrain, { // This is the redefined sinegrain from the original script
	|out = 0, attack = 0.01, decay = 0.01, freq=300, pan = 0, amp = 0.5|
	var sound, env;
	env = EnvGen.ar(Env.perc(attack, decay), doneAction: 2);
	sound = FSinOsc.ar(freq);
	sound = sound*(env*amp);
	sound = Pan2.ar(sound, pan);
	Out.ar(out, sound);
	Out.kr(~ctrlbus,freq/5) // Output control data
}).add;
)

// Remap data for this section:
~freq_slew = ~mycsv_0.normalize(200,5000);   // Positive
~levels_slew = ~mycsv_1.normalize(0.01,0.1); // Negative
~attack_slew = ~mycsv_2.normalize(0.2,0.5);  // Neutral for attack
~decay_slew = ~mycsv_2.normalize(1,2);      // Neutral for decay (example)
~dur_slew = ~mycsv_2.normalize(0.3,0.5);     // Neutral for duration

~sineslewtest=Synth(\sineslew,[\out,0,\freq,400,\amp,0.01,\slewrate,200]);
~sineslewtest.map(\freq, ~ctrlbus);

(
p=Pbindef(\soniSlew, // Give it a unique name if Pbindef(\soniData) is also active
	\instrument, \sinegrain,
	\freq, Pseq(~freq_slew,inf),
	\attack, Pseq(~attack_slew,inf),
	\decay, Pseq(~decay_slew,inf),
	\pan, 0,
	\dur, Pseq(~dur_slew,inf),
	\amp, Pseq(~levels_slew,inf) / Pseq(~decay_slew,inf) // Example amp modulation
).play;
)
// Pbindef(\soniSlew).stop;
// ~sineslewtest.free;
*/
// that's why we use Synths with enveloppes so they "disapear" after their short sound so another sound
// can be called, that is also why Slew does not work when directly put into this kind of Synths..
// But, we can create another Synth that is running all the time that gets a frequency information from
// The Synth that is called by Pbind, through a control bus.

// Try the Sineslew Synth, see how it works, change frequencies and slewrates.

(
SynthDef(\sineslew, {
	|out = 0, freq=300, amp = 0.05, slewrate = 1|
	var sound, f;
	// add slew rate on frequency
	f=Slew.kr(freq,slewrate,slewrate);
	sound = Blip.ar(f,5,amp).dup;
	Out.ar(out, sound)
}).add;
)

~sineslewtest=Synth(\sineslew,[\out,0,\freq,400,\amp,0.05,\slewrate,500])
~sineslewtest.set(\freq,300)
~sineslewtest.set(\freq,400)
~sineslewtest.set(\slewrate,200)
~sineslewtest.free;

// The original Synth has been modified, one line has been added to output a control parameter,
//we need also to set a control bus, and map it to the Synth.

~ctrlbus = Bus.control(s,1);

(
SynthDef(\sinegrain, {
	|out = 0, attack = 0.01, decay = 0.01, freq=300, pan = 0, amp = 0.5|
	var sound, env;
	// an amplitude envelope with fixed duration
	env = EnvGen.ar(Env.perc(attack, decay), doneAction: 2);
	// the underlying sound
	sound = FSinOsc.ar(freq);
	// use the envelope to control sound amplitude:.
	sound = sound*(env*amp);
	// add stereo panning
	sound = Pan2.ar(sound, pan);
	// write to output bus
	Out.ar(out, sound); // Out.ar is an audio output
	Out.kr(~ctrlbus,freq/5) // Out.kr is a control output
}).add;
)

// Let's test it again and play with parameters, chang duration, slewrate,etc...

// Normalize the data between a max val and min val and match them to sound parameters
~freq=~mycsv_0.normalize(200,5000);
~levels=~mycsv_1.normalize(0.01,0.1);
~attack=~mycsv_2.normalize(0.2,0.5);
~decay=~mycsv_3.normalize(1,2);
~dur=~mycsv_4.normalize(0.3,0.5);

// let's run the Synth
~sineslewtest=Synth(\sineslew,[\out,0,\freq,400,\amp,0.01,\slewrate,200]);

// map the control bus to the frequency parameter
~sineslewtest.map(\freq, ~ctrlbus);

//Run the sonification
(
p=Pbind(\instrument, \sinegrain,
	\freq, Pseq(~freq,1),
	\attack, Pseq(~attack,1),
	\decay, Pseq(~decay,1),
	\pan, 0,
	\dur, Pseq(~dur,1),
	\amp, Pseq(~levels,1)/ Pseq(~decay,1)
).play;
)
p.stop;
~sineslewtest.free;

// We could also output another parameter from \sinegrain and map it to another parameter in \sineslew
// such as \amp or \slewrate, through another control channel. Try it!