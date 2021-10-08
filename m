Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808604272B9
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Oct 2021 22:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhJHVBq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Oct 2021 17:01:46 -0400
Received: from mail.rptsys.com ([23.155.224.45]:60730 "EHLO mail.rptsys.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243219AbhJHVBq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Oct 2021 17:01:46 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Oct 2021 17:01:46 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 9B5A837B7BD8BA;
        Fri,  8 Oct 2021 15:53:58 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zoFNyIxCEgef; Fri,  8 Oct 2021 15:53:52 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id C5E4A37B7BD8B3;
        Fri,  8 Oct 2021 15:53:52 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com C5E4A37B7BD8B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1633726432; bh=OpktRCblVAKNN5BY1SWB8YBxvAIISMAIsmep5/SEL2A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pU1jEHfC+NJDY4Ncul0tbW9QbjXdebzLtVsrxNsluMt6DRKi9Q8XzP0wPQx8B45M4
         TcmPHoaawzjoRK2XsWICoEfb9baOmm8mgTsoBfyOiFqn2F/bSWxUfTuNAMQGJYx8jP
         IJvkt492TcNDGWK4vQ97jzqrDtVz9q+9CuTvpoyQ=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gtrDPMnIuJ7N; Fri,  8 Oct 2021 15:53:52 -0500 (CDT)
Received: from vali.starlink.edu (vali.starlink.edu [192.168.3.21])
        by mail.rptsys.com (Postfix) with ESMTP id 9E23B37B7BD8B0;
        Fri,  8 Oct 2021 15:53:52 -0500 (CDT)
Date:   Fri, 8 Oct 2021 15:53:51 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@gmail.com>
Message-ID: <1588431100.13810104.1633726431350.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com> <162855621114.22632.14151019687856585770@noble.neil.brown.name> <20210812144428.GA9536@fieldses.org> <162880418532.15074.7140645794203395299@noble.neil.brown.name> <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC83 (Linux)/8.5.0_GA_3042)
Thread-Topic: CPU stall, eventual host hang with BTRFS + NFS under heavy load
Thread-Index: vyRNKcyWO1qUHEfem7Z9DkN71NU3Pg==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As a data point, disabling NFSv4 has completely resolved the stability problems on our servers (tested for some months), but that's fairly large sledgehammer to use.

----- Original Message -----
> From: "Scott Mayhew" <smayhew@redhat.com>
> To: "NeilBrown" <neilb@suse.de>
> Cc: "J. Bruce Fields" <bfields@fieldses.org>, "Timothy Pearson" <tpearson@raptorengineering.com>, "Chuck Lever"
> <chuck.lever@oracle.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "Trond Myklebust" <trondmy@gmail.com>
> Sent: Friday, October 8, 2021 3:27:10 PM
> Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load

