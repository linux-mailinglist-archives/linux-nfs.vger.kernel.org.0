Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2745BBF23
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Sep 2022 19:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiIRR2V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Sep 2022 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRR2U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Sep 2022 13:28:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2027918E00;
        Sun, 18 Sep 2022 10:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEBDB60C58;
        Sun, 18 Sep 2022 17:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E164CC433D6;
        Sun, 18 Sep 2022 17:28:17 +0000 (UTC)
Subject: [PATCH v2] SUNRPC: Replace the use of the xprtiod WQ in rpcrdma
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sun, 18 Sep 2022 13:28:16 -0400
Message-ID: <166352202786.788329.12244712939409452291.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While setting up a new lab, I accidentally misconfigured the
Ethernet port for a system that tried an NFS mount using RoCE.
This made the NFS server unreachable. The following WARNING
popped on the NFS client while waiting for the mount attempt to
time out:

kernel: workqueue: WQ_MEM_RECLAIM xprtiod:xprt_rdma_connect_worker [rpcrdma] is flushing !WQ_MEM_RECLAI>
kernel: WARNING: CPU: 0 PID: 100 at kernel/workqueue.c:2628 check_flush_dependency+0xbf/0xca
kernel: Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs 8021q garp stp mrp llc rfkill rpcrdma>
kernel: CPU: 0 PID: 100 Comm: kworker/u8:8 Not tainted 6.0.0-rc1-00002-g6229f8c054e5 #13
kernel: Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0b 06/12/2017
kernel: Workqueue: xprtiod xprt_rdma_connect_worker [rpcrdma]
kernel: RIP: 0010:check_flush_dependency+0xbf/0xca
kernel: Code: 75 2a 48 8b 55 18 48 8d 8b b0 00 00 00 4d 89 e0 48 81 c6 b0 00 00 00 48 c7 c7 65 33 2e be>
kernel: RSP: 0018:ffffb562806cfcf8 EFLAGS: 00010092
kernel: RAX: 0000000000000082 RBX: ffff97894f8c3c00 RCX: 0000000000000027
kernel: RDX: 0000000000000002 RSI: ffffffffbe3447d1 RDI: 00000000ffffffff
kernel: RBP: ffff978941315840 R08: 0000000000000000 R09: 0000000000000000
kernel: R10: 00000000000008b0 R11: 0000000000000001 R12: ffffffffc0ce3731
kernel: R13: ffff978950c00500 R14: ffff97894341f0c0 R15: ffff978951112eb0
kernel: FS:  0000000000000000(0000) GS:ffff97987fc00000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00007f807535eae8 CR3: 000000010b8e4002 CR4: 00000000003706f0
kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kernel: Call Trace:
kernel:  <TASK>
kernel:  __flush_work.isra.0+0xaf/0x188
kernel:  ? _raw_spin_lock_irqsave+0x2c/0x37
kernel:  ? lock_timer_base+0x38/0x5f
kernel:  __cancel_work_timer+0xea/0x13d
kernel:  ? preempt_latency_start+0x2b/0x46
kernel:  rdma_addr_cancel+0x70/0x81 [ib_core]
kernel:  _destroy_id+0x1a/0x246 [rdma_cm]
kernel:  rpcrdma_xprt_connect+0x115/0x5ae [rpcrdma]
kernel:  ? _raw_spin_unlock+0x14/0x29
kernel:  ? raw_spin_rq_unlock_irq+0x5/0x10
kernel:  ? finish_task_switch.isra.0+0x171/0x249
kernel:  xprt_rdma_connect_worker+0x3b/0xc7 [rpcrdma]
kernel:  process_one_work+0x1d8/0x2d4
kernel:  worker_thread+0x18b/0x24f
kernel:  ? rescuer_thread+0x280/0x280
kernel:  kthread+0xf4/0xfc
kernel:  ? kthread_complete_and_exit+0x1b/0x1b
kernel:  ret_from_fork+0x22/0x30
kernel:  </TASK>

SUNRPC's xprtiod workqueue is WQ_MEM_RECLAIM, so any workqueue that
one of its work items tries to cancel has to be WQ_MEM_RECLAIM to
prevent a priority inversion. The internal workqueues in the
RDMA/core are currently non-MEM_RECLAIM.

Jason Gunthorpe says this about the current state of RDMA/core:
> If you attempt to do a reconnection/etc from within a RECLAIM
> context it will deadlock on one of the many allocations that are
> made to support opening the connection.
>
> The general idea of reclaim is that the entire task context
> working under the reclaim is marked with an override of the gfp
> flags to make all allocations under that call chain reclaim safe.
>
> But rdmacm does allocations outside this, eg in the WQs processing
> the CM packets. So this doesn't work and we will deadlock.
>
> Fixing it is a big deal and needs more than poking WQ_MEM_RECLAIM
> here and there.

So we will change the ULP in this case to avoid the use of
WQ_MEM_RECLAIM where possible. Deadlocks that were possible before
are not fixed, but at least we no longer have a false sense of
confidence that the stack won't allocate memory during memory
reclaim.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |    3 +--
 net/sunrpc/xprtrdma/verbs.c     |   10 +++-------
 2 files changed, 4 insertions(+), 9 deletions(-)

Changes since v1:
- Using queue_work_on(smp_processor_id()) is ineffective and broken


diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index bcb37b51adf6..10bb2b929c6d 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -494,8 +494,7 @@ xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 		xprt_reconnect_backoff(xprt, RPCRDMA_INIT_REEST_TO);
 	}
 	trace_xprtrdma_op_connect(r_xprt, delay);
-	queue_delayed_work(xprtiod_workqueue, &r_xprt->rx_connect_worker,
-			   delay);
+	queue_delayed_work(system_long_wq, &r_xprt->rx_connect_worker, delay);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 2fbe9aaeec34..049c854b7b37 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -791,13 +791,9 @@ void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt)
 	/* If there is no underlying connection, it's no use
 	 * to wake the refresh worker.
 	 */
-	if (ep->re_connect_status == 1) {
-		/* The work is scheduled on a WQ_MEM_RECLAIM
-		 * workqueue in order to prevent MR allocation
-		 * from recursing into NFS during direct reclaim.
-		 */
-		queue_work(xprtiod_workqueue, &buf->rb_refresh_worker);
-	}
+	if (ep->re_connect_status != 1)
+		return;
+	queue_work(system_highpri_wq, &buf->rb_refresh_worker);
 }
 
 /**


