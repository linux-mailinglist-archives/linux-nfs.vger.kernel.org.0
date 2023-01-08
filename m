Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC35F6616BA
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjAHQc4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbjAHQ2g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:28:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E4DEA7
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:28:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87B9FCE0B6A
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75314C433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195311;
        bh=h3WbmLS7lqbzJy8Ex1BkBSAASCbOy3167ohrofAJb8o=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=kgzXmL95HVdkE/BR03mY7JFYCsITbm3K79MN+ELkTXGa9x1P5Qwk++BEIsu73tldc
         6N+D4GglAV3kHix/sN3E5CN2piOKIVlBNQQISeE2yFvwm2y6Vzgyr+nLZyzocNMqZk
         76imDDwnkwRf53e+T9CeicWrI/uV4DwBlYuvV+nESrS6FIM0Xp0em8Z8796mxoH1RF
         m87q8NGD1oWi4LOdULQ3ELsVF9c9l8W/jebqkWSZ/sjLh8Z9RW5JYAUJ6TpOzVMxa8
         xSIJb5mPnNHtjzvSc8o4hvZXXgLtReZaKwOfsjhUK610xcnb8pMzzD02b1mXILUgD+
         IbpvEWD6EONEA==
Subject: [PATCH v1 01/27] SUNRPC: Clean up svcauth_gss_release()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:28:30 -0500
Message-ID: <167319531054.7490.10405247832294580026.stgit@bazille.1015granger.net>
In-Reply-To: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
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

Now that upper layers use an xdr_stream to track the construction
of each RPC Reply message, resbuf->len is kept up-to-date
automatically. There's no need to recompute it in svc_gss_release().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 2e603358fae1..4a576ed7aa32 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -969,12 +969,6 @@ svcauth_gss_unwrap_integ(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
 	return -EINVAL;
 }
 
-static inline int
-total_buf_len(struct xdr_buf *buf)
-{
-	return buf->head[0].iov_len + buf->page_len + buf->tail[0].iov_len;
-}
-
 /*
  * RFC 2203, Section 5.3.2.3
  *
@@ -1882,14 +1876,25 @@ svcauth_gss_wrap_resp_priv(struct svc_rqst *rqstp)
 	return 0;
 }
 
+/**
+ * svcauth_gss_release - Wrap payload and release resources
+ * @rqstp: RPC transaction context
+ *
+ * Return values:
+ *    %0: the Reply is ready to be sent
+ *    %-ENOMEM: failed to allocate memory
+ *    %-EINVAL: encoding error
+ *
+ * XXX: These return values do not match the return values documented
+ *      for the auth_ops ->release method in linux/sunrpc/svcauth.h.
+ */
 static int
 svcauth_gss_release(struct svc_rqst *rqstp)
 {
-	struct gss_svc_data *gsd = (struct gss_svc_data *)rqstp->rq_auth_data;
-	struct rpc_gss_wire_cred *gc;
-	struct xdr_buf *resbuf = &rqstp->rq_res;
-	int stat = -EINVAL;
 	struct sunrpc_net *sn = net_generic(SVC_NET(rqstp), sunrpc_net_id);
+	struct gss_svc_data *gsd = rqstp->rq_auth_data;
+	struct rpc_gss_wire_cred *gc;
+	int stat;
 
 	if (!gsd)
 		goto out;
@@ -1899,10 +1904,7 @@ svcauth_gss_release(struct svc_rqst *rqstp)
 	/* Release can be called twice, but we only wrap once. */
 	if (gsd->verf_start == NULL)
 		goto out;
-	/* normally not set till svc_send, but we need it here: */
-	/* XXX: what for?  Do we mess it up the moment we call svc_putu32
-	 * or whatever? */
-	resbuf->len = total_buf_len(resbuf);
+
 	switch (gc->gc_svc) {
 	case RPC_GSS_SVC_NONE:
 		break;


