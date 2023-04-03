Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333706D4F96
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Apr 2023 19:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjDCRxd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Apr 2023 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjDCRxc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Apr 2023 13:53:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2B435A9
        for <linux-nfs@vger.kernel.org>; Mon,  3 Apr 2023 10:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B560061BFE
        for <linux-nfs@vger.kernel.org>; Mon,  3 Apr 2023 17:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACCDC433EF
        for <linux-nfs@vger.kernel.org>; Mon,  3 Apr 2023 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680544388;
        bh=IEM39LdfCRxL5BiVZXPOvEmHYmiJdGQ1uQYkOvGMMSg=;
        h=Subject:From:To:Date:From;
        b=UJvX6n0dbrE7aM6//nGnQeWZEGtHLSsZHgPlfZsbcDhvYzMXw1+16jEhSv0G97pLn
         zRAQ3CpizFh/xtzBz03n0q5v62QeIa7oYAP5c105B1LeyeN10Me6Ktt4mzh4pfOLnh
         Cicesy7srml4KFTZAv1+3K3kahbRMmazI/wWHULka4OH4YWnOB2iSBWwj28tocrzv6
         UKsRmavT3lCFm4Fi+t6vzyUxF3W+Mh5zB+IzVFNAQ1g8lpzzr7MQR1/Pr/LP5Tv7BI
         sSoPK6f/MJJBLfdEPc2DL1amK/cJOMQMBaHizaydfG/7MLTw/hekTfNUnbOniGs2TG
         yzZvEseRHnBHQ==
Subject: [PATCH] SUNRPC: Ignore return value of ->xpo_sendto
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 Apr 2023 13:53:07 -0400
Message-ID: <168054438704.1386.13312356737261415877.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: All callers of svc_process() ignore its return value, so
svc_process() can safely be converted to return void. Ditto for
svc_send().

The return value of ->xpo_sendto() is now used only as part of a
trace event.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h     |    2 +-
 include/linux/sunrpc/svcsock.h |    2 +-
 net/sunrpc/svc.c               |   13 +++++++------
 net/sunrpc/svc_xprt.c          |   21 +++++++++------------
 4 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f5af055280ff..2d31121fc2e6 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -430,7 +430,7 @@ struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
 				     int (*threadfn)(void *data));
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
-int		   svc_process(struct svc_rqst *);
+void		   svc_process(struct svc_rqst *rqstp);
 int		   bc_svc_process(struct svc_serv *, struct rpc_rqst *,
 			struct svc_rqst *);
 int		   svc_register(const struct svc_serv *, struct net *, const int,
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index bcc555c7ae9c..6c95fc42ece9 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -56,7 +56,7 @@ static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
  */
 void		svc_close_net(struct svc_serv *, struct net *);
 int		svc_recv(struct svc_rqst *, long);
-int		svc_send(struct svc_rqst *);
+void		svc_send(struct svc_rqst *);
 void		svc_drop(struct svc_rqst *);
 void		svc_sock_update_bufs(struct svc_serv *serv);
 bool		svc_alien_sock(struct net *net, int fd);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 633aa1eb476b..0aa8892fad63 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1444,11 +1444,12 @@ svc_process_common(struct svc_rqst *rqstp)
 	goto sendit;
 }
 
-/*
- * Process the RPC request.
+/**
+ * svc_process - Execute one RPC transaction
+ * @rqstp: RPC transaction context
+ *
  */
-int
-svc_process(struct svc_rqst *rqstp)
+void svc_process(struct svc_rqst *rqstp)
 {
 	struct kvec		*resv = &rqstp->rq_res.head[0];
 	__be32 *p;
@@ -1484,7 +1485,8 @@ svc_process(struct svc_rqst *rqstp)
 
 	if (!svc_process_common(rqstp))
 		goto out_drop;
-	return svc_send(rqstp);
+	svc_send(rqstp);
+	return;
 
 out_baddir:
 	svc_printk(rqstp, "bad direction 0x%08x, dropping request\n",
@@ -1492,7 +1494,6 @@ svc_process(struct svc_rqst *rqstp)
 	rqstp->rq_server->sv_stats->rpcbadfmt++;
 out_drop:
 	svc_drop(rqstp);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(svc_process);
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index ba629297da4e..36c79b718323 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -909,18 +909,20 @@ void svc_drop(struct svc_rqst *rqstp)
 }
 EXPORT_SYMBOL_GPL(svc_drop);
 
-/*
- * Return reply to client.
+/**
+ * svc_send - Return reply to client
+ * @rqstp: RPC transaction context
+ *
  */
-int svc_send(struct svc_rqst *rqstp)
+void svc_send(struct svc_rqst *rqstp)
 {
 	struct svc_xprt	*xprt;
-	int		len = -EFAULT;
 	struct xdr_buf	*xb;
+	int status;
 
 	xprt = rqstp->rq_xprt;
 	if (!xprt)
-		goto out;
+		return;
 
 	/* calculate over-all length */
 	xb = &rqstp->rq_res;
@@ -930,15 +932,10 @@ int svc_send(struct svc_rqst *rqstp)
 	trace_svc_xdr_sendto(rqstp->rq_xid, xb);
 	trace_svc_stats_latency(rqstp);
 
-	len = xprt->xpt_ops->xpo_sendto(rqstp);
+	status = xprt->xpt_ops->xpo_sendto(rqstp);
 
-	trace_svc_send(rqstp, len);
+	trace_svc_send(rqstp, status);
 	svc_xprt_release(rqstp);
-
-	if (len == -ECONNREFUSED || len == -ENOTCONN || len == -EAGAIN)
-		len = 0;
-out:
-	return len;
 }
 
 /*


