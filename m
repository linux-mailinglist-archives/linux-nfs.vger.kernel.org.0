Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72BD3E506B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 02:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhHJAn6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 20:43:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46782 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbhHJAn6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 20:43:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3ECB1FE2B;
        Tue, 10 Aug 2021 00:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628556215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tOuqp6Lc+2SQsqdU/h0S6/wsJR1nQEbmGKsdTXPYanA=;
        b=FNakPbABvlQP8JpR4Pe4XmrIXRYemCv3M8kz5Lh9/kM+dwZMGPjdqAnETO7yHYYSLmwkTH
        6pQHGIspGslS8dNv7knbnPp8tjYXvDPAETuO46NDtgq1R3df9+ToMoKYeuWIdQl1Z+mCP7
        vQ6VeSXd/fN6yvoAciN/D6J2j7eYLRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628556215;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tOuqp6Lc+2SQsqdU/h0S6/wsJR1nQEbmGKsdTXPYanA=;
        b=ikBMuuc+n5dQ4gWUX0RyySK96my7WNJp9uoj3GEkRJEVDm9WEpRvbbmD7vCnVCvh0pB5bv
        bzRt0DKsmg4kEJAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 237E313A88;
        Tue, 10 Aug 2021 00:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q6O9NLXLEWGXNQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 10 Aug 2021 00:43:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Timothy Pearson" <tpearson@raptorengineering.com>
Cc:     "J.  Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@gmail.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
In-reply-to: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>
Date:   Tue, 10 Aug 2021 10:43:31 +1000
Message-id: <162855621114.22632.14151019687856585770@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 05 Jul 2021, Timothy Pearson wrote:
>=20
> Sample backtrace below:
>=20
> [16846.426141] rcu: INFO: rcu_sched self-detected stall on CPU
> [16846.426202] rcu:     32-....: (5249 ticks this GP) idle=3D78a/1/0x400000=
0000000002 softirq=3D1663878/1663878 fqs=3D1986
> [16846.426241]  (t=3D5251 jiffies g=3D2720809 q=3D756724)
> [16846.426273] NMI backtrace for cpu 32
> [16846.426298] CPU: 32 PID: 10624 Comm: kworker/u130:25 Not tainted 5.12.14=
 #1
> [16846.426342] Workqueue: rpciod rpc_async_schedule [sunrpc]
> [16846.426406] Call Trace:
> [16846.426429] [c000200010823250] [c00000000074e630] dump_stack+0xc4/0x114 =
(unreliable)
> [16846.426483] [c000200010823290] [c00000000075aebc] nmi_cpu_backtrace+0xfc=
/0x150
> [16846.426506] [c000200010823310] [c00000000075b0a8] nmi_trigger_cpumask_ba=
cktrace+0x198/0x1f0
> [16846.426577] [c0002000108233b0] [c000000000072818] arch_trigger_cpumask_b=
acktrace+0x28/0x40
> [16846.426621] [c0002000108233d0] [c000000000202db8] rcu_dump_cpu_stacks+0x=
158/0x1b8
> [16846.426667] [c000200010823470] [c000000000201828] rcu_sched_clock_irq+0x=
908/0xb10
> [16846.426708] [c000200010823560] [c0000000002141d0] update_process_times+0=
xc0/0x140
> [16846.426768] [c0002000108235a0] [c00000000022dd34] tick_sched_handle.isra=
.18+0x34/0xd0
> [16846.426808] [c0002000108235d0] [c00000000022e1e8] tick_sched_timer+0x68/=
0xe0
> [16846.426856] [c000200010823610] [c00000000021577c] __hrtimer_run_queues+0=
x16c/0x370
> [16846.426903] [c000200010823690] [c000000000216378] hrtimer_interrupt+0x12=
8/0x2f0
> [16846.426947] [c000200010823740] [c000000000029494] timer_interrupt+0x134/=
0x310
> [16846.426989] [c0002000108237a0] [c000000000016c54] replay_soft_interrupts=
+0x124/0x2e0
> [16846.427045] [c000200010823990] [c000000000016f14] arch_local_irq_restore=
+0x104/0x170
> [16846.427103] [c0002000108239c0] [c00000000017247c] mod_delayed_work_on+0x=
8c/0xe0
> [16846.427149] [c000200010823a20] [c00800000819fe04] rpc_set_queue_timer+0x=
5c/0x80 [sunrpc]
> [16846.427234] [c000200010823a40] [c0080000081a096c] __rpc_sleep_on_priorit=
y_timeout+0x194/0x1b0 [sunrpc]
> [16846.427324] [c000200010823a90] [c0080000081a3080] rpc_sleep_on_timeout+0=
x88/0x110 [sunrpc]
> [16846.427388] [c000200010823ad0] [c0080000071f7220] nfsd4_cb_done+0x468/0x=
530 [nfsd]
> [16846.427457] [c000200010823b60] [c0080000081a0a0c] rpc_exit_task+0x84/0x1=
d0 [sunrpc]
> [16846.427520] [c000200010823ba0] [c0080000081a2448] __rpc_execute+0xd0/0x7=
60 [sunrpc]
> [16846.427598] [c000200010823c30] [c0080000081a2b18] rpc_async_schedule+0x4=
0/0x70 [sunrpc]

