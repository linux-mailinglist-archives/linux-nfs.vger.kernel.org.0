Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A246644E8
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 16:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjAJPck (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 10:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbjAJPcG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 10:32:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06CAA8
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 07:32:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7389FB81730
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 15:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6875C433EF
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673364721;
        bh=MkkKSseiUyv0ZMxXIOxE11DPzalsbgZvjPPLyBO7w+I=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=iRKguWTlzQPyQFSb/lxy9WOQ4DhCLHyqJZskvusI4wnfQiIkES5t/1jK9zJMPBlS4
         n5HRsLPTkH7exuAbVB3DIH7r3AISNZuTv9hvokMogeCsmN1hhdlvmlPbbNpzItMHTx
         nJpjZtOBxixmlvPEf6wMv6rmtT5VW/HJJWL+2iEcF0W33XRoD09g1isNQKVtavQBeJ
         91adbMLp5J5D+NzWPm1PrgOTmdRxsIwO0Rmdrvgt1z+F4QnrGof+J1wo54PhX/kiwF
         E9fcipqvXgqwZX9cdV16YZtuIMBQrH7ZNGDLiAVT9oafXP++fwx+uscN3KSfm+XVX/
         5ULvm8qBt26nw==
Subject: [PATCH v1 2/2] SUNRPC: Replace pool stats with per-CPU variables
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 10 Jan 2023 10:32:00 -0500
Message-ID: <167336472076.15674.17899270167774301682.stgit@bazille.1015granger.net>
In-Reply-To: <167336437322.15674.16325059932149395877.stgit@bazille.1015granger.net>
References: <167336437322.15674.16325059932149395877.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Eliminate the use of bus-locked operations in svc_xprt_enqueue(),
which is a hot path. Replace them with per-cpu variables to reduce
cross-CPU memory bus traffic.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |   15 ++++++---------
 net/sunrpc/svc.c           |   12 ++++++++++++
 net/sunrpc/svc_xprt.c      |   18 ++++++++----------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 1b078c9a2d60..877891536c2f 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -21,14 +21,6 @@
 #include <linux/mm.h>
 #include <linux/pagevec.h>
 
-/* statistics for svc_pool structures */
-struct svc_pool_stats {
-	atomic_long_t	packets;
-	unsigned long	sockets_queued;
-	atomic_long_t	threads_woken;
-	atomic_long_t	threads_timedout;
-};
-
 /*
  *
  * RPC service thread pool.
@@ -45,7 +37,12 @@ struct svc_pool {
 	struct list_head	sp_sockets;	/* pending sockets */
 	unsigned int		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
-	struct svc_pool_stats	sp_stats;	/* statistics on pool operation */
+
+	/* statistics on pool operation */
+	struct percpu_counter	sp_sockets_queued;
+	struct percpu_counter	sp_threads_woken;
+	struct percpu_counter	sp_threads_timedout;
+
 #define	SP_TASK_PENDING		(0)		/* still work to do even if no
 						 * xprt is queued. */
 #define SP_CONGESTED		(1)
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 2e1788314cf0..8f9c6562c20d 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -512,6 +512,10 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
 		INIT_LIST_HEAD(&pool->sp_sockets);
 		INIT_LIST_HEAD(&pool->sp_all_threads);
 		spin_lock_init(&pool->sp_lock);
+
+		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
+		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
+		percpu_counter_init(&pool->sp_threads_timedout, 0, GFP_KERNEL);
 	}
 
 	return serv;
@@ -565,6 +569,7 @@ void
 svc_destroy(struct kref *ref)
 {
 	struct svc_serv *serv = container_of(ref, struct svc_serv, sv_refcnt);
+	unsigned int i;
 
 	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
 	timer_shutdown_sync(&serv->sv_temptimer);
@@ -580,6 +585,13 @@ svc_destroy(struct kref *ref)
 
 	svc_pool_map_put(serv->sv_nrpools);
 
+	for (i = 0; i < serv->sv_nrpools; i++) {
+		struct svc_pool *pool = &serv->sv_pools[i];
+
+		percpu_counter_destroy(&pool->sp_sockets_queued);
+		percpu_counter_destroy(&pool->sp_threads_woken);
+		percpu_counter_destroy(&pool->sp_threads_timedout);
+	}
 	kfree(serv->sv_pools);
 	kfree(serv);
 }
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b4697984b4b2..f9da49106e78 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -462,11 +462,9 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 
 	pool = svc_pool_for_cpu(xprt->xpt_server);
 
-	atomic_long_inc(&pool->sp_stats.packets);
-
+	percpu_counter_inc(&pool->sp_sockets_queued);
 	spin_lock_bh(&pool->sp_lock);
 	list_add_tail(&xprt->xpt_ready, &pool->sp_sockets);
-	pool->sp_stats.sockets_queued++;
 	spin_unlock_bh(&pool->sp_lock);
 
 	/* find a thread for this xprt */
@@ -474,7 +472,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
 		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
 			continue;
-		atomic_long_inc(&pool->sp_stats.threads_woken);
+		percpu_counter_inc(&pool->sp_threads_woken);
 		rqstp->rq_qtime = ktime_get();
 		wake_up_process(rqstp->rq_task);
 		goto out_unlock;
@@ -769,7 +767,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 		goto out_found;
 
 	if (!time_left)
-		atomic_long_inc(&pool->sp_stats.threads_timedout);
+		percpu_counter_inc(&pool->sp_threads_timedout);
 
 	if (signalled() || kthread_should_stop())
 		return ERR_PTR(-EINTR);
@@ -1440,12 +1438,12 @@ static int svc_pool_stats_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
-	seq_printf(m, "%u %lu %lu %lu %lu\n",
+	seq_printf(m, "%u %llu %llu %llu %llu\n",
 		pool->sp_id,
-		(unsigned long)atomic_long_read(&pool->sp_stats.packets),
-		pool->sp_stats.sockets_queued,
-		(unsigned long)atomic_long_read(&pool->sp_stats.threads_woken),
-		(unsigned long)atomic_long_read(&pool->sp_stats.threads_timedout));
+		percpu_counter_sum_positive(&pool->sp_sockets_queued),
+		percpu_counter_sum_positive(&pool->sp_sockets_queued),
+		percpu_counter_sum_positive(&pool->sp_threads_woken),
+		percpu_counter_sum_positive(&pool->sp_threads_timedout));
 
 	return 0;
 }


