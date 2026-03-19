Return-Path: <linux-nfs+bounces-20269-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMy5Guz7u2mzqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-20269-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 14:36:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC632CC12F
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 14:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E98D30C1FBB
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B210B3D34AB;
	Thu, 19 Mar 2026 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EahVUt1T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F877348466;
	Thu, 19 Mar 2026 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927373; cv=none; b=lYuiQ3xTpCKSjV1Qtb9Ou7TeE0EpVGnl+wiOE5pGPjBMha/oJafMWN2hQWGwSB4cXbkRXFzFiQHFpESb53URucbAzsOhVbAvLdQwwHq91HwSW1Swe3JSuSIAf+9TcoOITXh0LucPxi1NVjXRxZQ+7bKGtrrwCyG+szKy1EP/XRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927373; c=relaxed/simple;
	bh=HrXm2fOkmAYdTHoubW+Na9hTy6HG5eNa1hvtG99SJKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mibxM5K6tpMX3IblYIKWwUe8rW8fQtbq4no15wHWZU6hl2ofQzQnwI4y7FtnV9RV0zX/qvzGes+jOs5Wge4v0ERt2n02qNzjethO/P3fZbtZFQYxUUr3CeIjXbodl05UfLrAeLQWHpyJ2d4B0ISqrFTj3hQBXDQ8ltwr1eIpFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EahVUt1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF79C19424;
	Thu, 19 Mar 2026 13:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773927373;
	bh=HrXm2fOkmAYdTHoubW+Na9hTy6HG5eNa1hvtG99SJKQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EahVUt1TTieMvQoZz4tLLu2houeUoX2STWjTl+uJMun1DKna3BYqTp0d4E3IeLDf6
	 CLSLNjX75wAihRMT+g1JQP/NHSbzRRcdgsTSIQSX+cunp2UIPV4Prhw8KWXlFbTI88
	 74T5QNZKdO2GuX2W4R24GirYv13SseE06HzrBfR7h/F1jQbCoPudaMnrSR4783UX6n
	 ZV79VLHM/V4zE9/nOD9ex/jvTvm1Ay3Xr51ryTdHsvGNkv5GxFipIPmgJvzMVo/pbN
	 wuzBc405r+edb0z5ONKezciOj9+1rtcmMfeGpXQobJruhSEdwd7WHvaGwkmVgao72l
	 fJhpx4nwXydMw==
From: Chuck Lever <cel@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4] svcrdma: Use contiguous pages for RDMA Read sink buffers
Date: Thu, 19 Mar 2026 09:36:10 -0400
Message-ID: <20260319133610.2556826-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-20269-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,lst.de,ownmail.net,redhat.com,oracle.com,talpey.com];
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
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: BEC632CC12F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

svc_rdma_build_read_segment() constructs RDMA Read sink
buffers by consuming pages one-at-a-time from rq_pages[]
and building one bvec per page. A 64KB NFS READ payload
produces 16 separate bvecs, 16 DMA mappings, and
potentially multiple RDMA Read WRs (on platforms with
4KB pages).

A single higher-order allocation followed by split_page()
yields physically contiguous memory while preserving
per-page refcounts. A single bvec spanning the contiguous
range causes rdma_rw_ctx_init_bvec() to take the
rdma_rw_init_single_wr_bvec() fast path: one DMA mapping,
one SGE, one WR.

The split sub-pages replace the original rq_pages[] entries,
so all downstream page tracking, completion handling, and
xdr_buf assembly remain unchanged.

Allocation uses __GFP_NORETRY | __GFP_NOWARN and falls back
through decreasing orders. If even order-1 fails, the
existing per-page path handles the segment.

When nr_pages is not a power of two, get_order() rounds up
and the allocation yields more pages than needed. The extra
split pages replace existing rq_pages[] entries (freed via
put_page() first), so there is no net increase in per-
request page consumption. Successive segments reuse the
same padding slots, preventing accumulation. The
rq_maxpages guard rejects any allocation that would
overrun the array, falling back to the per-page path.
Under memory pressure, __GFP_NORETRY causes the higher-
order allocation to fail without stalling.

The contiguous path is attempted when the segment starts
page-aligned (rc_pageoff == 0) and spans at least two
pages. NFS WRITE segments carry application-modified byte
ranges of arbitrary length, so the optimization is not
restricted to power-of-two page counts.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
Changes since v3:
- Drop 1/3 - 3/3, they have already been reviewed and queued
- Incorporate hch's review comments
- Remove the #ifdef SZ_64K -- the logic works on those systems too


 net/sunrpc/xprtrdma/svc_rdma_rw.c | 213 ++++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 9e17700fae2a..2b598aaa646f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -754,6 +754,211 @@ int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 	return xdr->len;
 }
 
