Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4927B3BBA81
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jul 2021 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhGEJxb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Jul 2021 05:53:31 -0400
Received: from mail.rptsys.com ([23.155.224.45]:19761 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhGEJxb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 5 Jul 2021 05:53:31 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2021 05:53:31 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 6ADAE37B07BF9D;
        Mon,  5 Jul 2021 04:44:32 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id abxwXdBdPa-W; Mon,  5 Jul 2021 04:44:31 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 7884437B07BF99;
        Mon,  5 Jul 2021 04:44:31 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 7884437B07BF99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1625478271; bh=4UbBdYGrB2d2oYtGxPZG8/tVQ18zKxxJTBIDKruOhGk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nQlx0u00btEHx3riIqeYrgAYfICTxVd8wkHf7XgtW0gkZzruuD/R51jMhFtWMUyPY
         nunN5tmzIsaefA5aQPvtEYIVHNAJVEaMU91Da7h2FgcViSd5soE3/pRACMyB+wgdaq
         n9H4alfRiCsJVibR8HKQ4bSgnTDty5VBZL84zrRg=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g4ON9P2-cjW6; Mon,  5 Jul 2021 04:44:31 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 4C99F37B07BF96;
        Mon,  5 Jul 2021 04:44:31 -0500 (CDT)
Date:   Mon, 5 Jul 2021 04:44:29 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Message-ID: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
Subject: CPU stall, eventual host hang with BTRFS + NFS under heavy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC83 (Linux)/8.5.0_GA_3042)
Thread-Index: xSdTgH983VDBQkCAmg52fDts9flGRg==
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We've been dealing with a fairly nasty NFS-related problem off and on for t=
he past couple of years.  The host is a large POWER server with several ext=
ernal SAS arrays attached, using BTRFS for cold storage of large amounts of=
 data.  The main symptom is that under heavy sustained NFS write traffic us=
ing certain file types (see below) a core will suddenly lock up, continuall=
y spewing a backtrace similar to the one I've pasted below.  While this imm=
ediately halts all NFS traffic to the affected client (which is never the s=
ame client as the machine doing the large file transfer), the larger issue =
is that over the next few minutes / hours the entire host will gradually de=
grade in responsiveness until it grinds to a complete halt.  Once the core =
stall occurs we have been unable to find any way to restore the machine to =
full functionality or avoid the degradation and eventual hang short of a ha=
rd power down and restart.

Tens of GB of compressed data in a single file seems to be fairly good at t=
riggering the problem, whereas raw disk images or other regularly patterned=
 data tend not to be.  The underlying hardware is functioning perfectly wit=
h no problems noted, and moving the files without NFS avoids the bug.

We've been using a workaround involving purposefully pausing (SIGSTOP) the =
file transfer process on the client as soon as other clients start to show =
a slowdown.  This hack avoids the bug entirely provided the host is allowed=
 to catch back up prior to resuming (SIGCONT) the file transfer process.  F=
rom this, it seems something is going very wrong within the NFS stack under=
 high storage I/O pressure and high storage write latency (timeout?) -- it =
should simply pause transfers while the storage subsystem catches up, not l=
ock up a core and force a host restart.  Interesting, sometimes it does exa=
ctly what it is supposed to and does pause and wait for the storage subsyst=
em, but around 20% of the time it just triggers this bug and stalls a core.

This bug has been present since at least 4.14 and is still present in the l=
atest 5.12.14 version.

As the machine is in production, it is difficult to gather further informat=
ion or test patches, however we would be able to apply patches to the kerne=
l that would potentially restore stability with enough advance scheduling.

Sample backtrace below:

[16846.426141] rcu: INFO: rcu_sched self-detected stall on CPU
[16846.426202] rcu:     32-....: (5249 ticks this GP) idle=3D78a/1/0x400000=
0000000002 softirq=3D1663878/1663878 fqs=3D1986
[16846.426241]  (t=3D5251 jiffies g=3D2720809 q=3D756724)
[16846.426273] NMI backtrace for cpu 32
[16846.426298] CPU: 32 PID: 10624 Comm: kworker/u130:25 Not tainted 5.12.14=
 #1
