% This file contains the Forward Chaining Interpreter for Joel Wilhelm
% and Dallas Barnett's Homework 4 / 5.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Directives (must be at the top of your SWI Prolog program.
% Syntax may differ in other Prolog interpreters. This is
% needed so the program can assert the fact predicate.
:- dynamic fact(1) .

% Operator definitions needed for forward chaining if-then rules.
:- op(800,fx,if).
:- op(700,xfx,then).
:- op(300,xfy,or).
:- op(200,xfy,and).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%defining the BN relations

parent(julianA, didHack).
parent(julianA, possessedInfo).
parent(julianA, didEscape).
parent(edwardS, didEScape).
parent(edwardS, hasClearance).
parent(edwardS, didStealInfo).
parent(didHack, inEmbassy).
parent(didHack, possessedInfo).
parent(didEscape, possessedInfo).
parent(didEscape, hasClearance).
parent(didStealInfo, hasClearance).
parent(didStealInfo, govWorker).
parent(inEmbassy, passedLeaks).
parent(possessedInfo, passedLeaks).
parent(possessedInfo, infoLeaked).
parent(hasClearance, infoLeaked).
parent(hasClearance, stoodTrial).
parent(govWorker, stoodTrail).



%prior probabilities

p(julianA, 0.8).
p(edwardS, 0.8).

%conditional probabilities

p(didHack, [julianA], 0.5).
p(didHack, [not(julianA)], 0.4).

p(didEscape, [julianA, edwardS], 0.5).
p(didEscape, [julianA, not(edwardS)], 0.3).
p(didEscape, [not(julianA), edwardS], 0.3).
p(didEscape, [not(julianA), not(edwardS)], 0.4).

p(didStealInfo, [edwardS], 0.7).
p(didStealInfo, [not(edwardS)], 0.7).

p(inEmbassy, [didHack], 0.456).
p(inEmbassy, [not(didHack)], 0.56).

p(possessedInfo, [didHack, julianA, didEscape], 0.543).
p(possessedInfo, [didHack, julianA, not(didEscape)], 0.62).
p(possessedInfo, [didHack, not(julianA), didEscape], 0.454).
p(possessedInfo, [didHack, not(julianA), not(didEscape)], 0.756).
p(possessedInfo, [not(didHack), julianA, didEscape], 0.456).
p(possessedInfo, [not(didHack), julianA, not(didEscape)], 0.523).
p(possessedInfo, [not(didHack), not(julianA), didEscape], 0.675).
p(possessedInfo, [not(didHack), not(julianA), not(didEscape)], 0.345).

p(hasClearance, [didEscape, edwardS, didStealInfo], 0.4).
p(hasClearance, [didEscape, edwardS, not(didStealInfo)], 0.6).
p(hasClearance, [didEscape, not(edwardS), didStealInfo], 0.3).
p(hasClearance, [didEscape, not(edwardS), not(didStealInfo)], 0.8).
p(hasClearance, [not(didEscape), edwardS, didStealInfo], 0.45).
p(hasClearance, [not(didEscape), edwardS, not(didStealInfo)], 0.42).
p(hasClearance, [not(didEscape), not(edwardS), didStealInfo], 0.24).
p(hasClearance, [not(didEscape), not(edwardS), not(didStealInfo)], 0.32).

p(govWorker, [didStealInfo], 0.7).
p(govWorker, [not(didStealInfo)], 0.8).

p(passedLeaks, [inEmbassy, possessedInfo], 0.89).
p(passedLeaks, [inEmbassy, not(possessedInfo)], 0.46).
p(passedLeaks, [not(inEmbassy), possessedInfo], 0.3).
p(passedLeaks, [not(inEmbassy), not(possessedInfo)], 0.1).

p(infoLeaked, [possessedInfo, hasClearance], 0.9).
p(infoLeaked, [possessedInfo, not(hasClearance)], 0.1).
p(infoLeaked, [not(possessedInfo), hasClearance], 0.54).
p(infoLeaked, [not(possessedInfo), not(hasClearance)], 0.2).

p(stoodTrial, [hasClearance, govWorker], 0.34).
p(stoodTrial, [hasClearance, not(govWorker)], 0.34).
p(stoodTrial, [not(hasClearance), govWorker], 0.5).
p(stoodTrial, [not(hasClearance), not(govWorker)], 0.1).


