Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E874F8770
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 20:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347004AbiDGSyd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347009AbiDGSya (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 14:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98C61834C7
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 11:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5610A61DE8
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0811BC385A6
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649357548;
        bh=EqdUAZd8WBm9afbdm9YM2jUQej1o7enVtbJ6jOPJwhE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BgT3OmIbKxEGABxDycMia1+AtsR2HUsetM0RTVUegyU90CpcKyplMLaRhRxJyVCMq
         ScvA0Jqq2x3CJuk/spupdri+3LGtWqzAR29naFfKB0ruda1PlGquTxjtAxgBOsEE95
         xYra0tsmSXVhFyen0KqMqHcMGRTDzmRcdfw6TVu3Mf3n/oPyXa7l4g9VPxWOIDVWze
         5xjFD6iBh4luCbeNeVe+M8BhZAlZRVLk2L6wAMm9FF2hNL5KahnxC6UnzbqUFSKvha
         Re4lUoGkjdK7fnLVUHQtLu9jDEFF1Bq3mqegBLUimkVAlu63qDzEm942jsPa4RiHpr
         +xCMCE+8MMd5A==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 8/8] SUNRPC: Move the call to xprt_send_pagedata() out of xprt_sock_sendmsg()
Date:   Thu,  7 Apr 2022 14:46:01 -0400
Message-Id: <20220407184601.1064640-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407184601.1064640-7-trondmy@kernel.org>
References: <20220407184601.1064640-1-trondmy@kernel.org>
 <20220407184601.1064640-2-trondmy@kernel.org>
 <20220407184601.1064640-3-trondmy@kernel.org>
 <20220407184601.1064640-4-trondmy@kernel.org>
 <20220407184601.1064640-5-trondmy@kernel.org>
 <20220407184601.1064640-6-trondmy@kernel.org>
 <20220407184601.1064640-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The client and server have different requirements for their memory
allocation, so move the allocation of the send buffer out of the socket
send code that is common to both.

Reported-by: NeilBrown <neilb@suse.de>
Fixes: b2648015d452 ("SUNRPC: Make the rpciod and xprtiod slab allocation modes consistent")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/socklib.c  |  6 ------
 net/sunrpc/svcsock.c  |  9 ++++++---
 net/sunrpc/xprtsock.c | 15 +++++++++++++--
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index 05b38bf68316..71ba4cf513bc 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -221,12 +221,6 @@ static int xprt_send_kvec(struct socket *sock, struct msghdr *msg,
 static int xprt_send_pagedata(struct socket *sock, struct msghdr *msg,
 			      struct xdr_buf *xdr, size_t base)
 {
-	int err;
-
-	err = xdr_alloc_bvec(xdr, rpc_task_gfp_mask());
-	if (err < 0)
-		return err;
-
 	iov_iter_bvec(&msg->msg_iter, WRITE, xdr->bvec, xdr_buf_pagecount(xdr),
 		      xdr->page_len + xdr->page_base);
 	return xprt_sendmsg(sock, msg, base + xdr->page_base);
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 6ea3d87e1147..cc35ec433400 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -579,15 +579,18 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 
+	err = xdr_alloc_bvec(xdr, GFP_KERNEL);
+	if (err < 0)
+		goto out_unlock;
+
 	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
-	xdr_free_bvec(xdr);
 	if (err == -ECONNREFUSED) {
 		/* ICMP error on earlier request. */
 		err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
-		xdr_free_bvec(xdr);
 	}
+	xdr_free_bvec(xdr);
 	trace_svcsock_udp_send(xprt, err);
-
+out_unlock:
 	mutex_unlock(&xprt->xpt_mutex);
 	if (err < 0)
 		return err;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index a34a15750122..e16568f9a82d 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -825,9 +825,14 @@ static int xs_stream_nospace(struct rpc_rqst *req, bool vm_wait)
 static int
 xs_stream_prepare_request(struct rpc_rqst *req)
 {
+	gfp_t gfp = rpc_task_gfp_mask();
+	int ret;
+
+	ret = xdr_alloc_bvec(&req->rq_snd_buf, gfp);
+	if (ret < 0)
+		return ret;
 	xdr_free_bvec(&req->rq_rcv_buf);
-	return xdr_alloc_bvec(
-		&req->rq_rcv_buf, GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
+	return xdr_alloc_bvec(&req->rq_rcv_buf, gfp);
 }
 
 /*
@@ -956,6 +961,9 @@ static int xs_udp_send_request(struct rpc_rqst *req)
 	if (!xprt_request_get_cong(xprt, req))
 		return -EBADSLT;
 
+	status = xdr_alloc_bvec(xdr, rpc_task_gfp_mask());
+	if (status < 0)
+		return status;
 	req->rq_xtime = ktime_get();
 	status = xprt_sock_sendmsg(transport->sock, &msg, xdr, 0, 0, &sent);
 
@@ -2557,6 +2565,9 @@ static int bc_sendto(struct rpc_rqst *req)
 	int err;
 
 	req->rq_xtime = ktime_get();
+	err = xdr_alloc_bvec(xdr, rpc_task_gfp_mask());
+	if (err < 0)
+		return err;
 	err = xprt_sock_sendmsg(transport->sock, &msg, xdr, 0, marker, &sent);
 	xdr_free_bvec(xdr);
 	if (err < 0 || sent != (xdr->len + sizeof(marker)))
-- 
2.35.1

