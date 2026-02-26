Return-Path: <linux-nfs+bounces-19281-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMbzLqZeoGlViwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19281-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:54:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2811A808A
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B645A311DEF2
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 14:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C512731064E;
	Thu, 26 Feb 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjG3Y+ot"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5036E46F
	for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117264; cv=none; b=QOCWe68jlLX8PQBakhF/H75+OcUfuRAecWgJcpOv5HFPGHAQTrI7Q7qQf7Yu1gW/fM3AOSiBBljdYc2n8xSAu7ejOZontHLSab9SwL2YUXpIjMG8CgbncVreGeTQTGNbZj6ahBS2lGRHn3MhbP70gR1SmvBTtHITuCVsBt3TQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117264; c=relaxed/simple;
	bh=C4q9Sgl84jJDzeIyRkqD4WwthgXkm2hVP0z8GYnH7eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grCVXwLlhPiKu2DVHAT8SKFZKglKupuPeGJzHSDY5MrevVc5FavzQqmhVfZb52/X5YhSdDzbFXe7EHhXMLtA6nkOmh2D9bkQipX3trCRJ/wlMgZ7svLaW37yawX+wZ2CN5V3CD/nySZESd9AU8E+k16pIU0khx/CEGQ0P1iy5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjG3Y+ot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC527C116C6;
	Thu, 26 Feb 2026 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772117264;
	bh=C4q9Sgl84jJDzeIyRkqD4WwthgXkm2hVP0z8GYnH7eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjG3Y+otnllQImNVhylXdrs+CcpV0cewU3SkMAULljWD0dI2jKtraijW4tm+chX9m
	 +NML6d6/RiwJgLK5Zd6VVedkEnUh749U264U/9dJTpwaYGxeLH8bi/pMy4/c9QUAH9
	 c+wwOCwUQALLNq9s1Fh9YjXfBZfnarfZddW/JE3frVVpiczjTpqjeCeAE4zKAEJwip
	 jDjsF2znKNfMqXr9UdAS5q6KCEIDaY/ill8zHut9nM7kqD8ERPy5bJqLK4/VwO//ZA
	 bXSvDkk6dVoAjItG9Oo2sxhu3E0UuhP0hv1tCUq9TERfWkxdsm2ULJtABshUBGQj3z
	 IN7qbqNycLSFQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/6] SUNRPC: Allocate a separate Reply page array
Date: Thu, 26 Feb 2026 09:47:35 -0500
Message-ID: <20260226144739.193129-3-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19281-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 3F2811A808A
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

struct svc_rqst uses a single dynamically-allocated page array
(rq_pages) for both the incoming RPC Call message and the outgoing
RPC Reply message. rq_respages is a sliding pointer into rq_pages
that each transport receive path must compute based on how many
pages the Call consumed. This boundary tracking is a source of
confusion and bugs, and prevents an RPC transaction from having
both a large Call and a large Reply simultaneously.

Allocate rq_respages as its own page array, eliminating the boundary
arithmetic. This decouples Call and Reply buffer lifetimes,
following the precedent set by rq_bvec (a separate dynamically-
allocated array for I/O vectors).

Each svc_rqst now pins twice as many pages as before. For a server
running 16 threads with a 1MB maximum payload, the additional cost
is roughly 16MB of pinned memory. The new dynamic svc thread count
facility keeps this overhead minimal on an idle server. A subsequent
patch in this series limits per-request repopulation to only the
pages released during the previous RPC, avoiding a full-array scan
on each call to svc_alloc_arg().

Note: We've considered several alternatives to maintaining a full
second array. Each alternative reintroduces either boundary logic
complexity or I/O-path allocation pressure.

