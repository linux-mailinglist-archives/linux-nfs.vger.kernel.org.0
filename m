Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9F65BB223
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Sep 2022 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIPS3C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Sep 2022 14:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIPS3B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Sep 2022 14:29:01 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00A3B7280;
        Fri, 16 Sep 2022 11:28:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a80so13442129pfa.4;
        Fri, 16 Sep 2022 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=d3hdfr9jL9JFD1GCiB99ZnQ26Rodd0m2mAbpLLEijpA=;
        b=S48kij/7BVBmd6/ZpiwTyl5CJUQgY9NQxcDQyDLrK5zLyc8x2C8dquhy+xkAVhikj1
         pW3vf0b0diU+V5UcY1nWWw8PgVq2/yHNWv44mK85IllWKRFIvoyO0PxsFXw5U8Ur/DqG
         ScRq9Zm+MpEqS75hteIGT6H9y7uB7h4rb6g9D87H4jIbgy7dAmV6XOregRI1+QI4vMQ1
         fQKtJW/BtuujA/GtGiOGJ6luiF2NHd2ZTFpgU97fiSl4MMCRg+zdwsp0CqN64TQMeQtq
         temCTxB3IxaewuxuBn8jtLO4skH4Wm1+tvuYo6QAYTMXfpRXnZ/m5s1XGY54JVfX9pmU
         XvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=d3hdfr9jL9JFD1GCiB99ZnQ26Rodd0m2mAbpLLEijpA=;
        b=OIsotXRWhziYbGcCdFlfKtV8gazQCoxwM0IHkj/W6fpIiEc47o4A8AxvnlHipc0Gp8
         7bEEnNAjBEG5114Gf8TGqt6hkSVZ6m0RDCZ/xhjPfATXBengTsPx3gH7zs4oPI4KFQaz
         LeoUF+xS4pJ29Cv595aR4LG6jqLH2o/Mt8EyFWbdSAA3ehG87gEn+WCyQgEvuS/uf5Fs
         sy4sAAQeDboko1gDETQzgXbgskDynAxZaPnxNYze+el+Fy0y9/DiWUyt+DZRdlNprYLV
         AIgPf7/NI1gTpkqgv11NRut4Gl21rbX2jnMKE4Qirgx7YnNYCEF3z62B+kya3oOna2gk
         N+ow==
X-Gm-Message-State: ACrzQf21fIF1XKPmk5bv0peTGz2yfXqMkq0TLQu74rALcUvxckNcBn6H
        91VLdd2v9zsB+Y5MCboQKlSQsVruTytCwVzhKf8Z1OLtokg=
X-Google-Smtp-Source: AMsMyM6YsAJHQ1CXSOhr90eh9tZCw8xH0bh9yocHwlF75LgmV2VOCJ9ocA2eh0lv9O/jBNT1okwZl9BKYE/8o4EoICU=
X-Received: by 2002:a63:de58:0:b0:439:41e9:dda2 with SMTP id
 y24-20020a63de58000000b0043941e9dda2mr5607212pgi.331.1663352932837; Fri, 16
 Sep 2022 11:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <166247968798.587726.7092426682689468087.stgit@morisot.1015granger.net>
 <CAN-5tyEtr0f6o=0j_kMpf-tY7vvzfzaCd__P6taXhmq+e3TM-g@mail.gmail.com>
In-Reply-To: <CAN-5tyEtr0f6o=0j_kMpf-tY7vvzfzaCd__P6taXhmq+e3TM-g@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 16 Sep 2022 14:28:41 -0400
Message-ID: <CAN-5tyGwvwKZCttNu4W+Rxmq5OV1rJBsMnMVC3yufhqsCmyC=Q@mail.gmail.com>
Subject: Re: [PATCH v1] SUNRPC: Replace the use of the xprtiod WQ in rpcrdma
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 15, 2022 at 11:56 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Tue, Sep 6, 2022 at 12:25 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > While setting up a new lab, I accidentally misconfigured the
> > Ethernet port for a system that tried an NFS mount using RoCE.
> > This made the NFS server unreachable. The following WARNING
> > popped on the NFS client while waiting for the mount attempt to
> > time out:
>
> I also hit this today (on the 5.18 kernel) while running xfstest
> generic/460 using soft iWarp. In my case the port was properly
> configured. The test was going. I'm not sure exactly what happened. I
> know I also crashed the server that I was running against. But the
> point I would like to make is that this condition is possible to get
> to on a properly configured system.

But I think with this patch. I'm hitting this instead (of course could
be something else):