> On Fri, 13 Aug 2021, NeilBrown wrote:
> 
>> On Fri, 13 Aug 2021, J.  Bruce Fields wrote:
>> > On Tue, Aug 10, 2021 at 10:43:31AM +1000, NeilBrown wrote:
>> > > 
>> > > The problem here appears to be that a signalled task is being retried
>> > > without clearing the SIGNALLED flag.  That is causing the infinite loop
>> > > and the soft lockup.
>> > > 
>> > > This bug appears to have been introduced in Linux 5.2 by
>> > > Commit: ae67bd3821bb ("SUNRPC: Fix up task signalling")
>> > 
>> > I wonder how we arrived here.  Does it require that an rpc task returns
>> > from one of those rpc_delay() calls just as rpc_shutdown_client() is
>> > signalling it?  That's the only way async tasks get signalled, I think.
>> 
>> I don't think "just as" is needed.
>> I think it could only happen if rpc_shutdown_client() were called when
>> there were active tasks - presumably from nfsd4_process_cb_update(), but
>> I don't know the callback code well.
>> If any of those active tasks has a ->done handler which might try to
>> reschedule the task when tk_status == -ERESTARTSYS, then you get into
>> the infinite loop.
> 
> This thread seems to have fizzled out, but I'm pretty sure I hit this
> during the Virtual Bakeathon yesterday.  My server was unresponsive but
> I eventually managed to get a vmcore.
> 
> [182411.119788] receive_cb_reply: Got unrecognized reply: calldir 0x1
> xpt_bc_xprt 00000000f2f40905 xid 5d83adfb
> [182437.775113] watchdog: BUG: soft lockup - CPU#1 stuck for 26s!
> [kworker/u4:1:216458]
> [182437.775633] Modules linked in: nfs_layout_flexfiles nfsv3
> nfs_layout_nfsv41_files bluetooth ecdh_generic ecc rpcsec_gss_krb5 nfsv4
> dns_resolver nfs fscache netfs rpcrdma rdma_cm iw_cm ib_cm ib_core tun rfkill
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib isofs cdrom nft_reject_inet
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink xfs
> intel_rapl_msr intel_rapl_common libcrc32c kvm_intel qxl kvm drm_ttm_helper ttm
> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops irqbypass cec
> joydev virtio_balloon pcspkr i2c_piix4 nfsd auth_rpcgss nfs_acl lockd grace
> sunrpc drm fuse ext4 mbcache jbd2 ata_generic crct10dif_pclmul crc32_pclmul
> crc32c_intel ghash_clmulni_intel virtio_net serio_raw ata_piix net_failover
> libata virtio_blk virtio_scsi failover dm_mirror dm_region_hash dm_log dm_mod
> [182437.780157] CPU: 1 PID: 216458 Comm: kworker/u4:1 Kdump: loaded Not tainted
> 5.14.0-5.el9.x86_64 #1
> [182437.780894] Hardware name: DigitalOcean Droplet, BIOS 20171212 12/12/2017
> [182437.781567] Workqueue: rpciod rpc_async_schedule [sunrpc]
> [182437.782500] RIP: 0010:try_to_grab_pending+0x12/0x160
> [182437.783104] Code: e7 e8 72 f3 ff ff e9 6e ff ff ff 48 89 df e8 65 f3 ff ff
> eb b7 0f 1f 00 0f 1f 44 00 00 41 55 41 54 55 48 89 d5 53 48 89 fb 9c <58> fa 48
> 89 02 40 84 f6 0f 85 92 00 00 00 f0 48 0f ba 2b 00 72 09
> [182437.784261] RSP: 0018:ffffb5b24066fd30 EFLAGS: 00000246
> [182437.785052] RAX: 0000000000000000 RBX: ffffffffc05e0768 RCX:
> 00000000000007d0
> [182437.785760] RDX: ffffb5b24066fd60 RSI: 0000000000000001 RDI:
> ffffffffc05e0768
> [182437.786399] RBP: ffffb5b24066fd60 R08: ffffffffc05e0708 R09:
> ffffffffc05e0708
> [182437.787010] R10: 0000000000000003 R11: 0000000000000003 R12:
> ffffffffc05e0768
> [182437.787621] R13: ffff9daa40312400 R14: 00000000000007d0 R15:
> 0000000000000000
> [182437.788235] FS:  0000000000000000(0000) GS:ffff9daa5bd00000(0000)
> knlGS:0000000000000000
> [182437.788859] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [182437.789483] CR2: 00007f8f73d5d828 CR3: 000000008a010003 CR4:
> 00000000001706e0
> [182437.790188] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [182437.790831] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [182437.791522] Call Trace:
> [182437.792183]  mod_delayed_work_on+0x3c/0x90
> [182437.792866]  __rpc_sleep_on_priority_timeout+0x107/0x110 [sunrpc]
> [182437.793553]  rpc_delay+0x56/0x90 [sunrpc]
> [182437.794236]  nfsd4_cb_sequence_done+0x202/0x290 [nfsd]
> [182437.794910]  nfsd4_cb_done+0x18/0xf0 [nfsd]
> [182437.795974]  rpc_exit_task+0x58/0x100 [sunrpc]
> [182437.796955]  ? rpc_do_put_task+0x60/0x60 [sunrpc]
> [182437.797645]  __rpc_execute+0x5e/0x250 [sunrpc]
> [182437.798375]  rpc_async_schedule+0x29/0x40 [sunrpc]
> [182437.799043]  process_one_work+0x1e6/0x380
> [182437.799703]  worker_thread+0x53/0x3d0
> [182437.800393]  ? process_one_work+0x380/0x380
> [182437.801029]  kthread+0x10f/0x130
> [182437.801686]  ? set_kthread_struct+0x40/0x40
> [182437.802333]  ret_from_fork+0x22/0x30
> 
> The process causing the soft lockup warnings:
> 
> crash> set 216458
>    PID: 216458
> COMMAND: "kworker/u4:1"
>   TASK: ffff9da94281e200  [THREAD_INFO: ffff9da94281e200]
>    CPU: 0
>  STATE: TASK_RUNNING (ACTIVE)
> crash> bt
> PID: 216458  TASK: ffff9da94281e200  CPU: 0   COMMAND: "kworker/u4:1"
> #0 [fffffe000000be50] crash_nmi_callback at ffffffffb3055c31
> #1 [fffffe000000be58] nmi_handle at ffffffffb30268f8
> #2 [fffffe000000bea0] default_do_nmi at ffffffffb3a36d42
> #3 [fffffe000000bec8] exc_nmi at ffffffffb3a36f49
> #4 [fffffe000000bef0] end_repeat_nmi at ffffffffb3c013cb
>    [exception RIP: add_timer]
>    RIP: ffffffffb317c230  RSP: ffffb5b24066fd58  RFLAGS: 00000046
>    RAX: 000000010b3585fc  RBX: 0000000000000000  RCX: 00000000000007d0
>    RDX: ffffffffc05e0768  RSI: ffff9daa40312400  RDI: ffffffffc05e0788
>    RBP: 0000000000002000   R8: ffffffffc05e0770   R9: ffffffffc05e0788
>    R10: 0000000000000003  R11: 0000000000000003  R12: ffffffffc05e0768
>    R13: ffff9daa40312400  R14: 00000000000007d0  R15: 0000000000000000
>    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
> #5 [ffffb5b24066fd58] add_timer at ffffffffb317c230
> #6 [ffffb5b24066fd58] mod_delayed_work_on at ffffffffb3103247
> #7 [ffffb5b24066fd98] __rpc_sleep_on_priority_timeout at ffffffffc0580547
> [sunrpc]
> #8 [ffffb5b24066fdc8] rpc_delay at ffffffffc0589ed6 [sunrpc]
> #9 [ffffb5b24066fde8] nfsd4_cb_sequence_done at ffffffffc06731b2 [nfsd]
> #10 [ffffb5b24066fe10] nfsd4_cb_done at ffffffffc0673258 [nfsd]
> #11 [ffffb5b24066fe30] rpc_exit_task at ffffffffc05800a8 [sunrpc]
> #12 [ffffb5b24066fe40] __rpc_execute at ffffffffc0589fee [sunrpc]
> #13 [ffffb5b24066fe70] rpc_async_schedule at ffffffffc058a209 [sunrpc]
> #14 [ffffb5b24066fe88] process_one_work at ffffffffb31026c6
> #15 [ffffb5b24066fed0] worker_thread at ffffffffb31028b3
> #16 [ffffb5b24066ff10] kthread at ffffffffb310960f
> #17 [ffffb5b24066ff50] ret_from_fork at ffffffffb30034f2
> 
> Looking at the rpc_task being executed:
> 
> crash> rpc_task.tk_status,tk_callback,tk_action,tk_runstate,tk_client,tk_flags
> ffff9da94120bd00
>  tk_status = 0x0
>  tk_callback = 0xffffffffc057bc60 <__rpc_atrun>
>  tk_action = 0xffffffffc0571f20 <call_start>
>  tk_runstate = 0x47
>  tk_client = 0xffff9da958909c00
>  tk_flags = 0x2281
> 
> tk_runstate has the following flags set: RPC_TASK_SIGNALLED, RPC_TASK_ACTIVE,
> RPC_TASK_QUEUED, and RPC_TASK_RUNNING.
> 
> tk_flags is RPC_TASK_NOCONNECT|RPC_TASK_SOFT|RPC_TASK_DYNAMIC|RPC_TASK_ASYNC.
> 
> There's another kworker thread calling rpc_shutdown_client() via
> nfsd4_process_cb_update():
> 
> crash> bt 0x342a3
> PID: 213667  TASK: ffff9daa4fde9880  CPU: 1   COMMAND: "kworker/u4:4"
> #0 [ffffb5b24077bbe0] __schedule at ffffffffb3a40ec6
> #1 [ffffb5b24077bc60] schedule at ffffffffb3a4124c
> #2 [ffffb5b24077bc78] schedule_timeout at ffffffffb3a45058
> #3 [ffffb5b24077bcd0] rpc_shutdown_client at ffffffffc056fbb3 [sunrpc]
> #4 [ffffb5b24077bd20] nfsd4_process_cb_update at ffffffffc0672c6c [nfsd]
> #5 [ffffb5b24077be68] nfsd4_run_cb_work at ffffffffc0672f0f [nfsd]
> #6 [ffffb5b24077be88] process_one_work at ffffffffb31026c6
> #7 [ffffb5b24077bed0] worker_thread at ffffffffb31028b3
> #8 [ffffb5b24077bf10] kthread at ffffffffb310960f
> #9 [ffffb5b24077bf50] ret_from_fork at ffffffffb30034f2
> 
> The rpc_clnt being shut down is:
> 
> crash> nfs4_client.cl_cb_client ffff9daa454db808
>  cl_cb_client = 0xffff9da958909c00
> 
> Which is the same as the tk_client for the rpc_task being executed by the
> thread triggering the soft lockup warnings.
> 
> -Scott
> 
>> 
>> > 
>> > > Prior to this commit a flag RPC_TASK_KILLED was used, and it gets
>> > > cleared by rpc_reset_task_statistics() (called from rpc_exit_task()).
>> > > After this commit a new flag RPC_TASK_SIGNALLED is used, and it is never
>> > > cleared.
>> > > 
>> > > A fix might be to clear RPC_TASK_SIGNALLED in
>> > > rpc_reset_task_statistics(), but I'll leave that decision to someone
>> > > else.
>> > 
>> > Might be worth testing with that change just to verify that this is
>> > what's happening.
>> > 
>> > diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>> > index c045f63d11fa..caa931888747 100644
>> > --- a/net/sunrpc/sched.c
>> > +++ b/net/sunrpc/sched.c
>> > @@ -813,7 +813,8 @@ static void
>> >  rpc_reset_task_statistics(struct rpc_task *task)
>> >  {
>> >  	task->tk_timeouts = 0;
>> > -	task->tk_flags &= ~(RPC_CALL_MAJORSEEN|RPC_TASK_SENT);
>> > +	task->tk_flags &= ~(RPC_CALL_MAJORSEEN|RPC_TASK_SIGNALLED|
>> > +							RPC_TASK_SENT);
>> 
>> NONONONONO.
>> RPC_TASK_SIGNALLED is a flag in tk_runstate.
>> So you need
>> 	clear_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
>> 
>> NeilBrown
