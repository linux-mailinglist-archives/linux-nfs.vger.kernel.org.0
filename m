Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4C768C58
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGaGwO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGaGwF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:52:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ACC10FB
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:51:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1A8341F460;
        Mon, 31 Jul 2023 06:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYhjnikyPyZwqrlvzb0TK1YtTBwRd8PH2wuC/oo/6Sg=;
        b=RZmhMlBzT1U9Suu+c/m9WfA8ZgVKqDIywCuQ4s8Izz0N53MF4gGYfwluRjwvA5hXw3lzuy
        sSUEttHRhkRiwNB7x9BibYZDNVolAf4A8PJ3TgpT8xZ/Db/cVLYHPaIVvZnBJLs6BMYuHu
        lB2RmqQCtUw3Pw9mx6v9k70p57pSsvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786316;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYhjnikyPyZwqrlvzb0TK1YtTBwRd8PH2wuC/oo/6Sg=;
        b=CS644a+/RMg1Pg/4ZnFUUMF1d4pwVT7tZjIIiLjtefezlfqm5MAC7kksoj7fZzKOAeY//d
        9aneR7cBOEuAr6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE7481322C;
        Mon, 31 Jul 2023 06:51:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7FwXIApax2TSbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:51:54 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 07/12] SUNRPC: move all of xprt handling into svc_xprt_handle()
Date:   Mon, 31 Jul 2023 16:48:34 +1000
Message-Id: <20230731064839.7729-8-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731064839.7729-1-neilb@suse.de>
References: <20230731064839.7729-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svc_xprt_handle() does lots of things itself, but leaves some to the
caller - svc_recv().  This isn't elegant.

Move that code out of svc_recv() into svc_xprt_handle()

Remove the calls to svc_xprt_release() from svc_send() and svc_drop()
(the two possible final steps in svc_process()) and from svc_recv() (in
the case where svc_process() wasn't called) into svc_xprt_handle().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc_xprt.c | 53 ++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 67f2b34cb8e4..604c486c8576 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -792,7 +792,7 @@ static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt
 	svc_xprt_received(newxpt);
 }
 
-static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
+static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 {
 	struct svc_serv *serv = rqstp->rq_server;
 	int len = 0;
@@ -833,11 +833,26 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 			len = xprt->xpt_ops->xpo_recvfrom(rqstp);
 		rqstp->rq_reserved = serv->sv_max_mesg;
 		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
+		if (len <= 0)
+			goto out;
+
+		trace_svc_xdr_recvfrom(&rqstp->rq_arg);
+
+		clear_bit(XPT_OLD, &xprt->xpt_flags);
+
+		rqstp->rq_chandle.defer = svc_defer;
+
+		if (serv->sv_stats)
+			serv->sv_stats->netcnt++;
+		percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
+		rqstp->rq_stime = ktime_get();
+		svc_process(rqstp);
 	} else
 		svc_xprt_received(xprt);
 
 out:
-	return len;
+	rqstp->rq_res.len = 0;
+	svc_xprt_release(rqstp);
 }
 
 /**
@@ -851,40 +866,16 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 void svc_recv(struct svc_rqst *rqstp)
 {
 	struct svc_xprt		*xprt = NULL;
-	struct svc_serv		*serv = rqstp->rq_server;
-	int			len;
 
 	if (!svc_alloc_arg(rqstp))
-		goto out;
+		return;
 
 	svc_rqst_wait_and_dequeue_work(rqstp);
 
 	xprt = rqstp->rq_xprt;
-	if (!xprt)
-		goto out;
-
-	len = svc_handle_xprt(rqstp, xprt);
-
-	/* No data, incomplete (TCP) read, or accept() */
-	if (len <= 0)
-		goto out_release;
-
-	trace_svc_xdr_recvfrom(&rqstp->rq_arg);
-
-	clear_bit(XPT_OLD, &xprt->xpt_flags);
-
-	rqstp->rq_chandle.defer = svc_defer;
-
-	if (serv->sv_stats)
-		serv->sv_stats->netcnt++;
-	percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
-	rqstp->rq_stime = ktime_get();
-	svc_process(rqstp);
+	if (xprt)
+		svc_handle_xprt(rqstp, xprt);
 out:
-	return;
-out_release:
-	rqstp->rq_res.len = 0;
-	svc_xprt_release(rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_recv);
 
@@ -894,7 +885,6 @@ EXPORT_SYMBOL_GPL(svc_recv);
 void svc_drop(struct svc_rqst *rqstp)
 {
 	trace_svc_drop(rqstp);
-	svc_xprt_release(rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_drop);
 
@@ -910,8 +900,6 @@ void svc_send(struct svc_rqst *rqstp)
 	int status;
 
 	xprt = rqstp->rq_xprt;
-	if (!xprt)
-		return;
 
 	/* calculate over-all length */
 	xb = &rqstp->rq_res;
@@ -924,7 +912,6 @@ void svc_send(struct svc_rqst *rqstp)
 	status = xprt->xpt_ops->xpo_sendto(rqstp);
 
 	trace_svc_send(rqstp, status);
-	svc_xprt_release(rqstp);
 }
 
 /*
-- 
2.40.1

