Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC13D9630
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jul 2021 21:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhG1Tvn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Jul 2021 15:51:43 -0400
Received: from mail.rptsys.com ([23.155.224.45]:17276 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhG1Tvn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Jul 2021 15:51:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 3CF7A37B227367;
        Wed, 28 Jul 2021 14:51:39 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id c2K_5WzZkgzS; Wed, 28 Jul 2021 14:51:36 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 4E0B037B227364;
        Wed, 28 Jul 2021 14:51:36 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 4E0B037B227364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1627501896; bh=DKya2Yl+b7wigICbm+QU9Ai6J86XzR25MFepiYucV8Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IKY7dfx+SV7JcOMF1+wd9RqyjbGG8Vn+qENEEoMTfhjtXADADfFH9zF36u1Sw8AXX
         gFJHJrYgYfU75UXfE/G7/tdvGo79NL7Whot5PAcdC+9orG/o6nQ5QAGooR0uhTyPtX
         hJ3nljoXrbaiCPSt7Bs7qPOiXDgRvuaD5Cc1rqHA=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xq8CHhKkvGlT; Wed, 28 Jul 2021 14:51:36 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 28D5837B227361;
        Wed, 28 Jul 2021 14:51:36 -0500 (CDT)
Date:   Wed, 28 Jul 2021 14:51:36 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <8367147.22241.1627501896064.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <2057894451.4327679.1627075347173.JavaMail.zimbra@raptorengineeringinc.com>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com> <20210723210012.GC1278@fieldses.org> <2057894451.4327679.1627075347173.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC91 (Linux)/8.5.0_GA_3042)
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: UJcWg66JWy2W5ky+Tq7edxJ7/SDu7MvMQsNu
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Just happened again, this time seemingly at random (unknown network load).  This is on kernel 5.13.4 now, and we're going to be breaking off the most critical production services to another host at this point due to the continued issues:

