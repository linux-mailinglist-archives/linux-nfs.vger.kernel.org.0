Return-Path: <linux-nfs+bounces-19409-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEo9BmWpoWm1vQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19409-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:25:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 290B11B8DE6
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFA0730FD19F
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08827264A97;
	Fri, 27 Feb 2026 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXuIUfSc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981240B6ED
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201037; cv=none; b=roGkBLqHaOjik+jM3yi2ICdbQyLvOyulzk76ol3kJv2uP9K3dw08eseLdqi+8gwAPjUOGNONcDS4djWHbi1jIIfEDtVmZSXWfrZgs/z381VQd36Vxu1TiXe6nUz88SZGNRg0too2ImcLcCiiV1t47BWO3CCoQBtUqRV0iUE7h7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201037; c=relaxed/simple;
	bh=Q9d7qXFg1x+pEO6TRb4EcZe901VhoQ4zgTmg28vUkeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a96y0oLJHBMppHtbb958rQG6MM6TzVX8rlQBxpIO147bQSrMoKND1g1UucA9h+UAwuTy292haK1F0TDYqGahujkuXaDrp4mT4Gk021+uZWOrvInq78dtzil/I+bXMxhQAlFraTwODnztEutkzdBr/m3TmiVzhc7Fd7R55TVlkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXuIUfSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A11BC19425;
	Fri, 27 Feb 2026 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201037;
	bh=Q9d7qXFg1x+pEO6TRb4EcZe901VhoQ4zgTmg28vUkeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXuIUfScPqpc3R1dVRRcGZVs5zUjTVkW+zssCqChaX95UXf6bKJTBH78WHYG1t4la
	 aNYI6+WIJqJpRyboLsn8+ycHLueCrkFovRBIWYb66N6XyAOkPaJ5T8kPLU2KJaCU+z
	 Sz2TAvj/ZLi831sZNyPfEYjTVmS+/Uda0Ad7kN6jgfyJNGXiR0qlMMKctPiX7G9XCE
	 poqtBdU99Yc+u92P5W8V7JacsA9kEyQeBWbIBnHqWFPrOxDJ9UK0TqMdSl2euy5jZq
	 3jb8xKr0ZBXkzzkhVzTisXScutkX7wf9DKt3mEDHWzkxhiNh0DOiR9HqC6Hc3ANb5+
	 +vkUxOBj1unEQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 12/18] svcrdma: Add per-recv_ctxt chunk context cache
Date: Fri, 27 Feb 2026 09:03:39 -0500
Message-ID: <20260227140345.40488-13-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227140345.40488-1-cel@kernel.org>
References: <20260227140345.40488-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19409-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 290B11B8DE6
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Parsed chunk list (PCL) processing currently allocates a new
svc_rdma_chunk structure via kmalloc for each chunk in every
incoming RPC. These allocations add overhead to the receive path.

Introduce a per-recv_ctxt single-entry cache. Over 99% of RPC Calls
that specify RPC/RDMA chunks provide only a single chunk, so a
single cached chunk handles the common case. Chunks with up to
SVC_RDMA_CHUNK_SEGMAX (4) segments are eligible for caching; larger
chunks fall back to dynamic allocation.

