Return-Path: <linux-nfs+bounces-15137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5322ABCE3EB
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 20:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009D9403196
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 18:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1D72FF664;
	Fri, 10 Oct 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2jFgeA3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6D2FFDC0;
	Fri, 10 Oct 2025 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120855; cv=none; b=QsTTmC4kSpCYyNejb0sE5WATtvWD/7URMC6ji1BaGv3bU3Mi5z1INTcrH02z3oL1uUkws9ul5HSIUPJtyB4curK7rObTeiUPgx0P6eXIax8zV1r1/B3q7vxMGWKphfeqTUZOCSHp9O/FWkEZDL4fiCkbHcsbYkE4c6859421DRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120855; c=relaxed/simple;
	bh=eLy5f8BYq1FZ75LlTMzJvXsfCy88if544RCMW6Jg9FM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O7vgedinTj9JedMzX5H2MRnTmSNUQlKRnOGSvLa8fpC/g2OBjLfGVZfMQ54evZlzv1tNNRQyCFfN7T/TXE5TdNYG3FcZVHxUzkkmLIFoXHEGMQAXopk8J/deRPvY5gXWgycArGygRb/hNOQOvMC/LgIroDuN3kwbuo6ZaSiFgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2jFgeA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3E0C4CEF5;
	Fri, 10 Oct 2025 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760120853;
	bh=eLy5f8BYq1FZ75LlTMzJvXsfCy88if544RCMW6Jg9FM=;
	h=From:Date:Subject:To:Cc:From;
	b=Z2jFgeA3HOvCBv9HW0qSykSn5u+tXiXUOxQctdezWagjGCbHS5j+9vC8Cso8BGBAY
	 i+A7R1yrViLxfBfYCyDRztU3Fw324cq94aBY3bI6lBuyDdSIw19Pz4IJn5js3SUlEx
	 hztQJG2yEJIQIu1WqM+hcmoUvAfhYhrFoGtoc92HYsIO3UwIp+3JgQP4RO+Rpx9Vjp
	 sp7J/c3v8hQsg5cYmUbq3dIGNEV1W/3INFAEL0VlOaKwDosNRLlPP04AB94mspPPAz
	 vwnyMVV+p18peibko9X6g2ETn73yQvxpHKXQ9xj3x2FKgTlnFCaeRXDdSHTM7fQsZk
	 yn1IyLL0lEQ1Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 10 Oct 2025 14:27:22 -0400
Subject: [PATCH v5] sunrpc: allocate a separate bvec array for socket sends
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-rq_bvec-v5-1-44976250199d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAApQ6WgC/3XMQQ7CIBCF4asY1mKYQaB15T2MMQUGJZpWqSEa0
 7uLblrTuHyT+f4X6ylF6tlm8WKJcuxj15ahlgvmTk17JB592QwFKhCi4ul2sJkct1o3wYvgrbW
 sfF8Thfj4lnb7sk+xv3fp+Q1n+FznjQxccBNQeoneKFLbM6WWLqsuHdknkvEPxAIrlE40lWrQu
 BmUU1iPUBaoDFQgtbC1szO4nkAQI1xz4BqN0iaAoxp+4DAMbw0sK5BKAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5335; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eLy5f8BYq1FZ75LlTMzJvXsfCy88if544RCMW6Jg9FM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo6VAPtUGvoIwWqqz/lc5Ho7U9WvDl3ATC9mU2v
 a2ELpDKYGGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaOlQDwAKCRAADmhBGVaC
 Ff4oD/0S5lUBbOdg04YMWA9mXPWwc1H071gKHk//J9K9bFDXtpPt6gaGqwyS4eCs6XoURn/VX5T
 AntwsbiBmm5WFbstLEhvRiHVTaLQrhDQ0ojN4AlOjOj2OA/nft8ZFxBdSJJXKV14cI/w4IMuLTH
 VQp4WnMpNVgb2nLpvTE8D1q2tlHghhj9xdcouhytxjkALj1uBvbiECnXbR6rBI81aS6SVUTaNZA
 gRY6/uOMFb6brNKovczfOTlRUFGOPoX77J7QvIoZo9N6o/SWb0nInbPE4uyMCLUOKx4bBcpy4lw
 fZTIym6TnDPVravIv1OIgLa7OBEjDBR0N36NiEKjBE+dT1LtV7cN2FMInU3olVkTzCDc523E9Z5
 +7V9bWBwPAQez7kqDOreJVnZiota0Eyg56LxbJkJKI4ptsLy97fvpuQN+QhYJLOotzkBYLOnneR
 Yg56qonIq7ffIxUXa8FxBbHCaWv8VsJgVGRYarqSklNUaLSd/g8qExL52Sh9M+ECglaJ2aw1URi
 UJT3EmR7WsnooAjHKN8E9XCIjPeZrap+nYqUiehJtWT4CbJOke35bOlx0iavEas+PHq0Gcv+QrF
 +AOI96dJO/bDOK7D23K3huuVnkFS3NqvsracLnfSvbyBR0znsCliRFDoRqPhOmsygx2c+32UOcq
 G70fwp3kxPk9wyg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