[ 3222.712335] BUG: using smp_processor_id() in preemptible [00000000]
code: 192.168.1.124-m/3814
[ 3222.714428] caller is xprt_rdma_connect+0x6a/0x120 [rpcrdma]
[ 3222.716047] CPU: 0 PID: 3814 Comm: 192.168.1.124-m Not tainted
6.0.0-rc5+ #123
[ 3222.717706] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[ 3222.720310] Call Trace:
[ 3222.721032]  <TASK>
[ 3222.721587]  dump_stack_lvl+0x33/0x46
[ 3222.722501]  check_preemption_disabled+0xc3/0xf0
[ 3222.723754]  xprt_rdma_connect+0x6a/0x120 [rpcrdma]
[ 3222.725594]  xprt_connect+0x300/0x370 [sunrpc]
[ 3222.727369]  ? call_reserveresult+0xa0/0xa0 [sunrpc]
[ 3222.729272]  __rpc_execute+0x162/0x870 [sunrpc]
[ 3222.731101]  ? rpc_exit+0x40/0x40 [sunrpc]
[ 3222.732841]  ? __wake_up+0x10/0x10
[ 3222.733657]  rpc_execute+0x148/0x1b0 [sunrpc]
[ 3222.735326]  rpc_run_task+0x270/0x2d0 [sunrpc]
[ 3222.737182]  nfs4_proc_bind_one_conn_to_session+0x1cc/0x3a0 [nfsv4]
[ 3222.740472]  ? _nfs4_do_set_security_label+0x2d0/0x2d0 [nfsv4]
[ 3222.745034]  ? xprt_get+0xa0/0x120 [sunrpc]
[ 3222.747150]  ? nfs4_proc_bind_one_conn_to_session+0x3a0/0x3a0 [nfsv4]
[ 3222.749299]  ? __rcu_read_unlock+0x4e/0x250
[ 3222.750429]  ? nfs4_proc_bind_one_conn_to_session+0x3a0/0x3a0 [nfsv4]
[ 3222.752586]  rpc_clnt_iterate_for_each_xprt+0xc6/0x140 [sunrpc]
[ 3222.754900]  ? rpc_clnt_xprt_switch_add_xprt+0xa0/0xa0 [sunrpc]
[ 3222.757041]  ? preempt_count_sub+0x14/0xc0
[ 3222.758097]  nfs4_proc_bind_conn_to_session+0x87/0xb0 [nfsv4]
[ 3222.760341]  ? nfs4_proc_secinfo+0x250/0x250 [nfsv4]
[ 3222.762257]  nfs4_state_manager+0x34e/0xf60 [nfsv4]
[ 3222.764095]  nfs4_run_state_manager+0x1a6/0x2e0 [nfsv4]
[ 3222.766778]  ? nfs4_state_manager+0xf60/0xf60 [nfsv4]
[ 3222.768811]  ? _raw_spin_lock_irqsave+0x8d/0xf0
[ 3222.770029]  ? _raw_spin_unlock_irqrestore+0x40/0x40
[ 3222.771740]  ? __list_del_entry_valid+0x77/0xa0
[ 3222.773400]  ? nfs4_state_manager+0xf60/0xf60 [nfsv4]
[ 3222.775653]  kthread+0x160/0x190
[ 3222.776729]  ? kthread_complete_and_exit+0x20/0x20
[ 3222.777865]  ret_from_fork+0x1f/0x30
[ 3222.778972]  </TASK>


