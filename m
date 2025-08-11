Return-Path: <linux-nfs+bounces-13555-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829B1B20C4B
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 16:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD2F3AD471
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85F72D320E;
	Mon, 11 Aug 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU+/msgj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085C2C325B;
	Mon, 11 Aug 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923038; cv=none; b=HAovinpL8+q9ZHAriWis7UcnI2nSk6oUm/4+uAYTZM63wonVT7YjhraLgWebq/dUlo5h11nz4yfyociU28s0QnJFLTZnkpsooWRC6k/hHdyCSAGA3u5CGB1RgCygj9FLPZifd5oTvrDjlDSYEa5k8YW0NVdVr/meFReai4QDwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923038; c=relaxed/simple;
	bh=qR9vSCPotI30iKaZxd6uDACGqYOSSZxxGzGbK/JS7sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiAcdkDNumaOikVn5LN+whKDjgJ36arMdnwXl2xl1ECVAPcfXj/TTQsR4LzLpDRa0uvJdG9uq1JfmglY242uzjpHDGe01ExuuqipAYZmCpfvq3ymRZ+ZrhQWBZrdh9L8lS6tp5B7pi5dRRXzUblooywzexncVc7iXZB4nHnNusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU+/msgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9880CC4CEF8;
	Mon, 11 Aug 2025 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754923038;
	bh=qR9vSCPotI30iKaZxd6uDACGqYOSSZxxGzGbK/JS7sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CU+/msgjW6L6PPyuIZbu7gsPz57APWxsWL4XOHMkNCiDUPpieddw+7X+bCSJltuV0
	 OofLDJuns7vXgKOR69yNemeNk/EMRmYZZmZSRcP4TJ7yOW0lPbLzz7kRimSJur7Yqo
	 GKC/7sQSnIu2zylfDV50jEJLqKAqkcx1F0WeCxbzWfQK7+oaGVo4PT1dIu6vh7e4FC
	 fVf+Y1DFROkSZnocEmjmOu/2YQTmB6PbI61jBUqXhZ/gUjz5L/nDtn4ZIhu0jxy+Lz
	 tp5nhzwMh9AdchgYbCBlqgR0lBXmArBEM43uleiDOkg+OXDlwTXL90IfJULaiZaFtj
	 JwHFb0Jy7A/LQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 11 Aug 2025 10:37:08 -0400
Subject: [PATCH 2/2] sunrpc: eliminate return pointer in svc_tcp_sendmsg()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-nfsd-testing-v1-2-f9a21bbf238b@kernel.org>
References: <20250811-nfsd-testing-v1-0-f9a21bbf238b@kernel.org>
In-Reply-To: <20250811-nfsd-testing-v1-0-f9a21bbf238b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qR9vSCPotI30iKaZxd6uDACGqYOSSZxxGzGbK/JS7sw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBomgAbO//eV2OR6//8krF8sKSjfC10hgEMvx167
 CavYms5jH6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaJoAGwAKCRAADmhBGVaC
 FfrmD/wNHBuTP+P0JcS6i8FyZrAWhJeYt8nYYS9t4xgbBiE44tzTjy8LIl2ldW7HBrW3ioniFFX
 CpdTEwTfOSPNdklH8aJnCJ51ZPHRTFYkcFMmitEKvdq/E/4wma/nSGqOfZdnaTbgDlEVluDw32s
 Q8APsNBh0K0c7FWrGQd+AqeBsXYpf94xbl3FVuiwtdrZAgpzYjjLWG2nFtN+iivv56BMtKXF8Lg
 tI0agFqR4rFQQWfhqpYM2jRSyyfwZ5Jw1u/iban8lamGHO8vfkqcWBveIpr0qXXyQrLL+Dn7y6I
 kth6jVaOSkQdQLLFZwc8jnvZBlNR9hkyAsQVlsKDeBb2Dq38KF+hBAR+3ffq1+77auP6+8m6MTi
 Kp+UD/TxW6lQlNMDzEBb9nTj9XF97es9ZHN3Vf15HnYB6BhAjYkqseMIHcfVEVV5VLNxZM/+FEU
 YZZgWhl3CctuJ69/le43OSI7Ew0qgvTi3/9YGJx4ANaJZnqdGYQKMhzRdtpC3LxYTrZsVMLmQyr
 V1c4Ue6STtYiGVTt0BiWUGbFs7Bx8fNTwulrWVmeYnM4KGrhEO1Jt/yVj3g3dj6i89m5n7VkQai
 i5maT1peee05P3DqrS9/IowNfC39R6+JRQl8m2LUMlV26kdAallyMmQcH3U9IFcYBjOmSjVbNiT
 1fHHr5DEpZyckAQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Return a positive value if something was sent, or a negative error code.
Eliminate the "err" variable in the only caller as well.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svcsock.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 22f59289fdcf17137fcac59e13975281ecf3e380..2b531d6d5edd92b2c2fe3b774f67e5ecaa9fd57f 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1197,7 +1197,7 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
  * that the pages backing @xdr are unchanging.
  */
 static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
-			   rpc_fraghdr marker, int *sentp)
+			   rpc_fraghdr marker)
 {
 	struct msghdr msg = {
 		.msg_flags	= MSG_SPLICE_PAGES,
@@ -1206,8 +1206,6 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	void *buf;
 	int ret;
 
-	*sentp = 0;
-
 	/* The stream record marker is copied into a temporary page
 	 * fragment buffer so that it can be included in rq_bvec.
 	 */
@@ -1225,10 +1223,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 		      1 + count, sizeof(marker) + rqstp->rq_res.len);
 	ret = sock_sendmsg(svsk->sk_sock, &msg);
 	page_frag_free(buf);
-	if (ret < 0)
-		return ret;
-	*sentp += ret;
-	return 0;
+	return ret;
 }
 
 /**
@@ -1247,7 +1242,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	struct xdr_buf *xdr = &rqstp->rq_res;
 	rpc_fraghdr marker = cpu_to_be32(RPC_LAST_STREAM_FRAGMENT |
 					 (u32)xdr->len);
-	int sent, err;
+	int sent;
 
 	svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
 	rqstp->rq_xprt_ctxt = NULL;
@@ -1255,9 +1250,9 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	mutex_lock(&xprt->xpt_mutex);
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
-	err = svc_tcp_sendmsg(svsk, rqstp, marker, &sent);
-	trace_svcsock_tcp_send(xprt, err < 0 ? (long)err : sent);
-	if (err < 0 || sent != (xdr->len + sizeof(marker)))
+	sent = svc_tcp_sendmsg(svsk, rqstp, marker);
+	trace_svcsock_tcp_send(xprt, sent);
+	if (sent < 0 || sent != (xdr->len + sizeof(marker)))
 		goto out_close;
 	mutex_unlock(&xprt->xpt_mutex);
 	return sent;
@@ -1268,8 +1263,8 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 out_close:
 	pr_notice("rpc-srv/tcp: %s: %s %d when sending %zu bytes - shutting down socket\n",
 		  xprt->xpt_server->sv_name,
-		  (err < 0) ? "got error" : "sent",
-		  (err < 0) ? err : sent, xdr->len + sizeof(marker));
+		  (sent < 0) ? "got error" : "sent",
+		  sent, xdr->len + sizeof(marker));
 	svc_xprt_deferred_close(xprt);
 	mutex_unlock(&xprt->xpt_mutex);
 	return -EAGAIN;

-- 
2.50.1


