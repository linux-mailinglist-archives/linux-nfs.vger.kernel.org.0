Return-Path: <linux-nfs+bounces-15178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73709BD33A8
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 15:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD809189D6C1
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 13:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED512F28F2;
	Mon, 13 Oct 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSwSb3Vo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149022157B;
	Mon, 13 Oct 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362719; cv=none; b=DGE7L3XG5UwRmXE75p85U1F/lHPIYO70atcHr+2j0rUWuYvIee1Tb25Bx1ycttkDmpzb9wZViUe9fs7LSsf1MHTl5opZJNh63Y+cokhrsdIvAPBnk4lzRWEwvOXXyjEJDuhkZQX+sg96iseolrt3yn7GN09IWzxnuQKwmiRTQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362719; c=relaxed/simple;
	bh=x+PN02ZPz5D3mRsRokGX7FVJjc6Z2tGcmM9hNPlpiWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RV8Gdsnjf4bfYMNSra/c7cdrRFVXqm7Yrm6RiQPS3jgD60siAt6/dRBSPDuAAJot2E7fV11M9CsKPaD9EmmqlqwYjwljJ8w7Dh3ONqLkHlBRbfZUWb8LLnGMrIComp4ZOj3KAFbOQwzmrHDbxzm2LulOTDQE4bC9bsLymTYIDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSwSb3Vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A31FC4CEE7;
	Mon, 13 Oct 2025 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760362718;
	bh=x+PN02ZPz5D3mRsRokGX7FVJjc6Z2tGcmM9hNPlpiWY=;
	h=From:Date:Subject:To:Cc:From;
	b=cSwSb3Vo+MKugI5i7sOGtx2UjZd2pu7YfoOlMVOSVxXV+DI1Fy5A9XJgX7v5MskgY
	 a15IVS8B0GtsT6Q4iU3teJGk0F3xn/3/xDVsSKI1OfNDcJL++F4XAS0PRD8P9BI1bg
	 aFZApokbE2hIUDHnxI+C5uYDVGR36c/QKGTCpkCi9MutVAkOfHP9iCkII9soMV69WS
	 ym1vWQ4UHoXxaUG1RrvTXSdpIopWDG8Ue78lWJgaTFjMrm3Dc51+49bm9OrEy2FoDo
	 b9KIUC/YFZr74x2981mERFqk4sLjVdR3+qL25j0DUzQUrDmIgSjashd1g8VW+YsqLg
	 UJDKQjyFKLtUw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 13 Oct 2025 09:38:23 -0400
Subject: [PATCH v6] sunrpc: allocate a separate bvec array for socket sends
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-rq_bvec-v6-1-17982fc64ad2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM4A7WgC/3XMwW4CIRDG8VcxnEszMyyw9OR7mKZZYFBis1tZQ
 9qYffeiFzUbj99kfv+LmLlknsXH5iIK1zznaWzDvG1EOAzjnmWObQsC0gjQy3L68pWD9MYMKUK
 K3nvRvn8Kp/x7K+0+2z7k+TyVv1u44vW6blSUIG0iFRVFq1lvj1xG/n6fyl5cI5VeQGqwJxVg6
 PVANqygeoTuDlWD2mKPyoB3wa9g9wAR7rCTKA1ZbWzCwA5XUL+AusGuc9aQBnQuPsFlWf4BeZD
 w+4MBAAA=
