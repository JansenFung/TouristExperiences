//
//  LoginScreen.swift
//  Project_#6
//
//  Created by Jansen & Gelareh on 2023-03-02.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var preDefinedUsers: PreDefinedUsers
    
    @State var emailAddress: String = ""
    @State var password: String = ""
    @State var rememberMe: Bool = true
    @State var loginFailed: Bool = false
    @State var homeScreenLink: Int?
    @State var isUserNameAndPasswordEmpty: Bool = false
    @State var showPassword: Bool = false
    var paddingSize: Int = UIDevice.current.userInterfaceIdiom == .pad ? 150 : 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            NavigationLink(destination: HomeScreen(), tag: 1, selection: self.$homeScreenLink){}
            Spacer()

            //Title
            HStack(alignment: .center) {
                Image(systemName: "bird.fill")
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .foregroundColor(.blue)
                    .padding(.horizontal)
                
                Text("Downtown Toronto Tour").font(.largeTitle)

            }//HStack
            .padding()
            .frame(maxWidth: .infinity)

            //Username field
            TextField("Email", text: self.$emailAddress)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(.gray, lineWidth: 1))
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            
            //Password field
            ZStack(alignment: .trailing){
                //show or hide the password
                if !self.showPassword {
                    SecureField("Password", text: self.$password)
                        .textFieldStyle(.roundedBorder)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(.gray, lineWidth: 1))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                }
                else {
                    TextField("Password", text: self.$password)
                        .textFieldStyle(.roundedBorder)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(.gray, lineWidth: 1))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                }
                
                Button(action: {
                    self.showPassword.toggle()
                }){
                    Image(systemName: "\(self.showPassword ? "eye.slash.fill" : "eye.fill")")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }

            //Remember Me checkbox
            Toggle("Remember Me", isOn: self.$rememberMe).toggleStyle(CheckboxToggleStyle())
                .padding(.horizontal)
            
            //Login button
            Button(action: {self.logIn()}){
                Text("Sign In")
                    .frame(maxWidth: .infinity)
            }
            .tint(.red)
            .buttonStyle(.borderedProminent)
            .padding()
            .alert(isPresented: self.$loginFailed) {
                Alert(title: Text("Login Failed"),
                      message: Text("\(self.isUserNameAndPasswordEmpty ? "Please enter your email address and password" : "Invaild username or password")"), dismissButton: .default(Text("OK")))
            }//alert
            
            Spacer()
        }//VStack
        .padding(.horizontal, CGFloat(self.paddingSize))
        .navigationBarBackButtonHidden(true)
    }//body
    
    //User login function
    func logIn() {
        //if either username and password is empty
        if self.emailAddress.trimmingCharacters(in: .whitespaces).isEmpty || self.password.isEmpty {
            self.isUserNameAndPasswordEmpty = true
            self.loginFailed = true
            
            return
        }
        
        //if email and password are valid
        if self.preDefinedUsers.preDefinedUsersDict.keys.contains(self.emailAddress.lowercased()) &&
            self.preDefinedUsers.preDefinedUsersDict[self.emailAddress]?.password ?? "" == self.password {
            
            self.loginFailed = false
            
            self.isUserNameAndPasswordEmpty = false
            
            //check if Remember Me option is enable
            self.saveUserCredential()
                
            //if login is successful, then redirect user to home screen
            self.homeScreenLink = 1
        }
        else {
            self.loginFailed = true
            
            self.isUserNameAndPasswordEmpty = false
        }
    }
    
    //Save current username and password in UserDefaults if user chooses to
    //remember the user credential
    func saveUserCredential() {
        if self.rememberMe {
            UserDefaults.standard.set(true, forKey: "rememberMe")
            
            //remember both current user email and password
            UserDefaults.standard.set(self.emailAddress, forKey: "username")
            UserDefaults.standard.set(self.password, forKey: "password")
        }
        else {
            //if rememberMe is false, then only remember the current user status
            UserDefaults.standard.set(false, forKey: "rememberMe")
            UserDefaults.standard.set(self.emailAddress, forKey: "username")
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

