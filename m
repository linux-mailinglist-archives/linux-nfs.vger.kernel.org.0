Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE89754258
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 20:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbjGNSLy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 14:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbjGNSLv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 14:11:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E3635B6
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 11:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 779C761DA4
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 18:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96005C433C8;
        Fri, 14 Jul 2023 18:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689358251;
        bh=nIwnDpeLNNXqIqXQ2IZyBusc1AZA0y1HhYlRmT4gqbU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RKQeX5dxvCCGQHXzqHhU19LZik+aQZE7pEZpcPOXKOHmH7N2TE3kGiUciP9me5S0D
         vZMSdHLNslH3xWr/iRDn4C84pBp78bAJcA/YTyG86e+AHVYjrQ06HD8F7h1qedu+15
         QCcunZPq57zIDmewUGTIrhcJu0daitKDYJ1w5xjKDMpPl+TPFD16sH7svKHgYThFdR
         e31pkypO5soEC99rc4Fw0lp6UO+n6z7Jf0c8ddoj2U44LsKB8Gphufq5PRPTHGMFdi
         UVT1Gv+uI6OmO4I9DKO78aV9dWapHv1e9IoHNXKqBAYuzBsxet7CEuv+PmR6hQ5xjn
         yQ7XcwEGUTMIg==
Subject: [PATCH v2 3/4] SUNRPC: Convert svc_udp_sendto() to use the per-socket
 bio_vec array
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com
Date:   Fri, 14 Jul 2023 14:10:50 -0400
Message-ID: <168935825062.1984.15414767603272782406.stgit@manet.1015granger.net>
In-Reply-To: <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net>
References: <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Once the use of bio_vecs is ubiquitous, the xdr_buf-to-bio_vec array
code can be hoisted into a path that is common for all transports.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index bb185c0bb57c..e164ea4d0e0a 100644
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
+	count = xdr_buf_to_bvec(svsk->sk_send_bvec,
+				ARRAY_SIZE(svsk->sk_send_bvec), xdr);
 
-	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_send_bvec,
+		      count, 0);
+	err = sock_sendmsg(svsk->sk_sock, &msg);
 	if (err == -ECONNREFUSED) {
 		/* ICMP error on earlier request. */
-		err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_send_bvec,
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


