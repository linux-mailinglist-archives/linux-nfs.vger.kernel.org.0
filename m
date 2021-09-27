Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD219418EFA
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Sep 2021 08:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhI0GTe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Sep 2021 02:19:34 -0400
Received: from virgo02.ee.ethz.ch ([129.132.72.10]:52158 "EHLO
        virgo02.ee.ethz.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhI0GTe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Sep 2021 02:19:34 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Sep 2021 02:19:34 EDT
Received: from localhost (localhost [127.0.0.1])
        by virgo02.ee.ethz.ch (Postfix) with ESMTP id 4HHsgw2dBDz15V0b;
        Mon, 27 Sep 2021 08:10:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at virgo02.ee.ethz.ch
Received: from virgo02.ee.ethz.ch ([127.0.0.1])
        by localhost (virgo02.ee.ethz.ch [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i6KmS8l1ttgs; Mon, 27 Sep 2021 08:10:33 +0200 (CEST)
X-MtScore: NO score=0
Received: from varda.ee.ethz.ch (varda.ee.ethz.ch [129.132.3.17])
        by virgo02.ee.ethz.ch (Postfix) with ESMTP;
        Mon, 27 Sep 2021 08:10:31 +0200 (CEST)
Received: by varda.ee.ethz.ch (Postfix, from userid 65212)
        id 769892A043F; Mon, 27 Sep 2021 08:10:31 +0200 (CEST)
Date:   Mon, 27 Sep 2021 08:10:31 +0200
From:   Salvatore Bonaccorso <bonaccos@ee.ethz.ch>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: nfsd4_process_open2 failed to open newly-created file! status=10008
 ; warning at fs/nfsd/nfs4proc.c for nfsd4_open
Message-ID: <20210927061025.GA20892@varda.ee.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi

We recently got the following traces on a NFS server, but I'm not sure
how to further debug this, any hints?

[5746893.904448] ------------[ cut here ]------------
[5746893.910050] nfsd4_process_open2 failed to open newly-created file! status=10008
[5746893.918488] WARNING: CPU: 16 PID: 1316 at fs/nfsd/nfs4proc.c:456 nfsd4_open+0x4e0/0x6f0 [nfsd]
[5746893.927833] Modules linked in: tcp_diag udp_diag raw_diag inet_diag unix_diag binfmt_misc rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bonding quota_v2 quota_tree intel_rapl ipmi_ssif skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ast ghash_clmulni_intel intel_cstate ttm drm_kms_helper drm intel_uncore pcspkr intel_rapl_perf mei_me ioatdma iTCO_wdt evdev joydev pcc_cpufreq sg i2c_algo_bit iTCO_vendor_support mei dca ipmi_si wmi ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad button nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto ecb dm_mod raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1
[5746894.000592]  raid0 multipath linear md_mod hid_generic usbhid hid sd_mod crc32c_intel xhci_pci ahci xhci_hcd libahci aesni_intel aes_x86_64 crypto_simd libata arcmsr usbcore cryptd i40e scsi_mod glue_helper lpc_ich i2c_i801 mfd_core usb_common
[5746894.023137] CPU: 16 PID: 1316 Comm: nfsd Not tainted 4.19.0-17-amd64 #1 Debian 4.19.194-3
[5746894.031916] Hardware name: DALCO AG S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[5746894.042198] RIP: 0010:nfsd4_open+0x4e0/0x6f0 [nfsd]
[5746894.047704] Code: 80 88 a8 01 00 00 01 e9 52 fe ff ff 80 bb 15 01 00 00 00 0f 84 ef fe ff ff 44 89 fe 48 c7 c7 f0 10 58 c0 0f ce e8 89 70 3a d0 <0f> 0b e9 d7 fe ff ff 48 8b 83 18 01 00 00 8b 55 00 48 8d 75 04 89
[5746894.067573] RSP: 0018:ffffa5228948fda8 EFLAGS: 00010286
[5746894.073487] RAX: 0000000000000000 RBX: ffff97c0669ae3e0 RCX: 0000000000000000
[5746894.081317] RDX: ffff97cc8f91efc0 RSI: ffff97cc8f9166b8 RDI: ffff97cc8f9166b8
[5746894.089148] RBP: ffff97c0665b0068 R08: 00000000000005e8 R09: 0000000000aaaaaa
[5746894.096993] R10: 0000000000000000 R11: 0000000000000001 R12: ffff97c0cc1cb400
[5746894.104848] R13: ffff97c066aa8000 R14: ffff97c0665a9600 R15: 0000000018270000
[5746894.112717] FS:  0000000000000000(0000) GS:ffff97cc8f900000(0000) knlGS:0000000000000000
[5746894.121558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[5746894.128035] CR2: 00007f83d25a68a0 CR3: 00000015b900a002 CR4: 00000000007606e0
[5746894.135899] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[5746894.143764] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[5746894.151647] PKRU: 55555554
[5746894.155117] Call Trace:
[5746894.158373]  nfsd4_proc_compound+0x342/0x660 [nfsd]
[5746894.164084]  nfsd_dispatch+0x9e/0x210 [nfsd]
[5746894.169206]  svc_process_common+0x345/0x750 [sunrpc]
[5746894.175017]  ? nfsd_destroy+0x50/0x50 [nfsd]
[5746894.180155]  svc_process+0xb7/0xf0 [sunrpc]
[5746894.185194]  nfsd+0xe3/0x140 [nfsd]
[5746894.189545]  kthread+0x112/0x130
[5746894.193618]  ? kthread_bind+0x30/0x30
[5746894.198072]  ret_from_fork+0x35/0x40
[5746894.202439] ---[ end trace c6400532dff968eb ]---
[5768733.993671] ------------[ cut here ]------------
[5768733.999711] nfsd4_process_open2 failed to open newly-created file! status=10008
[5768734.008148] WARNING: CPU: 9 PID: 1316 at fs/nfsd/nfs4proc.c:456 nfsd4_open+0x4e0/0x6f0 [nfsd]
[5768734.017448] Modules linked in: tcp_diag udp_diag raw_diag inet_diag unix_diag binfmt_misc rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bonding quota_v2 quota_tree intel_rapl ipmi_ssif skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ast ghash_clmulni_intel intel_cstate ttm drm_kms_helper drm intel_uncore pcspkr intel_rapl_perf mei_me ioatdma iTCO_wdt evdev joydev pcc_cpufreq sg i2c_algo_bit iTCO_vendor_support mei dca ipmi_si wmi ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad button nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto ecb dm_mod raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1
[5768734.092781]  raid0 multipath linear md_mod hid_generic usbhid hid sd_mod crc32c_intel xhci_pci ahci xhci_hcd libahci aesni_intel aes_x86_64 crypto_simd libata arcmsr usbcore cryptd i40e scsi_mod glue_helper lpc_ich i2c_i801 mfd_core usb_common
[5768734.115967] CPU: 9 PID: 1316 Comm: nfsd Tainted: G        W         4.19.0-17-amd64 #1 Debian 4.19.194-3
[5768734.126331] Hardware name: DALCO AG S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[5768734.136855] RIP: 0010:nfsd4_open+0x4e0/0x6f0 [nfsd]
[5768734.142623] Code: 80 88 a8 01 00 00 01 e9 52 fe ff ff 80 bb 15 01 00 00 00 0f 84 ef fe ff ff 44 89 fe 48 c7 c7 f0 10 58 c0 0f ce e8 89 70 3a d0 <0f> 0b e9 d7 fe ff ff 48 8b 83 18 01 00 00 8b 55 00 48 8d 75 04 89
[5768734.162998] RSP: 0018:ffffa5228948fda8 EFLAGS: 00010286
[5768734.169071] RAX: 0000000000000000 RBX: ffff97c0669ae3e0 RCX: 0000000000000000
[5768734.177036] RDX: ffff97c090e9efc0 RSI: ffff97c090e966b8 RDI: ffff97c090e966b8
[5768734.184996] RBP: ffff97c0665b0068 R08: 0000000000000608 R09: 0000000000aaaaaa
[5768734.192945] R10: 0000000000000000 R11: 0000000000000001 R12: ffff97c08698b000
[5768734.200885] R13: ffff97c066aa8000 R14: ffff97c0665a9600 R15: 0000000018270000
[5768734.208815] FS:  0000000000000000(0000) GS:ffff97c090e80000(0000) knlGS:0000000000000000
[5768734.217702] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[5768734.224236] CR2: 00007f9b4006df10 CR3: 00000015b900a002 CR4: 00000000007606e0
[5768734.232157] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[5768734.240077] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[5768734.248017] PKRU: 55555554
[5768734.251553] Call Trace:
[5768734.254867]  nfsd4_proc_compound+0x342/0x660 [nfsd]
[5768734.260517]  nfsd_dispatch+0x9e/0x210 [nfsd]
[5768734.265570]  svc_process_common+0x345/0x750 [sunrpc]
[5768734.271373]  ? nfsd_destroy+0x50/0x50 [nfsd]
[5768734.276414]  svc_process+0xb7/0xf0 [sunrpc]
[5768734.281370]  nfsd+0xe3/0x140 [nfsd]
[5768734.285624]  kthread+0x112/0x130
[5768734.289610]  ? kthread_bind+0x30/0x30
[5768734.294030]  ret_from_fork+0x35/0x40
[5768734.298396] ---[ end trace c6400532dff968ec ]---
[5795002.037239] ------------[ cut here ]------------
[5795002.044280] nfsd4_process_open2 failed to open newly-created file! status=10008
[5795002.053358] WARNING: CPU: 1 PID: 1315 at fs/nfsd/nfs4proc.c:456 nfsd4_open+0x4e0/0x6f0 [nfsd]
[5795002.063065] Modules linked in: tcp_diag udp_diag raw_diag inet_diag unix_diag binfmt_misc rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bonding quota_v2 quota_tree intel_rapl ipmi_ssif skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ast ghash_clmulni_intel intel_cstate ttm drm_kms_helper drm intel_uncore pcspkr intel_rapl_perf mei_me ioatdma iTCO_wdt evdev joydev pcc_cpufreq sg i2c_algo_bit iTCO_vendor_support mei dca ipmi_si wmi ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad button nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto ecb dm_mod raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1
[5795002.138537]  raid0 multipath linear md_mod hid_generic usbhid hid sd_mod crc32c_intel xhci_pci ahci xhci_hcd libahci aesni_intel aes_x86_64 crypto_simd libata arcmsr usbcore cryptd i40e scsi_mod glue_helper lpc_ich i2c_i801 mfd_core usb_common
[5795002.161747] CPU: 1 PID: 1315 Comm: nfsd Tainted: G        W         4.19.0-17-amd64 #1 Debian 4.19.194-3
[5795002.172089] Hardware name: DALCO AG S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[5795002.182668] RIP: 0010:nfsd4_open+0x4e0/0x6f0 [nfsd]
[5795002.188400] Code: 80 88 a8 01 00 00 01 e9 52 fe ff ff 80 bb 15 01 00 00 00 0f 84 ef fe ff ff 44 89 fe 48 c7 c7 f0 10 58 c0 0f ce e8 89 70 3a d0 <0f> 0b e9 d7 fe ff ff 48 8b 83 18 01 00 00 8b 55 00 48 8d 75 04 89
[5795002.208706] RSP: 0018:ffffa52289487da8 EFLAGS: 00010286
[5795002.214775] RAX: 0000000000000000 RBX: ffff97c0669a83e0 RCX: 0000000000000000
[5795002.222743] RDX: ffff97c090a9efc0 RSI: ffff97c090a966b8 RDI: ffff97c090a966b8
[5795002.230710] RBP: ffff97c0669aa068 R08: 0000000000000628 R09: 0000000000aaaaaa
[5795002.238684] R10: 0000000000000000 R11: 0000000000000001 R12: ffff97c21bb64200
[5795002.246670] R13: ffff97c066aae000 R14: ffff97c0665a8000 R15: 0000000018270000
[5795002.254611] FS:  0000000000000000(0000) GS:ffff97c090a80000(0000) knlGS:0000000000000000
[5795002.263492] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[5795002.270097] CR2: 00007fba9f588590 CR3: 00000015b900a002 CR4: 00000000007606e0
[5795002.278100] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[5795002.286091] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[5795002.294078] PKRU: 55555554
[5795002.297634] Call Trace:
[5795002.300910]  nfsd4_proc_compound+0x342/0x660 [nfsd]
[5795002.306572]  nfsd_dispatch+0x9e/0x210 [nfsd]
[5795002.311617]  svc_process_common+0x345/0x750 [sunrpc]
[5795002.317421]  ? nfsd_destroy+0x50/0x50 [nfsd]
[5795002.322480]  svc_process+0xb7/0xf0 [sunrpc]
[5795002.327433]  nfsd+0xe3/0x140 [nfsd]
[5795002.331728]  kthread+0x112/0x130
[5795002.335718]  ? kthread_bind+0x30/0x30
[5795002.340144]  ret_from_fork+0x35/0x40
[5795002.344475] ---[ end trace c6400532dff968ed ]---

But I have as well no reproducing recipe to trigger it.

The kernel is the current Debian buster distro kernel, based on
4.19.194.

This initally looked similar than
https://bugzilla.kernel.org/show_bug.cgi?id=195725 but the user did
get there status=5, so EIO, so seems different issue.

Regards,
Salvatore
