Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A735B9F3F
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Sep 2022 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiIOP5S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Sep 2022 11:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiIOP5B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Sep 2022 11:57:01 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51974F693;
        Thu, 15 Sep 2022 08:56:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dv25so43099739ejb.12;
        Thu, 15 Sep 2022 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4SJlOpsTPc5GSecmr6gUPYeQqelFZcN9hVkBWAKVK4M=;
        b=JRUkPnvxqt+21+hZQtDFYdtNLMgNs+4ZDEZIuxHu+d6Kk/YMH2v2giTnAerjbATRqA
         d25T/h4EsPeZfZ6/vvsfDo7txgCH+klgY3oDI15bbANrUEEBNnFvr5vmtmbFhMboNcqd
         QsSLAVOzq8rbxbCQfezu+tc6adTeaxRxI2S5ToerqxWfdx1rI9MPkYqLvAKG8i5uS5v9
         skIu0Dtag7/38w2rNna6Gh0Zywm6x+nERYc/GZqa2CZ4CHBzoabM/hR7yUHLiUDa3haS
         Y6Zwm2fkwoGcETRxRf9WIFDW2agnZhM0VEX7l07OdiyVNomzFW0z8Rfk9kdZCY5oednJ
         EIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4SJlOpsTPc5GSecmr6gUPYeQqelFZcN9hVkBWAKVK4M=;
        b=LySMJ20rOP6qprm8jDSj5pnuc6ut8ROmW2VdMeEuF40F6k+JWlX4yGnKA6mGO/4fVx
         y+oqUL/5rclfoxnwYIX66wVIBU8DFL07q6QrQg7KEBBzGqeixVicGlZSkm15GuO3LhcW
         QlmSip3ZdHH1yDm6OCvMQaDVp89R5vWtvE4Gy0kqvQID54Cq1CiJLh1d3Mp6zqmKR+qT
         38Xaaqf+1rQ/G7x/BWvXe6KWBB6JLDpJfRrWnfhQawqRAy+4Uk6OdQxJe3fsRlmZg+F6
         j/rJJDKoYoBw3DaMQi96HX0cWs1V3NC4Z2YD49JP7IiNM6JYhUfrSQAbkOOZFK0UX/mA
         7Ytw==
X-Gm-Message-State: ACrzQf2gh9N6de7mXyMiOxaekiBgjazlL/JGM3oT/4Pnred/WWYHzMjv
        9aTVehmM1+GdONUOIvdwYFufWPZyEZwpajYvuKE=
X-Google-Smtp-Source: AMsMyM7w7rxaxmEkffH15PuLQgUYuCuNhhDMGSISfi3eZ9u97MOCM8FHl9ULuyDSSmA3i6p7Lyd8yFYd04abXXdKKEI=
X-Received: by 2002:a17:907:72cf:b0:780:2618:97d4 with SMTP id
 du15-20020a17090772cf00b00780261897d4mr469476ejc.150.1663257418175; Thu, 15
 Sep 2022 08:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <166247968798.587726.7092426682689468087.stgit@morisot.1015granger.net>
In-Reply-To: <166247968798.587726.7092426682689468087.stgit@morisot.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 15 Sep 2022 11:56:46 -0400
Message-ID: <CAN-5tyEtr0f6o=0j_kMpf-tY7vvzfzaCd__P6taXhmq+e3TM-g@mail.gmail.com>
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

On Tue, Sep 6, 2022 at 12:25 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> While setting up a new lab, I accidentally misconfigured the
> Ethernet port for a system that tried an NFS mount using RoCE.
> This made the NFS server unreachable. The following WARNING
> popped on the NFS client while waiting for the mount attempt to
> time out:

I also hit this today (on the 5.18 kernel) while running xfstest
generic/460 using soft iWarp. In my case the port was properly
configured. The test was going. I'm not sure exactly what happened. I
know I also crashed the server that I was running against. But the
point I would like to make is that this condition is possible to get
to on a properly configured system.

