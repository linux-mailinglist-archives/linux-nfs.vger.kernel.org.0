Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA15759D4D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 20:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGSSbT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 14:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGSSbT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 14:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A3B6
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 11:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC8B6617C2
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 18:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B8CC433C8;
        Wed, 19 Jul 2023 18:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689791477;
        bh=D6DwcPwywvoVU7CXOxDCIrUiHzrDx4usY5dx9EsKCaI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eVonETjNis11TjJ1oRLkrr3NJ4iHzlF7nw72KDfLquSbo2B4zMpOWrTfYToeZuGDP
         sriFE2tNBDGZrTo4tCMhmITUnid9+1HjIUJZ3YLbPTj3vw21s8ZEJRC/lpMQsZnE+b
         9WWuDQ3DEoSAR/ztkxluu8RCQeYyvWTzQ493WSRjUt8B+99EAJQZffLXon+XUvC239
         5kU2/bT29ZXOwxH10FnCahbw7T3KNIH93COT+4cqOGJlFIShXnsVpSvfKcidjoJgCm
         3O1FhQXDtIrEpkFcdWkNv+3G8Tw+hM3wXu5NwsYDT3NPgCcLsgdooE8sbCFMLvs2yR
         EgWJgrvrzJItg==
Subject: [PATCH v3 3/5] SUNRPC: Convert svc_udp_sendto() to use the per-socket
 bio_vec array
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Wed, 19 Jul 2023 14:31:16 -0400
Message-ID: <168979147611.1905271.944494362977362823.stgit@morisot.1015granger.net>
In-Reply-To: <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
References: <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Commit da1661b93bf4 ("SUNRPC: Teach server to use xprt_sock_sendmsg
for socket sends") modified svc_udp_sendto() to use xprt_sock_sendmsg()
because we originally believed xprt_sock_sendmsg() would be needed
for TLS support. That does not actually appear to be the case.

In addition, the linkage between the client and server send code has
been a bit of a maintenance headache because of the distinct ways
that the client and server handle memory allocation.

Going forward, eventually the XDR layer will deal with its buffers
in the form of bio_vec arrays, so convert this function accordingly.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index d4d816036c04..f28790f282c2 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -695,7 +695,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 		.msg_control	= cmh,
 		.msg_controllen	= sizeof(buffer),
 	};
-	unsigned int sent;
+	unsigned int count;
 	int err;
 
 	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
@@ -708,22 +708,23 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 
-	err = xdr_alloc_bvec(xdr, GFP_KERNEL);
-	if (err < 0)
-		goto out_unlock;
+	count = xdr_buf_to_bvec(rqstp->rq_bvec,
+				ARRAY_SIZE(rqstp->rq_bvec), xdr);
 
-	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
+		      count, 0);
+	err = sock_sendmsg(svsk->sk_sock, &msg);
 	if (err == -ECONNREFUSED) {
 		/* ICMP error on earlier request. */
-		err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
+			      count, 0);
+		err = sock_sendmsg(svsk->sk_sock, &msg);
 	}
-	xdr_free_bvec(xdr);
+
 	trace_svcsock_udp_send(xprt, err);
-out_unlock:
+
 	mutex_unlock(&xprt->xpt_mutex);
-	if (err < 0)
-		return err;
-	return sent;
+	return err;
 
 out_notconn:
 	mutex_unlock(&xprt->xpt_mutex);


