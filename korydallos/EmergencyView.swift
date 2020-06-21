//
//  EmergencyView.swift
//  korydallos
//
//  Created by user172589 on 8/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI

struct EmergencyView: View {
    var body: some View {
        VStack(alignment:  .leading, spacing: 20){
            //TopBarWithoutNav()
            HStack{
            Text("Σε περίπτωση έκτακτης ανάγκης μπορείτε να καλέσετε την αντίστοιχη υπηρεσία πατώντας επάνω στο εικονίδιο.")
                .padding()
            //
            }

      
            ScrollView {
                VStack(alignment : .leading, spacing: 30){
                    HStack{
                        Spacer()
                        CallerButtonView(btnImage: "korydallos_logo_new", description: "Δήμος Κορυδαλλού", phoneNumber: "2104990500").scaledToFit()
                        Spacer(minLength: 40)
                        CallerButtonView(btnImage: "Elas", description: "Αστυνομία", phoneNumber: "100").scaledToFit()
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        CallerButtonView(btnImage: "EKAB_logo", description: "Ε.Κ.Α.Β.", phoneNumber: "166")
                                              Spacer()
                        CallerButtonView(btnImage: "gscp_logo_xoris_grammata_0", description: "Πολιτική Προστασία", phoneNumber: "2103359002")
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        CallerButtonView(btnImage: "sos1056", description: "Γραμμή SOS", phoneNumber: "1056")
                                              Spacer()
                        CallerButtonView(btnImage: "firedep", description: "Πυροσβεστικό Σώμα", phoneNumber: "199")
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        CallerButtonView(btnImage: "Hellenic_Coast_Guard_logo", description: "Λυμενικό Σώμα", phoneNumber: "1056")
                                              Spacer()
                        CallerButtonView(btnImage: "eody-el", description: "ΕΟΔΥ", phoneNumber: "1135")
                        Spacer()
                    }
                    
                    
                }
                Spacer()
            }
        }
    }
    struct EmergencyView_Previews: PreviewProvider {
        static var previews: some View {
            
            EmergencyView()
            
        }
    }
}