[305943.277482] rcu: INFO: rcu_sched self-detected stall on CPU
[305943.277508] rcu:    45-....: (68259 ticks this GP) idle=bc6/1/0x4000000000000002 softirq=26727261/26727261 fqs=27492
[305943.277551]         (t=68263 jiffies g=45124409 q=1158662)
[305943.277568] Sending NMI from CPU 45 to CPUs 16:
[305943.277600] NMI backtrace for cpu 16
[305943.277637] CPU: 16 PID: 15327 Comm: nfsd Tainted: G      D W    L    5.13.4 #1
[305943.277666] NIP:  c0000000001cdcd0 LR: c000000000c024b4 CTR: c000000000c02450
[305943.277694] REGS: c0002000ab2d35f0 TRAP: 0e80   Tainted: G      D W    L     (5.13.4)
[305943.277712] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 22002444  XER: 20040000
[305943.277771] CFAR: c0000000001cdce4 IRQMASK: 0
[305943.277771] GPR00: c000000000c024b4 c0002000ab2d3890 c000000001511f00 c008000010b248f0
[305943.277771] GPR04: 0000000000000000 0000000000000008 0000000000000008 0000000000000010
[305943.277771] GPR08: 0000000000000001 0000000000000001 0000000000000001 c008000010b04c78
[305943.277771] GPR12: c000000000c02450 c000000ffffde000 c00000000017a528 c000200006f30bc0
[305943.277771] GPR16: 0000000000000000 c000000017f45dd0 c0002000891f8000 0000000000000000
[305943.277771] GPR20: c000200099068000 0000000000000000 c008000010b248f0 c0002000993091a0
[305943.277771] GPR24: c00000093aa55698 c008000010b24060 00000000000004e8 c0002000891f8030
[305943.277771] GPR28: 000000000000009d c0002000993091a0 0000000000000000 c0002000993091a0
[305943.278108] NIP [c0000000001cdcd0] native_queued_spin_lock_slowpath+0x70/0x360
[305943.278158] LR [c000000000c024b4] _raw_spin_lock+0x64/0xa0
[305943.278183] Call Trace:
[305943.278204] [c0002000ab2d3890] [c0002000891f8030] 0xc0002000891f8030 (unreliable)
[305943.278252] [c0002000ab2d38b0] [c008000010aec0ac] nfsd4_process_open2+0x864/0x1910 [nfsd]
[305943.278311] [c0002000ab2d3a20] [c008000010ad0df4] nfsd4_open+0x40c/0x8f0 [nfsd]
[305943.278360] [c0002000ab2d3ad0] [c008000010ad16bc] nfsd4_proc_compound+0x3e4/0x730 [nfsd]
[305943.278418] [c0002000ab2d3b80] [c008000010aadb10] nfsd_dispatch+0x148/0x2d8 [nfsd]
[305943.278474] [c0002000ab2d3bd0] [c008000010d644e0] svc_process_common+0x498/0xa70 [sunrpc]
[305943.278525] [c0002000ab2d3ca0] [c008000010d64b70] svc_process+0xb8/0x140 [sunrpc]
[305943.278585] [c0002000ab2d3d10] [c008000010aad198] nfsd+0x150/0x1e0 [nfsd]
[305943.278639] [c0002000ab2d3da0] [c00000000017a6a4] kthread+0x184/0x190
[305943.278667] [c0002000ab2d3e10] [c00000000000d6ec] ret_from_kernel_thread+0x5c/0x70
[305943.278706] Instruction dump:
[305943.278727] 790a0020 2f890000 409e02b8 2faa0000 419e003c 81230000 5529063e 2f890000
[305943.278782] 419e0028 60000000 60000000 60000000 <7c210b78> 7c421378 81230000 5529063e
[305943.278871] NMI backtrace for cpu 45
[305943.278892] CPU: 45 PID: 15323 Comm: nfsd Tainted: G      D W    L    5.13.4 #1
[305943.278932] Call Trace:
[305943.278950] [c0002000ab2e30d0] [c00000000075d080] dump_stack+0xc4/0x114 (unreliable)
[305943.279002] [c0002000ab2e3110] [c00000000076996c] nmi_cpu_backtrace+0xfc/0x150
[305943.279054] [c0002000ab2e3190] [c000000000769b78] nmi_trigger_cpumask_backtrace+0x1b8/0x220
[305943.279112] [c0002000ab2e3230] [c000000000070788] arch_trigger_cpumask_backtrace+0x28/0x40
[305943.279167] [c0002000ab2e3250] [c0000000001fe6b0] rcu_dump_cpu_stacks+0x158/0x1b8
[305943.279218] [c0002000ab2e32f0] [c0000000001fd164] rcu_sched_clock_irq+0x954/0xb40
[305943.279276] [c0002000ab2e33e0] [c000000000210030] update_process_times+0xc0/0x140
[305943.279316] [c0002000ab2e3420] [c000000000229e04] tick_sched_handle.isra.18+0x34/0xd0
[305943.279369] [c0002000ab2e3450] [c00000000022a2b8] tick_sched_timer+0x68/0xe0
[305943.279416] [c0002000ab2e3490] [c00000000021158c] __hrtimer_run_queues+0x16c/0x370
[305943.279456] [c0002000ab2e3510] [c0000000002121b8] hrtimer_interrupt+0x128/0x2f0
[305943.279508] [c0002000ab2e35c0] [c000000000027904] timer_interrupt+0x134/0x310
[305943.279551] [c0002000ab2e3620] [c000000000009c04] decrementer_common_virt+0x1a4/0x1b0
[305943.279591] --- interrupt: 900 at native_queued_spin_lock_slowpath+0x200/0x360
[305943.279635] NIP:  c0000000001cde60 LR: c000000000c024b4 CTR: c000000000711850
[305943.279678] REGS: c0002000ab2e3690 TRAP: 0900   Tainted: G      D W    L     (5.13.4)
[305943.279727] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44000822  XER: 20040000
[305943.279787] CFAR: c0000000001cde70 IRQMASK: 0
[305943.279787] GPR00: 0000000000000000 c0002000ab2e3930 c000000001511f00 c008000010b248f0
[305943.279787] GPR04: c000200ffbf75380 0000000000b80000 c000200ffbf75380 c000000001085380
[305943.279787] GPR08: c00000000154e060 0000000000000000 0000000ffe410000 0000000000000000
[305943.279787] GPR12: 0000000000b80000 c000200fff6d5400 c00000000017a528 c000200006f30bc0
[305943.279787] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[305943.279787] GPR20: 0000000000000000 0000000000000000 c000200cd3c90014 c000000ba2670d90
[305943.279787] GPR24: c000000ba2670a30 c008000010b2319c c008000010db8634 c0002000ab2e3a40
[305943.279787] GPR28: c000200099331a44 c008000010b248f0 0000000000000000 0000000000b80101
[305943.280122] NIP [c0000000001cde60] native_queued_spin_lock_slowpath+0x200/0x360
[305943.280150] LR [c000000000c024b4] _raw_spin_lock+0x64/0xa0
[305943.280185] --- interrupt: 900
[305943.280209] [c0002000ab2e3930] [c0002000ab2e3970] 0xc0002000ab2e3970 (unreliable)
[305943.280255] [c0002000ab2e3950] [c0000000007118b8] refcount_dec_and_lock+0x68/0x130
[305943.280298] [c0002000ab2e3990] [c008000010ae5458] put_nfs4_file+0x40/0x140 [nfsd]
[305943.280355] [c0002000ab2e39d0] [c008000010aeee68] nfsd4_close+0x1f0/0x470 [nfsd]
[305943.280410] [c0002000ab2e3ad0] [c008000010ad16bc] nfsd4_proc_compound+0x3e4/0x730 [nfsd]
[305943.280466] [c0002000ab2e3b80] [c008000010aadb10] nfsd_dispatch+0x148/0x2d8 [nfsd]
[305943.280514] [c0002000ab2e3bd0] [c008000010d644e0] svc_process_common+0x498/0xa70 [sunrpc]
[305943.280582] [c0002000ab2e3ca0] [c008000010d64b70] svc_process+0xb8/0x140 [sunrpc]
[305943.280656] [c0002000ab2e3d10] [c008000010aad198] nfsd+0x150/0x1e0 [nfsd]
[305943.280710] [c0002000ab2e3da0] [c00000000017a6a4] kthread+0x184/0x190
[305943.280749] [c0002000ab2e3e10] [c00000000000d6ec] ret_from_kernel_thread+0x5c/0x70
[305943.280805] Sending NMI from CPU 45 to CPUs 58:
[305943.280842] NMI backtrace for cpu 58
[305943.280865] CPU: 58 PID: 15325 Comm: nfsd Tainted: G      D W    L    5.13.4 #1
[305943.280904] NIP:  c0000000001cde98 LR: c000000000c024b4 CTR: c000000000711850
[305943.280953] REGS: c0002000ab2ff690 TRAP: 0e80   Tainted: G      D W    L     (5.13.4)
[305943.280992] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24000824  XER: 20040000
[305943.281062] CFAR: c0000000001cdeac IRQMASK: 0
[305943.281062] GPR00: 0000000000000000 c0002000ab2ff930 c000000001511f00 c008000010b248f0
[305943.281062] GPR04: c000200ffc795380 0000000000ec0000 c000200ffc795380 c000000001085380
[305943.281062] GPR08: 0000000000e00101 0000000000e00101 0000000000000101 0000000000000000
[305943.281062] GPR12: 0000000000ec0000 c000200fff695e00 c00000000017a528 c000200006f30bc0
[305943.281062] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[305943.281062] GPR20: 0000000000000000 0000000000000000 c000200223680014 c000000ba2670d90
[305943.281062] GPR24: c000000ba2670a30 c008000010b2319c c008000010db8634 c0002000ab2ffa40
[305943.281062] GPR28: c000200099341a44 c008000010b248f0 0000000000000000 0000000000ec0101
[305943.281737] NIP [c0000000001cde98] native_queued_spin_lock_slowpath+0x238/0x360
[305943.281842] LR [c000000000c024b4] _raw_spin_lock+0x64/0xa0
[305943.281902] Call Trace:
[305943.281940] [c0002000ab2ff930] [c0002000ab2ff970] 0xc0002000ab2ff970 (unreliable)
[305943.282040] [c0002000ab2ff950] [c0000000007118b8] refcount_dec_and_lock+0x68/0x130
[305943.282154] [c0002000ab2ff990] [c008000010ae5458] put_nfs4_file+0x40/0x140 [nfsd]
[305943.282330] [c0002000ab2ff9d0] [c008000010aeee68] nfsd4_close+0x1f0/0x470 [nfsd]
[305943.282436] [c0002000ab2ffad0] [c008000010ad16bc] nfsd4_proc_compound+0x3e4/0x730 [nfsd]
[305943.282520] [c0002000ab2ffb80] [c008000010aadb10] nfsd_dispatch+0x148/0x2d8 [nfsd]
[305943.282670] [c0002000ab2ffbd0] [c008000010d644e0] svc_process_common+0x498/0xa70 [sunrpc]
[305943.282781] [c0002000ab2ffca0] [c008000010d64b70] svc_process+0xb8/0x140 [sunrpc]
[305943.282882] [c0002000ab2ffd10] [c008000010aad198] nfsd+0x150/0x1e0 [nfsd]
[305943.282963] [c0002000ab2ffda0] [c00000000017a6a4] kthread+0x184/0x190
[305943.283057] [c0002000ab2ffe10] [c00000000000d6ec] ret_from_kernel_thread+0x5c/0x70
[305943.283136] Instruction dump:
[305943.283178] 81240008 2f890000 419efff0 7c2004ac 7d66002a 2fab0000 419e0018 7c0059ec
[305943.283288] 48000010 60000000 7c210b78 7c421378 <81230000> 79280020 7d2907b4 550a043e
[305943.283415] Sending NMI from CPU 45 to CPUs 62:
[305943.283467] NMI backtrace for cpu 62
[305943.283507] CPU: 62 PID: 15326 Comm: nfsd Tainted: G      D W    L    5.13.4 #1
[305943.283625] NIP:  c0000000001cde64 LR: c000000000c024b4 CTR: c000000000711850
[305943.283713] REGS: c0002000ab2f7690 TRAP: 0e80   Tainted: G      D W    L     (5.13.4)
[305943.283805] MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 44000822  XER: 20040000
[305943.283912] CFAR: c0000000001cde70 IRQMASK: 0
[305943.283912] GPR00: 0000000000000000 c0002000ab2f7930 c000000001511f00 c008000010b248f0
[305943.283912] GPR04: c000200ffca15380 0000000000fc0000 c000200ffca15380 c000000001085380
[305943.283912] GPR08: c00000000154e060 0000000000000000 0000200ffb710000 0000000000000000
[305943.283912] GPR12: 0000000000fc0000 c000200fff691600 c00000000017a528 c000200006f30bc0
[305943.283912] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[305943.283912] GPR20: 0000000000000000 0000000000000000 c00020009c030014 c000000ba2670d90
[305943.283912] GPR24: c000000ba2670a30 c008000010b2319c c008000010db8634 c0002000ab2f7a40
[305943.283912] GPR28: c000200099321a44 c008000010b248f0 0000000000000000 0000000000fc0101
[305943.284785] NIP [c0000000001cde64] native_queued_spin_lock_slowpath+0x204/0x360
[305943.284867] LR [c000000000c024b4] _raw_spin_lock+0x64/0xa0
[305943.284934] Call Trace:
[305943.284966] [c0002000ab2f7930] [c0002000ab2f7970] 0xc0002000ab2f7970 (unreliable)
[305943.285042] [c0002000ab2f7950] [c0000000007118b8] refcount_dec_and_lock+0x68/0x130
[305943.285158] [c0002000ab2f7990] [c008000010ae5458] put_nfs4_file+0x40/0x140 [nfsd]
[305943.285249] [c0002000ab2f79d0] [c008000010aeee68] nfsd4_close+0x1f0/0x470 [nfsd]
[305943.285336] [c0002000ab2f7ad0] [c008000010ad16bc] nfsd4_proc_compound+0x3e4/0x730 [nfsd]
[305943.285451] [c0002000ab2f7b80] [c008000010aadb10] nfsd_dispatch+0x148/0x2d8 [nfsd]
[305943.285542] [c0002000ab2f7bd0] [c008000010d644e0] svc_process_common+0x498/0xa70 [sunrpc]
[305943.285639] [c0002000ab2f7ca0] [c008000010d64b70] svc_process+0xb8/0x140 [sunrpc]
[305943.285751] [c0002000ab2f7d10] [c008000010aad198] nfsd+0x150/0x1e0 [nfsd]
[305943.285830] [c0002000ab2f7da0] [c00000000017a6a4] kthread+0x184/0x190
[305943.285903] [c0002000ab2f7e10] [c00000000000d6ec] ret_from_kernel_thread+0x5c/0x70

