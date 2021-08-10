Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34DF3E5074
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 02:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhHJAzR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 20:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhHJAzQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 20:55:16 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B9BC0613D3
        for <linux-nfs@vger.kernel.org>; Mon,  9 Aug 2021 17:54:55 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id DB2C66852; Mon,  9 Aug 2021 20:54:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DB2C66852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1628556894;
        bh=GXP0thoyBjqOqPrrS8db9CPYps+HvRAi3Sk5vEs/F+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pBrC3Lafz9daVzoKprKlj//UZA0kLioGYIyqqkQYnwhk19014mGnWOnpe8spRvldp
         rdYnUoCyz29SvoJZSvw2Bv+jlanhZszsWKRe9aw1wuVNy+qS9t/dRb9lxnWxNnDsm4
         G4NegmWQd/ONlySeIJuaKbtaW4MpHXz5rFvsrClg=
Date:   Mon, 9 Aug 2021 20:54:54 -0400
From:   "J.  Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Timothy Pearson <tpearson@raptorengineering.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@gmail.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Message-ID: <20210810005454.GE13400@fieldses.org>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
 <162855621114.22632.14151019687856585770@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162855621114.22632.14151019687856585770@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 10, 2021 at 10:43:31AM +1000, NeilBrown wrote:
> On Mon, 05 Jul 2021, Timothy Pearson wrote:
> > 
> > Sample backtrace below:
> > 
> > [16846.426141] rcu: INFO: rcu_sched self-detected stall on CPU
> > [16846.426202] rcu:     32-....: (5249 ticks this GP) idle=78a/1/0x4000000000000002 softirq=1663878/1663878 fqs=1986
> > [16846.426241]  (t=5251 jiffies g=2720809 q=756724)
> > [16846.426273] NMI backtrace for cpu 32
> > [16846.426298] CPU: 32 PID: 10624 Comm: kworker/u130:25 Not tainted 5.12.14 #1
> > [16846.426342] Workqueue: rpciod rpc_async_schedule [sunrpc]
> > [16846.426406] Call Trace:
> > [16846.426429] [c000200010823250] [c00000000074e630] dump_stack+0xc4/0x114 (unreliable)
> > [16846.426483] [c000200010823290] [c00000000075aebc] nmi_cpu_backtrace+0xfc/0x150
> > [16846.426506] [c000200010823310] [c00000000075b0a8] nmi_trigger_cpumask_backtrace+0x198/0x1f0
> > [16846.426577] [c0002000108233b0] [c000000000072818] arch_trigger_cpumask_backtrace+0x28/0x40
> > [16846.426621] [c0002000108233d0] [c000000000202db8] rcu_dump_cpu_stacks+0x158/0x1b8
> > [16846.426667] [c000200010823470] [c000000000201828] rcu_sched_clock_irq+0x908/0xb10
> > [16846.426708] [c000200010823560] [c0000000002141d0] update_process_times+0xc0/0x140
> > [16846.426768] [c0002000108235a0] [c00000000022dd34] tick_sched_handle.isra.18+0x34/0xd0
> > [16846.426808] [c0002000108235d0] [c00000000022e1e8] tick_sched_timer+0x68/0xe0
> > [16846.426856] [c000200010823610] [c00000000021577c] __hrtimer_run_queues+0x16c/0x370
> > [16846.426903] [c000200010823690] [c000000000216378] hrtimer_interrupt+0x128/0x2f0
> > [16846.426947] [c000200010823740] [c000000000029494] timer_interrupt+0x134/0x310
> > [16846.426989] [c0002000108237a0] [c000000000016c54] replay_soft_interrupts+0x124/0x2e0
> > [16846.427045] [c000200010823990] [c000000000016f14] arch_local_irq_restore+0x104/0x170
> > [16846.427103] [c0002000108239c0] [c00000000017247c] mod_delayed_work_on+0x8c/0xe0
> > [16846.427149] [c000200010823a20] [c00800000819fe04] rpc_set_queue_timer+0x5c/0x80 [sunrpc]
> > [16846.427234] [c000200010823a40] [c0080000081a096c] __rpc_sleep_on_priority_timeout+0x194/0x1b0 [sunrpc]
> > [16846.427324] [c000200010823a90] [c0080000081a3080] rpc_sleep_on_timeout+0x88/0x110 [sunrpc]
> > [16846.427388] [c000200010823ad0] [c0080000071f7220] nfsd4_cb_done+0x468/0x530 [nfsd]
> > [16846.427457] [c000200010823b60] [c0080000081a0a0c] rpc_exit_task+0x84/0x1d0 [sunrpc]
> > [16846.427520] [c000200010823ba0] [c0080000081a2448] __rpc_execute+0xd0/0x760 [sunrpc]
> > [16846.427598] [c000200010823c30] [c0080000081a2b18] rpc_async_schedule+0x40/0x70 [sunrpc]
> 
> Time to play the sleuth .....
> "rpc_async_schedule" - so this is clearly an async task.
> It is running in __rpc_execute(), and calls rpc_exit_task().
> 
> rpc_exit_task() is a possible value for ->tk_action, which is set in
> several places.
> 1/ in call_bc_transmit_status(), but only after generating a kernel
>   message
>      RPC: Could not send backchannel reply......
>  You didn't report that message, so I'll assume it didn't happen.
> 
> 2/ In call_decode() if ->p_decode is NULL.  This implies a message
>    which didn't expect a reply.  All nfs4 callback procedures
>    (nfs4_cb_procedures[]) do set p_decode, so it cannot be here.
> 
> 3/ In call_decode() if the reply was successfully decoded.
>    I cannot rule this out quite so easily, but it seems unlikely as this
>    is a normal pattern and I wouldn't expect it to cause a soft-lockup.
> 
> 4/ In rpc_exit().  This is my guess.  All the places that rpc_exit() can
>    be called by nfsd (and nfsd appears in the call stack) are for handling 
>    errors.
> 
> So GUESS: rpc_exit() is getting called.
> Not only that, but it is getting called *often*.  The call to
> rpc_exit_task() (which is not the same as rpc_exit() - be careful) sets
> tk_action to NULL.  So rpc_exit() must get called again and again and
> again to keept setting tk_action back to rpc_exit_task, resulting in the
> soft lockup.
> 
> After setting ->tk_action to NULL, rpc_exit_task() calls
> ->rpc_call_done, which we see in the stack trace is nfsd4_cb_done().
> 
> nfsd4_cb_done() in turn calls ->done which is one of
>   nfsd4_cb_probe_done()
>   nfsd4_cb_sequence_done()
>   nfsd4_cb_layout_done()
> or
>   nfsd4_cb_notify_lock_done()
> 
> Some of these call rpc_delay(task,...) and return 0, causing
> nfsd4_cb_done() to call rpc_restart_call_prepare() This means the task
> can be requeued, but only after a delay.
> 
> This doesn't yet explain the spin, but now let's look back at
>  __rpc_execute().
> After calling do_action()  (which is rpc_exit_task() in the call trace)
> it checks if the task is queued.  If rpc_delay_task() wasn't call, it
> won't be queued and tk_action will be NULL, so it will loop around,
> do_action will be NULL, and the task aborts.
> 
> But if rpc_delay_task() was called, then the task will be queued (on the
> delay queue), and we continue in __rpc_execute().
> 
> The next test if is RPC_SIGNALLED().  If so, then rpc_exit() is called.
> Aha! We though that must have been getting called repeatedly.  It
> *might* not be here, but I think it is.  Let's assume so.
> rpc_exit() will set ->tk_action to rpc_exit_task, dequeue the task and
> (as it is async) schedule it for handling by rpc_async_schedule (that is
> in rpc_make_runnable()).
> 
> __rpc_execute_task continues down to
> 		if (task_is_async)
> 			return;
> and 
> rpc_async_schedule() returns.  But the task has already been queued to
> be handled again, so the whole process loops.
> 
> The problem here appears to be that a signalled task is being retried
> without clearing the SIGNALLED flag.  That is causing the infinite loop
> and the soft lockup.
> 
> This bug appears to have been introduced in Linux 5.2 by
> Commit: ae67bd3821bb ("SUNRPC: Fix up task signalling")

Wow, that's a lot farther than I got.  I'll take a look tomorrow....

> Prior to this commit a flag RPC_TASK_KILLED was used, and it gets
> cleared by rpc_reset_task_statistics() (called from rpc_exit_task()).
> After this commit a new flag RPC_TASK_SIGNALLED is used, and it is never
> cleared.
> 
> A fix might be to clear RPC_TASK_SIGNALLED in
> rpc_reset_task_statistics(), but I'll leave that decision to someone
> else.
> 
> This analysis doesn't completely gel with your claim that the bug has
> been present since at least 4.14, and the bug I think I found appeared
> in Linux 5.2.
> Maybe you previously had similar symptoms from a different bug?

I think it's possible there's more than one problem getting mixed into
this discussion.

--b.