X-Change-ID: 20251008-rq_bvec-b66afd0fdbbb
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>
Cc: Brandon Adams <brandona@meta.com>, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6563; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=x+PN02ZPz5D3mRsRokGX7FVJjc6Z2tGcmM9hNPlpiWY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7QDU9/NXXhcz6uTsf5HgiW3i25jjTNl00zuUJ
 ap/2+1CuXSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0A1AAKCRAADmhBGVaC
 FfmVEACxy6szP7N44Fb117oThIaxorei2ShcJm6UyErf8oCW7hS6KgOFhNfWW9undL8debdXTSP
 4qRLYubnEERGLfQExdFcbDkNQD40sUdYtf+4vRtLPibxTR3685nbUmLAP6cHUCkw+xuBxQoucu3
 es66h/RbGseo3DGxwwUpDVDFgudh0wIdd/tXZPEkhQJKXwXPyBIPIExiCy2Hd8StuH8t6LH0RE5
 hyHOUUH1ounFqO2Ur/0Qk96JA1YGUScP/9CmdICsDT8d5dTn34NbYdZZcHau++0xS/4SWmnnDtq
 vIz6ijtL/6e0xQPEhqK8Ma40L5I9OzOOlm+Ld8MGRPu6lS/kDlxMVkddXAQ4h38XDkyeVSjt9av
 O+8rotdENf/Sz4TcN3Ihomh8v3IoyuwWawy6wOJEyyStuMOi+s0pF9kkTsWX1Bfd6ErUpS7tvTU
 afCjvV4g1STFzcAOKtqVCBZhT4G6nAYusWkDPj9fARiEeTN64sFTUzwZlwb1nlAPgU89vUKtZ+e
 fAu9z9IL69Y5XT15e4iapID0n5K0UW1RgB96fJ74XFdwecLspjf4ACBf+4XwXmQpK/vXJyKBNEN
 EjV5JHixvSXRAtsZH3uzuYHvsTiNV5elc8/3NhuH9zJYu7rxC1hSkNYAIUN1y7d0UZKnY+LI0dV
 NbQUQDa/VTqrtow==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

svc_tcp_sendmsg() calls xdr_buf_to_bvec() with the second slot of
rq_bvec as the start, but doesn't reduce the array length by one, which
could lead to an array overrun. Also, rq_bvec is always rq_maxpages in
length, which can be too short in some cases, since the TCP record
marker consumes a slot.

Fix both problems by adding a separate bvec array to the svc_sock that
is specifically for sending. For TCP, make this array one slot longer
than rq_maxpages, to account for the record marker. For UDP, only
allocate as large an array as we need since it's limited to 64k of
payload.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Another update based on Neil's feedback. This version allocates the
array when the socket is allocated, and fixes the UDP length
calculation.
---
Changes in v6:
- allocate sk_bvec in ->xpo_create
- fix the array-length calculation for UDP
- Link to v5: https://lore.kernel.org/r/20251010-rq_bvec-v5-1-44976250199d@kernel.org

Changes in v5:
- reduce the size of sk_bvec on UDP sockets
- Link to v4: https://lore.kernel.org/r/20251010-rq_bvec-v4-1-627567f1ce91@kernel.org

Changes in v4:
- switch to allocating a separate bvec for sends in the svc_sock
- Link to v3: https://lore.kernel.org/r/20251009-rq_bvec-v3-0-57181360b9cb@kernel.org

Changes in v3:
- Add rq_bvec_len field and use it in appropriate places
- Link to v2: https://lore.kernel.org/r/20251008-rq_bvec-v2-0-823c0a85a27c@kernel.org

Changes in v2:
- Better changelog message for patch #2
- Link to v1: https://lore.kernel.org/r/20251008-rq_bvec-v1-0-7f23d32d75e5@kernel.org
---
 include/linux/sunrpc/svcsock.h |  3 +++
 net/sunrpc/svcsock.c           | 54 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 963bbe251e52109a902f6b9097b6e9c3c23b1fd8..de37069aba90899be19b1090e6e90e509a3cf530 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -26,6 +26,9 @@ struct svc_sock {
 	void			(*sk_odata)(struct sock *);
 	void			(*sk_owspace)(struct sock *);
 
+	/* For sends (protected by xpt_mutex) */
+	struct bio_vec		*sk_bvec;
+
 	/* private TCP part */
 	/* On-the-wire fragment header: */
 	__be32			sk_marker;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 0cb9c4d457453b26db29f08985b056c3f8d59447..e979505a21b69267a10d39f9084b557db4c9369c 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -68,6 +68,16 @@
 
 #define RPCDBG_FACILITY	RPCDBG_SVCXPRT
 
+/*
+ * For UDP:
+ * 1 for header page
+ * 16 for up to 64kb of payload + 1 in case it's not aligned
+ * 1 for tail page
+ */
+enum {
+	SUNRPC_MAX_UDP_SENDPAGES = 1 + 16 + 1 + 1
+};
+
 /* To-do: to avoid tying up an nfsd thread while waiting for a
  * handshake request, the request could instead be deferred.
  */
@@ -740,14 +750,14 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
+	count = xdr_buf_to_bvec(svsk->sk_bvec, SUNRPC_MAX_UDP_SENDPAGES, xdr);
 
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
 		      count, rqstp->rq_res.len);
 	err = sock_sendmsg(svsk->sk_sock, &msg);
 	if (err == -ECONNREFUSED) {
 		/* ICMP error on earlier request. */
-		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
 			      count, rqstp->rq_res.len);
 		err = sock_sendmsg(svsk->sk_sock, &msg);
 	}