+/*
+ * Cap contiguous RDMA Read sink allocations at order-4.
+ * Higher orders risk allocation failure under
+ * __GFP_NORETRY, which would negate the benefit of the
+ * contiguous fast path.
+ */
+#define SVC_RDMA_CONTIG_MAX_ORDER	4
+
+/**
+ * svc_rdma_alloc_read_pages - Allocate physically contiguous pages
+ * @nr_pages: number of pages needed
+ * @order: on success, set to the allocation order
+ *
+ * Attempts a higher-order allocation, falling back to smaller orders.
+ * The returned pages are split immediately so each sub-page has its
+ * own refcount and can be freed independently.
+ *
+ * Returns a pointer to the first page on success, or NULL if even
+ * order-1 allocation fails.
+ */
+static struct page *
+svc_rdma_alloc_read_pages(unsigned int nr_pages, unsigned int *order)
+{
+	unsigned int o;
+	struct page *page;
+
+	o = min(get_order(nr_pages << PAGE_SHIFT),
+		SVC_RDMA_CONTIG_MAX_ORDER);
+
+	while (o >= 1) {
+		page = alloc_pages(GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN,
+				   o);
+		if (page) {
+			split_page(page, o);
+			*order = o;
+			return page;
+		}
+		o--;
+	}
+	return NULL;
+}
+
+/*
+ * svc_rdma_fill_contig_bvec - Replace rq_pages with a contiguous allocation
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
+ * @bv: bvec entry to fill
+ * @pages_left: number of data pages remaining in the segment
+ * @len_left: bytes remaining in the segment
+ *
+ * On success, fills @bv with a bvec spanning the contiguous range and
+ * advances rc_curpage/rc_page_count. Returns the byte length covered,
+ * or zero if the allocation failed or would overrun rq_maxpages.
+ */
+static unsigned int
+svc_rdma_fill_contig_bvec(struct svc_rqst *rqstp,
+			  struct svc_rdma_recv_ctxt *head,
+			  struct bio_vec *bv, unsigned int pages_left,
+			  unsigned int len_left)
+{
+	unsigned int order, alloc_nr, chunk_pages, chunk_len, i;
+	struct page *page;
+
+	page = svc_rdma_alloc_read_pages(pages_left, &order);
+	if (!page)
+		return 0;
+	alloc_nr = 1 << order;
+
+	if (head->rc_curpage + alloc_nr > rqstp->rq_maxpages) {
+		for (i = 0; i < alloc_nr; i++)
+			__free_page(page + i);
+		return 0;
+	}
+
+	for (i = 0; i < alloc_nr; i++) {
+		svc_rqst_page_release(rqstp,
+				      rqstp->rq_pages[head->rc_curpage + i]);
+		rqstp->rq_pages[head->rc_curpage + i] = page + i;
+	}
+
+	chunk_pages = min(alloc_nr, pages_left);
+	chunk_len = min_t(unsigned int, chunk_pages << PAGE_SHIFT, len_left);
+	bvec_set_page(bv, page, chunk_len, 0);
+	head->rc_page_count += chunk_pages;
+	head->rc_curpage += chunk_pages;
+	return chunk_len;
+}
+
+/*
+ * svc_rdma_fill_page_bvec - Add a single rq_page to the bvec array
+ * @head: context for ongoing I/O
+ * @ctxt: R/W context whose bvec array is being filled
+ * @cur: page to add
+ * @bvec_idx: pointer to current bvec index, not advanced on merge
+ * @len_left: bytes remaining in the segment
+ *
+ * If @cur is physically contiguous with the preceding bvec, it is
+ * merged by extending that bvec's length. Otherwise a new bvec
+ * entry is created. Returns the byte length covered.
+ */
+static unsigned int
+svc_rdma_fill_page_bvec(struct svc_rdma_recv_ctxt *head,
+			struct svc_rdma_rw_ctxt *ctxt, struct page *cur,
+			unsigned int *bvec_idx, unsigned int len_left)
+{
+	unsigned int chunk_len = min_t(unsigned int, PAGE_SIZE, len_left);
+
+	head->rc_page_count++;
+	head->rc_curpage++;
+
+	if (*bvec_idx > 0) {
+		struct bio_vec *prev = &ctxt->rw_bvec[*bvec_idx - 1];
+
+		if (page_to_phys(prev->bv_page) + prev->bv_offset +
+		    prev->bv_len == page_to_phys(cur)) {
+			prev->bv_len += chunk_len;
+			return chunk_len;
+		}
+	}
+
+	bvec_set_page(&ctxt->rw_bvec[*bvec_idx], cur, chunk_len, 0);
+	(*bvec_idx)++;
+	return chunk_len;
+}
+
+/**
+ * svc_rdma_build_read_segment_contig - Build RDMA Read WR with contiguous pages
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
+ * @segment: co-ordinates of remote memory to be read
+ *
+ * Greedily allocates higher-order pages to cover the segment,
+ * building one bvec per contiguous chunk. Each allocation is
+ * split so sub-pages have independent refcounts. When a
+ * higher-order allocation fails, remaining pages are covered
+ * individually, merging adjacent pages into the preceding bvec
+ * when they are physically contiguous. The split sub-pages
+ * replace entries in rq_pages[] so downstream cleanup is
+ * unchanged.
+ *
+ * Returns:
+ *   %0: the Read WR was constructed successfully
+ *   %-ENOMEM: allocation failed
+ *   %-EIO: a DMA mapping error occurred
+ */
+static int svc_rdma_build_read_segment_contig(struct svc_rqst *rqstp,
+					      struct svc_rdma_recv_ctxt *head,
+					      const struct svc_rdma_segment *segment)
+{
+	struct svcxprt_rdma *rdma = svc_rdma_rqst_rdma(rqstp);
+	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
+	unsigned int nr_data_pages, bvec_idx;
+	struct svc_rdma_rw_ctxt *ctxt;
+	unsigned int len_left;
+	int ret;
+
+	nr_data_pages = PAGE_ALIGN(segment->rs_length) >> PAGE_SHIFT;
+	if (head->rc_curpage + nr_data_pages > rqstp->rq_maxpages)
+		return -ENOMEM;
+
+	ctxt = svc_rdma_get_rw_ctxt(rdma, nr_data_pages);
+	if (!ctxt)
+		return -ENOMEM;
+
+	bvec_idx = 0;
+	len_left = segment->rs_length;
+	while (len_left) {
+		unsigned int pages_left = PAGE_ALIGN(len_left) >> PAGE_SHIFT;
+		unsigned int chunk_len = 0;
+
+		if (pages_left >= 2)
+			chunk_len = svc_rdma_fill_contig_bvec(rqstp, head,
+							      &ctxt->rw_bvec[bvec_idx],
+							      pages_left, len_left);
+		if (chunk_len) {
+			bvec_idx++;
+		} else {
+			struct page *cur =
+				rqstp->rq_pages[head->rc_curpage];
+			chunk_len = svc_rdma_fill_page_bvec(head, ctxt, cur,
+							    &bvec_idx,
+							    len_left);
+		}
+
+		len_left -= chunk_len;
+	}
+
+	ctxt->rw_nents = bvec_idx;
+
+	head->rc_pageoff = offset_in_page(segment->rs_length);
+	if (head->rc_pageoff)
+		head->rc_curpage--;
+
+	ret = svc_rdma_rw_ctx_init(rdma, ctxt, segment->rs_offset,
+				   segment->rs_handle, segment->rs_length,
+				   DMA_FROM_DEVICE);
+	if (ret < 0)
+		return -EIO;
+	percpu_counter_inc(&svcrdma_stat_read);
+
+	list_add(&ctxt->rw_list, &cc->cc_rwctxts);
+	cc->cc_sqecount += ret;
+	return 0;
+}
+
 /**
  * svc_rdma_build_read_segment - Build RDMA Read WQEs to pull one RDMA segment
  * @rqstp: RPC transaction context
@@ -780,6 +985,14 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
 	if (check_add_overflow(head->rc_pageoff, len, &total))
 		return -EINVAL;
 	nr_bvec = PAGE_ALIGN(total) >> PAGE_SHIFT;
+
+	if (head->rc_pageoff == 0 && nr_bvec >= 2) {
+		ret = svc_rdma_build_read_segment_contig(rqstp, head,
+							 segment);
+		if (ret != -ENOMEM)
+			return ret;
+	}
+
 	ctxt = svc_rdma_get_rw_ctxt(rdma, nr_bvec);
 	if (!ctxt)
 		return -ENOMEM;
-- 
2.53.0