svc_tcp_sendmsg() calls xdr_buf_to_bvec() with the second slot of
rq_bvec as the start, but doesn't reduce the array length by one, which
could lead to an array overrun. Also, rq_bvec is always rq_maxpages in
length, which can be too short in some cases, since the TCP record
marker consumes a slot.

Fix both problems by adding a separate bvec array to the svc_sock that
is specifically for sending. Allocate it when doing the first send on
the socket, to avoid allocating the array for listener sockets.

For TCP, make this array one slot longer than rq_maxpages, to account
for the record marker. For UDP only allocate as large an array as we
need since frames are limited to 64k anyway.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Minor update to the last patch to reduce the size of the array on UDP
sockets since that transport doesn't need rq_maxpages.
---
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
 net/sunrpc/svcsock.c           | 29 ++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 963bbe251e52109a902f6b9097b6e9c3c23b1fd8..a80a05aba75410b3c4cd7ba19181ead7d40e1fdf 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -26,6 +26,9 @@ struct svc_sock {
 	void			(*sk_odata)(struct sock *);
 	void			(*sk_owspace)(struct sock *);
 
+	/* For sends */
+	struct bio_vec		*sk_bvec;
+
 	/* private TCP part */
 	/* On-the-wire fragment header: */
 	__be32			sk_marker;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 7b90abc5cf0ee1520796b2f38fcb977417009830..0ec1131ffade8d0c66099bfb1fb141b22c6e411b 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -730,6 +730,13 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	unsigned int count;
 	int err;
 
+	count = DIV_ROUND_UP(RPC_MAX_REPHEADER_WITH_AUTH + RPCSVC_MAXPAYLOAD_UDP, PAGE_SIZE);
+	if (!svsk->sk_bvec) {
+		svsk->sk_bvec = kcalloc(count, sizeof(*svsk->sk_bvec), GFP_KERNEL);
+		if (!svsk->sk_bvec)
+			return -ENOMEM;
+	}
+
 	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
 	rqstp->rq_xprt_ctxt = NULL;
 
@@ -740,14 +747,14 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
+	count = xdr_buf_to_bvec(svsk->sk_bvec, rqstp->rq_maxpages, xdr);
 
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
@@ -1235,19 +1242,19 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
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
@@ -1272,6 +1279,13 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 					 (u32)xdr->len);
 	int sent;
 
+	if (!svsk->sk_bvec) {
+		/* +1 for TCP record marker */
+		svsk->sk_bvec = kcalloc(rqstp->rq_maxpages + 1, sizeof(*svsk->sk_bvec), GFP_KERNEL);
+		if (!svsk->sk_bvec)
+			return -ENOMEM;
+	}
+
 	svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
 	rqstp->rq_xprt_ctxt = NULL;
 
@@ -1636,5 +1650,6 @@ static void svc_sock_free(struct svc_xprt *xprt)
 		sock_release(sock);
 
 	page_frag_cache_drain(&svsk->sk_frag_cache);
+	kfree(svsk->sk_bvec);
 	kfree(svsk);
 }

---
base-commit: 177818f176ef904fb18d237d1dbba00c2643aaf2
change-id: 20251008-rq_bvec-b66afd0fdbbb

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