>
> > kernel: workqueue: WQ_MEM_RECLAIM xprtiod:xprt_rdma_connect_worker [rpcrdma] is flushing !WQ_MEM_RECLAI>
> > kernel: WARNING: CPU: 0 PID: 100 at kernel/workqueue.c:2628 check_flush_dependency+0xbf/0xca
> > kernel: Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs 8021q garp stp mrp llc rfkill rpcrdma>
> > kernel: CPU: 0 PID: 100 Comm: kworker/u8:8 Not tainted 6.0.0-rc1-00002-g6229f8c054e5 #13
> > kernel: Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0b 06/12/2017
> > kernel: Workqueue: xprtiod xprt_rdma_connect_worker [rpcrdma]
> > kernel: RIP: 0010:check_flush_dependency+0xbf/0xca
> > kernel: Code: 75 2a 48 8b 55 18 48 8d 8b b0 00 00 00 4d 89 e0 48 81 c6 b0 00 00 00 48 c7 c7 65 33 2e be>
> > kernel: RSP: 0018:ffffb562806cfcf8 EFLAGS: 00010092
> > kernel: RAX: 0000000000000082 RBX: ffff97894f8c3c00 RCX: 0000000000000027
> > kernel: RDX: 0000000000000002 RSI: ffffffffbe3447d1 RDI: 00000000ffffffff
> > kernel: RBP: ffff978941315840 R08: 0000000000000000 R09: 0000000000000000
> > kernel: R10: 00000000000008b0 R11: 0000000000000001 R12: ffffffffc0ce3731
> > kernel: R13: ffff978950c00500 R14: ffff97894341f0c0 R15: ffff978951112eb0
> > kernel: FS:  0000000000000000(0000) GS:ffff97987fc00000(0000) knlGS:0000000000000000
> > kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > kernel: CR2: 00007f807535eae8 CR3: 000000010b8e4002 CR4: 00000000003706f0
> > kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > kernel: Call Trace:
> > kernel:  <TASK>
> > kernel:  __flush_work.isra.0+0xaf/0x188
> > kernel:  ? _raw_spin_lock_irqsave+0x2c/0x37
> > kernel:  ? lock_timer_base+0x38/0x5f
> > kernel:  __cancel_work_timer+0xea/0x13d
> > kernel:  ? preempt_latency_start+0x2b/0x46
> > kernel:  rdma_addr_cancel+0x70/0x81 [ib_core]
> > kernel:  _destroy_id+0x1a/0x246 [rdma_cm]
> > kernel:  rpcrdma_xprt_connect+0x115/0x5ae [rpcrdma]
> > kernel:  ? _raw_spin_unlock+0x14/0x29
> > kernel:  ? raw_spin_rq_unlock_irq+0x5/0x10
> > kernel:  ? finish_task_switch.isra.0+0x171/0x249
> > kernel:  xprt_rdma_connect_worker+0x3b/0xc7 [rpcrdma]
> > kernel:  process_one_work+0x1d8/0x2d4
> > kernel:  worker_thread+0x18b/0x24f
> > kernel:  ? rescuer_thread+0x280/0x280
> > kernel:  kthread+0xf4/0xfc
> > kernel:  ? kthread_complete_and_exit+0x1b/0x1b
> > kernel:  ret_from_fork+0x22/0x30
> > kernel:  </TASK>
> >
> > SUNRPC's xprtiod workqueue is WQ_MEM_RECLAIM, so any workqueue that
> > one of its work items tries to cancel has to be WQ_MEM_RECLAIM to
> > prevent a priority inversion. The internal workqueues in the
> > RDMA/core are currently non-MEM_RECLAIM.
> >
> > Jason Gunthorpe says this about the current state of RDMA/core:
> > > If you attempt to do a reconnection/etc from within a RECLAIM
> > > context it will deadlock on one of the many allocations that are
> > > made to support opening the connection.
> > >
> > > The general idea of reclaim is that the entire task context
> > > working under the reclaim is marked with an override of the gfp
> > > flags to make all allocations under that call chain reclaim safe.
> > >
> > > But rdmacm does allocations outside this, eg in the WQs processing
> > > the CM packets. So this doesn't work and we will deadlock.
> > >
> > > Fixing it is a big deal and needs more than poking WQ_MEM_RECLAIM
> > > here and there.
> >
> > So we will change the ULP in this case to avoid the use of
> > WQ_MEM_RECLAIM where possible. Deadlocks that were possible before
> > are not fixed, but at least we no longer have a false sense of
> > confidence that the stack won't allocate memory during memory
> > reclaim.
> >
> > While we're adjusting these queue_* call sites, ensure the work
> > requests always run on the local CPU so the worker allocates RDMA
> > resources that are local to the CPU that queued the work request.
> >
> > Suggested-by: Leon Romanovsky <leon@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  net/sunrpc/xprtrdma/transport.c |    4 ++--
> >  net/sunrpc/xprtrdma/verbs.c     |   11 ++++-------
> >  2 files changed, 6 insertions(+), 9 deletions(-)
> >
> > Hi Anna-
> >
> > I've had this applied to my test client for a while. I think it's
> > ready to apply.
> >
> >
> > diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
> > index bcb37b51adf6..9581641bb8cb 100644
> > --- a/net/sunrpc/xprtrdma/transport.c
> > +++ b/net/sunrpc/xprtrdma/transport.c
> > @@ -494,8 +494,8 @@ xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_task *task)
> >                 xprt_reconnect_backoff(xprt, RPCRDMA_INIT_REEST_TO);
> >         }
> >         trace_xprtrdma_op_connect(r_xprt, delay);
> > -       queue_delayed_work(xprtiod_workqueue, &r_xprt->rx_connect_worker,
> > -                          delay);
> > +       queue_delayed_work_on(smp_processor_id(), system_long_wq,
> > +                             &r_xprt->rx_connect_worker, delay);
> >  }
> >
> >  /**
> > diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> > index 2fbe9aaeec34..691afc96bcbc 100644
> > --- a/net/sunrpc/xprtrdma/verbs.c
> > +++ b/net/sunrpc/xprtrdma/verbs.c
> > @@ -791,13 +791,10 @@ void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt)
> >         /* If there is no underlying connection, it's no use
> >          * to wake the refresh worker.
> >          */
> > -       if (ep->re_connect_status == 1) {
> > -               /* The work is scheduled on a WQ_MEM_RECLAIM
> > -                * workqueue in order to prevent MR allocation
> > -                * from recursing into NFS during direct reclaim.
> > -                */
> > -               queue_work(xprtiod_workqueue, &buf->rb_refresh_worker);
> > -       }
> > +       if (ep->re_connect_status != 1)
> > +               return;
> > +       queue_work_on(smp_processor_id(), system_highpri_wq,
> > +                     &buf->rb_refresh_worker);
> >  }
> >
> >  /**
> >
> >
