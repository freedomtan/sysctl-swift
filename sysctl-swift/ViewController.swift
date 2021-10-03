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
    "hw.cpusperl3": "int32",
    "hw.cpusubtype": "int32",
    "hw.cputhreadtype": "int32",
    "hw.cputype": "int32x",
    "hw.l1dcachesize": "int64",
    "hw.l1icachesize": "int64",
    "hw.l2cachesize": "int64",
    "hw.l3cachesize": "int64",
    "hw.logicalcpu": "int32",
    "hw.logicalcpu_max": "int32",
    "hw.machine": "string",
    "hw.memsize": "int64",
    "hw.model": "string",
    "hw.ncpu": "int32",
    "hw.nperflevels": "int32",
    "hw.optional.amx_version": "int32",
    "hw.optional.arm.FEAT_AES": "int32",
    "hw.optional.arm.FEAT_BF16": "int32",
    "hw.optional.arm.FEAT_BTI": "int32",
    "hw.optional.arm.FEAT_CSV2": "int32",
    "hw.optional.arm.FEAT_CSV3": "int32",
    "hw.optional.arm.FEAT_DPB": "int32",
    "hw.optional.arm.FEAT_DPB2": "int32",
    "hw.optional.arm.FEAT_DotProd": "int32",
    "hw.optional.arm.FEAT_ECV": "int32",
    "hw.optional.arm.FEAT_FCMA": "int32",
    "hw.optional.arm.FEAT_FHM": "int32",
    "hw.optional.arm.FEAT_FP16": "int32",
    "hw.optional.arm.FEAT_FPAC": "int32",
    "hw.optional.arm.FEAT_FRINTTS": "int32",
    "hw.optional.arm.FEAT_FlagM": "int32",
    "hw.optional.arm.FEAT_FlagM2": "int32",
    "hw.optional.arm.FEAT_I8MM": "int32",
    "hw.optional.arm.FEAT_JSCVT": "int32",
    "hw.optional.arm.FEAT_LRCPC": "int32",
    "hw.optional.arm.FEAT_LRCPC2": "int32",
    "hw.optional.arm.FEAT_LSE": "int32",
    "hw.optional.arm.FEAT_LSE2": "int32",
    "hw.optional.arm.FEAT_PAuth": "int32",
    "hw.optional.arm.FEAT_PAuth2": "int32",
    "hw.optional.arm.FEAT_PMULL": "int32",
    "hw.optional.arm.FEAT_RDM": "int32",
    "hw.optional.arm.FEAT_SB": "int32",
    "hw.optional.arm.FEAT_SHA1": "int32",
    "hw.optional.arm.FEAT_SHA256": "int32",
    "hw.optional.arm.FEAT_SHA3": "int32",
    "hw.optional.arm.FEAT_SHA512": "int32",
    "hw.optional.arm.FEAT_SPECRES": "int32",
    "hw.optional.arm.FEAT_SSBS": "int32",
    "hw.optional.arm64": "int32",
    "hw.optional.armv8_1_atomics": "int32",
    "hw.optional.armv8_2_fhm": "int32",
    "hw.optional.armv8_2_sha3": "int32",
    "hw.optional.armv8_2_sha512": "int32",
    "hw.optional.armv8_3_compnum": "int32",
    "hw.optional.armv8_crc32": "int32",
    "hw.optional.breakpoint": "int32",
    "hw.optional.floatingpoint": "int32",
    "hw.optional.neon": "int32",
    "hw.optional.neon_fp16": "int32",
    "hw.optional.neon_hpfp": "int32",
    "hw.optional.ucnormal_mem": "int32",
    "hw.optional.watchpoint": "int32",
    "hw.packages": "int32",
    "hw.pagesize": "int32",
    "hw.perflevel0.cpusperl2": "int32",
    "hw.perflevel0.cpusperl3": "int32",
    "hw.perflevel0.l1dcachesize": "int64",
    "hw.perflevel0.l1icachesize": "int64",
    "hw.perflevel0.l2cachesize": "int64",
    "hw.perflevel0.logicalcpu": "int32",
    "hw.perflevel0.logicalcpu_max": "int32",
    "hw.perflevel0.phyicalcpu": "int32",
    "hw.perflevel0.physicalccpu_max": "int32",
    "hw.perflevel1.cpusperl2": "int32",
    "hw.perflevel1.cpusperl3": "int32",
    "hw.perflevel1.l1dcachesize": "int64",
    "hw.perflevel1.l1icachesize": "int64",
    "hw.perflevel1.l2cachesize": "int64",
    "hw.perflevel1.logicalcpu": "int32",
    "hw.perflevel1.logicalcpu_max": "int32",
    "hw.perflevel1.phyicalcpu": "int32",
    "hw.perflevel1.physicalccpu_max": "int32",
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
                    var p = CUnsignedInt()
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

