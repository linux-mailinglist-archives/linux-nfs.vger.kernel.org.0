Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466112F65C5
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 17:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbhANQX2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jan 2021 11:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbhANQX1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 14 Jan 2021 11:23:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38D0423B45;
        Thu, 14 Jan 2021 16:22:47 +0000 (UTC)
Subject: [PATCH v1 3/5] svcrdma: Convert rdma_stat_sq_starve to a per-CPU
 counter
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 14 Jan 2021 11:22:46 -0500
Message-ID: <161064136651.6061.4240701868650517710.stgit@klimt.1015granger.net>
In-Reply-To: <161064114388.6061.6808790429789225779.stgit@klimt.1015granger.net>
References: <161064114388.6061.6808790429789225779.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Avoid the overhead of a memory bus lock cycle for counting a value
that is hardly every used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    2 +-
 net/sunrpc/xprtrdma/svc_rdma.c        |   13 +++++++++----
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |    1 +
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    2 +-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index ff32c59a27e7..c06b16ccf83e 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -69,7 +69,7 @@ extern unsigned int svcrdma_max_req_size;
 extern struct percpu_counter svcrdma_stat_recv;
 extern atomic_t rdma_stat_read;
 extern atomic_t rdma_stat_write;
-extern atomic_t rdma_stat_sq_starve;
+extern struct percpu_counter svcrdma_stat_sq_starve;
 extern atomic_t rdma_stat_rq_starve;
 extern atomic_t rdma_stat_rq_poll;
 extern atomic_t rdma_stat_rq_prod;
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index 3e5e622bad81..ee768d4c3c90 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -66,7 +66,7 @@ static unsigned int max_max_inline = RPCRDMA_MAX_INLINE_THRESH;
 struct percpu_counter svcrdma_stat_recv;
 atomic_t rdma_stat_read;
 atomic_t rdma_stat_write;
-atomic_t rdma_stat_sq_starve;
+struct percpu_counter svcrdma_stat_sq_starve;
 atomic_t rdma_stat_rq_starve;
 atomic_t rdma_stat_rq_poll;
 atomic_t rdma_stat_rq_prod;
@@ -199,10 +199,10 @@ static struct ctl_table svcrdma_parm_table[] = {
 	},
 	{
 		.procname	= "rdma_stat_sq_starve",
-		.data		= &rdma_stat_sq_starve,
-		.maxlen		= sizeof(atomic_t),
+		.data		= &svcrdma_stat_sq_starve,
+		.maxlen		= SVCRDMA_COUNTER_BUFSIZ,
 		.mode		= 0644,
-		.proc_handler	= read_reset_stat,
+		.proc_handler	= svcrdma_counter_handler,
 	},
 	{
 		.procname	= "rdma_stat_rq_starve",
@@ -267,6 +267,7 @@ static void svc_rdma_proc_cleanup(void)
 	unregister_sysctl_table(svcrdma_table_header);
 	svcrdma_table_header = NULL;
 
+	percpu_counter_destroy(&svcrdma_stat_sq_starve);
 	percpu_counter_destroy(&svcrdma_stat_recv);
 }
 
@@ -278,6 +279,9 @@ static int svc_rdma_proc_init(void)
 		return 0;
 
 	rc = percpu_counter_init(&svcrdma_stat_recv, 0, GFP_KERNEL);
+	if (rc)
+		goto out_err;
+	rc = percpu_counter_init(&svcrdma_stat_sq_starve, 0, GFP_KERNEL);
 	if (rc)
 		goto out_err;
 
@@ -285,6 +289,7 @@ static int svc_rdma_proc_init(void)
 	return 0;
 
 out_err:
+	percpu_counter_destroy(&svcrdma_stat_recv);
 	return rc;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 0b63e1321d74..d7d98b2df00b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -364,6 +364,7 @@ static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
 			return 0;
 		}
 
+		percpu_counter_inc(&svcrdma_stat_sq_starve);
 		trace_svcrdma_sq_full(rdma);
 		atomic_add(cc->cc_sqecount, &rdma->sc_sq_avail);
 		wait_event(rdma->sc_send_wait,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 68af79d4f04f..52c759a8543e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -317,7 +317,7 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 	/* If the SQ is full, wait until an SQ entry is available */
 	while (1) {
 		if ((atomic_dec_return(&rdma->sc_sq_avail) < 0)) {
-			atomic_inc(&rdma_stat_sq_starve);
+			percpu_counter_inc(&svcrdma_stat_sq_starve);
 			trace_svcrdma_sq_full(rdma);
 			atomic_inc(&rdma->sc_sq_avail);
 			wait_event(rdma->sc_send_wait,