> kernel: workqueue: WQ_MEM_RECLAIM xprtiod:xprt_rdma_connect_worker [rpcrdma] is flushing !WQ_MEM_RECLAI>
> kernel: WARNING: CPU: 0 PID: 100 at kernel/workqueue.c:2628 check_flush_dependency+0xbf/0xca
> kernel: Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs 8021q garp stp mrp llc rfkill rpcrdma>
> kernel: CPU: 0 PID: 100 Comm: kworker/u8:8 Not tainted 6.0.0-rc1-00002-g6229f8c054e5 #13
> kernel: Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0b 06/12/2017
> kernel: Workqueue: xprtiod xprt_rdma_connect_worker [rpcrdma]
> kernel: RIP: 0010:check_flush_dependency+0xbf/0xca
> kernel: Code: 75 2a 48 8b 55 18 48 8d 8b b0 00 00 00 4d 89 e0 48 81 c6 b0 00 00 00 48 c7 c7 65 33 2e be>
> kernel: RSP: 0018:ffffb562806cfcf8 EFLAGS: 00010092
> kernel: RAX: 0000000000000082 RBX: ffff97894f8c3c00 RCX: 0000000000000027
> kernel: RDX: 0000000000000002 RSI: ffffffffbe3447d1 RDI: 00000000ffffffff
> kernel: RBP: ffff978941315840 R08: 0000000000000000 R09: 0000000000000000
> kernel: R10: 00000000000008b0 R11: 0000000000000001 R12: ffffffffc0ce3731
> kernel: R13: ffff978950c00500 R14: ffff97894341f0c0 R15: ffff978951112eb0
> kernel: FS:  0000000000000000(0000) GS:ffff97987fc00000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 00007f807535eae8 CR3: 000000010b8e4002 CR4: 00000000003706f0
> kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __flush_work.isra.0+0xaf/0x188
> kernel:  ? _raw_spin_lock_irqsave+0x2c/0x37
> kernel:  ? lock_timer_base+0x38/0x5f
> kernel:  __cancel_work_timer+0xea/0x13d
> kernel:  ? preempt_latency_start+0x2b/0x46
> kernel:  rdma_addr_cancel+0x70/0x81 [ib_core]
> kernel:  _destroy_id+0x1a/0x246 [rdma_cm]
> kernel:  rpcrdma_xprt_connect+0x115/0x5ae [rpcrdma]
> kernel:  ? _raw_spin_unlock+0x14/0x29
> kernel:  ? raw_spin_rq_unlock_irq+0x5/0x10
> kernel:  ? finish_task_switch.isra.0+0x171/0x249
> kernel:  xprt_rdma_connect_worker+0x3b/0xc7 [rpcrdma]
> kernel:  process_one_work+0x1d8/0x2d4
> kernel:  worker_thread+0x18b/0x24f
> kernel:  ? rescuer_thread+0x280/0x280
> kernel:  kthread+0xf4/0xfc
> kernel:  ? kthread_complete_and_exit+0x1b/0x1b
> kernel:  ret_from_fork+0x22/0x30
> kernel:  </TASK>
>
> SUNRPC's xprtiod workqueue is WQ_MEM_RECLAIM, so any workqueue that
> one of its work items tries to cancel has to be WQ_MEM_RECLAIM to
> prevent a priority inversion. The internal workqueues in the
> RDMA/core are currently non-MEM_RECLAIM.
>
> Jason Gunthorpe says this about the current state of RDMA/core:
> > If you attempt to do a reconnection/etc from within a RECLAIM
> > context it will deadlock on one of the many allocations that are
> > made to support opening the connection.
> >
> > The general idea of reclaim is that the entire task context
> > working under the reclaim is marked with an override of the gfp
> > flags to make all allocations under that call chain reclaim safe.
> >
> > But rdmacm does allocations outside this, eg in the WQs processing
> > the CM packets. So this doesn't work and we will deadlock.
> >
> > Fixing it is a big deal and needs more than poking WQ_MEM_RECLAIM
> > here and there.
>
> So we will change the ULP in this case to avoid the use of
> WQ_MEM_RECLAIM where possible. Deadlocks that were possible before
> are not fixed, but at least we no longer have a false sense of
> confidence that the stack won't allocate memory during memory
> reclaim.
>
> While we're adjusting these queue_* call sites, ensure the work
> requests always run on the local CPU so the worker allocates RDMA
> resources that are local to the CPU that queued the work request.
>
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/transport.c |    4 ++--
>  net/sunrpc/xprtrdma/verbs.c     |   11 ++++-------
>  2 files changed, 6 insertions(+), 9 deletions(-)
>
> Hi Anna-
>
> I've had this applied to my test client for a while. I think it's
> ready to apply.
>
>
> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
> index bcb37b51adf6..9581641bb8cb 100644
> --- a/net/sunrpc/xprtrdma/transport.c
> +++ b/net/sunrpc/xprtrdma/transport.c
> @@ -494,8 +494,8 @@ xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_task *task)
>                 xprt_reconnect_backoff(xprt, RPCRDMA_INIT_REEST_TO);
>         }
>         trace_xprtrdma_op_connect(r_xprt, delay);
> -       queue_delayed_work(xprtiod_workqueue, &r_xprt->rx_connect_worker,
> -                          delay);
> +       queue_delayed_work_on(smp_processor_id(), system_long_wq,
> +                             &r_xprt->rx_connect_worker, delay);
>  }
>
>  /**
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 2fbe9aaeec34..691afc96bcbc 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -791,13 +791,10 @@ void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt)
>         /* If there is no underlying connection, it's no use
>          * to wake the refresh worker.
>          */
> -       if (ep->re_connect_status == 1) {
> -               /* The work is scheduled on a WQ_MEM_RECLAIM
> -                * workqueue in order to prevent MR allocation
> -                * from recursing into NFS during direct reclaim.
> -                */
> -               queue_work(xprtiod_workqueue, &buf->rb_refresh_worker);
> -       }
> +       if (ep->re_connect_status != 1)
> +               return;
> +       queue_work_on(smp_processor_id(), system_highpri_wq,
> +                     &buf->rb_refresh_worker);
>  }
>
>  /**
>
>