rq_next_page is initialized in svc_alloc_arg() and svc_process()
during Reply construction, and in svc_rdma_recvfrom() as a
precaution on error paths. Transport receive paths no longer compute
it from the Call size.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h              | 47 ++++++++++++-------------
 net/sunrpc/svc.c                        | 29 ++++++++++++---
 net/sunrpc/svc_xprt.c                   | 36 +++++++++++++------
 net/sunrpc/svcsock.c                    |  6 ----
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 15 +++-----
 5 files changed, 77 insertions(+), 56 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 4dc14c7a711b..3559de664f64 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -134,25 +134,24 @@ enum {
 extern u32 svc_max_payload(const struct svc_rqst *rqstp);
 
 /*
- * RPC Requests and replies are stored in one or more pages.
- * We maintain an array of pages for each server thread.
- * Requests are copied into these pages as they arrive.  Remaining
- * pages are available to write the reply into.
+ * RPC Call and Reply messages each have their own page array.
+ * rq_pages holds the incoming Call message; rq_respages holds
+ * the outgoing Reply message. Both arrays are sized to
+ * svc_serv_maxpages() entries and are allocated dynamically.
  *
- * Pages are sent using ->sendmsg with MSG_SPLICE_PAGES so each server thread
- * needs to allocate more to replace those used in sending.  To help keep track
- * of these pages we have a receive list where all pages initialy live, and a
- * send list where pages are moved to when there are to be part of a reply.
+ * Pages are sent using ->sendmsg with MSG_SPLICE_PAGES so each
+ * server thread needs to allocate more to replace those used in
+ * sending.
  *
- * We use xdr_buf for holding responses as it fits well with NFS
- * read responses (that have a header, and some data pages, and possibly
- * a tail) and means we can share some client side routines.
+ * xdr_buf holds responses; the structure fits NFS read responses
+ * (header, data pages, optional tail) and enables sharing of
+ * client-side routines.
  *
- * The xdr_buf.head kvec always points to the first page in the rq_*pages
- * list.  The xdr_buf.pages pointer points to the second page on that
- * list.  xdr_buf.tail points to the end of the first page.
- * This assumes that the non-page part of an rpc reply will fit
- * in a page - NFSd ensures this.  lockd also has no trouble.
+ * The xdr_buf.head kvec always points to the first page in the
+ * rq_*pages list. The xdr_buf.pages pointer points to the second
+ * page on that list. xdr_buf.tail points to the end of the first
+ * page. This assumes that the non-page part of an rpc reply will
+ * fit in a page - NFSd ensures this. lockd also has no trouble.
  */
 
 /**
@@ -162,10 +161,10 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  * Returns a count of pages or vectors that can hold the maximum
  * size RPC message for @serv.
  *
- * Each request/reply pair can have at most one "payload", plus two
- * pages, one for the request, and one for the reply.
- * nfsd_splice_actor() might need an extra page when a READ payload
- * is not page-aligned.
+ * Each page array can hold at most one payload plus two
+ * overhead pages (one for the RPC header, one for tail data).
+ * nfsd_splice_actor() might need an extra page when a READ
+ * payload is not page-aligned.
  */
 static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
 {
@@ -201,11 +200,11 @@ struct svc_rqst {
 	struct xdr_stream	rq_res_stream;
 	struct folio		*rq_scratch_folio;
 	struct xdr_buf		rq_res;
-	unsigned long		rq_maxpages;	/* num of entries in rq_pages */
-	struct page *		*rq_pages;
-	struct page *		*rq_respages;	/* points into rq_pages */
+	unsigned long		rq_maxpages;	/* entries per page array */
+	struct page *		*rq_pages;	/* Call buffer pages */
+	struct page *		*rq_respages;	/* Reply buffer pages */
 	struct page *		*rq_next_page; /* next reply page to use */
-	struct page *		*rq_page_end;  /* one past the last page */
+	struct page *		*rq_page_end;  /* one past the last reply page */
 
 	struct folio_batch	rq_fbatch;
 	struct bio_vec		*rq_bvec;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f7ec02457328..9abef638b1e0 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -638,13 +638,23 @@ svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int node)
 {
 	rqstp->rq_maxpages = svc_serv_maxpages(serv);
 
-	/* rq_pages' last entry is NULL for historical reasons. */
+	/* +1 for a NULL sentinel readable by nfsd_splice_actor() */
 	rqstp->rq_pages = kcalloc_node(rqstp->rq_maxpages + 1,
 				       sizeof(struct page *),
 				       GFP_KERNEL, node);
 	if (!rqstp->rq_pages)
 		return false;
 
+	/* +1 for a NULL sentinel at rq_page_end (see svc_rqst_replace_page) */
+	rqstp->rq_respages = kcalloc_node(rqstp->rq_maxpages + 1,
+					  sizeof(struct page *),
+					  GFP_KERNEL, node);
+	if (!rqstp->rq_respages) {
+		kfree(rqstp->rq_pages);
+		rqstp->rq_pages = NULL;
+		return false;
+	}
+
 	return true;
 }
 
@@ -656,10 +666,19 @@ svc_release_buffer(struct svc_rqst *rqstp)
 {
 	unsigned long i;
 
-	for (i = 0; i < rqstp->rq_maxpages; i++)
-		if (rqstp->rq_pages[i])
-			put_page(rqstp->rq_pages[i]);
-	kfree(rqstp->rq_pages);
+	if (rqstp->rq_pages) {
+		for (i = 0; i < rqstp->rq_maxpages; i++)
+			if (rqstp->rq_pages[i])
+				put_page(rqstp->rq_pages[i]);
+		kfree(rqstp->rq_pages);
+	}
+
+	if (rqstp->rq_respages) {
+		for (i = 0; i < rqstp->rq_maxpages; i++)
+			if (rqstp->rq_respages[i])
+				put_page(rqstp->rq_respages[i]);
+		kfree(rqstp->rq_respages);
+	}
 }
 
 static void
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 56a663b8939f..e027765f4307 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -650,14 +650,13 @@ static void svc_check_conn_limits(struct svc_serv *serv)
 	}
 }
 
