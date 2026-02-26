Return-Path: <linux-nfs+bounces-19284-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIHOMB5doGm3igQAu9opvQ
	(envelope-from <linux-nfs+bounces-19284-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:47:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8461A7D96
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3B12302D1AC
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B3539B4AD;
	Thu, 26 Feb 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg5XkS37"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E438A70D
	for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117267; cv=none; b=WRh839fk//wmPgOzsCwoGhU1XgPgVMsrCc0SWcM0k+a/9TQ3usB7CTIM0m2/ScDDqqZe2YnKwhRSBWsTz0TDie6JSYGOEhNGZHDOiwE0CZ09KvrpPVLionTR+lSKW+CMv1zlNP8bpXf06LF9p5KZB/A37ZEpeGFI02Pp8reS318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117267; c=relaxed/simple;
	bh=iJ/ZqGl+ymh1ROgtNUxF+X2fYhYML8LYJ5PrvDpRW2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S98XdGRPTYG2Zx0s8Hl7VcqDaEXLy/+SaPUKH6GJQWEB5pNvi7Z/CaDdkmlizWYnmzSetoh/lU5ubxjJCg0WLNWMlX6DCpX44L6ZuLgMD1kKX4DQ2J3gr0jsfbegT0O5WBqOB+x2pCyCqwZPqH2VNW3DTgIJPhLOGKpyFnWlY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg5XkS37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371E8C19424;
	Thu, 26 Feb 2026 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772117266;
	bh=iJ/ZqGl+ymh1ROgtNUxF+X2fYhYML8LYJ5PrvDpRW2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jg5XkS37O9+Tkq9m60xUplsvLz+q08NRNk370/hgaUNycFB60Fgs0jZT9j4vBV2zJ
	 eh139q0wgNznDRMPHR0N+9DPv2ckHUtQPehW7yhVIrm1TX2MiDU86UM8Pr5JAN+9+w
	 TO1BzwzfA11swWvs0jomP+y8EQjKxQe3hJCopGBHgM/d7iivHaXNpeoTAGXzzY3N3Y
	 Xv6CiOVlbbUsVtBNlpBpVnbndLVcPGPN8QZzJXJrxBCg9xda2QZyLrjroIlMAoOmzn
	 78BPJnr9gjRESrrE4wJzAMVue7yciNr28+sNIzAPa47nPXeOrI3wXcsijxJZ35lZ5p
	 TRE4qUuP1Pd3Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 5/6] SUNRPC: Track consumed rq_pages entries
Date: Thu, 26 Feb 2026 09:47:38 -0500
Message-ID: <20260226144739.193129-6-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226144739.193129-1-cel@kernel.org>
References: <20260226144739.193129-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19284-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: AC8461A7D96
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The rq_pages array holds pages allocated for incoming RPC requests.
Two transport receive paths NULL entries in rq_pages to prevent
svc_rqst_release_pages() from freeing pages that the transport has
taken ownership of:

- svc_tcp_save_pages() moves partial request data pages to
  svsk->sk_pages during multi-fragment TCP reassembly.

- svc_rdma_clear_rqst_pages() moves request data pages to
  head->rc_pages because they are targets of active RDMA Read WRs.

A new rq_pages_nfree field in struct svc_rqst records how many
entries were NULLed. svc_alloc_arg() uses it to refill only those
entries rather than scanning the full rq_pages array. In steady
state, the transport NULLs a handful of entries per RPC, so the
allocator visits only those entries instead of the full ~259 slots
(for 1MB messages).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h        | 10 ++++++++++
 net/sunrpc/svc.c                  |  1 +
 net/sunrpc/svc_xprt.c             | 11 ++++++++---
 net/sunrpc/svcsock.c              |  1 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c |  1 +
 5 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 3559de664f64..b5a842dd97a4 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -143,6 +143,15 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  * server thread needs to allocate more to replace those used in
  * sending.
  *
+ * rq_pages request page contract:
+ *
+ * Transport receive paths that move request data pages out of
+ * rq_pages -- TCP multi-fragment reassembly (svc_tcp_save_pages)
+ * and RDMA Read I/O (svc_rdma_clear_rqst_pages) -- NULL those
+ * entries to prevent svc_rqst_release_pages() from freeing pages
+ * still in transport use, and set rq_pages_nfree to the count.
+ * svc_alloc_arg() refills only that many rq_pages entries.
+ *
  * xdr_buf holds responses; the structure fits NFS read responses
  * (header, data pages, optional tail) and enables sharing of
  * client-side routines.
@@ -201,6 +210,7 @@ struct svc_rqst {
 	struct folio		*rq_scratch_folio;
 	struct xdr_buf		rq_res;
 	unsigned long		rq_maxpages;	/* entries per page array */
+	unsigned long		rq_pages_nfree;	/* rq_pages entries NULLed by transport */
 	struct page *		*rq_pages;	/* Call buffer pages */
 	struct page *		*rq_respages;	/* Reply buffer pages */
 	struct page *		*rq_next_page; /* next reply page to use */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 0ce16e9abdf6..6e57e35fa6d6 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -655,6 +655,7 @@ svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int node)
 		return false;
 	}
 
+	rqstp->rq_pages_nfree = rqstp->rq_maxpages;
 	return true;
 }
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index e027765f4307..795b5729525f 100644
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
index c86f28f720f7..2ce43f9995f1 100644
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


