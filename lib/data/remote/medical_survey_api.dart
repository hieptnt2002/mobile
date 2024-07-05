import 'package:make_appointment_app/data/models/medical_survey_answer.dart';

class MedicalSurveyApi {
  Future<dynamic> sendSurveyAnswers({
    required List<MedicalSurveyAnswer> surveyAnswers,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<dynamic> getMedicalSurveyQuestions({required int appointmentId}) {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        return '''
  [
    {
      "id": "q1",
      "questionContents": [
        {
          "content":
              "Please double-check the notes for the affiliated medical institution and the subject you will be visiting.",
          "isEmphasized": true
        },
        {
          "content":
              "・This is an elective medical treatment that is not covered by public health insurance.",
          "isEmphasized": false
        },
        {
          "content": "・Those under 18 and over 75 cannot be treated.",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "Confirmed", "nextQuestionId": "q2"}
      ]
    },
    {
      "id": "q2",
      "questionContents": [
        {
          "content":
              "Next, we will ask about your health condition and medical history.",
          "isEmphasized": true
        },
        {"content": "Have you ever been sick?", "isEmphasized": false}
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "No", "nextQuestionId": "q4"},
        {"answerText": "Yes", "nextQuestionId": "q3"}
      ]
    },
    {
      "id": "q3",
      "questionContents": [
        {
          "content": "Please enter the name of the disease.",
          "isEmphasized": false
        }
      ],
      "questionType": "input",
      "answers": [
        {"answerText": null, "nextQuestionId": "q4"}
      ]
    },
    {
      "id": "q4",
      "questionContents": [
        {
          "content":
              "Have you ever had anything abnormal pointed out during a health check?",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "No", "nextQuestionId": "q7"},
        {"answerText": "Yes", "nextQuestionId": "q5"}
      ]
    },
    {
      "id": "q5",
      "questionContents": [
        {
          "content":
              "Please select the indicated item. (Multiple selections possible)",
          "isEmphasized": false
        }
      ],
      "questionType": "checkbox",
      "answers": [
        {"answerText": "Blood pressure", "nextQuestionId": "q7"},
        {"answerText": "Electrocardiogram", "nextQuestionId": "q7"},
        {"answerText": "Liver function", "nextQuestionId": "q7"},
        {"answerText": "Kidney function", "nextQuestionId": "q7"},
        {"answerText": "Blood glucose level", "nextQuestionId": "q7"},
        {"answerText": "Other", "nextQuestionId": "q6"}
      ]
    },
    {
      "id": "q6",
      "questionContents": [
        {
          "content": "Please enter the information indicated.",
          "isEmphasized": false
        }
      ],
      "questionType": "input",
      "answers": [
        {"answerText": null, "nextQuestionId": "q7"}
      ]
    },
    {
      "id": "q7",
      "questionContents": [
        {
          "content": "Are you currently undergoing treatment for any illness?",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "No", "nextQuestionId": "q9"},
        {"answerText": "Yes", "nextQuestionId": "q8"}
      ]
    },
    {
      "id": "q8",
      "questionContents": [
        {
          "content": "Please enter the name of the disease.",
          "isEmphasized": false
        }
      ],
      "questionType": "input",
      "answers": [
        {"answerText": null, "nextQuestionId": "q9"}
      ]
    },
    {
      "id": "q9",
      "questionContents": [
        {
          "content":
              "Are you currently taking any medications? Please answer only if they are not for female AGA.",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "No", "nextQuestionId": "q14"},
        {"answerText": "Yes", "nextQuestionId": "q10"}
      ]
    },
    {
      "id": "q10",
      "questionContents": [
        {
          "content":
              "Please enter the name of the medicine and the purpose of taking it (such as the name of the disease). Example: Amlodipine (high blood pressure)",
          "isEmphasized": false
        }
      ],
      "questionType": "input",
      "answers": [
        {"answerText": null, "nextQuestionId": "q11"}
      ]
    },
    {
      "id": "q11",
      "questionContents": [
        {
          "content": "Are you taking any blood pressure medications?",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "No", "nextQuestionId": "q14"},
        {"answerText": "Yes", "nextQuestionId": "q12"}
      ]
    },
    {
      "id": "q12",
      "questionContents": [
        {
          "content":
              "Have you changed your medication type or dosage within the last month?",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "No changes", "nextQuestionId": "q14"},
        {"answerText": "Changes", "nextQuestionId": "q14"}
      ]
    },
    {
      "id": "q13",
      "questionContents": [
        {
          "content":
              "Have you changed your medication type or dosage within the last month?",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "No changes", "nextQuestionId": "q7"},
        {"answerText": "Changes", "nextQuestionId": "q5"}
      ]
    },
    {
      "id": "q14",
      "questionContents": [
        {
          "content":
              "Please tell us your last blood pressure measurement. If you are taking antihypertensive medication, please enter the value after treatment.",
          "isEmphasized": false
        },
        {
          "content":
              "First, please enter your blood pressure above (systolic blood pressure). If you do not remember the exact value, an estimate is fine.",
          "isEmphasized": false
        }
      ],
      "questionType": "checkbox",
      "answers": [
        {"answerText": "Less than 50", "nextQuestionId": "q15"},
        {"answerText": "50 to less than 85", "nextQuestionId": "q15"},
        {"answerText": "85 to less than 100", "nextQuestionId": "q15"},
        {"answerText": "100 or more", "nextQuestionId": "q15"},
        {"answerText": "Don't know", "nextQuestionId": "q15"}
      ]
    },
    {
      "id": "q15",
      "questionContents": [
        {
          "content": "Do you have any medication allergies?",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "No", "nextQuestionId": "q17"},
        {"answerText": "Yes", "nextQuestionId": "q16"}
      ]
    },
    {
      "id": "q16",
      "questionContents": [
        {
          "content":
              "Please enter which medication you had an allergic reaction to.",
          "isEmphasized": false
        }
      ],
      "questionType": "input",
      "answers": [
        {"answerText": null, "nextQuestionId": "q17"}
      ]
    },
    {
      "id": "q17",
      "questionContents": [
        {
          "content":
              "Are there any that apply to you? (Multiple choices possible)",
          "isEmphasized": false
        }
      ],
      "questionType": "checkbox",
      "answers": [
        {"answerText": "Not applicable", "nextQuestionId": "q18"},
        {
          "answerText": "Pregnant or possibly pregnant",
          "nextQuestionId": "q18"
        },
        {"answerText": "Breastfeeding", "nextQuestionId": "q18"}
      ]
    },
    {
      "id": "q18",
      "questionContents": [
        {
          "content":
              "Next, we will ask you about your history of taking female AGA medication and your symptoms.",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "Next", "nextQuestionId": "q19"}
      ]
    },
    {
      "id": "q19",
      "questionContents": [
        {
          "content": "Have you ever taken medication for female AGA?",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "No (first time)", "nextQuestionId": "q20"},
        {"answerText": "Yes", "nextQuestionId": "q20"}
      ]
    },
    {
      "id": "q20",
      "questionContents": [
        {
          "content":
              "Please select the symptoms that concern you. (Multiple selections possible)",
          "isEmphasized": false
        }
      ],
      "questionType": "checkbox",
      "answers": [
        {"answerText": "Increased hair loss", "nextQuestionId": "q21"},
        {"answerText": "Hair has thinned", "nextQuestionId": "q21"},
        {"answerText": "Hair breaks easily", "nextQuestionId": "q21"},
        {
          "answerText": "Hair has lost shine and strength",
          "nextQuestionId": "q21"
        }
      ]
    },
    {
      "id": "q21",
      "questionContents": [
        {
          "content":
              "Please select when you first began to notice the symptoms.",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "1 month ago", "nextQuestionId": "q22"},
        {"answerText": "3 months ago", "nextQuestionId": "q22"},
        {"answerText": "6 months ago", "nextQuestionId": "q22"},
        {"answerText": "1 year ago", "nextQuestionId": "q22"},
        {"answerText": "Over a year ago", "nextQuestionId": "q22"}
      ]
    },
    {
      "id": "q22",
      "questionContents": [
        {
          "content":
              "Please select the effect you most want from treatment. (Multiple choices possible)",
          "isEmphasized": false
        }
      ],
      "questionType": "checkbox",
      "answers": [
        {"answerText": "Less hair loss", "nextQuestionId": "q23"},
        {"answerText": "Increased hair count", "nextQuestionId": "q23"},
        {"answerText": "Thicker hair", "nextQuestionId": "q23"}
      ]
    },
    {
      "id": "q23",
      "questionContents": [
        {
          "content": "Does anyone in your family have thinning hair?",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "No", "nextQuestionId": "q24"},
        {"answerText": "Yes", "nextQuestionId": "q24"}
      ]
    },
    {
      "id": "q24",
      "questionContents": [
        {
          "content": "Now, I'd like to ask you a question about medication.",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "Next", "nextQuestionId": "q25"}
      ]
    },
    {
      "id": "q25",
      "questionContents": [
        {
          "content":
              "We will check whether you can prescribe certain medications. Are there any that apply to you? (Multiple choices possible)",
          "isEmphasized": false
        }
      ],
      "questionType": "checkbox",
      "answers": [
        {"answerText": "None", "nextQuestionId": "q26"},
        {"answerText": "Liver dysfunction", "nextQuestionId": "q26"},
        {
          "answerText": "Anuria or acute renal failure",
          "nextQuestionId": "q26"
        },
        {"answerText": "Hyperkalemia", "nextQuestionId": "q26"},
        {"answerText": "Addison's disease", "nextQuestionId": "q26"},
        {
          "answerText":
              "Tacrolimus, eplerenone, esaxerenone, or mitotane being administered",
          "nextQuestionId": "q26"
        },
        {"answerText": "Kidney dysfunction", "nextQuestionId": "q26"},
        {
          "answerText":
              "History or disease of the circulatory system, such as the heart, lungs, or blood vessels",
          "nextQuestionId": "q26"
        },
        {"answerText": "Arrhythmia", "nextQuestionId": "q26"},
        {
          "answerText": "Uncontrolled hypertension (160/100mmHg or higher)",
          "nextQuestionId": "q26"
        },
        {
          "answerText": "Hypotension (less than 90/50mmHg)",
          "nextQuestionId": "q26"
        },
        {
          "answerText":
              "Rash, eczema, or wounds on the scalp that produce pus or dandruff",
          "nextQuestionId": "q26"
        },
        {
          "answerText": "Trying to conceive or undergoing fertility treatment",
          "nextQuestionId": "q26"
        }
      ]
    },
    {
      "id": "q26",
      "questionContents": [
        {
          "content":
              "Our affiliated medical institutions handle drugs not approved in Japan (including off-label use of approved drugs) in the following subjects.",
          "isEmphasized": false
        },
        {
          "content":
              "If you take a drug not approved in Japan (including off-label use of approved drugs) and experience serious side effects, you will not be covered by the national drug side effect relief system. Please be aware of this in advance.",
          "isEmphasized": false
        },
        {
          "content":
              "*Drug Side Effect Relief System: A public system that provides relief for health damage when serious side effects occur despite the proper use of nationally approved drugs.",
          "isEmphasized": false
        },
        {"content": "▼Female AGA", "isEmphasized": false},
        {
          "content": "・Spironolactone tablets 25mg, 50mg",
          "isEmphasized": false
        },
        {"content": "・Minoxidil tablets 2.5mg, 5mg", "isEmphasized": false},
        {"content": "・Minoxidil lotion 2%", "isEmphasized": false},
        {"content": "・L-lysine", "isEmphasized": false},
        {
          "content": "*List of other subjects and unapproved drugs",
          "isEmphasized": false
        },
        {"content": "▼Medical diet, obesity", "isEmphasized": false},
        {"content": "・Rebelsus tablets 3mg, 7mg, 14mg", "isEmphasized": false},
        {"content": "・Jardiance 10mg, 25mg", "isEmphasized": false},
        {"content": "・Acarbose tablets 50mg, 100 mg", "isEmphasized": false},
        {"content": "・Kudzu flower & black ginger", "isEmphasized": false},
        {"content": "・Multivitamin & minerals", "isEmphasized": false},
        {"content": "・Essential amino acids", "isEmphasized": false},
        {"content": "・Heme iron", "isEmphasized": false},
        {"content": "▼Insomnia, sleep disorders", "isEmphasized": false},
        {"content": "・Rahma & amino acids", "isEmphasized": false},
        {"content": "・Rahma & lactic acid bacteria", "isEmphasized": false},
        {"content": "▼Medical skin care", "isEmphasized": false},
        {"content": "・Vitamin C & pantothenic acid", "isEmphasized": false},
        {"content": "・B vitamins", "isEmphasized": false},
        {"content": "・L-cystine 100", "isEmphasized": false},
        {"content": "▼Influenza prevention", "isEmphasized": false},
        {"content": "・Inavir inhalation powder 20mg", "isEmphasized": false},
        {"content": "・Relenza", "isEmphasized": false},
        {
          "content": "・Oseltamivir capsule 75mg (Tamiflu generic)",
          "isEmphasized": false
        },
        {"content": "▼Medical eyelashes", "isEmphasized": false},
        {
          "content": "・Bimatoprost (Glashes Vista generic)",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "Agree", "nextQuestionId": "q27"},
        {"answerText": "Disagree", "nextQuestionId": "q27"}
      ]
    },
    {
      "id": "q27",
      "questionContents": [
        {
          "content": "Have you decided which medicine you want?",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "I've already decided", "nextQuestionId": "q28"},
        {
          "answerText":
              "I haven't decided yet, I'd like to know your recommendations",
          "nextQuestionId": "q28"
        }
      ]
    },
    {
      "id": "q28",
      "questionContents": [
        {
          "content":
              "Please select the desired medication. (Multiple selections possible)",
          "isEmphasized": false
        },
        {
          "content":
              "*Depending on the delivery situation due to reasons such as shipping adjustments, we may deliver an alternative medication (e.g., a different manufacturer, a different dosage form such as capsules instead of tablets, etc.). Thank you for your understanding.",
          "isEmphasized": false
        }
      ],
      "questionType": "checkbox",
      "answers": [
        {
          "answerText":
              "Preventive plan (spironolactone tablets 50mg, L-lysine)",
          "nextQuestionId": "q29"
        },
        {
          "answerText":
              "Light hair growth plan (spironolactone tablets 50mg, minoxidil tablets 2.5mg)",
          "nextQuestionId": "q29"
        },
        {
          "answerText":
              "Basic hair growth plan (spironolactone tablets 50mg, minoxidil tablets 2.5mg, L-lysine)",
          "nextQuestionId": "q29"
        },
        {
          "answerText":
              "Strong hair growth plan (spironolactone tablets 50mg, minoxidil tablets 2.5mg, L-lysine, minoxidil lotion 2%)",
          "nextQuestionId": "q29"
        },
        {
          "answerText": "Mini hair growth plan (minoxidil tablets 2.5mg)",
          "nextQuestionId": "q29"
        },
        {"answerText": "Spironolactone tablets 25mg", "nextQuestionId": "q29"},
        {"answerText": "Spironolactone tablets 50mg", "nextQuestionId": "q29"},
        {"answerText": "Minoxidil tablets 5mg", "nextQuestionId": "q29"},
        {"answerText": "Minoxidil lotion 2%", "nextQuestionId": "q29"},
        {
          "answerText":
              "Carpronium chloride topical solution 5% Monthly set of 3 bottles",
          "nextQuestionId": "q29"
        },
        {
          "answerText":
              "Carpronium chloride topical solution 5% Monthly set of 5 bottles",
          "nextQuestionId": "q29"
        },
        {"answerText": "AGA tablets L-lysine", "nextQuestionId": "q29"}
      ]
    },
    {
      "id": "q29",
      "questionContents": [
        {
          "content":
              "Please enter any questions you would like to discuss with us or anything you would like to tell us in advance.",
          "isEmphasized": false
        }
      ],
      "questionType": "input",
      "answers": [
        {"answerText": null, "nextQuestionId": "q30"}
      ]
    },
    {
      "id": "q30",
      "questionContents": [
        {
          "content":
              "Finally, please read the precautions before your appointment.",
          "isEmphasized": true
        },
        {"content": "[About consultations]", "isEmphasized": false},
        {
          "content":
              "Please note that if you do not enter the room within 15 minutes of the start of the consultation, your appointment will be automatically canceled.",
          "isEmphasized": false
        },
        {
          "content":
              "Please turn on your camera and microphone during the consultation.",
          "isEmphasized": false
        },
        {
          "content":
              "We cannot provide consultations if you are driving a car or bicycle.",
          "isEmphasized": false
        },
        {
          "content":
              "For the purpose of improving quality, the contents of the consultation will be recorded.",
          "isEmphasized": false
        },
        {"content": "[About delivery]", "isEmphasized": false},
        {
          "content":
              "In principle, we cannot accept exchanges, returns, or refunds due to patient convenience after shipping.",
          "isEmphasized": false
        },
        {
          "content":
              "Please make sure that the delivery address is a place where the patient can receive the item.",
          "isEmphasized": false
        },
        {
          "content":
              "If the medication is returned, a re-delivery fee of 550 yen will be charged.",
          "isEmphasized": false
        },
        {
          "content":
              "We are not responsible for any loss of medication after it has been delivered to the specified address.",
          "isEmphasized": false
        },
        {"content": "[About payment]", "isEmphasized": false},
        {
          "content":
              "If a payment error occurs and two business days have passed without you responding, the order will be canceled. Thank you for your understanding.",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "Confirmed", "nextQuestionId": "q31"}
      ]
    },
    {
      "id": "q31",
      "questionContents": [
        {
          "content":
              "This completes the questions you need to answer. Please confirm the consultation method and then submit your answers.",
          "isEmphasized": false
        },
        {
          "content":
              "▼On the day of your appointment, when it is time, press the 'Start Consultation' button on your My Page and enter the online tool yourself.",
          "isEmphasized": false
        },
        {
          "content":
              "*The consultation will begin within 15 minutes of the consultation start time.",
          "isEmphasized": false
        },
        {
          "content":
              "*Please remain in the room and wait during your appointment hours.",
          "isEmphasized": false
        }
      ],
      "questionType": "radio",
      "answers": [
        {"answerText": "Confirmed", "nextQuestionId": null}
      ]
    }
  ]
  ''';
      },
    );
  }

