Return-Path: <linux-nfs+bounces-19095-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOwVBsosm2llugMAu9opvQ
	(envelope-from <linux-nfs+bounces-19095-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 17:20:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7416F9D7
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 17:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22D1F301440F
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346D14EC73;
	Sun, 22 Feb 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS9e/Ts9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E556A3D3B3
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771777211; cv=none; b=rLEoaIGHU2udPuhHI4bM4LeqD3Zw2NyGtZUuFXclFj3RWxSRq5NWpLWD9U2UcyLi1GV3YgeYjiMNikaEksuW9CD2SkSZvVWnxFc9k2UYfERwWYIM8n88my9nP67nSntkTCjhChxhP41SkPyeqE4qdSOPPY2A3AFNLPLZrpPkyJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771777211; c=relaxed/simple;
	bh=C6IVUnCGEmdjlbMbMbDB99NkvMyR5R0D1nuagejGRxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5Q2RS25J6PNg1NrSj3CnE+qMoCn/UCO5uX5JA2jNqNf08Iz4/HXlkmA3PrxWsZ2eibwpag4D3hs/DW369WDL41l1282uV73t45hGMstb0Mtihoq8Z4LlbZQEcbT6WzfqiQSFDsuK7+V9gA8ncrt4NOuNrpjmIhn/kj2hGSqcrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS9e/Ts9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A3AC116D0;
	Sun, 22 Feb 2026 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771777210;
	bh=C6IVUnCGEmdjlbMbMbDB99NkvMyR5R0D1nuagejGRxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jS9e/Ts9Uks//tKoy/P6EdMEhG3dJoGAKR6TDuWJbH7dZtpC6d1HDksQ1I4A5fO9C
	 C3808GvyCO/TbQYMeqWWmSNKkYYVVYgBjOKpnCzB6T/rVHNUcxkxGHD0ZeWrjpQcls
	 NwXOsaeX5ThZFgP6AwUaiXwbIIodRIurcKbcW6oRd/1YpyEJxzHlSgQI+7n+aKKb6m
	 r0nUPMefEZfFlms9B/DYy5/JCP2goKhyqTBpYpNj4OyJIS9t+L2gzFsBfLO4QRSBmq
	 lQX2+yWDokAJsFgTsopYzQ5Favbs5nWSQzj1lHwRaFDPWFNuEwcNheDJq2PvgmPuw1
	 qlchnx6ja2/lw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 5/6] sunrpc: Track consumed rq_pages entries
Date: Sun, 22 Feb 2026 11:20:01 -0500
Message-ID: <20260222162002.10613-6-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222162002.10613-1-cel@kernel.org>
References: <20260222162002.10613-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19095-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DB7416F9D7
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Transports that consume pages from the rq_pages array --
svc_tcp_save_pages() for TCP fragment reassembly and
svc_rdma_clear_rqst_pages() for RDMA Read I/O -- NULL
the consumed entries starting at rq_pages[0]. A new
rq_pages_nfree field in struct svc_rqst records the
count of entries consumed.

svc_alloc_arg() uses rq_pages_nfree to refill only
the consumed entries rather than scanning the full
rq_pages array. In steady state, the transport consume
path NULLs a handful of entries per RPC, so the
allocator visits only those entries instead of the
full ~259 slots (for 1MB messages).

svc_init_buffer() initializes rq_pages_nfree to
rq_maxpages so that the first svc_alloc_arg() call
populates every entry.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h        |  8 ++++++++
 net/sunrpc/svc.c                  |  1 +
 net/sunrpc/svc_xprt.c             | 11 ++++++++---
 net/sunrpc/svcsock.c              |  1 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c |  1 +
 5 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index b1fb728724f5..bb2029e396db 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -143,6 +143,13 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  * server thread needs to allocate more to replace those used in
  * sending.
  *
+ * Transport page-consumption contract:
+ *
+ * Transports that consume rq_pages entries (for TCP fragment
+ * reassembly or RDMA Read I/O) NULL entries starting at
+ * rq_pages[0] and set rq_pages_nfree to the count of entries
+ * consumed. svc_alloc_arg() refills only that many entries.
+ *
  * xdr_buf holds responses; the structure fits NFS read responses
  * (header, data pages, optional tail) and enables sharing of
  * client-side routines.
@@ -201,6 +208,7 @@ struct svc_rqst {
 	struct folio		*rq_scratch_folio;
 	struct xdr_buf		rq_res;
 	unsigned long		rq_maxpages;	/* entries per page array */
+	unsigned long		rq_pages_nfree;		/* NULL rq_pages to refill */
 	struct page *		*rq_pages;
 	struct page *		*rq_respages;	/* Reply buffer pages */
 	struct page *		*rq_next_page; /* next reply page to use */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 620de9abedbb..a8c26634ecf1 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -654,6 +654,7 @@ svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int node)
 		return false;
 	}
 
+	rqstp->rq_pages_nfree = rqstp->rq_maxpages;
 	return true;
 }
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index cd38f09c1803..9d8f6adcfe1f 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -675,12 +675,17 @@ static bool svc_fill_pages(struct svc_rqst *rqstp, struct page **pages,
 static bool svc_alloc_arg(struct svc_rqst *rqstp)
 {
 	struct xdr_buf *arg = &rqstp->rq_arg;
-	unsigned long pages;
+	unsigned long pages, nfree;
 
 	pages = rqstp->rq_maxpages;
 
-	if (!svc_fill_pages(rqstp, rqstp->rq_pages, pages))
-		return false;
+	nfree = rqstp->rq_pages_nfree;
+	if (nfree) {
+		if (!svc_fill_pages(rqstp, rqstp->rq_pages, nfree))
+			return false;
+		rqstp->rq_pages_nfree = 0;
+	}
+
 	if (!svc_fill_pages(rqstp, rqstp->rq_respages, pages))
 		return false;
 	rqstp->rq_next_page = rqstp->rq_respages;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 10a298f440cc..f9140ac8ed99 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1009,6 +1009,7 @@ static void svc_tcp_save_pages(struct svc_sock *svsk, struct svc_rqst *rqstp)
 		svsk->sk_pages[i] = rqstp->rq_pages[i];
 		rqstp->rq_pages[i] = NULL;
 	}
+	rqstp->rq_pages_nfree = npages;
 }
 
 static void svc_tcp_clear_pages(struct svc_sock *svsk)
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 4ec2f9ae06aa..cf4a1762b629 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -1107,6 +1107,7 @@ static void svc_rdma_clear_rqst_pages(struct svc_rqst *rqstp,
 		head->rc_pages[i] = rqstp->rq_pages[i];
 		rqstp->rq_pages[i] = NULL;
 	}
+	rqstp->rq_pages_nfree = head->rc_page_count;
 }
 
 /**
-- 
2.53.0


