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



% Starts the interpreter 

guilt :- ask_user, forward.


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












