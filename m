Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B528B48E8C6
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jan 2022 12:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbiANLCl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jan 2022 06:02:41 -0500
Received: from server.atrad.com.au ([150.101.241.2]:43474 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiANLCj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jan 2022 06:02:39 -0500
X-Greylist: delayed 1412 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jan 2022 06:02:39 EST
Received: from marvin.atrad.com.au (IDENT:1008@marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 20EAd1eS016249
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jan 2022 21:09:02 +1030
Date:   Fri, 14 Jan 2022 21:09:01 +1030
From:   Jonathan Woithe <jwoithe@just42.net>
To:     linux-nfs@vger.kernel.org
Subject: [Bug report] Recurring oops, 5.15.x, possibly during or soon after
 client mount
Message-ID: <20220114103901.GA22009@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all

Recently we migrated an NFS server from a 32-bit environment running 
kernel 4.14.128 to a 64-bit 5.15.x kernel.  The NFS configuration remained
unchanged between the two systems.

On two separate occasions since the upgrade (5 Jan under 5.15.10, 14 Jan
under 5.15.12) the kernel has oopsed at around the time that an NFS client
machine is turned on for the day.  On both occasions the call trace was
essentially identical.  The full oops sequence is at the end of this email. 
The oops was not observed when running the 4.14.128 kernel.

Is there anything more I can provide to help track down the cause of the
oops?

Regards
  jonathan

Oops under 5.15.12:

Jan 14 08:48:30 nfssvr kernel: BUG: kernel NULL pointer dereference, address: 0000000000000110
Jan 14 08:48:30 nfssvr kernel: #PF: supervisor read access in kernel mode
Jan 14 08:48:30 nfssvr kernel: #PF: error_code(0x0000) - not-present page
Jan 14 08:48:30 nfssvr kernel: Oops: 0000 [#1] PREEMPT SMP PTI
Jan 14 08:48:30 nfssvr kernel: CPU: 0 PID: 2935 Comm: lockd Not tainted 5.15.12 #1
Jan 14 08:48:30 nfssvr kernel: Hardware name:  /DG31PR, BIOS PRG3110H.86A.0038.2007.1221.1757 12/21/2007
Jan 14 08:48:30 nfssvr kernel: RIP: 0010:vfs_lock_file+0x5/0x30
Jan 14 08:48:30 nfssvr kernel: Code: ff ff 41 89 c4 85 c0 0f 84 42 ff ff ff e9 f8 fe ff ff 0f 0b e8 2c bc d2 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 <48> 8b 47 28 49 89 d0 48 8b 80 98 00 00 00 48 85 c0 74 05 e9 f3 dc
Jan 14 08:48:30 nfssvr kernel: RSP: 0018:ffffa478401a3c38 EFLAGS: 00010246
Jan 14 08:48:30 nfssvr kernel: RAX: 7fffffffffffffff RBX: 00000000000000e8 RCX: 0000000000000000
Jan 14 08:48:30 nfssvr kernel: RDX: ffffa478401a3c40 RSI: 0000000000000006 RDI: 00000000000000e8
Jan 14 08:48:30 nfssvr kernel: RBP: ffff946ead1ecc00 R08: ffff946f88ab1000 R09: ffff946f88b33a00
Jan 14 08:48:30 nfssvr kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa657ff30
Jan 14 08:48:30 nfssvr kernel: R13: ffff946e99df7c40 R14: ffff946e82fb0510 R15: ffff946ead1ecc00
Jan 14 08:48:30 nfssvr kernel: FS:  0000000000000000(0000) GS:ffff946fabc00000(0000) knlGS:0000000000000000
Jan 14 08:48:30 nfssvr kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 14 08:48:30 nfssvr kernel: CR2: 0000000000000110 CR3: 000000010083a000 CR4: 00000000000006f0
Jan 14 08:48:30 nfssvr kernel: Call Trace:
Jan 14 08:48:30 nfssvr kernel:  <TASK>
Jan 14 08:48:30 nfssvr kernel:  nlm_unlock_files+0x6e/0xb0
Jan 14 08:48:30 nfssvr kernel:  ? __skb_recv_udp+0x198/0x330
Jan 14 08:48:30 nfssvr kernel:  ? _raw_spin_lock+0x13/0x2e
Jan 14 08:48:30 nfssvr kernel:  ? nlmsvc_traverse_blocks+0x36/0x120
Jan 14 08:48:30 nfssvr kernel:  ? preempt_count_add+0x68/0xa0
Jan 14 08:48:30 nfssvr kernel:  nlm_traverse_files+0x152/0x280
Jan 14 08:48:30 nfssvr kernel:  nlmsvc_free_host_resources+0x27/0x40
Jan 14 08:48:30 nfssvr kernel:  nlm_host_rebooted+0x23/0x90
Jan 14 08:48:30 nfssvr kernel:  nlmsvc_proc_sm_notify+0xae/0x110
Jan 14 08:48:30 nfssvr kernel:  ? nlmsvc_decode_reboot+0x8b/0xc0
Jan 14 08:48:30 nfssvr kernel:  nlmsvc_dispatch+0x89/0x180
Jan 14 08:48:30 nfssvr kernel:  svc_process_common+0x3ce/0x6f0
Jan 14 08:48:30 nfssvr kernel:  ? lockd_inet6addr_event+0xf0/0xf0
Jan 14 08:48:30 nfssvr kernel:  svc_process+0xb7/0xf0
Jan 14 08:48:30 nfssvr kernel:  lockd+0xca/0x1b0
Jan 14 08:48:30 nfssvr kernel:  ? preempt_count_add+0x68/0xa0
Jan 14 08:48:30 nfssvr kernel:  ? _raw_spin_lock_irqsave+0x19/0x40
Jan 14 08:48:30 nfssvr kernel:  ? set_grace_period+0x90/0x90
Jan 14 08:48:30 nfssvr kernel:  kthread+0x141/0x170
Jan 14 08:48:30 nfssvr kernel:  ? set_kthread_struct+0x40/0x40
Jan 14 08:48:30 nfssvr kernel:  ret_from_fork+0x22/0x30
Jan 14 08:48:30 nfssvr kernel:  </TASK>
Jan 14 08:48:30 nfssvr kernel: Modules linked in: tun nf_nat_ftp nf_conntrack_ftp xt_REDIRECT xt_nat xt_conntrack xt_tcpudp xt_NFLOG nfnetlink_log nfnetlink iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter ip_tables x_tables ipv6 hid_generic usbhid hi
Jan 14 08:48:30 nfssvr kernel: CR2: 0000000000000110
Jan 14 08:48:30 nfssvr kernel: ---[ end trace f8f28acee6f24340 ]---
Jan 14 08:48:30 nfssvr kernel: RIP: 0010:vfs_lock_file+0x5/0x30
Jan 14 08:48:30 nfssvr kernel: Code: ff ff 41 89 c4 85 c0 0f 84 42 ff ff ff e9 f8 fe ff ff 0f 0b e8 2c bc d2 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 <48> 8b 47 28 49 89 d0 48 8b 80 98 00 00 00 48 85 c0 74 05 e9 f3 dc
Jan 14 08:48:30 nfssvr kernel: RSP: 0018:ffffa478401a3c38 EFLAGS: 00010246
Jan 14 08:48:30 nfssvr kernel: RAX: 7fffffffffffffff RBX: 00000000000000e8 RCX: 0000000000000000
Jan 14 08:48:30 nfssvr kernel: RDX: ffffa478401a3c40 RSI: 0000000000000006 RDI: 00000000000000e8
Jan 14 08:48:30 nfssvr kernel: RBP: ffff946ead1ecc00 R08: ffff946f88ab1000 R09: ffff946f88b33a00
Jan 14 08:48:30 nfssvr kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa657ff30
Jan 14 08:48:30 nfssvr kernel: R13: ffff946e99df7c40 R14: ffff946e82fb0510 R15: ffff946ead1ecc00
Jan 14 08:48:30 nfssvr kernel: FS:  0000000000000000(0000) GS:ffff946fabc00000(0000) knlGS:0000000000000000
Jan 14 08:48:30 nfssvr kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jan 14 08:48:30 nfssvr kernel: CR2: 0000000000000110 CR3: 000000010083a000 CR4: 00000000000006f0
