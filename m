Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BABD3D4220
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jul 2021 23:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhGWUl7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jul 2021 16:41:59 -0400
Received: from mail.rptsys.com ([23.155.224.45]:52988 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGWUl4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 23 Jul 2021 16:41:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 3F84837B1CE7D0;
        Fri, 23 Jul 2021 16:22:29 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fLUMrwndMRXD; Fri, 23 Jul 2021 16:22:28 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 5CFED37B1CE7CD;
        Fri, 23 Jul 2021 16:22:28 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 5CFED37B1CE7CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1627075348; bh=nvgd4BoxdfaPVsHVKJgN9L6rWbzxR939nvTlwDDdaJY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=iPy85IF3oclnmjrgsi26pM01u/opecDB95XYLk5HZK4ppl/gyNOOE3BWWYWskzkuj
         lb77Pe7zvn7WA3pn1U+QqWa7X5ryQ4BZ4u3956Jd4mxBsVp8K5Puipc8Ca96xPraUE
         vVMX3dG7nr0cvNP37GpguMuFGFJMV/eb1/PBco/8=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lZc3UHNo4cZr; Fri, 23 Jul 2021 16:22:28 -0500 (CDT)
Received: from vali.starlink.edu (unknown [192.168.3.2])
        by mail.rptsys.com (Postfix) with ESMTP id 2E23337B1CE7CA;
        Fri, 23 Jul 2021 16:22:28 -0500 (CDT)
Date:   Fri, 23 Jul 2021 16:22:27 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <2057894451.4327679.1627075347173.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20210723210012.GC1278@fieldses.org>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com> <20210723210012.GC1278@fieldses.org>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC73 (Linux)/8.5.0_GA_3042)
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: UJcWg66JWy2W5ky+Tq7edxJ7/SDu7A==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



----- Original Message -----
> From: "J. Bruce Fields" <bfields@fieldses.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "Chuck Lever" <chuck.lever@oracle.com>, "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Friday, July 23, 2021 4:00:12 PM
> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load

> Sorry, took me a while to get to this because I'm not sure what to
> suggest:
> 
> On Mon, Jul 05, 2021 at 04:44:29AM -0500, Timothy Pearson wrote:
>> We've been dealing with a fairly nasty NFS-related problem off and on
>> for the past couple of years.  The host is a large POWER server with
>> several external SAS arrays attached, using BTRFS for cold storage of
>> large amounts of data.  The main symptom is that under heavy sustained
>> NFS write traffic using certain file types (see below) a core will
>> suddenly lock up, continually spewing a backtrace similar to the one
>> I've pasted below.
> 
> Is this the very *first* backtrace you get in the log?  Is there
> anything suspicious right before it?  (Other than the warnings you
> mention in the next message?)

Nothing in the logs before that.

