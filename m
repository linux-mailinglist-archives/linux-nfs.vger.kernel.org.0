Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871322E0D7
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 17:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfE2PS2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 11:18:28 -0400
Received: from mail3.start.ca ([64.140.120.243]:58703 "EHLO mail3.start.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfE2PS2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 11:18:28 -0400
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 11:18:28 EDT
Received: from localhost (ip-24-156-181-89.user.start.ca [24.156.181.89])
        by mail3.start.ca (8.14.4/8.14.4/) with ESMTP id x4TFA4V7017901
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 11:10:07 -0400
Date:   Wed, 29 May 2019 11:10:04 -0400
From:   Nick Bowler <nbowler@draconx.ca>
To:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: PROBLEM: oops spew with Linux 5.1.5 (NFS regression?)
Message-ID: <20190529151003.hzmesyoiopnbcgkb@aura.draconx.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I upgraded to Linux 5.1.5 on one machine yesterday, and this morning I
happened noticed a large amount of backtraces in the log.  It appears
that the system oopsed 62 times over a period of about 5 minutes,
producing about half a megabyte of log messages, after which the
messages stopped.  No idea what action (if any) triggered these.

However, other than the noise in the logs there is nothing obviously
broken, but I thought I should report the spews anyway.  I was running
5.0.9 previously and have not seen any similar errors.  The first couple
spews are appended.  All 64 faults look very similar to these ones, with
the same faulting address and the same rpc_check_timeout function at the
top of the backtrace.

Cheers,
  Nick

2019-05-28T16:00:29-04:00 emergent kernel: BUG: unable to handle kernel NULL pointer dereference at 0000000000000098
2019-05-28T16:00:29-04:00 emergent kernel: #PF error: [normal kernel read fault]
2019-05-28T16:00:29-04:00 emergent kernel: PGD 0 P4D 0 
2019-05-28T16:00:29-04:00 emergent kernel: Oops: 0000 [#1] PREEMPT SMP
2019-05-28T16:00:29-04:00 emergent kernel: CPU: 1 PID: 11036 Comm: bash Not tainted 5.1.5 #59
2019-05-28T16:00:29-04:00 emergent kernel: Hardware name: Acer Aspire X3810/WG43M, BIOS P01-B2 03/24/2010
2019-05-28T16:00:29-04:00 emergent kernel: RIP: 0010:xprt_adjust_timeout+0x4/0xe1 [sunrpc]
2019-05-28T16:00:29-04:00 emergent kernel: Code: c7 80 ac 00 00 00 00 00 00 00 48 8b 10 48 81 aa a8 00 00 00 00 01 00 00 48 89 d7 e8 4d ef ff ff e9 b7 fe ff ff c3 41 54 55 53 <48> 8b 87 98 00 00 00 48 89 fb 48 8b 80 a8 00 00 00 48 8b 68 78 48
2019-05-28T16:00:29-04:00 emergent kernel: RSP: 0018:ffffb88ac976fa08 EFLAGS: 00010207
2019-05-28T16:00:29-04:00 emergent kernel: RAX: 00000000fffffff5 RBX: ffffa330879b3e00 RCX: 0000000000000003
2019-05-28T16:00:29-04:00 emergent kernel: RDX: 0000000000000000 RSI: 00000000fffffe00 RDI: 0000000000000000
2019-05-28T16:00:29-04:00 emergent kernel: RBP: ffffa330b6332a00 R08: 0000000000000000 R09: 0000000000000003
2019-05-28T16:00:29-04:00 emergent kernel: R10: ffffa330b3c87aa8 R11: ffffa330b3c87aa8 R12: ffffa330b9e52c50
2019-05-28T16:00:29-04:00 emergent kernel: R13: 0000000000000080 R14: 0000000000000000 R15: 0000000000000002
2019-05-28T16:00:29-04:00 emergent kernel: FS:  00007f0e2b683740(0000) GS:ffffa330bba80000(0000) knlGS:0000000000000000
2019-05-28T16:00:29-04:00 emergent kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2019-05-28T16:00:29-04:00 emergent kernel: CR2: 0000000000000098 CR3: 0000000134db3000 CR4: 00000000000406e0
2019-05-28T16:00:29-04:00 emergent kernel: Call Trace:
2019-05-28T16:00:29-04:00 emergent kernel:  rpc_check_timeout+0x18/0xed [sunrpc]
2019-05-28T16:00:29-04:00 emergent kernel:  call_decode+0x129/0x132 [sunrpc]
2019-05-28T16:00:29-04:00 emergent kernel:  __rpc_execute+0x4f/0x1c1 [sunrpc]
2019-05-28T16:00:29-04:00 emergent kernel:  rpc_run_task+0x105/0x10f [sunrpc]
2019-05-28T16:00:29-04:00 emergent kernel:  rpc_call_sync+0x45/0x65 [sunrpc]
2019-05-28T16:00:29-04:00 emergent kernel:  nfs3_rpc_wrapper.constprop.17+0x17/0x86 [nfsv3]
2019-05-28T16:00:29-04:00 emergent kernel:  nfs3_proc_access+0x6f/0xa3 [nfsv3]
2019-05-28T16:00:29-04:00 emergent kernel:  nfs_do_access+0x1e4/0x2a6 [nfs]
2019-05-28T16:00:29-04:00 emergent kernel:  ? put_link+0x1f/0x32
2019-05-28T16:00:29-04:00 emergent kernel:  ? step_into+0x59/0x1b7
2019-05-28T16:00:29-04:00 emergent kernel:  ? xfs_iomap_write_unwritten+0x1b0/0x1b0
2019-05-28T16:00:29-04:00 emergent kernel:  ? xfs_iomap_write_unwritten+0x1b0/0x1b0
2019-05-28T16:00:29-04:00 emergent kernel:  nfs_permission+0xdf/0x17c [nfs]
2019-05-28T16:00:29-04:00 emergent kernel:  link_path_walk.part.59+0x1b2/0x3d5
2019-05-28T16:00:29-04:00 emergent kernel:  ? path_init+0xf9/0x25c
2019-05-28T16:00:29-04:00 emergent kernel:  path_lookupat.isra.61+0x117/0x197
2019-05-28T16:00:29-04:00 emergent kernel:  ? prep_new_page+0x6f/0xa8
2019-05-28T16:00:29-04:00 emergent kernel:  filename_lookup.part.76+0x56/0xa1
2019-05-28T16:00:29-04:00 emergent kernel:  ? cpumask_any_but+0x14/0x23
2019-05-28T16:00:29-04:00 emergent kernel:  ? getname_flags+0x44/0x14c
2019-05-28T16:00:29-04:00 emergent kernel:  vfs_statx+0x5f/0xa6
2019-05-28T16:00:29-04:00 emergent kernel:  __do_sys_newstat+0x26/0x40
2019-05-28T16:00:29-04:00 emergent kernel:  ? __check_object_size+0xf4/0x177
2019-05-28T16:00:29-04:00 emergent kernel:  ? kmem_cache_free+0x2b/0x89
2019-05-28T16:00:29-04:00 emergent kernel:  ? __do_sys_getcwd+0x16e/0x180
2019-05-28T16:00:29-04:00 emergent kernel:  do_syscall_64+0x48/0x55
2019-05-28T16:00:29-04:00 emergent kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
2019-05-28T16:00:29-04:00 emergent kernel: RIP: 0033:0x7f0e2af8de99
2019-05-28T16:00:29-04:00 emergent kernel: Code: 00 48 83 ec 18 64 48 8b 0c 25 28 00 00 00 48 89 4c 24 08 31 c9 83 ff 01 77 4f 48 89 f0 48 89 d6 48 89 c7 b8 04 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 1f 48 8b 4c 24 08 64 48 33 0c 25 28 00 00 00
2019-05-28T16:00:29-04:00 emergent kernel: RSP: 002b:00007ffdd27f90a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
2019-05-28T16:00:29-04:00 emergent kernel: RAX: ffffffffffffffda RBX: 0000563d4d7b3770 RCX: 00007f0e2af8de99
2019-05-28T16:00:29-04:00 emergent kernel: RDX: 00007ffdd27f90c0 RSI: 00007ffdd27f90c0 RDI: 0000563d4d79f6b0
2019-05-28T16:00:29-04:00 emergent kernel: RBP: 0000563d4d7b1c70 R08: 0000000000000000 R09: 0000000000000005
2019-05-28T16:00:29-04:00 emergent kernel: R10: fffffffffffff675 R11: 0000000000000246 R12: 0000000000000000
2019-05-28T16:00:29-04:00 emergent kernel: R13: 00007ffdd27fffd0 R14: 0000000000000000 R15: 00007ffdd27f9ec0
2019-05-28T16:00:29-04:00 emergent kernel: Modules linked in: nfsv3 nfs_acl nfs autofs4 nfsd auth_rpcgss lockd grace bridge stp llc iptable_filter xt_REDIRECT xt_tcpudp xt_owner iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_tables x_tables snd_hda_codec_realtek snd_hda_codec_generic ext4 crc16 mbcache jbd2 arc4 rt2800pci eeprom_93cx6 rt2x00pci rt2800mmio rt2x00mmio rt2800lib snd_hda_codec_hdmi crc_ccitt rt2x00lib mac80211 snd_hda_intel cfg80211 snd_hda_codec snd_hwdep snd_hda_core cp210x it87 coretemp hwmon_vid i2c_dev usbserial snd_pcm snd_timer snd mousedev soundcore loop i2c_i801 evdev acpi_cpufreq fuse serpent_sse2_x86_64 crypto_simd cryptd serpent_generic glue_helper xts algif_skcipher af_alg dm_crypt sr_mod cdrom e1000e usb_storage ptp pps_core ipv6 sunrpc dm_mod dax
2019-05-28T16:00:29-04:00 emergent kernel: CR2: 0000000000000098
2019-05-28T16:00:29-04:00 emergent kernel: ---[ end trace c88e131c8cdcf387 ]---
2019-05-28T16:00:29-04:00 emergent kernel: RIP: 0010:xprt_adjust_timeout+0x4/0xe1 [sunrpc]
2019-05-28T16:00:29-04:00 emergent kernel: Code: c7 80 ac 00 00 00 00 00 00 00 48 8b 10 48 81 aa a8 00 00 00 00 01 00 00 48 89 d7 e8 4d ef ff ff e9 b7 fe ff ff c3 41 54 55 53 <48> 8b 87 98 00 00 00 48 89 fb 48 8b 80 a8 00 00 00 48 8b 68 78 48
2019-05-28T16:00:29-04:00 emergent kernel: RSP: 0018:ffffb88ac976fa08 EFLAGS: 00010207
2019-05-28T16:00:29-04:00 emergent kernel: RAX: 00000000fffffff5 RBX: ffffa330879b3e00 RCX: 0000000000000003
2019-05-28T16:00:29-04:00 emergent kernel: RDX: 0000000000000000 RSI: 00000000fffffe00 RDI: 0000000000000000
2019-05-28T16:00:29-04:00 emergent kernel: RBP: ffffa330b6332a00 R08: 0000000000000000 R09: 0000000000000003
2019-05-28T16:00:29-04:00 emergent kernel: R10: ffffa330b3c87aa8 R11: ffffa330b3c87aa8 R12: ffffa330b9e52c50
2019-05-28T16:00:29-04:00 emergent kernel: R13: 0000000000000080 R14: 0000000000000000 R15: 0000000000000002
2019-05-28T16:00:29-04:00 emergent kernel: FS:  00007f0e2b683740(0000) GS:ffffa330bba80000(0000) knlGS:0000000000000000
2019-05-28T16:00:29-04:00 emergent kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2019-05-28T16:00:29-04:00 emergent kernel: CR2: 0000000000000098 CR3: 0000000134db3000 CR4: 00000000000406e0
2019-05-28T16:00:30-04:00 emergent kernel: BUG: unable to handle kernel NULL pointer dereference at 0000000000000098
2019-05-28T16:00:30-04:00 emergent kernel: #PF error: [normal kernel read fault]
2019-05-28T16:00:30-04:00 emergent kernel: PGD 0 P4D 0 
2019-05-28T16:00:30-04:00 emergent kernel: Oops: 0000 [#2] PREEMPT SMP
2019-05-28T16:00:30-04:00 emergent kernel: CPU: 3 PID: 11056 Comm: bash Tainted: G      D           5.1.5 #59
2019-05-28T16:00:30-04:00 emergent kernel: Hardware name: Acer Aspire X3810/WG43M, BIOS P01-B2 03/24/2010
2019-05-28T16:00:30-04:00 emergent kernel: RIP: 0010:xprt_adjust_timeout+0x4/0xe1 [sunrpc]
2019-05-28T16:00:30-04:00 emergent kernel: Code: c7 80 ac 00 00 00 00 00 00 00 48 8b 10 48 81 aa a8 00 00 00 00 01 00 00 48 89 d7 e8 4d ef ff ff e9 b7 fe ff ff c3 41 54 55 53 <48> 8b 87 98 00 00 00 48 89 fb 48 8b 80 a8 00 00 00 48 8b 68 78 48
2019-05-28T16:00:30-04:00 emergent kernel: RSP: 0018:ffffb88ac9a4ba08 EFLAGS: 00010207
2019-05-28T16:00:30-04:00 emergent kernel: RAX: 00000000fffffff5 RBX: ffffa330879b5c00 RCX: 0000000000000003
2019-05-28T16:00:30-04:00 emergent kernel: RDX: 0000000000000000 RSI: 00000000fffffe00 RDI: 0000000000000000
2019-05-28T16:00:30-04:00 emergent kernel: RBP: ffffa330b6332a00 R08: 0000000000000000 R09: 0000000000000003
2019-05-28T16:00:30-04:00 emergent kernel: R10: ffffa330b3c87aa8 R11: ffffa330b3c87aa8 R12: ffffa330b9e52c50
2019-05-28T16:00:30-04:00 emergent kernel: R13: 0000000000000080 R14: 0000000000000000 R15: 0000000000000002
2019-05-28T16:00:30-04:00 emergent kernel: FS:  00007f6025ca4740(0000) GS:ffffa330bbb80000(0000) knlGS:0000000000000000
2019-05-28T16:00:30-04:00 emergent kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2019-05-28T16:00:30-04:00 emergent kernel: CR2: 0000000000000098 CR3: 0000000054043000 CR4: 00000000000406e0
2019-05-28T16:00:30-04:00 emergent kernel: Call Trace:
2019-05-28T16:00:30-04:00 emergent kernel:  rpc_check_timeout+0x18/0xed [sunrpc]
2019-05-28T16:00:30-04:00 emergent kernel:  call_decode+0x129/0x132 [sunrpc]
2019-05-28T16:00:30-04:00 emergent kernel:  __rpc_execute+0x4f/0x1c1 [sunrpc]
2019-05-28T16:00:30-04:00 emergent kernel:  rpc_run_task+0x105/0x10f [sunrpc]
2019-05-28T16:00:30-04:00 emergent kernel:  rpc_call_sync+0x45/0x65 [sunrpc]
2019-05-28T16:00:30-04:00 emergent kernel:  nfs3_rpc_wrapper.constprop.17+0x17/0x86 [nfsv3]
2019-05-28T16:00:30-04:00 emergent kernel:  nfs3_proc_access+0x6f/0xa3 [nfsv3]
2019-05-28T16:00:30-04:00 emergent kernel:  nfs_do_access+0x1e4/0x2a6 [nfs]
2019-05-28T16:00:30-04:00 emergent kernel:  ? put_link+0x1f/0x32
2019-05-28T16:00:30-04:00 emergent kernel:  ? step_into+0x59/0x1b7
2019-05-28T16:00:30-04:00 emergent kernel:  ? xfs_iomap_write_unwritten+0x1b0/0x1b0
2019-05-28T16:00:30-04:00 emergent kernel:  ? xfs_iomap_write_unwritten+0x1b0/0x1b0
2019-05-28T16:00:30-04:00 emergent kernel:  nfs_permission+0xdf/0x17c [nfs]
2019-05-28T16:00:30-04:00 emergent kernel:  link_path_walk.part.59+0x1b2/0x3d5
2019-05-28T16:00:30-04:00 emergent kernel:  ? path_init+0xf9/0x25c
2019-05-28T16:00:30-04:00 emergent kernel:  path_lookupat.isra.61+0x117/0x197
2019-05-28T16:00:30-04:00 emergent kernel:  ? prep_new_page+0x6f/0xa8
2019-05-28T16:00:30-04:00 emergent kernel:  ? prep_new_page+0x6f/0xa8
2019-05-28T16:00:30-04:00 emergent kernel:  filename_lookup.part.76+0x56/0xa1
2019-05-28T16:00:30-04:00 emergent kernel:  ? cpumask_any_but+0x14/0x23
2019-05-28T16:00:30-04:00 emergent kernel:  ? getname_flags+0x44/0x14c
2019-05-28T16:00:30-04:00 emergent kernel:  vfs_statx+0x5f/0xa6
2019-05-28T16:00:30-04:00 emergent kernel:  __do_sys_newstat+0x26/0x40
2019-05-28T16:00:30-04:00 emergent kernel:  ? __check_object_size+0xf4/0x177
2019-05-28T16:00:30-04:00 emergent kernel:  ? kmem_cache_free+0x2b/0x89
2019-05-28T16:00:30-04:00 emergent kernel:  ? __do_sys_getcwd+0x16e/0x180
2019-05-28T16:00:30-04:00 emergent kernel:  do_syscall_64+0x48/0x55
2019-05-28T16:00:30-04:00 emergent kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
2019-05-28T16:00:30-04:00 emergent kernel: RIP: 0033:0x7f60255aae99
2019-05-28T16:00:30-04:00 emergent kernel: Code: 00 48 83 ec 18 64 48 8b 0c 25 28 00 00 00 48 89 4c 24 08 31 c9 83 ff 01 77 4f 48 89 f0 48 89 d6 48 89 c7 b8 04 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 1f 48 8b 4c 24 08 64 48 33 0c 25 28 00 00 00
2019-05-28T16:00:30-04:00 emergent kernel: RSP: 002b:00007ffcc63fde70 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
2019-05-28T16:00:30-04:00 emergent kernel: RAX: ffffffffffffffda RBX: 000056487a4ac800 RCX: 00007f60255aae99
2019-05-28T16:00:30-04:00 emergent kernel: RDX: 00007ffcc63fde90 RSI: 00007ffcc63fde90 RDI: 000056487a4986b0
2019-05-28T16:00:30-04:00 emergent kernel: RBP: 000056487a4aad10 R08: 0000000000000000 R09: 0000000000000005
2019-05-28T16:00:30-04:00 emergent kernel: R10: fffffffffffff675 R11: 0000000000000246 R12: 0000000000000000
2019-05-28T16:00:30-04:00 emergent kernel: R13: 00007ffcc6403fd0 R14: 0000000000000000 R15: 00007ffcc63fec90
2019-05-28T16:00:30-04:00 emergent kernel: Modules linked in: nfsv3 nfs_acl nfs autofs4 nfsd auth_rpcgss lockd grace bridge stp llc iptable_filter xt_REDIRECT xt_tcpudp xt_owner iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_tables x_tables snd_hda_codec_realtek snd_hda_codec_generic ext4 crc16 mbcache jbd2 arc4 rt2800pci eeprom_93cx6 rt2x00pci rt2800mmio rt2x00mmio rt2800lib snd_hda_codec_hdmi crc_ccitt rt2x00lib mac80211 snd_hda_intel cfg80211 snd_hda_codec snd_hwdep snd_hda_core cp210x it87 coretemp hwmon_vid i2c_dev usbserial snd_pcm snd_timer snd mousedev soundcore loop i2c_i801 evdev acpi_cpufreq fuse serpent_sse2_x86_64 crypto_simd cryptd serpent_generic glue_helper xts algif_skcipher af_alg dm_crypt sr_mod cdrom e1000e usb_storage ptp pps_core ipv6 sunrpc dm_mod dax
2019-05-28T16:00:30-04:00 emergent kernel: CR2: 0000000000000098
2019-05-28T16:00:30-04:00 emergent kernel: ---[ end trace c88e131c8cdcf388 ]---
2019-05-28T16:00:30-04:00 emergent kernel: RIP: 0010:xprt_adjust_timeout+0x4/0xe1 [sunrpc]
2019-05-28T16:00:30-04:00 emergent kernel: Code: c7 80 ac 00 00 00 00 00 00 00 48 8b 10 48 81 aa a8 00 00 00 00 01 00 00 48 89 d7 e8 4d ef ff ff e9 b7 fe ff ff c3 41 54 55 53 <48> 8b 87 98 00 00 00 48 89 fb 48 8b 80 a8 00 00 00 48 8b 68 78 48
2019-05-28T16:00:30-04:00 emergent kernel: RSP: 0018:ffffb88ac976fa08 EFLAGS: 00010207
2019-05-28T16:00:30-04:00 emergent kernel: RAX: 00000000fffffff5 RBX: ffffa330879b3e00 RCX: 0000000000000003
2019-05-28T16:00:30-04:00 emergent kernel: RDX: 0000000000000000 RSI: 00000000fffffe00 RDI: 0000000000000000
2019-05-28T16:00:30-04:00 emergent kernel: RBP: ffffa330b6332a00 R08: 0000000000000000 R09: 0000000000000003
2019-05-28T16:00:30-04:00 emergent kernel: R10: ffffa330b3c87aa8 R11: ffffa330b3c87aa8 R12: ffffa330b9e52c50
2019-05-28T16:00:30-04:00 emergent kernel: R13: 0000000000000080 R14: 0000000000000000 R15: 0000000000000002
2019-05-28T16:00:30-04:00 emergent kernel: FS:  00007f6025ca4740(0000) GS:ffffa330bbb80000(0000) knlGS:0000000000000000
2019-05-28T16:00:30-04:00 emergent kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2019-05-28T16:00:30-04:00 emergent kernel: CR2: 0000000000000098 CR3: 0000000054043000 CR4: 00000000000406e0
[ and on and on and on on ... ]

-- 
Nick Bowler
