Return-Path: <linux-nfs+bounces-15134-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC789BCDF60
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 18:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5F0A4E9567
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9791E2FBE08;
	Fri, 10 Oct 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYX3urCU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818B4A02;
	Fri, 10 Oct 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113689; cv=none; b=EFDLcLUgrRyMbSwJ30qHe7CdjsK4xkKlxMUD6RpBa9bystvh+DEUhQ3Mv/DIahLdzgMtJ/vrl4Ju9c7aRIGuHs5Py7CQK8stCfE8aMB1xy+Wkg6jLUpohSWJesH/au9YzXNdHqFo5j2nxzgq6be5iKl8bIdFY8hhZ6F66FAJ0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113689; c=relaxed/simple;
	bh=ul0WhsI1/S/s1VuIA53kCuhvAfuZ5mveHzB8QuQ0UJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KfnMN/215slTuKSFFpIme5ZAkylv4LucQ624bNJNETOTo+H7TN6stMKD42t6WyeXxHU0MBSzXtZbmpiBqwDb10e+oFcATFVwexvzBqkwfU79oMESDz1DkiNp5Z8kj7dtDXNTbvqEHw0Iz6/yG9yOElImV7LJX9YyuJdKqLH5IlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYX3urCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA1CC4CEF1;
	Fri, 10 Oct 2025 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760113688;
	bh=ul0WhsI1/S/s1VuIA53kCuhvAfuZ5mveHzB8QuQ0UJU=;
	h=From:Date:Subject:To:Cc:From;
	b=rYX3urCU8TISIqtEkj5mxobKUDaiZRYTRSrsbBC9qPGdcCYN07X8QHcqroNaXdtc3
	 DlV3FF94K/Z6KzkbZEhDTUsNbljVzF1MbUIpt/9CWiopy0Wyj4Q4Ok7LA6RtebXwar
	 OBeDB6i2huV8XumssoV8waCkxZRnPkyEAFIEMKQcQfpmIZ19G7QK2FnUFEHbkuDTkM
	 xqC/7qTTE2bPPraKoiExK6jwiLffKMcYWhovuP7gUtitIWdoHSHVOQgNlAQ89hs2sk
	 SwzI0kr6/4Qo0798RypCTiMDeVowMOox9xm7H2y5NlUgySGZWb2Dkr9miHSQkciaMh
	 QkB5lzZ4GIGdg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 10 Oct 2025 12:27:56 -0400
Subject: [PATCH v4] sunrpc: allocate a separate bvec array for socket sends
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-rq_bvec-v4-1-627567f1ce91@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAs06WgC/3XMSwrCMBSF4a2UjI3kYZrUkfsQkTxu2qC0mkhQS
 vdu2olKcXgu9/tHlCAGSGhfjShCDikMfRm7TYVsp/sWcHBlI0aYoIQoHO9nk8FiU9faO+KdMQa
 V71sEH55L6XgquwvpMcTXEs50vq4bmWKCpWfcceakAHG4QOzhuh1ii+ZIZn8gK1AxbolWQjNpV
 5B/w+YDeYFCUkV5TUxjzQ+cpukN0txJLREBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5016; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ul0WhsI1/S/s1VuIA53kCuhvAfuZ5mveHzB8QuQ0UJU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo6TQWlU2sYUUxkyJz5mMC2jAG0H66eSMFq3DJX
 w75JbfPFs+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaOk0FgAKCRAADmhBGVaC
 FQJ0D/9WNWPmLLO4vdQY5NoKnFwwhm0u6ltrQnhgYZdT2y67ARPfeTHGXMvia7cous5RuacocaJ
 aeWQrZjmxt9YVGKFaKIAnpJrdVVcwgFKfnuYB8jXpIO+gZk/4XDxBSBHiUYrI6q+HdykpSg3xRy
 8YNmMu1AcUwOOtZ00ZNY/7Y5lnYcSiLFbWz5Lv68ZQcuzXRFH1UPwJAHsEIpUNeBkConZ/ceiZ8
 /ZCpDAtHMtTxSktJKA+77TTa/LSz78Ty0hwy3V2GPBEL/qlwthezvMEMh2JFmx3EoVXpYqZhxmt
 Fjw7SYeutAqgQY7Wbl/sDYmCazuJQz98UIgbNe4ri69YncoD/RTcDfStD0rusqUMjLV5ZYCCRYQ
 RNCB80Ox5aw1bgTbpDHp+talACtar6dzw/P+CUxz4VDM5bVvxGwQLRKRNW8gWFRS0Y9zDHP+JkF
 N6IEYYWQuZkZhBV+LgSNMQ9+eA1Wqf8nSL+TLzzhc9VgZN6dYmIeuxmnjaBcO5xq8dtucOuZ+bM
 BqCNMXZHRQQZDIQA4CREugSfxnQpyDDZaMgBGNroDTSItJps67WzkS98YLWCa2Mt5QHHx6bzSKT
 4qMNaybGEmsnN5yPdmiLtXUcCLTMRpRRJvbJWglOgrfyA6GU5F8Xiwpv/0oNrmnDTwupxUJJpCx
 hLR9jbRykOo4kTA==
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
for the record marker.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This fixes the same problem in an alternate way -- by adding a separate
new bvec array to the svc_sock for sending purposes.
---
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
 net/sunrpc/svcsock.c           | 28 +++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

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
index 7b90abc5cf0ee1520796b2f38fcb977417009830..09ba65ba2e805b20044a7c27ee028bbeeaf5e44b 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -730,6 +730,12 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	unsigned int count;
 	int err;
 
+	if (!svsk->sk_bvec) {
+		svsk->sk_bvec = kcalloc(rqstp->rq_maxpages, sizeof(*svsk->sk_bvec), GFP_KERNEL);
+		if (!svsk->sk_bvec)
+			return -ENOMEM;
+	}
+
 	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
 	rqstp->rq_xprt_ctxt = NULL;
 
@@ -740,14 +746,14 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
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
@@ -1235,19 +1241,19 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
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
@@ -1272,6 +1278,13 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
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
 
@@ -1636,5 +1649,6 @@ static void svc_sock_free(struct svc_xprt *xprt)
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


