import Foundation
import NetworkExtension

class VPN {
    
    let vpnManager = NEVPNManager.shared();
    
    let username, password, sharedKey, url: String
    
    init(username: String, password: String, sharedKey: String, url: String) {
        self.username = username
        self.password = password
        self.sharedKey  = sharedKey
        self.url  = url
    }
    
    // EXAMPLE
    // NY 1 DC
    // 206.189.232.80
    // Server IP: 206.189.232.80
    // IPsec PSK: 6RPhWsUt7mMAgbtcRxV3
    // Username: vpnuser
    // Password: 6B35wN6Uib7kKYb
    
    private var vpnLoadHandler: (Error?) -> Void { return
    { (error:Error?) in
        if ((error) != nil) {
            
            print("Could not load VPN Configurations")
            return;
        }
        let p = NEVPNProtocolIPSec()
        p.username = self.username
        p.serverAddress = self.url
        p.authenticationMethod = NEVPNIKEAuthenticationMethod.sharedSecret
        
        let kcs = KeychainService();
        kcs.save(key: "SHARED", value: self.sharedKey)
        kcs.save(key: "VPN_PASSWORD", value: self.password)
        p.sharedSecretReference = kcs.load(key: "SHARED")
        p.passwordReference = kcs.load(key: "VPN_PASSWORD")
        p.useExtendedAuthentication = true
        p.disconnectOnSleep = false
        
        var rules = [NEOnDemandRule]()
        let rule = NEOnDemandRuleConnect()
        rule.interfaceTypeMatch = .any
        rules.append(rule)
        
        self.vpnManager.isOnDemandEnabled = true
        self.vpnManager.onDemandRules = rules
        self.vpnManager.protocolConfiguration = p
        self.vpnManager.localizedDescription = "Vpn application"
        self.vpnManager.isEnabled = true
        self.vpnManager.saveToPreferences(completionHandler: self.vpnSaveHandler)
        } }
    
    private var vpnSaveHandler: (Error?) -> Void { return
    { (error:Error?) in
        if (error != nil) {
            print("Could not save VPN Configurations")
            return
        } else {
            do {
                try self.vpnManager.connection.startVPNTunnel()
            } catch let error {
                print("Error starting VPN Connection \(error.localizedDescription)");
            }
        }
        // self.vpnlock = false
        }
    }
    
    public func connectVPN() {
        //For no known reason the process of saving/loading the VPN configurations fails.On the 2nd time it works
        //        do {
        //            try self.vpnManager.loadFromPreferences(completionHandler: self.vpnLoadHandler)
        //        } catch let error {
        //            print("Could not start VPN Connection: \(error.localizedDescription)" )
        //        }
        self.vpnManager.loadFromPreferences(completionHandler: self.vpnLoadHandler)
    }
    
    public func disconnectVPN() ->Void {
        vpnManager.connection.stopVPNTunnel()
    }
}
