Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7494EB788
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 02:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbiC3Aub (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 20:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241489AbiC3Aua (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 20:50:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD6C2BC
        for <linux-nfs@vger.kernel.org>; Tue, 29 Mar 2022 17:48:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BEA941F37B;
        Wed, 30 Mar 2022 00:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648601323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZNQr0kOX+OSs6H4ABmP8G0qRlYC2SP0xwUztTJNXdjw=;
        b=FXSxKT8wSTUUiGKS1xSLZ9UF5VipeLNbMrNQHYeHHe7HUDp5WjF/3zXyltScyaDbxFM7Ce
        lL2A0ZcJIHBPxeZvRmPJYO8Iu2PmjLh6EBNi1HH89wU0Gez30VaqlXNf/l7m/im8TX1fUP
        Fd0a5S47uYsmecmB2rEw2iBh9jsGoo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648601323;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZNQr0kOX+OSs6H4ABmP8G0qRlYC2SP0xwUztTJNXdjw=;
        b=66zdlQLhwlTeotML3uTbd5MRABzU258Pixp4vlPDqnMOZ7uwZgkjvAdOWaCL4KUwhAP3nF
        +6jE/lG/THbTKqCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DCA513A60;
        Wed, 30 Mar 2022 00:48:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UQYCFuqoQ2J8OwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Mar 2022 00:48:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH v2] SUNRPC: handle malloc failure in ->request_prepare
Date:   Wed, 30 Mar 2022 11:48:37 +1100
Message-id: <164860131750.25542.11903698668406937236@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


If ->request_prepare() detects an error, it sets ->rq_task->tk_status.
This is easy for callers to ignore.
The only caller is xprt_request_enqueue_receive() and it does ignore the
error, as does call_encode() which calls it.  This can result in a
request being queued to receive a reply without an allocated receive buffer.

So instead of setting rq_task->tk_status, return an error, and store in
->tk_status only in call_encode();

The call to xprt_request_enqueue_receive() is now earlier in
call_encode(), where the error can still be handled.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/xprt.h |  5 ++---
 net/sunrpc/clnt.c           |  6 +++---
 net/sunrpc/xprt.c           | 23 +++++++++++++++--------
 net/sunrpc/xprtsock.c       |  4 ++--
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 955ea4d7af0b..400750505222 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -141,7 +141,7 @@ struct rpc_xprt_ops {
 	void		(*connect)(struct rpc_xprt *xprt, struct rpc_task *task);
 	int		(*buf_alloc)(struct rpc_task *task);
 	void		(*buf_free)(struct rpc_task *task);
-	void		(*prepare_request)(struct rpc_rqst *req);
+	int		(*prepare_request)(struct rpc_rqst *req);
 	int		(*send_request)(struct rpc_rqst *req);
 	void		(*wait_for_reply_request)(struct rpc_task *task);
 	void		(*timer)(struct rpc_xprt *xprt, struct rpc_task *task);
@@ -354,10 +354,9 @@ int			xprt_reserve_xprt_cong(struct rpc_xprt *xprt, stru=
ct rpc_task *task);
 void			xprt_alloc_slot(struct rpc_xprt *xprt, struct rpc_task *task);
 void			xprt_free_slot(struct rpc_xprt *xprt,
 				       struct rpc_rqst *req);
-void			xprt_request_prepare(struct rpc_rqst *req);
 bool			xprt_prepare_transmit(struct rpc_task *task);
 void			xprt_request_enqueue_transmit(struct rpc_task *task);
-void			xprt_request_enqueue_receive(struct rpc_task *task);
+int			xprt_request_enqueue_receive(struct rpc_task *task);
 void			xprt_request_wait_receive(struct rpc_task *task);
 void			xprt_request_dequeue_xprt(struct rpc_task *task);
 bool			xprt_request_need_retransmit(struct rpc_task *task);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 8bf2af8546d2..3c7407104d54 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1858,6 +1858,9 @@ call_encode(struct rpc_task *task)
 	xprt_request_dequeue_xprt(task);
 	/* Encode here so that rpcsec_gss can use correct sequence number. */
 	rpc_xdr_encode(task);
+	/* Add task to reply queue before transmission to avoid races */
+	if (task->tk_status =3D=3D 0 && rpc_reply_expected(task))
+		task->tk_status =3D xprt_request_enqueue_receive(task);
 	/* Did the encode result in an error condition? */
 	if (task->tk_status !=3D 0) {
 		/* Was the error nonfatal? */
@@ -1881,9 +1884,6 @@ call_encode(struct rpc_task *task)
 		return;
 	}
=20
-	/* Add task to reply queue before transmission to avoid races */
-	if (rpc_reply_expected(task))
-		xprt_request_enqueue_receive(task);
 	xprt_request_enqueue_transmit(task);
 out:
 	task->tk_action =3D call_transmit;
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 880bfe8dc7f6..73344ffb2692 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -69,10 +69,11 @@
 /*
  * Local functions
  */
-static void	 xprt_init(struct rpc_xprt *xprt, struct net *net);
+static void	xprt_init(struct rpc_xprt *xprt, struct net *net);
 static __be32	xprt_alloc_xid(struct rpc_xprt *xprt);
-static void	 xprt_destroy(struct rpc_xprt *xprt);
-static void	 xprt_request_init(struct rpc_task *task);
+static void	xprt_destroy(struct rpc_xprt *xprt);
+static void	xprt_request_init(struct rpc_task *task);
+static int	xprt_request_prepare(struct rpc_rqst *req);
=20
 static DEFINE_SPINLOCK(xprt_list_lock);
 static LIST_HEAD(xprt_list);
@@ -1143,16 +1144,19 @@ xprt_request_need_enqueue_receive(struct rpc_task *ta=
sk, struct rpc_rqst *req)
  * @task: RPC task
  *
  */
-void
+int
 xprt_request_enqueue_receive(struct rpc_task *task)
 {
 	struct rpc_rqst *req =3D task->tk_rqstp;
 	struct rpc_xprt *xprt =3D req->rq_xprt;
+	int ret;
=20
 	if (!xprt_request_need_enqueue_receive(task, req))
-		return;
+		return 0;
=20
-	xprt_request_prepare(task->tk_rqstp);
+	ret =3D xprt_request_prepare(task->tk_rqstp);
+	if (ret)
+		return ret;
 	spin_lock(&xprt->queue_lock);
=20
 	/* Update the softirq receive buffer */
@@ -1166,6 +1170,7 @@ xprt_request_enqueue_receive(struct rpc_task *task)
=20
 	/* Turn off autodisconnect */
 	del_singleshot_timer_sync(&xprt->timer);
+	return 0;
 }
=20
 /**
@@ -1452,14 +1457,16 @@ xprt_request_dequeue_xprt(struct rpc_task *task)
  *
  * Calls into the transport layer to do whatever is needed to prepare
  * the request for transmission or receive.
+ * Returns error, or zero.
  */
-void
+static int
 xprt_request_prepare(struct rpc_rqst *req)
 {
 	struct rpc_xprt *xprt =3D req->rq_xprt;
=20
 	if (xprt->ops->prepare_request)
-		xprt->ops->prepare_request(req);
+		return xprt->ops->prepare_request(req);
+	return 0;
 }
=20
 /**
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index b52eaa8a0cda..29683136ed49 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -822,11 +822,11 @@ static int xs_stream_nospace(struct rpc_rqst *req, bool=
 vm_wait)
 	return ret;
 }
=20
-static void
+static int
 xs_stream_prepare_request(struct rpc_rqst *req)
 {
 	xdr_free_bvec(&req->rq_rcv_buf);
-	req->rq_task->tk_status =3D xdr_alloc_bvec(
+	return xdr_alloc_bvec(
 		&req->rq_rcv_buf, GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
 }
=20
--=20
2.35.1