Time to play the sleuth .....
"rpc_async_schedule" - so this is clearly an async task.
It is running in __rpc_execute(), and calls rpc_exit_task().

rpc_exit_task() is a possible value for ->tk_action, which is set in
several places.
1/ in call_bc_transmit_status(), but only after generating a kernel
  message
     RPC: Could not send backchannel reply......
 You didn't report that message, so I'll assume it didn't happen.

2/ In call_decode() if ->p_decode is NULL.  This implies a message
   which didn't expect a reply.  All nfs4 callback procedures
   (nfs4_cb_procedures[]) do set p_decode, so it cannot be here.

3/ In call_decode() if the reply was successfully decoded.
   I cannot rule this out quite so easily, but it seems unlikely as this
   is a normal pattern and I wouldn't expect it to cause a soft-lockup.

4/ In rpc_exit().  This is my guess.  All the places that rpc_exit() can
   be called by nfsd (and nfsd appears in the call stack) are for handling=20
   errors.

So GUESS: rpc_exit() is getting called.
Not only that, but it is getting called *often*.  The call to
rpc_exit_task() (which is not the same as rpc_exit() - be careful) sets
tk_action to NULL.  So rpc_exit() must get called again and again and
again to keept setting tk_action back to rpc_exit_task, resulting in the
soft lockup.

After setting ->tk_action to NULL, rpc_exit_task() calls
->rpc_call_done, which we see in the stack trace is nfsd4_cb_done().

nfsd4_cb_done() in turn calls ->done which is one of
  nfsd4_cb_probe_done()
  nfsd4_cb_sequence_done()
  nfsd4_cb_layout_done()
or
  nfsd4_cb_notify_lock_done()

Some of these call rpc_delay(task,...) and return 0, causing
nfsd4_cb_done() to call rpc_restart_call_prepare() This means the task
can be requeued, but only after a delay.

This doesn't yet explain the spin, but now let's look back at
 __rpc_execute().
After calling do_action()  (which is rpc_exit_task() in the call trace)
it checks if the task is queued.  If rpc_delay_task() wasn't call, it
won't be queued and tk_action will be NULL, so it will loop around,
do_action will be NULL, and the task aborts.

But if rpc_delay_task() was called, then the task will be queued (on the
delay queue), and we continue in __rpc_execute().

The next test if is RPC_SIGNALLED().  If so, then rpc_exit() is called.
Aha! We though that must have been getting called repeatedly.  It
*might* not be here, but I think it is.  Let's assume so.
rpc_exit() will set ->tk_action to rpc_exit_task, dequeue the task and
(as it is async) schedule it for handling by rpc_async_schedule (that is
in rpc_make_runnable()).

__rpc_execute_task continues down to
		if (task_is_async)
			return;
and=20
rpc_async_schedule() returns.  But the task has already been queued to
be handled again, so the whole process loops.

The problem here appears to be that a signalled task is being retried
without clearing the SIGNALLED flag.  That is causing the infinite loop
and the soft lockup.

This bug appears to have been introduced in Linux 5.2 by
Commit: ae67bd3821bb ("SUNRPC: Fix up task signalling")

Prior to this commit a flag RPC_TASK_KILLED was used, and it gets
cleared by rpc_reset_task_statistics() (called from rpc_exit_task()).
After this commit a new flag RPC_TASK_SIGNALLED is used, and it is never
cleared.

A fix might be to clear RPC_TASK_SIGNALLED in
rpc_reset_task_statistics(), but I'll leave that decision to someone
else.

This analysis doesn't completely gel with your claim that the bug has
been present since at least 4.14, and the bug I think I found appeared
in Linux 5.2.
Maybe you previously had similar symptoms from a different bug?

I'll leave to Bruce, Chuck, and Trond to work out the best fix.

NeilBrown