justice:- guilty,sentencing.

guilty:-
	write('Did the suspect hack an agency? (y or n): '), read(Ans1), trans1(Ans1, DidHack),
	write('Did the suspect escape the country? (y or n): '), read(Ans2), trans2(Ans2, DidEscape),
	write('Did the suspect steal any information? (y or n): '), read(Ans3), trans3(Ans3, DidStealInfo),

	L = [DidHack, DidEscape, DidStealInfo],

	prob(edwardS, L, EdwardProb),
        prob(julianA, L, JulianProb),
        mostGuilty(EdwardProb, JulianProb).

mostGuilty(X,Y):- (X<Y), write('Edward Snowden is most guilty, with a probability of '), write(X), nl.
mostGuilty(X,Y):- (Y<X), write('Julian Assange is most guilty, with a probability of '), write(Y), nl.

trans1(y, didHack).
trans1(n, not(didHack)).

trans2(y, didEscape).
trans2(n, not(didEscape)).

trans3(y, didStealInfo).
trans3(n, not(didStealInfo)).

% Starts the interpreter

sentencing :- ask_user, forward.


ask_user :- write('Was the suspect in the military? (y or n): '), read(Ans), assert_military(Ans).

assert_military(y) :- assert(fact(military)), question_2.
assert_military(n) :- question_2.


question_2 :- write('Does the suspect have a criminal record? (y or n): '), read(Ans), assert_criminal(Ans).

assert_criminal(y) :- assert(fact(criminal)), question_3.
assert_criminal(n) :- question_3.


question_3 :- write('Does the suspect show remorse? (y or n): '), read(Ans), assert_remorse(Ans).

assert_remorse(y) :- assert(fact(remorse)), question_4.
assert_remorse(n) :- question_4.


question_4 :- write('Did the suspect willingly commit this crime? (y or n): '), read(Ans), assert_willing(Ans).

assert_willing(y) :- assert(fact(willing)), question_5.
assert_willing(n) :- question_7.


question_5 :- write('Did the suspect intend to interfere with the operation or success of the
armed forces of the United States of America, or promote success of its enemies? (y or n): '),
read(Ans), assert_serious(Ans).

assert_serious(y) :- assert(fact(serious)), question_7.
assert_serious(n) :- question_6.


question_6 :- write('Did the suspect intend to cause insubordination, disloyalty, mutiny, refusal
 of duty, or to obstruct the recruitment or enlistment service of the United States of America?
(y or n): '), read(Ans), assert_petty(Ans).

assert_petty(y) :- assert(fact(petty)), question_7.
assert_petty(n) :- question_7.


question_7 :- write('Was the suspect mentally ill? (y or n): '), read(Ans), assert_ill(Ans).

assert_ill(y) :- assert(fact(ill)), write('End of questions').
assert_ill(n) :- write('End of questions.').






% Rule derivation

if military then the_punishment_for_the_suspect_is_death.

if not(military) and criminal and willing and serious then the_punishment_for_the_suspect_is_death.
if not(military) and criminal and willing and petty then the_punishment_for_the_suspect_is_life_with_possible_parole.
if not(military) and criminal and not(willing) and not(ill) then the_punishment_for_the_suspect_is_10000_dollar_fine_and_20_years.
if not(military) and criminal and not(willing) and ill then the_punishment_for_the_suspect_is_20_years.
if not(military) and not(criminal) and willing and serious then the_punishment_for_the_suspect_is_death.
if not(military) and not(criminal) and willing and petty then the_punishment_for_the_suspect_is_10000_dollar_fine_and_30_years.
if not(military) and not(criminal) and not(willing) and remorse and ill then the_punishment_for_the_suspect_is_5000_dollar_fine_and_mental_health_help.
if not(military) and not(criminal) and not(willing) and remorse and not(ill) then the_punishment_for_the_suspect_is_5000_dollar_fine_and_1_year.
if not(military) and not(criminal) and not(willing) and not(remorse) and ill then the_punishment_for_the_suspect_is_7500_dollar_fine_and_5_years.
if not(military) and not(criminal) and not(willing) and not(remorse) and not(ill) then the_punishment_for_the_suspect_is_7500_dollar_fine_and_10_years.
