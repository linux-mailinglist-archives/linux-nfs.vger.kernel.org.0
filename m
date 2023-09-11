Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DD479AFE0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 01:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbjIKV7z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbjIKOi6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:38:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84284F2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:38:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68C1C433C8;
        Mon, 11 Sep 2023 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443133;
        bh=7t0+H+lUqrsP3+mj4+739Dbbu4qarBJFUpzxDXMZU9o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=U2DqHKv0j9XKzfQiawdZwlrr0731uMAkdTm0Vtqlx2Ii5dY1rDG77RFtBFdV4WN7E
         C9DfLsBuTYwFW6Czszj/1Fb3A36oZ4yftPtdUXtwod2lLyq8wioHPN1Auwavf/Jp8v
         jg/AOXy24QLhBfM7hPQOyRGpDBNGp4hl8SiWWxblyUKWGpeIou0clTgho8iyD53rqz
         bF/Xlk+u/MeONsfEIl3IkW4J1a5HzDyZKJLVC2Itk0EFRfq7yjM0rsE/zGKbdWshGG
         UrdSSzetZvdXau/aYQKDj7gPOkY17M5pSDawn4/BgJ9bbTK/sTx60We3m4GouSFoOs
         rb7y2+yKcHIyg==
Subject: [PATCH v1 03/17] SUNRPC: Clean up bc_svc_process()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:38:51 -0400
Message-ID: <169444313193.4327.1325713383472236219.stgit@bazille.1015granger.net>
In-Reply-To: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The test robot complained that, in some build configurations, the
@error variable in bc_svc_process's only caller is set but never
used. This happens because dprintk() is the only consumer of that
value.

 - Remove the dprintk() call sites in favor of the svc_process
   tracepoint
 - The @error variable and the return value of bc_svc_process() are
   now unused, so get rid of them.
 - The @serv parameter is set to rqstp->rq_serv by the only caller,
   and bc_svc_process() then uses it only to set rqstp->rq_serv. It
   can be removed.
 - Rename bc_svc_process() according to the convention that
   globally-visible RPC server functions have names that begin with
   "svc_"; and because it is globally-visible, give it a proper
   kdoc comment.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308121314.HA8Rq2XG-lkp@intel.com/
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback.c          |    6 +-----
 include/linux/sunrpc/svc.h |    3 +--
 net/sunrpc/svc.c           |   38 ++++++++++++--------------------------
 3 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 466ebf1d41b2..272e6d2bb478 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -95,7 +95,6 @@ nfs41_callback_svc(void *vrqstp)
 	struct svc_rqst *rqstp = vrqstp;
 	struct svc_serv *serv = rqstp->rq_server;
 	struct rpc_rqst *req;
-	int error;
 	DEFINE_WAIT(wq);
 
 	set_freezable();
@@ -109,10 +108,7 @@ nfs41_callback_svc(void *vrqstp)
 			list_del(&req->rq_bc_list);
 			spin_unlock_bh(&serv->sv_cb_lock);
 			finish_wait(&serv->sv_cb_waitq, &wq);
-			dprintk("Invoking bc_svc_process()\n");
-			error = bc_svc_process(serv, req, rqstp);
-			dprintk("bc_svc_process() returned w/ error code= %d\n",
-				error);
+			svc_process_bc(req, rqstp);
 		} else {
 			spin_unlock_bh(&serv->sv_cb_lock);
 			if (!kthread_should_stop())
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index dbf5b21feafe..0cdca5960171 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -413,8 +413,7 @@ struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
 int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
 int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
 void		   svc_process(struct svc_rqst *rqstp);
-int		   bc_svc_process(struct svc_serv *, struct rpc_rqst *,
-			struct svc_rqst *);
+void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
 int		   svc_register(const struct svc_serv *, struct net *, const int,
 				const unsigned short, const unsigned short);
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 812fda9d45dd..a3d031deb1ec 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1544,24 +1544,20 @@ void svc_process(struct svc_rqst *rqstp)
 }
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
-/*
- * Process a backchannel RPC request that arrived over an existing
- * outbound connection
+/**
+ * svc_process_bc - process a reverse-direction RPC request
+ * @req: RPC request to be used for client-side processing
+ * @rqstp: server-side execution context
+ *
  */
-int
-bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
-	       struct svc_rqst *rqstp)
+void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 {
 	struct rpc_task *task;
 	int proc_error;
-	int error;
-
-	dprintk("svc: %s(%p)\n", __func__, req);
 
 	/* Build the svc_rqst used by the common processing routine */
 	rqstp->rq_xid = req->rq_xid;
 	rqstp->rq_prot = req->rq_xprt->prot;
-	rqstp->rq_server = serv;
 	rqstp->rq_bc_net = req->rq_xprt->xprt_net;
 
 	rqstp->rq_addrlen = sizeof(req->rq_xprt->addr);
@@ -1590,10 +1586,8 @@ bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
 	 * been processed by the caller.
 	 */
 	svcxdr_init_decode(rqstp);
-	if (!xdr_inline_decode(&rqstp->rq_arg_stream, XDR_UNIT * 2)) {
-		error = -EINVAL;
-		goto out;
-	}
+	if (!xdr_inline_decode(&rqstp->rq_arg_stream, XDR_UNIT * 2))
+		return;
 
 	/* Parse and execute the bc call */
 	proc_error = svc_process_common(rqstp);
@@ -1602,26 +1596,18 @@ bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
 	if (!proc_error) {
 		/* Processing error: drop the request */
 		xprt_free_bc_request(req);
-		error = -EINVAL;
-		goto out;
+		return;
 	}
 	/* Finally, send the reply synchronously */
 	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
 	task = rpc_run_bc_task(req);
-	if (IS_ERR(task)) {
-		error = PTR_ERR(task);
-		goto out;
-	}
+	if (IS_ERR(task))
+		return;
 
 	WARN_ON_ONCE(atomic_read(&task->tk_count) != 1);
-	error = task->tk_status;
 	rpc_put_task(task);
-
-out:
-	dprintk("svc: %s(), error=%d\n", __func__, error);
-	return error;
 }
-EXPORT_SYMBOL_GPL(bc_svc_process);
+EXPORT_SYMBOL_GPL(svc_process_bc);
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 
 /**