@@ -1236,19 +1246,19 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	int ret;
 
 	/* The stream record marker is copied into a temporary page
-	 * fragment buffer so that it can be included in rq_bvec.
+	 * fragment buffer so that it can be included in sk_bvec.
 	 */
 	buf = page_frag_alloc(&svsk->sk_frag_cache, sizeof(marker),
 			      GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	memcpy(buf, &marker, sizeof(marker));
-	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
+	bvec_set_virt(svsk->sk_bvec, buf, sizeof(marker));
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages,
+	count = xdr_buf_to_bvec(svsk->sk_bvec + 1, rqstp->rq_maxpages,
 				&rqstp->rq_res);
 
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
 		      1 + count, sizeof(marker) + rqstp->rq_res.len);
 	ret = sock_sendmsg(svsk->sk_sock, &msg);
 	page_frag_free(buf);
@@ -1393,6 +1403,20 @@ void svc_sock_update_bufs(struct svc_serv *serv)
 	spin_unlock_bh(&serv->sv_lock);
 }
 
+static int svc_sock_sendpages(struct svc_serv *serv, struct socket *sock, int flags)
+{
+	switch (sock->type) {
+	case SOCK_STREAM:
+		/* +1 for TCP record marker */
+		if (flags & SVC_SOCK_TEMPORARY)
+			return svc_serv_maxpages(serv) + 1;
+		return 0;
+	case SOCK_DGRAM:
+		return SUNRPC_MAX_UDP_SENDPAGES;
+	}
+	return -EINVAL;
+}
+
 /*
  * Initialize socket for RPC use and create svc_sock struct
  */
@@ -1403,12 +1427,26 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 	struct svc_sock	*svsk;
 	struct sock	*inet;
 	int		pmap_register = !(flags & SVC_SOCK_ANONYMOUS);
+	int		sendpages;
 	unsigned long	pages;
 
+	sendpages = svc_sock_sendpages(serv, sock, flags);
+	if (sendpages < 0)
+		return ERR_PTR(sendpages);
+
 	pages = svc_serv_maxpages(serv);
 	svsk = kzalloc(struct_size(svsk, sk_pages, pages), GFP_KERNEL);
 	if (!svsk)
 		return ERR_PTR(-ENOMEM);
+
+	if (sendpages) {
+		svsk->sk_bvec = kcalloc(sendpages, sizeof(*svsk->sk_bvec), GFP_KERNEL);
+		if (!svsk->sk_bvec) {
+			kfree(svsk);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
 	svsk->sk_maxpages = pages;
 
 	inet = sock->sk;
@@ -1420,6 +1458,7 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 				     inet->sk_protocol,
 				     ntohs(inet_sk(inet)->inet_sport));
 		if (err < 0) {
+			kfree(svsk->sk_bvec);
 			kfree(svsk);
 			return ERR_PTR(err);
 		}
@@ -1637,5 +1676,6 @@ static void svc_sock_free(struct svc_xprt *xprt)
 		sock_release(sock);
 
 	page_frag_cache_drain(&svsk->sk_frag_cache);
+	kfree(svsk->sk_bvec);
 	kfree(svsk);
 }

---
base-commit: 05d2192090744b16ce05bd221c459a9357c17525
change-id: 20251008-rq_bvec-b66afd0fdbbb

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


