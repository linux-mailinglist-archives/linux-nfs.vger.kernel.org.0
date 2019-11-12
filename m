Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C83FBF8CAB
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKLKU0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 05:20:26 -0500
Received: from audible.transient.net ([24.143.126.66]:39266 "HELO
        audible.transient.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726924AbfKLKU0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Nov 2019 05:20:26 -0500
Received: (qmail 30547 invoked from network); 12 Nov 2019 10:13:44 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 12 Nov 2019 10:13:44 -0000
Received: (nullmailer pid 3784 invoked by uid 1000);
        Tue, 12 Nov 2019 10:13:43 -0000
Date:   Tue, 12 Nov 2019 10:13:43 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PROBLEM: NULL pointer dereference; nfsd4_remove_cld_pipe
Message-ID: <20191112101343.GA2806@audible.transient.net>
Mail-Followup-To: "J. Bruce Fields" <bfields@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Giving 5.4.0-rc7 a spin I hit a NULL pointer dereference and bisected
it to:

commit 6ee95d1c899186c0798cafd25998d436bcdb9618
Author: Scott Mayhew <smayhew@redhat.com>
Date:   Mon Sep 9 16:10:31 2019 -0400

    nfsd: add support for upcall version 2


The splat against 5.3.0-rc2-00034-g6ee95d1c8991:

BUG: kernel NULL pointer dereference, address: 0000000000000036
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 2936 Comm: rpc.nfsd Not tainted 5.3.0-rc2-00034-g6ee95d1c8991 #1
Hardware name: Dell Inc. Precision WorkStation T3400  /0TP412, BIOS A14 04/30/2012
RIP: 0010:crypto_destroy_tfm+0x5/0x4d
Code: 78 01 00 00 48 85 c0 74 05 e9 05 05 66 00 c3 55 48 8b af 80 01 00 00 e8 d5 ff ff ff 48 89 ef 5d e9 12 f9 ef ff 48 85 ff 74 47 <48> 83 7e 30 00 41 55 4c 8b 6e 38 41 54 49 89 fc 55 48 89 f5 75 14
RSP: 0018:ffffc90000b7bd68 EFLAGS: 00010282
RAX: ffffffffa0402841 RBX: ffff888230484400 RCX: 0000000000002cd0
RDX: 0000000000002cce RSI: 0000000000000006 RDI: fffffffffffffffe
RBP: ffffffff81e68440 R08: ffff888232801800 R09: ffffffffa0402841
R10: 0000000000000200 R11: ffff88823048ae40 R12: ffff888231585100
R13: ffff88823048ae40 R14: 000000000000000b R15: ffff888230484400
FS:  00007f02102c3740(0000) GS:ffff888233a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000036 CR3: 0000000230f94000 CR4: 00000000000406f0
Call Trace:
 nfsd4_remove_cld_pipe+0x6d/0x83 [nfsd]
 nfsd4_cld_tracking_init+0x1cf/0x295 [nfsd]
 nfsd4_client_tracking_init+0x72/0x13e [nfsd]
 nfs4_state_start_net+0x22a/0x2cf [nfsd]
 nfsd_svc+0x1c6/0x292 [nfsd]
 write_threads+0x68/0xb0 [nfsd]
 ? write_versions+0x333/0x333 [nfsd]
 nfsctl_transaction_write+0x4a/0x62 [nfsd]
 vfs_write+0xa0/0xdd
 ksys_write+0x71/0xba
 do_syscall_64+0x48/0x55
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f021056c904
Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 48 8d 05 d9 3a 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
RSP: 002b:00007ffdc76ec618 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055b534955560 RCX: 00007f021056c904
RDX: 0000000000000002 RSI: 000055b534955560 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ffdc76ec4b0
R10: 00007ffdc76ec367 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000008 R14: 0000000000000000 R15: 000055b534b8a2a0
Modules linked in: cpufreq_userspace cpufreq_powersave cpufreq_ondemand cpufreq_conservative autofs4 fan nfsd auth_rpcgss nfs lockd grace fscache sunrpc bridge stp llc nhpoly1305_sse2 nhpoly1305 aes_generic chacha_x86_64 chacha_generic adiantum poly1305_generic vhost_net tun vhost tap dm_crypt snd_hda_codec_analog snd_hda_codec_generic usb_storage snd_hda_intel kvm_intel snd_hda_codec kvm snd_hwdep snd_hda_core snd_pcm dcdbas snd_timer irqbypass snd soundcore sr_mod cdrom tg3 sg floppy evdev xfs dm_mod raid1 md_mod psmouse
CR2: 0000000000000036
---[ end trace bc12bbe4cdd6319f ]---
...
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered


My kernel config is at
http://audible.transient.net/~jamie/k/upcallv2.config-5.3.0-rc2-00034-g6ee95d1c8991

I don't think there's anything terribly interesting about my nfs
server setup, this happens reliably on boot up, idle network, no
active clients; let me know what else you need, happy to debug.

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