-static bool svc_alloc_arg(struct svc_rqst *rqstp)
+static bool svc_fill_pages(struct svc_rqst *rqstp, struct page **pages,
+			   unsigned long npages)
 {
-	struct xdr_buf *arg = &rqstp->rq_arg;
-	unsigned long pages, filled, ret;
+	unsigned long filled, ret;
 
-	pages = rqstp->rq_maxpages;
-	for (filled = 0; filled < pages; filled = ret) {
-		ret = alloc_pages_bulk(GFP_KERNEL, pages, rqstp->rq_pages);
+	for (filled = 0; filled < npages; filled = ret) {
+		ret = alloc_pages_bulk(GFP_KERNEL, npages, pages);
 		if (ret > filled)
 			/* Made progress, don't sleep yet */
 			continue;
@@ -667,11 +666,29 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
 			set_current_state(TASK_RUNNING);
 			return false;
 		}
-		trace_svc_alloc_arg_err(pages, ret);
+		trace_svc_alloc_arg_err(npages, ret);
 		memalloc_retry_wait(GFP_KERNEL);
 	}
-	rqstp->rq_page_end = &rqstp->rq_pages[pages];
-	rqstp->rq_pages[pages] = NULL; /* this might be seen in nfsd_splice_actor() */
+	return true;
+}
+
+static bool svc_alloc_arg(struct svc_rqst *rqstp)
+{
+	struct xdr_buf *arg = &rqstp->rq_arg;
+	unsigned long pages;
+
+	pages = rqstp->rq_maxpages;
+
+	if (!svc_fill_pages(rqstp, rqstp->rq_pages, pages))
+		return false;
+	if (!svc_fill_pages(rqstp, rqstp->rq_respages, pages))
+		return false;
+	rqstp->rq_next_page = rqstp->rq_respages;
+	rqstp->rq_page_end = &rqstp->rq_respages[pages];
+	/* svc_rqst_replace_page() dereferences *rq_next_page even
+	 * at rq_page_end; NULL prevents releasing a garbage page.
+	 */
+	rqstp->rq_page_end[0] = NULL;
 
 	/* Make arg->head point to first page and arg->pages point to rest */
 	arg->head[0].iov_base = page_address(rqstp->rq_pages[0]);
@@ -1277,7 +1294,6 @@ static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
 	rqstp->rq_addrlen     = dr->addrlen;
 	/* Save off transport header len in case we get deferred again */
 	rqstp->rq_daddr       = dr->daddr;
-	rqstp->rq_respages    = rqstp->rq_pages;
 	rqstp->rq_xprt_ctxt   = dr->xprt_ctxt;
 
 	dr->xprt_ctxt = NULL;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index f28c6076f7e8..c86f28f720f7 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -351,8 +351,6 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 
 	for (i = 0, t = 0; t < buflen; i++, t += PAGE_SIZE)
 		bvec_set_page(&bvec[i], rqstp->rq_pages[i], PAGE_SIZE, 0);
-	rqstp->rq_respages = &rqstp->rq_pages[i];
-	rqstp->rq_next_page = rqstp->rq_respages + 1;
 
 	iov_iter_bvec(&msg.msg_iter, ITER_DEST, bvec, i, buflen);
 	if (seek) {
@@ -677,13 +675,9 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 	if (len <= rqstp->rq_arg.head[0].iov_len) {
 		rqstp->rq_arg.head[0].iov_len = len;
 		rqstp->rq_arg.page_len = 0;
-		rqstp->rq_respages = rqstp->rq_pages+1;
 	} else {
 		rqstp->rq_arg.page_len = len - rqstp->rq_arg.head[0].iov_len;
-		rqstp->rq_respages = rqstp->rq_pages + 1 +
-			DIV_ROUND_UP(rqstp->rq_arg.page_len, PAGE_SIZE);
 	}
-	rqstp->rq_next_page = rqstp->rq_respages+1;
 
 	if (serv->sv_stats)
 		serv->sv_stats->netudpcnt++;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index e7e4a39ca6c6..3081a37a5896 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -861,18 +861,12 @@ static noinline void svc_rdma_read_complete(struct svc_rqst *rqstp,
 	unsigned int i;
 
 	/* Transfer the Read chunk pages into @rqstp.rq_pages, replacing
-	 * the rq_pages that were already allocated for this rqstp.
+	 * the receive buffer pages already allocated for this rqstp.
 	 */
-	release_pages(rqstp->rq_respages, ctxt->rc_page_count);
+	release_pages(rqstp->rq_pages, ctxt->rc_page_count);
 	for (i = 0; i < ctxt->rc_page_count; i++)
 		rqstp->rq_pages[i] = ctxt->rc_pages[i];
 
-	/* Update @rqstp's result send buffer to start after the
-	 * last page in the RDMA Read payload.
-	 */
-	rqstp->rq_respages = &rqstp->rq_pages[ctxt->rc_page_count];
-	rqstp->rq_next_page = rqstp->rq_respages + 1;
-
 	/* Prevent svc_rdma_recv_ctxt_put() from releasing the
 	 * pages in ctxt::rc_pages a second time.
 	 */
@@ -931,10 +925,9 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	struct svc_rdma_recv_ctxt *ctxt;
 	int ret;
 
-	/* Prevent svc_xprt_release() from releasing pages in rq_pages
-	 * when returning 0 or an error.
+	/* Precaution: a zero page count on error return causes
+	 * svc_rqst_release_pages() to release nothing.
 	 */
-	rqstp->rq_respages = rqstp->rq_pages;
 	rqstp->rq_next_page = rqstp->rq_respages;
 
 	rqstp->rq_xprt_ctxt = NULL;
-- 
2.53.0