>> While this immediately halts all NFS traffic to
>> the affected client (which is never the same client as the machine
>> doing the large file transfer), the larger issue is that over the next
>> few minutes / hours the entire host will gradually degrade in
>> responsiveness until it grinds to a complete halt.  Once the core
>> stall occurs we have been unable to find any way to restore the
>> machine to full functionality or avoid the degradation and eventual
>> hang short of a hard power down and restart.
> 
>> 
>> Tens of GB of compressed data in a single file seems to be fairly good at
>> triggering the problem, whereas raw disk images or other regularly patterned
>> data tend not to be.  The underlying hardware is functioning perfectly with no
>> problems noted, and moving the files without NFS avoids the bug.
>> 
>> We've been using a workaround involving purposefully pausing (SIGSTOP) the file
>> transfer process on the client as soon as other clients start to show a
>> slowdown.  This hack avoids the bug entirely provided the host is allowed to
>> catch back up prior to resuming (SIGCONT) the file transfer process.  From
>> this, it seems something is going very wrong within the NFS stack under high
>> storage I/O pressure and high storage write latency (timeout?) -- it should
>> simply pause transfers while the storage subsystem catches up, not lock up a
>> core and force a host restart.  Interesting, sometimes it does exactly what it
>> is supposed to and does pause and wait for the storage subsystem, but around
>> 20% of the time it just triggers this bug and stalls a core.
>> 
>> This bug has been present since at least 4.14 and is still present in the latest
>> 5.12.14 version.
>> 
>> As the machine is in production, it is difficult to gather further information
>> or test patches, however we would be able to apply patches to the kernel that
>> would potentially restore stability with enough advance scheduling.
>> 
>> Sample backtrace below:
>> 
>> [16846.426141] rcu: INFO: rcu_sched self-detected stall on CPU
>> [16846.426202] rcu:     32-....: (5249 ticks this GP)
>> idle=78a/1/0x4000000000000002 softirq=1663878/1663878 fqs=1986
>> [16846.426241]  (t=5251 jiffies g=2720809 q=756724)
>> [16846.426273] NMI backtrace for cpu 32
>> [16846.426298] CPU: 32 PID: 10624 Comm: kworker/u130:25 Not tainted 5.12.14 #1
>> [16846.426342] Workqueue: rpciod rpc_async_schedule [sunrpc]
>> [16846.426406] Call Trace:
>> [16846.426429] [c000200010823250] [c00000000074e630] dump_stack+0xc4/0x114
>> (unreliable)
>> [16846.426483] [c000200010823290] [c00000000075aebc]
>> nmi_cpu_backtrace+0xfc/0x150
>> [16846.426506] [c000200010823310] [c00000000075b0a8]
>> nmi_trigger_cpumask_backtrace+0x198/0x1f0
>> [16846.426577] [c0002000108233b0] [c000000000072818]
>> arch_trigger_cpumask_backtrace+0x28/0x40
>> [16846.426621] [c0002000108233d0] [c000000000202db8]
>> rcu_dump_cpu_stacks+0x158/0x1b8
>> [16846.426667] [c000200010823470] [c000000000201828]
>> rcu_sched_clock_irq+0x908/0xb10
>> [16846.426708] [c000200010823560] [c0000000002141d0]
>> update_process_times+0xc0/0x140
>> [16846.426768] [c0002000108235a0] [c00000000022dd34]
>> tick_sched_handle.isra.18+0x34/0xd0
>> [16846.426808] [c0002000108235d0] [c00000000022e1e8] tick_sched_timer+0x68/0xe0
>> [16846.426856] [c000200010823610] [c00000000021577c]
>> __hrtimer_run_queues+0x16c/0x370
>> [16846.426903] [c000200010823690] [c000000000216378]
>> hrtimer_interrupt+0x128/0x2f0
>> [16846.426947] [c000200010823740] [c000000000029494] timer_interrupt+0x134/0x310
>> [16846.426989] [c0002000108237a0] [c000000000016c54]
>> replay_soft_interrupts+0x124/0x2e0
>> [16846.427045] [c000200010823990] [c000000000016f14]
>> arch_local_irq_restore+0x104/0x170
>> [16846.427103] [c0002000108239c0] [c00000000017247c]
>> mod_delayed_work_on+0x8c/0xe0
>> [16846.427149] [c000200010823a20] [c00800000819fe04]
>> rpc_set_queue_timer+0x5c/0x80 [sunrpc]
>> [16846.427234] [c000200010823a40] [c0080000081a096c]
>> __rpc_sleep_on_priority_timeout+0x194/0x1b0 [sunrpc]
>> [16846.427324] [c000200010823a90] [c0080000081a3080]
>> rpc_sleep_on_timeout+0x88/0x110 [sunrpc]
>> [16846.427388] [c000200010823ad0] [c0080000071f7220] nfsd4_cb_done+0x468/0x530
>> [nfsd]
> 
> I think this has to be the rpc_delay in the -NFS4ERR_DELAY case of
> nfsd4_cb_sequence_done.  I don't know what would cause a lockup there.
> Maybe the rpc_task we've passed in is corrupted somehow?
> 
> We could try to add some instrumentation in that case.  I don't think
> that should be a common error case.  I guess the client has probably hit
> one of the NFS4ERR_DELAY cases in
> fs/nfs/callback_proc.c:nfs4_callback_sequence?
> 
> There might be a way to get some more information out of this with some
> tracing that you could run in production, but I'm not sure what to
> suggest off the top of my head.

Appreciate the response regardless!
