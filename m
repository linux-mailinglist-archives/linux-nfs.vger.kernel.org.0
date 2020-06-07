Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E51F0C67
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jun 2020 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgFGPct (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Jun 2020 11:32:49 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47373 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgFGPcs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 7 Jun 2020 11:32:48 -0400
Received: from 'smile.earth' ([95.89.4.93]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKKdD-1jNOpV1j2d-00LlBO for <linux-nfs@vger.kernel.org>; Sun, 07 Jun 2020
 17:32:46 +0200
X-Virus-Scanned: amavisd at 'smile.earth'
From:   Hans-Peter Jansen <hpj@urpla.net>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: general protection fault, probably for non-canonical address in nfsd
Date:   Sun, 07 Jun 2020 17:32:44 +0200
Message-ID: <15780697.tcFqIYE18H@xrated>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:TOLo9BcHMPoRTbf2mnb79IThVe+k+z1M2q2heo+eYMXMQn0iYFc
 CgoRnAzBSpzXO6toCz7/v5qkCyW7KIhsDfSqZPMSlCctfoI4iJT/sNrxTZl9ZIz7sDdmDyf
 qTlpB+JOo862pr2Bmuf8YRMdWIVbfD3LhUM0G09en2u3S+f7GKpoI8Cgm1ub6DifgBb4HCd
 1P5+zFEy0wQu+e4aQhSKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZVx7tmrkC2Q=:qLjg2xy5hhiuGRRLZWEMjK
 wIGc89zggj8/FAdsq4utItI4fJsaxUSJS/CSD4ZWvLXFdmqObvFt61Cgl85GTMda/sAWNUVdT
 punhpLyV5tIycf5maGd3xR5U8LfCFqP8g3Tbg3g7uAAs/UWRxoosjSP9NaSYppab1+VDRZv/5
 fInnKOzMAvXP1Z6OUiUkIwiQlBTvsCrF+W7M9pHVtlwvlz4jMzNPseW0vXN5EzbjmzwORNOyL
 wFEuAEifA52tELIQXGC8h/UX4Trz9t5PEqLLw0S31cq9TXSBrH6VtcNH9ewnc0Igut1siBlK7
 u66Mm07yLx0k4sD9JHslv91vBgpPd9RpJChi7slFwcoTvVvJNd2SpYXLGh7hm4LSSuVVQwxmB
 NGs94J9X7/qwHS1VnOf+6IKW4Pbay+y7gQoWnklrt1tJkL5P3HR98UVXlLNyJ7GaJzf2zxP19
 mzSdNZmM+f3PN+Hiswt6QUR2dBonhPHFJAPOGIHIgDdXhnkf37mnaxsbn1wk/5a+sJhiP87T+
 mx8WQeSOePlRRMYuILMc2TfCZ+rdbmI/eFX826G3sEiLa1SyxmFVLXeQhiXBuiN3xWiTTF7na
 sq1DT3MpjVYfxDNTnvt+NrTpmKejONNHu0DMXLYJIRAnFCqyaO6uF4OXD5Lzna2xaUxox2DFP
 39X3MxCLERaBwl9igepTFzqaXmB+GRieoKePVeSJeeLZ+5R/RnnFMNOPprv6Ub9Oq5+nFn93o
 o5SjXmtIXRz9UGGu1rtkfQjqbu7NdbESutaDMiKfWZH4rEnS9D+4SiAaBD+5pS/twXtTCR/y6
 ovmr8oU8rEhGTUhe76ArTtakPc7z/Xya5/tCQTwh25ypK4vii8=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

after upgrading the kernel from 5.6.11 to 5.6.14, we suffer from regular 
crashes of nfsd here:

2020-06-07T01:32:43.600306+02:00 server rpc.mountd[2664]: authenticated mount request from 192.168.3.16:303 for /work (/work)
2020-06-07T01:32:43.602594+02:00 server rpc.mountd[2664]: authenticated mount request from 192.168.3.16:304 for /work/vmware (/work)
2020-06-07T01:32:43.602971+02:00 server rpc.mountd[2664]: authenticated mount request from 192.168.3.16:305 for /work/vSphere (/work)
2020-06-07T01:32:43.606276+02:00 server kernel: [51901.089211] general protection fault, probably for non-canonical address 0xb9159d506ba40000: 0000 [#1] SMP PTI
2020-06-07T01:32:43.606284+02:00 server kernel: [51901.089226] CPU: 1 PID: 3190 Comm: nfsd Tainted: G           O      5.6.14-lp151.2-default #1 openSUSE Tumbleweed (unreleased)
2020-06-07T01:32:43.606286+02:00 server kernel: [51901.089234] Hardware name: System manufacturer System Product Name/P7F-E, BIOS 0906    09/20/2010
2020-06-07T01:32:43.606287+02:00 server kernel: [51901.089247] RIP: 0010:cgroup_sk_free+0x26/0x80
2020-06-07T01:32:43.606288+02:00 server kernel: [51901.089257] Code: 00 00 00 00 66 66 66 66 90 53 48 8b 07 48 c7 c3 30 72 07 b6 a8 01 75 07 48 85 c0 48 0f 45 d8 48 8b 83 18 09 00 00 a8 03 
75 1a <65> 48 ff 08 f6 43 7c 01 74 02 5b c3 48 8b 43 18 a8 03 75 26 65 48
2020-06-07T01:32:43.606290+02:00 server kernel: [51901.089276] RSP: 0018:ffffb248c21e7e10 EFLAGS: 00010246
2020-06-07T01:32:43.606291+02:00 server kernel: [51901.089280] RAX: b91603a504000000 RBX: ffff99ab141a0000 RCX: 0000000000000021
2020-06-07T01:32:43.606292+02:00 server kernel: [51901.089284] RDX: ffffffffb6135ec4 RSI: 0000000000010080 RDI: ffff99a7159c1490
2020-06-07T01:32:43.606293+02:00 server kernel: [51901.089287] RBP: ffff99a7159c1200 R08: ffff99ab67a60c60 R09: 000000000002eb00
2020-06-07T01:32:43.606294+02:00 server kernel: [51901.089291] R10: ffffb248c0087dc0 R11: 00000000000000c6 R12: 0000000000000000
2020-06-07T01:32:43.606295+02:00 server kernel: [51901.089294] R13: 0000000000000103 R14: ffff99aae4934238 R15: ffff99ab31902000
2020-06-07T01:32:43.606296+02:00 server kernel: [51901.089299] FS:  0000000000000000(0000) GS:ffff99ab67a40000(0000) knlGS:0000000000000000
2020-06-07T01:32:43.606297+02:00 server kernel: [51901.089303] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2020-06-07T01:32:43.606303+02:00 server kernel: [51901.089305] CR2: 00000000008e0000 CR3: 00000004df60a000 CR4: 00000000000026e0
2020-06-07T01:32:43.606304+02:00 server kernel: [51901.089307] Call Trace:
2020-06-07T01:32:43.606305+02:00 server kernel: [51901.089315]  __sk_destruct+0x10d/0x1d0
2020-06-07T01:32:43.606306+02:00 server kernel: [51901.089319]  inet_release+0x34/0x60
2020-06-07T01:32:43.606307+02:00 server kernel: [51901.089325]  __sock_release+0x81/0xb0
2020-06-07T01:32:43.606308+02:00 server kernel: [51901.089358]  svc_sock_free+0x38/0x60 [sunrpc]
2020-06-07T01:32:43.606308+02:00 server kernel: [51901.089374]  svc_xprt_put+0x99/0xe0 [sunrpc]
2020-06-07T01:32:43.606310+02:00 server kernel: [51901.089389]  svc_recv+0x9c0/0xa40 [sunrpc]
2020-06-07T01:32:43.606310+02:00 server kernel: [51901.089410]  ? nfsd_destroy+0x60/0x60 [nfsd]
2020-06-07T01:32:43.606311+02:00 server kernel: [51901.089417]  nfsd+0xd1/0x150 [nfsd]
2020-06-07T01:32:43.606312+02:00 server kernel: [51901.089420]  kthread+0x10d/0x130
2020-06-07T01:32:43.606313+02:00 server kernel: [51901.089423]  ? kthread_park+0x90/0x90
2020-06-07T01:32:43.606314+02:00 server kernel: [51901.089426]  ret_from_fork+0x35/0x40

A vSphere 5.5 host accesses this linux server with nfs v3 for backup
purposes (a Veeam backup server want to store a new backup here). 

The kernel is tainted due to vboxdrv. The OS is openSUSE Leap 15.1,
with the kernel and Virtualbox replaced with uptodate versions from 
proper rpm packages (built on that very vSphere host in a OBS server
VM..).

I used to be subscribed to this ML, but that subscription has been 
lost 04/09, thus I cannot reply properly to the general prot. fault
thread, started 05/12 from syzbot with Bruce looking into it.

It seems somewhat related.

Interestingly, we're using a couple of NFS v4 mounts for subsets of
home here, and mount /work and other shares from various 
Tumbleweed systems with NFS v4 here without any undesired effects. 

Since the kernel upgrade, every time, this Veeam thing triggers these 
v3 mounts, the crash happens. I've disabled this backup target for now 
until the problem is resolved, because it effectively prevents further 
nfs accesses to this server, and blocks our desktops until the server 
is rebooted.

A cursory look into 5.6.{15,16} changelogs seems to imply, that this
issue is still pending. 

Let me know, if I can provide any further info's.

Thanks,
Pete