[16846.426342] Workqueue: rpciod rpc_async_schedule [sunrpc]
[16846.426406] Call Trace:
[16846.426429] [c000200010823250] [c00000000074e630] dump_stack+0xc4/0x114 =
(unreliable)
[16846.426483] [c000200010823290] [c00000000075aebc] nmi_cpu_backtrace+0xfc=
/0x150
[16846.426506] [c000200010823310] [c00000000075b0a8] nmi_trigger_cpumask_ba=
cktrace+0x198/0x1f0
[16846.426577] [c0002000108233b0] [c000000000072818] arch_trigger_cpumask_b=
acktrace+0x28/0x40
[16846.426621] [c0002000108233d0] [c000000000202db8] rcu_dump_cpu_stacks+0x=
158/0x1b8
[16846.426667] [c000200010823470] [c000000000201828] rcu_sched_clock_irq+0x=
908/0xb10
[16846.426708] [c000200010823560] [c0000000002141d0] update_process_times+0=
xc0/0x140
[16846.426768] [c0002000108235a0] [c00000000022dd34] tick_sched_handle.isra=
.18+0x34/0xd0
[16846.426808] [c0002000108235d0] [c00000000022e1e8] tick_sched_timer+0x68/=
0xe0
[16846.426856] [c000200010823610] [c00000000021577c] __hrtimer_run_queues+0=
x16c/0x370
[16846.426903] [c000200010823690] [c000000000216378] hrtimer_interrupt+0x12=
8/0x2f0
[16846.426947] [c000200010823740] [c000000000029494] timer_interrupt+0x134/=
0x310
[16846.426989] [c0002000108237a0] [c000000000016c54] replay_soft_interrupts=
+0x124/0x2e0
[16846.427045] [c000200010823990] [c000000000016f14] arch_local_irq_restore=
+0x104/0x170
[16846.427103] [c0002000108239c0] [c00000000017247c] mod_delayed_work_on+0x=
8c/0xe0
[16846.427149] [c000200010823a20] [c00800000819fe04] rpc_set_queue_timer+0x=
5c/0x80 [sunrpc]
[16846.427234] [c000200010823a40] [c0080000081a096c] __rpc_sleep_on_priorit=
y_timeout+0x194/0x1b0 [sunrpc]
[16846.427324] [c000200010823a90] [c0080000081a3080] rpc_sleep_on_timeout+0=
x88/0x110 [sunrpc]
[16846.427388] [c000200010823ad0] [c0080000071f7220] nfsd4_cb_done+0x468/0x=
530 [nfsd]
[16846.427457] [c000200010823b60] [c0080000081a0a0c] rpc_exit_task+0x84/0x1=
d0 [sunrpc]
[16846.427520] [c000200010823ba0] [c0080000081a2448] __rpc_execute+0xd0/0x7=
60 [sunrpc]
[16846.427598] [c000200010823c30] [c0080000081a2b18] rpc_async_schedule+0x4=
0/0x70 [sunrpc]
[16846.427687] [c000200010823c60] [c000000000170bf0] process_one_work+0x290=
/0x580
[16846.427736] [c000200010823d00] [c000000000170f68] worker_thread+0x88/0x6=
20
[16846.427813] [c000200010823da0] [c00000000017b860] kthread+0x1a0/0x1b0
[16846.427865] [c000200010823e10] [c00000000000d6ec] ret_from_kernel_thread=
+0x5c/0x70
[16873.869180] watchdog: BUG: soft lockup - CPU#32 stuck for 49s! [kworker/=
u130:25:10624]
[16873.869245] Modules linked in: rpcsec_gss_krb5 iscsi_target_mod target_c=
ore_user uio target_core_pscsi target_core_file target_core_iblock target_c=
ore_mod tun nft_counter nf_tables nfnetlink vfio_pci vfio_virqfd vfio_iommu=
_spapr_tce vfio vfio_spapr_eeh i2c_dev bridg$
[16873.869413]  linear mlx4_ib ib_uverbs ib_core raid1 md_mod sd_mod t10_pi=
 hid_generic usbhid hid ses enclosure crct10dif_vpmsum crc32c_vpmsum xhci_p=
ci xhci_hcd ixgbe mlx4_core mpt3sas usbcore tg3 mdio_devres of_mdio fixed_p=
hy xfrm_algo mdio libphy aacraid igb raid_cl$
[16873.869889] CPU: 32 PID: 10624 Comm: kworker/u130:25 Not tainted 5.12.14=
 #1
[16873.869966] Workqueue: rpciod rpc_async_schedule [sunrpc]
[16873.870023] NIP:  c000000000711300 LR: c0080000081a0708 CTR: c0000000007=
112a0
[16873.870073] REGS: c0002000108237d0 TRAP: 0900   Not tainted  (5.12.14)
[16873.870109] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE> =
 CR: 24004842  XER: 00000000
[16873.870146] CFAR: c0080000081d8054 IRQMASK: 0
               GPR00: c0080000081a0748 c000200010823a70 c0000000015c0700 c0=
000000e2227a40
               GPR04: c0000000e2227a40 c0000000e2227a40 c000200ffb6cc0a8 00=
00000000000018
               GPR08: 0000000000000000 5deadbeef0000122 c0080000081ffd18 c0=
080000081d8040
               GPR12: c0000000007112a0 c000200fff7fee00 c00000000017b6c8 c0=
00000090d9ccc0
               GPR16: 0000000000000000 0000000000000000 0000000000000000 00=
00000000000000
               GPR20: 0000000000000000 0000000000000000 0000000000000000 00=
00000000000040
               GPR24: 0000000000000000 0000000000000000 fffffffffffffe00 00=
00000000000001
               GPR28: c00000001a62f000 c0080000081a0988 c0080000081ffd10 c0=
000000e2227a00
[16873.870452] NIP [c000000000711300] __list_del_entry_valid+0x60/0x100
[16873.870507] LR [c0080000081a0708] rpc_wake_up_task_on_wq_queue_action_lo=
cked+0x330/0x400 [sunrpc]