  Future<dynamic> getMedicalSurveyAnswers({required String treatmentId}) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return '''
        [
          {
            "id": "a1",
            "answerText": "Confirmed",
            "surveyQuestion": {
              "id": "q1",
              "questionContents": [
                {
                  "content":
                      "Please double-check the notes for the affiliated medical institution and the subject you will be visiting.",
                  "isEmphasized": true
                },
                {
                  "content":
                      "・This is an elective medical treatment that is not covered by public health insurance.",
                  "isEmphasized": false
                },
                {
                  "content": "・Those under 18 and over 75 cannot be treated.",
                  "isEmphasized": false
                }
              ],
              "questionType": "radio",
              "answers": [
                {"answerText": "Confirmed", "nextQuestionId": "q2"}
              ]
            }
          },
          {
            "id": "a2",
            "answerText": "No",
            "surveyQuestion": {
              "id": "q2",
              "questionContents": [
                {
                  "content":
                      "Next, we will ask about your health condition and medical history.",
                  "isEmphasized": true
                },
                {"content": "Have you ever been sick?", "isEmphasized": false}
              ],
              "questionType": "radio",
              "answers": [
                {"answerText": "No", "nextQuestionId": "q4"},
                {"answerText": "Yes", "nextQuestionId": "q3"}
              ]
            }
          },
          {
            "id": "a3",
            "answerText": "Confirmed",
            "surveyQuestion": {
              "id": "q3",
              "questionContents": [
                {
                  "content": "Please enter the name of the disease.",
                  "isEmphasized": false
                }
              ],
              "questionType": "input",
              "answers": [
                {"answerText": "null", "nextQuestionId": "q4"}
              ]
            }
          },
          {
            "id": "a4",
            "answerText": "No",
            "surveyQuestion": {
              "id": "q4",
              "questionContents": [
                {
                  "content":
                      "Have you ever had anything abnormal pointed out during a health check?",
                  "isEmphasized": false
                }
              ],
              "questionType": "radio",
              "answers": [
                {"answerText": "No", "nextQuestionId": "q7"},
                {"answerText": "Yes", "nextQuestionId": "q5"}
              ]
            }
          },
          {
            "id": "a5",
            "answerText": "Blood pressure",
            "surveyQuestion": {
              "id": "q5",
              "questionContents": [
                {
                  "content":
                      "Please select the indicated item. (Multiple selections possible)",
                  "isEmphasized": false
                }
              ],
              "questionType": "checkbox",
              "answers": [
                {"answerText": "Blood pressure", "nextQuestionId": "q7"},
                {"answerText": "Electrocardiogram", "nextQuestionId": "q7"},
                {"answerText": "Liver function", "nextQuestionId": "q7"},
                {"answerText": "Kidney function", "nextQuestionId": "q7"},
                {"answerText": "Blood glucose level", "nextQuestionId": "q7"},
                {"answerText": "Other", "nextQuestionId": "q6"}
              ]
            }
          },
          {
            "id": "a6",
            "answerText": "Confirmed",
            "surveyQuestion": {
              "id": "q6",
              "questionContents": [
                {
                  "content": "Please enter the information indicated.",
                  "isEmphasized": false
                }
              ],
              "questionType": "input",
              "answers": [
                {"answerText": "null", "nextQuestionId": "q7"}
              ]
            }
          },
          {
            "id": "a7",
            "answerText": "No",
            "surveyQuestion": {
              "id": "q7",
              "questionContents": [
                {
                  "content":
                      "Are you currently undergoing treatment for any illness?",
                  "isEmphasized": false
                }
              ],
              "questionType": "radio",
              "answers": [
                {"answerText": "No", "nextQuestionId": "q9"},
                {"answerText": "Yes", "nextQuestionId": "q8"}
              ]
            }
          },
          {
            "id": "a8",
            "answerText": "Confirmed",
            "surveyQuestion": {
              "id": "q8",
              "questionContents": [
                {
                  "content": "Please enter the name of the disease.",
                  "isEmphasized": false
                }
              ],
              "questionType": "input",
              "answers": [
                {"answerText": "null", "nextQuestionId": "q9"}
              ]
            }
          },
          {
            "id": "a9",
            "answerText": "No",
            "surveyQuestion": {
              "id": "q9",
              "questionContents": [
                {
                  "content":
                      "Are you currently taking any medications? Please answer only if they are not for female AGA.",
                  "isEmphasized": false
                }
              ],
              "questionType": "radio",
              "answers": [
                {"answerText": "No", "nextQuestionId": "q14"},
                {"answerText": "Yes", "nextQuestionId": "q10"}
              ]
            }
          },
          {
            "id": "a10",
            "answerText": "Confirmed",
            "surveyQuestion": {
              "id": "q10",
              "questionContents": [
                {
                  "content":
                      "Please enter the name of the medicine and the purpose of taking it (such as the name of the disease). Example: Amlodipine (high blood pressure).",
                  "isEmphasized": false
                }
              ],
              "questionType": "input",
              "answers": [
                {"answerText": "null", "nextQuestionId": "q11"}
              ]
            }
          },
          {
            "id": "a11",
            "answerText": "No",
            "surveyQuestion": {
              "id": "q11",
              "questionContents": [
                {
                  "content": "Are you taking any blood pressure medications?",
                  "isEmphasized": false
                }
              ],
              "questionType": "radio",
              "answers": [
                {"answerText": "No", "nextQuestionId": "q14"},
                {"answerText": "Yes", "nextQuestionId": "q12"}
              ]
            }
          },
          {
            "id": "a12",
            "answerText": "No changes",
            "surveyQuestion": {
              "id": "q12",
              "questionContents": [
                {
                  "content":
                      "Have you changed your medication type or dosage within the last month?",
                  "isEmphasized": false
                }
              ],
              "questionType": "radio",
              "answers": [
                {"answerText": "No changes", "nextQuestionId": "q14"},
                {"answerText": "Changes", "nextQuestionId": "q14"}
              ]
            }
          },
          {
            "id": "a13",
            "answerText": "Changes",
            "surveyQuestion": {
              "id": "q13",
              "questionContents": [
                {
                  "content":
                      "Have you changed your medication type or dosage within the last month?",
                  "isEmphasized": false
                }
              ],
              "questionType": "radio",
              "answers": [
                {"answerText": "No changes", "nextQuestionId": "q7"},
                {"answerText": "Changes", "nextQuestionId": "q5"}
              ]
            }
          },
          {
            "id": "a15",
            "answerText": "No",
            "surveyQuestion": {
              "id": "q15",
              "questionContents": [
                {
                  "content":
                      "Have you had any type of surgery in the past? If so, please enter the details.",
                  "isEmphasized": false
                }
              ],
              "questionType": "input",
              "answers": [
                {"answerText": "No", "nextQuestionId": "q16"},
                {"answerText": "Yes", "nextQuestionId": "q16"}
              ]
            }
          },
          {
            "id": "a16",
            "answerText": "No",
            "surveyQuestion": {
              "id": "q16",
              "questionContents": [
                {
                  "content":
                      "Have you been hospitalized for any reason in the past? If so, please enter the details.",
                  "isEmphasized": false
                }
              ],
              "questionType": "input",
              "answers": [
                {"answerText": "No", "nextQuestionId": "q17"},
                {"answerText": "Yes", "nextQuestionId": "q17"}
              ]
            }
          },
          {
            "id": "a17",
            "answerText": "No",
            "surveyQuestion": {
              "id": "q17",
              "questionContents": [
                {
                  "content":
                      "Are you currently receiving treatment at another hospital?",
                  "isEmphasized": false
                }
              ],
              "questionType": "radio",
              "answers": [
                {"answerText": "No", "nextQuestionId": "q19"},
                {"answerText": "Yes", "nextQuestionId": "q18"}
              ]
            }
          },
          {
            "id": "a18",
            "answerText": "Confirmed",
            "surveyQuestion": {
              "id": "q18",
              "questionContents": [
                {
                  "content":
                      "Please tell us the name of the affiliated hospital and the department name.",
                  "isEmphasized": false
                }
              ],
              "questionType": "input",
              "answers": [
                {"answerText": "null", "nextQuestionId": "q19"}
              ]
            }
          },
          {
            "id": "a19",
            "answerText": "No",
            "surveyQuestion": {
              "id": "q19",
              "questionContents": [
                {
                  "content":
                      "Are you currently taking any supplements? Please answer only if not female.",
                  "isEmphasized": false
                }
              ],
              "questionType": "radio",
              "answers": [
                {"answerText": "No", "nextQuestionId": "q21"},
                {"answerText": "Yes", "nextQuestionId": "q20"}
              ]
            }
          },
          {
            "id": "a20",
            "answerText": "Confirmed",
            "surveyQuestion": {
              "id": "q20",
              "questionContents": [
                {
                  "content":
                      "Please tell us the name of the supplements and the purpose of taking them.",
                  "isEmphasized": false
                }
              ],
              "questionType": "input",
              "answers": [
                {"answerText": "null", "nextQuestionId": "q21"}
              ]
            }
          },
          {
            "id": "a21",
            "answerText": "Confirmed",
            "surveyQuestion": {
              "id": "q31",
              "questionContents": [
                {
                  "content":
                      "This completes the questions you need to answer. Please confirm the consultation method and then submit your answers.",
                  "isEmphasized": false
                },
                {
                  "content":
                      "▼On the day of your appointment, when it is time, press the 'Start Consultation' button on your My Page and enter the online tool yourself.",
                  "isEmphasized": false
                },
                {
                  "content":
                      "*The consultation will begin within 15 minutes of the consultation start time.",
                  "isEmphasized": false
                },
                {
                  "content":
                      "*Please remain in the room and wait during your appointment hours.",
                  "isEmphasized": false
                }
              ],
              "questionType": "radio",
              "answers": [
                {"answerText": "Confirmed", "nextQuestionId": null}
              ]
            }
          }
        ]
        ''';
      },
    );
  }
}