----- Original Message -----
> From: "Timothy Pearson" <tpearson@raptorengineering.com>
> To: "J. Bruce Fields" <bfields@fieldses.org>
> Cc: "Chuck Lever" <chuck.lever@oracle.com>, "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Friday, July 23, 2021 4:22:27 PM
> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load

> ----- Original Message -----
>> From: "J. Bruce Fields" <bfields@fieldses.org>
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
>> Cc: "Chuck Lever" <chuck.lever@oracle.com>, "linux-nfs"
>> <linux-nfs@vger.kernel.org>
>> Sent: Friday, July 23, 2021 4:00:12 PM
>> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
> 
>> Sorry, took me a while to get to this because I'm not sure what to
>> suggest:
>> 
>> On Mon, Jul 05, 2021 at 04:44:29AM -0500, Timothy Pearson wrote:
>>> We've been dealing with a fairly nasty NFS-related problem off and on
>>> for the past couple of years.  The host is a large POWER server with
>>> several external SAS arrays attached, using BTRFS for cold storage of
>>> large amounts of data.  The main symptom is that under heavy sustained
>>> NFS write traffic using certain file types (see below) a core will
>>> suddenly lock up, continually spewing a backtrace similar to the one
>>> I've pasted below.
>> 
>> Is this the very *first* backtrace you get in the log?  Is there
>> anything suspicious right before it?  (Other than the warnings you
>> mention in the next message?)
> 
> Nothing in the logs before that.
> 
>>> While this immediately halts all NFS traffic to
>>> the affected client (which is never the same client as the machine
>>> doing the large file transfer), the larger issue is that over the next
>>> few minutes / hours the entire host will gradually degrade in
>>> responsiveness until it grinds to a complete halt.  Once the core
>>> stall occurs we have been unable to find any way to restore the
>>> machine to full functionality or avoid the degradation and eventual
>>> hang short of a hard power down and restart.
>> 
>>> 
>>> Tens of GB of compressed data in a single file seems to be fairly good at
>>> triggering the problem, whereas raw disk images or other regularly patterned
>>> data tend not to be.  The underlying hardware is functioning perfectly with no
>>> problems noted, and moving the files without NFS avoids the bug.
>>> 
>>> We've been using a workaround involving purposefully pausing (SIGSTOP) the file
>>> transfer process on the client as soon as other clients start to show a
>>> slowdown.  This hack avoids the bug entirely provided the host is allowed to
>>> catch back up prior to resuming (SIGCONT) the file transfer process.  From
>>> this, it seems something is going very wrong within the NFS stack under high
>>> storage I/O pressure and high storage write latency (timeout?) -- it should
>>> simply pause transfers while the storage subsystem catches up, not lock up a
>>> core and force a host restart.  Interesting, sometimes it does exactly what it
>>> is supposed to and does pause and wait for the storage subsystem, but around
>>> 20% of the time it just triggers this bug and stalls a core.
>>> 
>>> This bug has been present since at least 4.14 and is still present in the latest
>>> 5.12.14 version.
>>> 
>>> As the machine is in production, it is difficult to gather further information
>>> or test patches, however we would be able to apply patches to the kernel that
>>> would potentially restore stability with enough advance scheduling.
>>> 
>>> Sample backtrace below:
>>> 
>>> [16846.426141] rcu: INFO: rcu_sched self-detected stall on CPU
>>> [16846.426202] rcu:     32-....: (5249 ticks this GP)
>>> idle=78a/1/0x4000000000000002 softirq=1663878/1663878 fqs=1986
>>> [16846.426241]  (t=5251 jiffies g=2720809 q=756724)
>>> [16846.426273] NMI backtrace for cpu 32
>>> [16846.426298] CPU: 32 PID: 10624 Comm: kworker/u130:25 Not tainted 5.12.14 #1
>>> [16846.426342] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>> [16846.426406] Call Trace:
>>> [16846.426429] [c000200010823250] [c00000000074e630] dump_stack+0xc4/0x114
>>> (unreliable)
>>> [16846.426483] [c000200010823290] [c00000000075aebc]
>>> nmi_cpu_backtrace+0xfc/0x150
>>> [16846.426506] [c000200010823310] [c00000000075b0a8]
>>> nmi_trigger_cpumask_backtrace+0x198/0x1f0
>>> [16846.426577] [c0002000108233b0] [c000000000072818]
>>> arch_trigger_cpumask_backtrace+0x28/0x40
>>> [16846.426621] [c0002000108233d0] [c000000000202db8]
>>> rcu_dump_cpu_stacks+0x158/0x1b8
>>> [16846.426667] [c000200010823470] [c000000000201828]
>>> rcu_sched_clock_irq+0x908/0xb10
>>> [16846.426708] [c000200010823560] [c0000000002141d0]
>>> update_process_times+0xc0/0x140
>>> [16846.426768] [c0002000108235a0] [c00000000022dd34]
>>> tick_sched_handle.isra.18+0x34/0xd0
>>> [16846.426808] [c0002000108235d0] [c00000000022e1e8] tick_sched_timer+0x68/0xe0
>>> [16846.426856] [c000200010823610] [c00000000021577c]
>>> __hrtimer_run_queues+0x16c/0x370
>>> [16846.426903] [c000200010823690] [c000000000216378]
>>> hrtimer_interrupt+0x128/0x2f0
>>> [16846.426947] [c000200010823740] [c000000000029494] timer_interrupt+0x134/0x310
>>> [16846.426989] [c0002000108237a0] [c000000000016c54]
>>> replay_soft_interrupts+0x124/0x2e0
>>> [16846.427045] [c000200010823990] [c000000000016f14]
>>> arch_local_irq_restore+0x104/0x170
>>> [16846.427103] [c0002000108239c0] [c00000000017247c]
>>> mod_delayed_work_on+0x8c/0xe0
>>> [16846.427149] [c000200010823a20] [c00800000819fe04]
>>> rpc_set_queue_timer+0x5c/0x80 [sunrpc]
>>> [16846.427234] [c000200010823a40] [c0080000081a096c]
>>> __rpc_sleep_on_priority_timeout+0x194/0x1b0 [sunrpc]
>>> [16846.427324] [c000200010823a90] [c0080000081a3080]
>>> rpc_sleep_on_timeout+0x88/0x110 [sunrpc]
>>> [16846.427388] [c000200010823ad0] [c0080000071f7220] nfsd4_cb_done+0x468/0x530
>>> [nfsd]
>> 
>> I think this has to be the rpc_delay in the -NFS4ERR_DELAY case of
>> nfsd4_cb_sequence_done.  I don't know what would cause a lockup there.
>> Maybe the rpc_task we've passed in is corrupted somehow?
>> 
>> We could try to add some instrumentation in that case.  I don't think
>> that should be a common error case.  I guess the client has probably hit
>> one of the NFS4ERR_DELAY cases in
>> fs/nfs/callback_proc.c:nfs4_callback_sequence?
>> 
>> There might be a way to get some more information out of this with some
>> tracing that you could run in production, but I'm not sure what to
>> suggest off the top of my head.
> 
> Appreciate the response regardless!
