Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3F128B5D
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 22:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbfEWUOI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 16:14:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387408AbfEWUOH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 May 2019 16:14:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6704E308624A
        for <linux-nfs@vger.kernel.org>; Thu, 23 May 2019 20:14:07 +0000 (UTC)
Received: from f29-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C9BC6012C
        for <linux-nfs@vger.kernel.org>; Thu, 23 May 2019 20:14:07 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] SUNRPC: Count ops completing with tk_status < 0
Date:   Thu, 23 May 2019 16:13:50 -0400
Message-Id: <20190523201351.12232-3-dwysocha@redhat.com>
In-Reply-To: <20190523201351.12232-1-dwysocha@redhat.com>
References: <20190523201351.12232-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 23 May 2019 20:14:07 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We often see various error conditions with NFS4.x that show up with
a very high operation count all completing with tk_status < 0 in a
short period of time.  Add a count to rpc_iostats to record on a
per-op basis the ops that complete in this manner, which will
enable lower overhead diagnostics.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 include/linux/sunrpc/metrics.h | 7 ++++++-
 net/sunrpc/stats.c             | 8 ++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/metrics.h b/include/linux/sunrpc/metrics.h
index 1b3751327575..0ee3f7052846 100644
--- a/include/linux/sunrpc/metrics.h
+++ b/include/linux/sunrpc/metrics.h
@@ -30,7 +30,7 @@
 #include <linux/ktime.h>
 #include <linux/spinlock.h>
 
-#define RPC_IOSTATS_VERS	"1.0"
+#define RPC_IOSTATS_VERS	"1.1"
 
 struct rpc_iostats {
 	spinlock_t		om_lock;
@@ -66,6 +66,11 @@ struct rpc_iostats {
 	ktime_t			om_queue,	/* queued for xmit */
 				om_rtt,		/* RPC RTT */
 				om_execute;	/* RPC execution */
+	/*
+	 * The count of operations that complete with tk_status < 0.
+	 * These statuses usually indicate error conditions.
+	 */
+	unsigned long           om_error_status;
 } ____cacheline_aligned;
 
 struct rpc_task;
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 8b2d3c58ffae..737414247ca7 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -176,6 +176,8 @@ void rpc_count_iostats_metrics(const struct rpc_task *task,
 
 	execute = ktime_sub(now, task->tk_start);
 	op_metrics->om_execute = ktime_add(op_metrics->om_execute, execute);
+	if (task->tk_status < 0)
+		op_metrics->om_error_status++;
 
 	spin_unlock(&op_metrics->om_lock);
 
@@ -218,13 +220,14 @@ static void _add_rpc_iostats(struct rpc_iostats *a, struct rpc_iostats *b)
 	a->om_queue = ktime_add(a->om_queue, b->om_queue);
 	a->om_rtt = ktime_add(a->om_rtt, b->om_rtt);
 	a->om_execute = ktime_add(a->om_execute, b->om_execute);
+	a->om_error_status += b->om_error_status;
 }
 
 static void _print_rpc_iostats(struct seq_file *seq, struct rpc_iostats *stats,
 			       int op, const struct rpc_procinfo *procs)
 {
 	_print_name(seq, op, procs);
-	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu %llu\n",
+	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu %llu %lu\n",
 		   stats->om_ops,
 		   stats->om_ntrans,
 		   stats->om_timeouts,
@@ -232,7 +235,8 @@ static void _print_rpc_iostats(struct seq_file *seq, struct rpc_iostats *stats,
 		   stats->om_bytes_recv,
 		   ktime_to_ms(stats->om_queue),
 		   ktime_to_ms(stats->om_rtt),
-		   ktime_to_ms(stats->om_execute));
+		   ktime_to_ms(stats->om_execute),
+		   stats->om_error_status);
 }
 
 void rpc_clnt_show_stats(struct seq_file *seq, struct rpc_clnt *clnt)
-- 
2.20.1