Using per-recv_ctxt caching instead of a per-transport pool avoids
the need for locking or atomic operations, since a recv_ctxt is
used by only one thread at a time.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |  2 +
 include/linux/sunrpc/svc_rdma_pcl.h     | 12 +++++-
 net/sunrpc/xprtrdma/svc_rdma_pcl.c      | 52 ++++++++++++++++++++++---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 10 +++--
 4 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index ef52af656581..2233dec2ae7d 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -225,6 +225,8 @@ struct svc_rdma_chunk_ctxt {
 
 struct svc_rdma_recv_ctxt {
 	struct llist_node	rc_node;
+	struct svcxprt_rdma	*rc_rdma;
+	struct svc_rdma_chunk	*rc_chunk_cache;
 	struct ib_recv_wr	rc_recv_wr;
 	struct ib_cqe		rc_cqe;
 	struct rpc_rdma_cid	rc_cid;
diff --git a/include/linux/sunrpc/svc_rdma_pcl.h b/include/linux/sunrpc/svc_rdma_pcl.h
index 7516ad0fae80..8afd98dc4737 100644
--- a/include/linux/sunrpc/svc_rdma_pcl.h
+++ b/include/linux/sunrpc/svc_rdma_pcl.h
@@ -22,6 +22,7 @@ struct svc_rdma_chunk {
 	u32			ch_payload_length;
 
 	u32			ch_segcount;
+	u32			ch_segmax;	/* allocated segment capacity */
 	struct svc_rdma_segment	ch_segments[];
 };
 
@@ -114,7 +115,16 @@ pcl_chunk_end_offset(const struct svc_rdma_chunk *chunk)
 
 struct svc_rdma_recv_ctxt;
 
-extern void pcl_free(struct svc_rdma_pcl *pcl);
+/*
+ * Cached chunks have capacity for this many segments.
+ * Typical clients can register up to 120KB per segment, so 4
+ * segments covers most NFS I/O operations. Larger chunks fall
+ * back to kmalloc.
+ */
+#define SVC_RDMA_CHUNK_SEGMAX		4
+
+extern void pcl_free(struct svc_rdma_recv_ctxt *rctxt,
+		     struct svc_rdma_pcl *pcl);
 extern bool pcl_alloc_call(struct svc_rdma_recv_ctxt *rctxt, __be32 *p);
 extern bool pcl_alloc_read(struct svc_rdma_recv_ctxt *rctxt, __be32 *p);
 extern bool pcl_alloc_write(struct svc_rdma_recv_ctxt *rctxt,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_pcl.c b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
index 1f8f7dad8b6f..5c13a74b1f9e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_pcl.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
@@ -9,30 +9,70 @@
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
 
+static struct svc_rdma_chunk *rctxt_chunk_get(struct svc_rdma_recv_ctxt *rctxt)
+{
+	struct svc_rdma_chunk *chunk = rctxt->rc_chunk_cache;
+
+	if (chunk)
+		rctxt->rc_chunk_cache = NULL;
+	return chunk;
+}
+
+static void rctxt_chunk_put(struct svc_rdma_recv_ctxt *rctxt,
+			    struct svc_rdma_chunk *chunk)
+{
+	if (rctxt->rc_chunk_cache) {
+		kfree(chunk);
+		return;
+	}
+	rctxt->rc_chunk_cache = chunk;
+}
+
+static void rctxt_chunk_free(struct svc_rdma_recv_ctxt *rctxt,
+			     struct svc_rdma_chunk *chunk)
+{
+	if (chunk->ch_segmax == SVC_RDMA_CHUNK_SEGMAX)
+		rctxt_chunk_put(rctxt, chunk);
+	else
+		kfree(chunk);
+}
+
 /**
  * pcl_free - Release all memory associated with a parsed chunk list
+ * @rctxt: receive context containing @pcl
  * @pcl: parsed chunk list
  *
  */
-void pcl_free(struct svc_rdma_pcl *pcl)
+void pcl_free(struct svc_rdma_recv_ctxt *rctxt, struct svc_rdma_pcl *pcl)
 {
 	while (!list_empty(&pcl->cl_chunks)) {
 		struct svc_rdma_chunk *chunk;
 
 		chunk = pcl_first_chunk(pcl);
 		list_del(&chunk->ch_list);
-		kfree(chunk);
+		rctxt_chunk_free(rctxt, chunk);
 	}
 }
 
-static struct svc_rdma_chunk *pcl_alloc_chunk(u32 segcount, u32 position)
+static struct svc_rdma_chunk *pcl_alloc_chunk(struct svc_rdma_recv_ctxt *rctxt,
+					      u32 segcount, u32 position)
 {
 	struct svc_rdma_chunk *chunk;
 
+	if (segcount <= SVC_RDMA_CHUNK_SEGMAX) {
+		chunk = rctxt_chunk_get(rctxt);
+		if (chunk)
+			goto out;
+		/* Round up so all fresh allocations are cache-eligible */
+		segcount = SVC_RDMA_CHUNK_SEGMAX;
+	}
+
 	chunk = kmalloc_flex(*chunk, ch_segments, segcount);
 	if (!chunk)
 		return NULL;
+	chunk->ch_segmax = segcount;
 
+out:
 	chunk->ch_position = position;
 	chunk->ch_length = 0;
 	chunk->ch_payload_length = 0;
@@ -117,7 +157,7 @@ bool pcl_alloc_call(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
 			continue;
 
 		if (pcl_is_empty(pcl)) {
-			chunk = pcl_alloc_chunk(segcount, position);
+			chunk = pcl_alloc_chunk(rctxt, segcount, position);
 			if (!chunk)
 				return false;
 			pcl_insert_position(pcl, chunk);
@@ -172,7 +212,7 @@ bool pcl_alloc_read(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
 
 		chunk = pcl_lookup_position(pcl, position);
 		if (!chunk) {
-			chunk = pcl_alloc_chunk(segcount, position);
+			chunk = pcl_alloc_chunk(rctxt, segcount, position);
 			if (!chunk)
 				return false;
 			pcl_insert_position(pcl, chunk);
@@ -210,7 +250,7 @@ bool pcl_alloc_write(struct svc_rdma_recv_ctxt *rctxt,
 		p++;	/* skip the list discriminator */
 		segcount = be32_to_cpup(p++);
 
-		chunk = pcl_alloc_chunk(segcount, 0);
+		chunk = pcl_alloc_chunk(rctxt, segcount, 0);
 		if (!chunk)
 			return false;
 		list_add_tail(&chunk->ch_list, &pcl->cl_chunks);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index a11e845a7113..45edf57c7285 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -123,6 +123,7 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 			    GFP_KERNEL, node);
 	if (!ctxt)
 		goto fail0;
+	ctxt->rc_rdma = rdma;
 	ctxt->rc_maxpages = pages;
 	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
 	if (!buffer)
@@ -161,6 +162,7 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 static void svc_rdma_recv_ctxt_destroy(struct svcxprt_rdma *rdma,
 				       struct svc_rdma_recv_ctxt *ctxt)
 {
+	kfree(ctxt->rc_chunk_cache);
 	ib_dma_unmap_single(rdma->sc_cm_id->device, ctxt->rc_recv_sge.addr,
 			    ctxt->rc_recv_sge.length, DMA_FROM_DEVICE);
 	kfree(ctxt->rc_recv_buf);
@@ -219,10 +221,10 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 	 */
 	release_pages(ctxt->rc_pages, ctxt->rc_page_count);
 
-	pcl_free(&ctxt->rc_call_pcl);
-	pcl_free(&ctxt->rc_read_pcl);
-	pcl_free(&ctxt->rc_write_pcl);
-	pcl_free(&ctxt->rc_reply_pcl);
+	pcl_free(ctxt, &ctxt->rc_call_pcl);
+	pcl_free(ctxt, &ctxt->rc_read_pcl);
+	pcl_free(ctxt, &ctxt->rc_write_pcl);
+	pcl_free(ctxt, &ctxt->rc_reply_pcl);
 
 	llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
 }
-- 
2.53.0


