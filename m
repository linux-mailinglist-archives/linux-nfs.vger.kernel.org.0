Return-Path: <linux-nfs+bounces-18855-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJbbODNei2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18855-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:34:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6FA11D443
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B267630792E5
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EADD30CD80;
	Tue, 10 Feb 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgVy3aQz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C02D979C;
	Tue, 10 Feb 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741157; cv=none; b=HyOb1yPj2NgwljHZVsDhtO6gXiF5Vl4DjafFiCXU2sdztvYZSIX+iQe/9+QvSufM72q/8LiMG4UlQbyZxAv4p4ayS+ThiYrPoHrRCeGNmbOEGAzzuVK1lBxY/CdHLXO3gY76kY1y6BUMMO7GzY1Yh2mskMSu6nDHccJuphr6T0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741157; c=relaxed/simple;
	bh=9iErFTe+c80KQiPh8xhSURjvOJ75fmH4jJ/6sW2XHNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmhsmWtCO5WyohRTuO41QGqttDuOL99FI6/nlKAOf9Y8b6gtYO+AjD6VVLrUDfCaaLZd+agLq09HO9eXhTIDA/VwTdEKshyiNPohCGwP/0fvW91DrcCxqSUnVA70LbijOC5TtCn1OyxBCNhALPbkoiY6md7IxHbYg/E8pQJPiRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgVy3aQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3A5C116C6;
	Tue, 10 Feb 2026 16:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741156;
	bh=9iErFTe+c80KQiPh8xhSURjvOJ75fmH4jJ/6sW2XHNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgVy3aQzSRvNgW3AxWhWLcXnR2C/xAotczstl9MfXVQTa/0KxOeFzS5/+8p/hOVBe
	 Wtl02oUHEnbpobFWZhtIquIQU1Ojgpt9Fcm+Wu6/LE1iMy+b9JbaeUgAqlS2lA9hdh
	 L+0m0UnmBQTgYwBwRNi3ioCFmvMey2R3Wyhj0l0FFZHwKwPEtrN88/GDGpzkz+w2LW
	 NCJOlkoLMJnsynarUWIxMZBsmpBMi+1JvuUBmNl66ochjvmQNmH7SEv/Yiz/dMzHWe
	 0NNr04n0ktDLD9u99fk3XQr5KESuR+XmvalSNvOaMw/0zqNzo7U3Y3NpFJVEiHFQ3q
	 WC/5DCJrG5sRA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 12/15] svcrdma: Add per-recv_ctxt chunk context cache
Date: Tue, 10 Feb 2026 11:32:19 -0500
Message-ID: <20260210163222.2356793-13-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210163222.2356793-1-cel@kernel.org>
References: <20260210163222.2356793-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18855-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 7C6FA11D443
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
 net/sunrpc/xprtrdma/svc_rdma_pcl.c      | 55 +++++++++++++++++++++----
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 10 +++--
 4 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 8e78f958fa46..2164504093fd 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -204,6 +204,8 @@ struct svc_rdma_chunk_ctxt {
 
 struct svc_rdma_recv_ctxt {
 	struct llist_node	rc_node;
+	struct svcxprt_rdma	*rc_rdma;
+	struct svc_rdma_chunk	*rc_chunk_cache;
 	struct ib_recv_wr	rc_recv_wr;
 	struct ib_cqe		rc_cqe;
 	struct rpc_rdma_cid	rc_cid;
diff --git a/include/linux/sunrpc/svc_rdma_pcl.h b/include/linux/sunrpc/svc_rdma_pcl.h
index 7516ad0fae80..e23803b19e66 100644
--- a/include/linux/sunrpc/svc_rdma_pcl.h
+++ b/include/linux/sunrpc/svc_rdma_pcl.h
@@ -22,6 +22,7 @@ struct svc_rdma_chunk {
 	u32			ch_payload_length;
 
 	u32			ch_segcount;
+	u32			ch_segmax;
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
index b63cfeaa2923..079af7c633fd 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_pcl.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
@@ -9,30 +9,71 @@
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
+	struct ib_device *device = rctxt->rc_rdma->sc_cm_id->device;
 	struct svc_rdma_chunk *chunk;
 
-	chunk = kmalloc(struct_size(chunk, ch_segments, segcount), GFP_KERNEL);
+	if (segcount <= SVC_RDMA_CHUNK_SEGMAX) {
+		chunk = rctxt_chunk_get(rctxt);
+		if (chunk)
+			goto out;
+		segcount = SVC_RDMA_CHUNK_SEGMAX;
+	}
+
+	chunk = kmalloc_node(struct_size(chunk, ch_segments, segcount),
+			     GFP_KERNEL, ibdev_to_node(device));
 	if (!chunk)
 		return NULL;
+	chunk->ch_segmax = segcount;
 
+out:
 	chunk->ch_position = position;
 	chunk->ch_length = 0;
 	chunk->ch_payload_length = 0;
@@ -117,7 +158,7 @@ bool pcl_alloc_call(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
 			continue;
 
 		if (pcl_is_empty(pcl)) {
-			chunk = pcl_alloc_chunk(segcount, position);
+			chunk = pcl_alloc_chunk(rctxt, segcount, position);
 			if (!chunk)
 				return false;
 			pcl_insert_position(pcl, chunk);
@@ -172,7 +213,7 @@ bool pcl_alloc_read(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
 
 		chunk = pcl_lookup_position(pcl, position);
 		if (!chunk) {
-			chunk = pcl_alloc_chunk(segcount, position);
+			chunk = pcl_alloc_chunk(rctxt, segcount, position);
 			if (!chunk)
 				return false;
 			pcl_insert_position(pcl, chunk);
@@ -210,7 +251,7 @@ bool pcl_alloc_write(struct svc_rdma_recv_ctxt *rctxt,
 		p++;	/* skip the list discriminator */
 		segcount = be32_to_cpup(p++);
 
-		chunk = pcl_alloc_chunk(segcount, 0);
+		chunk = pcl_alloc_chunk(rctxt, segcount, 0);
 		if (!chunk)
 			return false;
 		list_add_tail(&chunk->ch_list, &pcl->cl_chunks);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 333b9468a15b..b48ef78c79c2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -122,6 +122,7 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 			    GFP_KERNEL, ibdev_to_node(device));
 	if (!ctxt)
 		goto fail0;
+	ctxt->rc_rdma = rdma;
 	ctxt->rc_maxpages = pages;
 	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL,
 			      ibdev_to_node(device));
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
2.52.0


