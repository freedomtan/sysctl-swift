//
//  ViewController.swift
//  sysctl-swift
//
//  Created by Koan-Sin Tan on 11/19/16.
//

import UIKit

var sysctl_hw = [
    "hw.activecpu": "int32",
    "hw.byteorder": "int32",
    "hw.cacheconfig": "uint64s",
    "hw.cpu64bit_capabile": "int32",
    "hw.cpufamily": "int32x",
    "hw.cpufrequency": "int64",
    "hw.cpufrequency_max": "int64",
    "hw.cpufrequency_min":  "int64",
    "hw.cpusubtype": "int32",
    "hw.cputhreadtype": "int32",
    "hw.cputype": "int32x",
    "hw.l1dcachesize": "int64",
    "hw.l1icachesize": "int64",
    "hw.l2cachesize": "int64",
    "hw.l3cachesize": "int64",
    "hw.logiccpu": "int32",
    "hw.logiccpu_max": "int32",
    "hw.machine": "string",
    "hw.memsize": "int64",
    "hw.model": "string",
    "hw.ncpu": "int32",
    "hw.packages": "int32",
    "hw.pagesize": "int32",
    "hw.physicalcpu": "int32",
    "hw.physicalcpu_max": "int32",
    "hw.tbfrequency": "int64",
]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var validHW: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        let sysctlHW = Array(sysctl_hw).sorted(by: { $0.0 < $1.0 })
        
        var len: Int = 0
        var ret: Int32
        for i in 0...(sysctlHW.count-1) {
            ret = sysctlbyname(sysctlHW[i].key, nil, &len, nil, 0)
            
            if (ret == 0) {
                switch(sysctlHW[i].value) {
                case "int32":
                    var p = CInt()
                    sysctlbyname(sysctlHW[i].key, &p, &len, nil, 0);
                    print(sysctlHW[i].key, ":", p)
                    validHW.append("\(sysctlHW[i].key): \(p)")
                    break;
                case "int64":
                    var p = CLong()
                    sysctlbyname(sysctlHW[i].key, &p, &len, nil, 0);
                    print(sysctlHW[i].key, ":", p)
                    validHW.append("\(sysctlHW[i].key): \(p)")
                    break;
                case "int32x":
                    var p = CInt()
                    sysctlbyname(sysctlHW[i].key, &p, &len, nil, 0);
                    print(sysctlHW[i].key, ":", String((p), radix: 16))
                    validHW.append("\(sysctlHW[i].key): \(String((p), radix: 16))")
                    break;
                case "string":
                    var p = [CChar](repeating: 0, count: Int(len))
                    sysctlbyname(sysctlHW[i].key, &p, &len, nil, 0);
                    print(sysctlHW[i].key, ":", String(cString: p))
                    validHW.append("\(sysctlHW[i].key): \(String(cString: p))")
                    break;
                default:
                    print("how come", sysctlHW[i].value)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return validHW.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        let string: NSMutableString = ""
        
        string.append(validHW[indexPath.row])
        cell.textLabel?.text = string as String?
        
        return cell
    }
}

