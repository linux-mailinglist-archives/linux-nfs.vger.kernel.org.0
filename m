Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93E4F83EB
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 17:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345196AbiDGPq6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345101AbiDGPqi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 11:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8215EC6F21
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 08:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0F3461B8E
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A51C385AA
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649346274;
        bh=ZBqeJfKcLA80ny5CZGoA9SnCqhrKZWAqtslhR/LejX8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i31to0SOiZQ11/HKfhgeQXDfT51aJx+ZFR3m2bTwFH0/gJRTHuc10jMtD8XtutyF+
         1+1lP9JZU55yVplelyRqumYcDjJcL8Hs28l3Cq85Fuc+Ykt70Jodpjey5TIwb5NgWw
         VE6EkSTOBliRsBJfDyCjK3MRKLZlOT81SRk/UFao2w1+EpuaNd0rnZ446IeM3IprqJ
         zCAe92vRIb7yH5+7hZwZmsippnFCbwDKDl+59ND6PLjzaTbbiwX/RzLS57lXmXz2pD
         VlJ84r9gHTcrH859OASnwZaj0OBuOSeO5qVD2q9+8W7huic49q0YU2l1RHbAOX0myw
         6C/3dbuqCnZLw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/7] SUNRPC: Move the call to xprt_send_pagedata() out of xprt_sock_sendmsg()
Date:   Thu,  7 Apr 2022 11:38:09 -0400
Message-Id: <20220407153809.1053261-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407153809.1053261-6-trondmy@kernel.org>
References: <20220407153809.1053261-1-trondmy@kernel.org>
 <20220407153809.1053261-2-trondmy@kernel.org>
 <20220407153809.1053261-3-trondmy@kernel.org>
 <20220407153809.1053261-4-trondmy@kernel.org>
 <20220407153809.1053261-5-trondmy@kernel.org>
 <20220407153809.1053261-6-trondmy@kernel.org>
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
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/socklib.c  |  6 ------
 net/sunrpc/svcsock.c  | 13 +++++++++----
 net/sunrpc/xprtsock.c | 15 +++++++++++++--
 3 files changed, 22 insertions(+), 12 deletions(-)

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
index 478f857cdaed..cc35ec433400 100644
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
@@ -1096,7 +1099,9 @@ static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
 	int ret;
 
 	*sentp = 0;
-	xdr_alloc_bvec(xdr, GFP_KERNEL);
+	ret = xdr_alloc_bvec(xdr, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
 
 	ret = kernel_sendmsg(sock, &msg, &rm, 1, rm.iov_len);
 	if (ret < 0)
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

