Return-Path: <linux-nfs+bounces-20411-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAG0GDoSxWkI6AQAu9opvQ
	(envelope-from <linux-nfs+bounces-20411-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:02:18 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E76EE333F43
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 12:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04BCB3182C42
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 10:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590F93E4C88;
	Thu, 26 Mar 2026 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+9wDi2V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F53E4C7E
	for <linux-nfs@vger.kernel.org>; Thu, 26 Mar 2026 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774522090; cv=none; b=TKHRn0earVYGZgI88upScNfGgylMSNJYCYA+OxQWhSKcLEa9Vf8KOnoARTiRYXbpCLQ46c4e9jgGeGyUUTpQYpRGYq+E6ci1T43vKh3JRSdcahyPwoWoPB8zYj4RyF2CPrO57y00xJIOsj1fZTxR3fuAs3gVxAFGCxpL4x2w/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774522090; c=relaxed/simple;
	bh=KDBbASYwY1Jt9g1tjqPa+0s93HJKDlMALHBY+TRuzqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8IH8d9XlbW5mGvvGac1mRQEsEJi6rZ+MQFtKat77mFK/W9OeIrL3K3AEcIELIMz3Vpt+cNbJJDb3UTdb0crQOh9bPbXWdObQyZDTBf51qmt54Mpa20Lbqi1dM8M5XjP4lh+yvrf6IKWTx40ZJCU25ef2ToicgG2nDVOgkDTpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+9wDi2V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDP/Sm6+MeU+8XN4gJgSUzN+frxmLx3rFrwpkE8Ii+s=;
	b=A+9wDi2V/u6AEZ/zRGGqRzYVYOgu2is2SC0ynrtNhWvFEAh9jBEr+n/+oPfGSNCnR1cbak
	LxATHKbvcxKjRgnG9SnhSaXShjoWlOwwSXu6BGtxfaq3Me+Rwzt7E52fYjJLMZ0HLI66WY
	W16++RtSeL1ZIPJXOuxrmbeyQHYdr3Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-2aoNTZEbMpuAFj9PGCTVWg-1; Thu,
 26 Mar 2026 06:48:03 -0400
X-MC-Unique: 2aoNTZEbMpuAFj9PGCTVWg-1
X-Mimecast-MFC-AGG-ID: 2aoNTZEbMpuAFj9PGCTVWg_1774522080
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BE531956065;
	Thu, 26 Mar 2026 10:48:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC011180075D;
	Thu, 26 Mar 2026 10:47:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 13/26] netfs: Add some tools for managing bvecq chains
Date: Thu, 26 Mar 2026 10:45:28 +0000
Message-ID: <20260326104544.509518-14-dhowells@redhat.com>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20411-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,manguebit.org:email,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E76EE333F43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Provide a selection of tools for managing bvec queue chains.  This
includes:

 (1) Allocation, prepopulation, expansion, shortening and refcounting of
     bvecqs and bvecq chains.

     This can be used to do things like creating an encryption buffer in
     cifs or a directory content buffer in afs.  The memory segments will
     be appropriate disposed off according to the flags on the bvecq.

 (2) Management of a bvecq chain as a rolling buffer and the management of
     positions within it.

 (3) Loading folios, slicing chains and clearing content.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/Makefile            |   1 +
 fs/netfs/bvecq.c             | 706 +++++++++++++++++++++++++++++++++++
 fs/netfs/internal.h          |   1 +
 fs/netfs/stats.c             |   4 +-
 include/linux/bvecq.h        | 165 +++++++-
 include/linux/iov_iter.h     |   4 +-
 include/linux/netfs.h        |   1 +
 include/trace/events/netfs.h |  24 ++
 lib/iov_iter.c               |  16 +-
 lib/scatterlist.c            |   4 +-
 lib/tests/kunit_iov_iter.c   |  18 +-
 11 files changed, 919 insertions(+), 25 deletions(-)
 create mode 100644 fs/netfs/bvecq.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index b43188d64bd8..e1f12ecb5abf 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -3,6 +3,7 @@
 netfs-y := \
 	buffered_read.o \
 	buffered_write.o \
+	bvecq.o \
 	direct_read.o \
 	direct_write.o \
 	iterator.o \
diff --git a/fs/netfs/bvecq.c b/fs/netfs/bvecq.c
new file mode 100644
index 000000000000..c71646ea5243
--- /dev/null
+++ b/fs/netfs/bvecq.c
@@ -0,0 +1,706 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Buffering helpers for bvec queues
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include "internal.h"
+
+void bvecq_dump(const struct bvecq *bq)
+{
+	int b = 0;
+
+	for (; bq; bq = bq->next, b++) {
+		int skipz = 0;
+
+		pr_notice("BQ[%u] %u/%u fp=%llx\n", b, bq->nr_slots, bq->max_slots, bq->fpos);
+		for (int s = 0; s < bq->nr_slots; s++) {
+			const struct bio_vec *bv = &bq->bv[s];
+
+			if (!bv->bv_page && !bv->bv_len && skipz < 2) {
+				skipz = 1;
+				continue;
+			}
+			if (skipz == 1)
+				pr_notice("BQ[%u:00-%02u] ...\n", b, s - 1);
+			skipz = 2;
+			pr_notice("BQ[%u:%02u] %10lx %04x %04x %u\n",
+				  b, s,
+				  bv->bv_page ? page_to_pfn(bv->bv_page) : 0,
+				  bv->bv_offset, bv->bv_len,
+				  bv->bv_page ? page_count(bv->bv_page) : 0);
+		}
+	}
+}
+EXPORT_SYMBOL(bvecq_dump);
+
+/**
+ * bvecq_alloc_one - Allocate a single bvecq node with unpopulated slots
+ * @nr_slots: Number of slots to allocate
+ * @gfp: The allocation constraints.
+ *
+ * Allocate a single bvecq node and initialise the header.  A number of inline
+ * slots are also allocated, rounded up to fit after the header in a power-of-2
+ * slab object of up to 512 bytes (up to 29 slots on a 64-bit cpu).  The slot
+ * array is not initialised.
+ *
+ * Return: The node pointer or NULL on allocation failure.
+ */
+struct bvecq *bvecq_alloc_one(size_t nr_slots, gfp_t gfp)
+{
+	struct bvecq *bq;
+	const size_t max_size = 512;
+	const size_t max_slots = (max_size - sizeof(*bq)) / sizeof(bq->__bv[0]);
+	size_t part = umin(nr_slots, max_slots);
+	size_t size = roundup_pow_of_two(struct_size(bq, __bv, part));
+
+	bq = kmalloc(size, gfp);
+	if (bq) {
+		*bq = (struct bvecq) {
+			.ref		= REFCOUNT_INIT(1),
+			.bv		= bq->__bv,
+			.inline_bv	= true,
+			.max_slots	= (size - sizeof(*bq)) / sizeof(bq->__bv[0]),
+		};
+		netfs_stat(&netfs_n_bvecq);
+	}
+	return bq;
+}
+EXPORT_SYMBOL(bvecq_alloc_one);
+
+/**
+ * bvecq_alloc_chain - Allocate an unpopulated bvecq chain
+ * @nr_slots: Number of slots to allocate
+ * @gfp: The allocation constraints.
+ *
+ * Allocate a chain of bvecq nodes providing at least the requested cumulative
+ * number of slots.
+ *
+ * Return: The first node pointer or NULL on allocation failure.
+ */
+struct bvecq *bvecq_alloc_chain(size_t nr_slots, gfp_t gfp)
+{
+	struct bvecq *head = NULL, *tail = NULL;
+
+	_enter("%zu", nr_slots);
+
+	for (;;) {
+		struct bvecq *bq;
+
+		bq = bvecq_alloc_one(nr_slots, gfp);
+		if (!bq)
+			goto oom;
+
+		if (tail) {
+			tail->next = bq;
+			bq->prev = tail;
+		} else {
+			head = bq;
+		}
+		tail = bq;
+		if (tail->max_slots >= nr_slots)
+			break;
+		nr_slots -= tail->max_slots;
+	}
+
+	return head;
+oom:
+	bvecq_put(head);
+	return NULL;
+}
+EXPORT_SYMBOL(bvecq_alloc_chain);
+
+/**
+ * bvecq_alloc_buffer - Allocate a bvecq chain and populate with buffers
+ * @size: Target size of the buffer (can be 0 for an empty buffer)
+ * @pre_slots: Number of preamble slots to set aside
+ * @gfp: The allocation constraints.
+ *
+ * Allocate a chain of bvecq nodes and populate the slots with sufficient pages
+ * to provide at least the requested amount of space, leaving the first
+ * @pre_slots slots unset.  The pages allocated may be compound pages larger
+ * than PAGE_SIZE and thus occupy fewer slots.  The pages have their refcounts
+ * set to 1 and can be passed to MSG_SPLICE_PAGES.
+ *
+ * Return: The first node pointer or NULL on allocation failure.
+ */
+struct bvecq *bvecq_alloc_buffer(size_t size, unsigned int pre_slots, gfp_t gfp)
+{
+	struct bvecq *head = NULL, *tail = NULL, *p = NULL;
+	size_t count = DIV_ROUND_UP(size, PAGE_SIZE);
+
+	_enter("%zx,%zx,%u", size, count, pre_slots);
+
+	do {
+		struct page **pages;
+		int want, got;
+
+		p = bvecq_alloc_one(umin(count, 32 - 3), gfp);
+		if (!p)
+			goto oom;
+
+		p->free = true;
+
+		if (tail) {
+			tail->next = p;
+			p->prev = tail;
+		} else {
+			head = p;
+		}
+		tail = p;
+		if (!count)
+			break;
+
+		pages = (struct page **)&p->bv[p->max_slots];
+		pages -= p->max_slots - pre_slots;
+		memset(pages, 0, (p->max_slots - pre_slots) * sizeof(pages[0]));
+
+		want = umin(count, p->max_slots - pre_slots);
+		got = alloc_pages_bulk(gfp, want, pages);
+		if (got < want) {
+			for (int i = 0; i < got; i++)
+				__free_page(pages[i]);
+			goto oom;
+		}
+
+		tail->nr_slots = pre_slots + got;
+		for (int i = 0; i < got; i++) {
+			int j = pre_slots + i;
+
+			set_page_count(pages[i], 1);
+			bvec_set_page(&tail->bv[j], pages[i], PAGE_SIZE, 0);
+		}
+
+		count -= got;
+		pre_slots = 0;
+	} while (count > 0);
+
+	return head;
+oom:
+	bvecq_put(head);
+	return NULL;
+}
+EXPORT_SYMBOL(bvecq_alloc_buffer);
+
+/*
+ * Free the page pointed to be a segment as necessary.
+ */
+static void bvecq_free_seg(struct bvecq *bq, unsigned int seg)
+{
+	if (!bq->free ||
+	    !bq->bv[seg].bv_page)
+		return;
+
+	if (bq->unpin)
+		unpin_user_page(bq->bv[seg].bv_page);
+	else
+		__free_page(bq->bv[seg].bv_page);
+}
+
+/**
+ * bvecq_put - Put a ref on a bvec queue
+ * @bq: The start of the folio queue to free
+ *
+ * Put the ref(s) on the nodes in a bvec queue, freeing up the node and the
+ * page fragments it points to as the refcounts become zero.
+ */
+void bvecq_put(struct bvecq *bq)
+{
+	struct bvecq *next;
+
+	for (; bq; bq = next) {
+		if (!refcount_dec_and_test(&bq->ref))
+			break;
+		for (int seg = 0; seg < bq->nr_slots; seg++)
+			bvecq_free_seg(bq, seg);
+		next = bq->next;
+		netfs_stat_d(&netfs_n_bvecq);
+		kfree(bq);
+	}
+}
+EXPORT_SYMBOL(bvecq_put);
+
+/**
+ * bvecq_expand_buffer - Allocate buffer space into a bvec queue
+ * @_buffer: Pointer to the bvecq chain to expand (may point to a NULL; updated).
+ * @_cur_size: Current size of the buffer (updated).
+ * @size: Target size of the buffer.
+ * @gfp: The allocation constraints.
+ */
+int bvecq_expand_buffer(struct bvecq **_buffer, size_t *_cur_size, ssize_t size, gfp_t gfp)
+{
+	struct bvecq *tail = *_buffer;
+	const size_t max_slots = 32;
+
+	size = round_up(size, PAGE_SIZE);
+	if (*_cur_size >= size)
+		return 0;
+
+	if (tail)
+		while (tail->next)
+			tail = tail->next;
+
+	do {
+		struct page *page;
+		int order = 0;
+
+		if (!tail || bvecq_is_full(tail)) {
+			struct bvecq *p;
+
+			p = bvecq_alloc_one(max_slots, gfp);
+			if (!p)
+				return -ENOMEM;
+			if (tail) {
+				tail->next = p;
+				p->prev = tail;
+			} else {
+				*_buffer = p;
+			}
+			tail = p;
+		}
+
+		if (size - *_cur_size > PAGE_SIZE)
+			order = umin(ilog2(size - *_cur_size) - PAGE_SHIFT,
+				     MAX_PAGECACHE_ORDER);
+
+		page = alloc_pages(gfp | __GFP_COMP, order);
+		if (!page && order > 0)
+			page = alloc_pages(gfp | __GFP_COMP, 0);
+		if (!page)
+			return -ENOMEM;
+
+		bvec_set_page(&tail->bv[tail->nr_slots++], page, PAGE_SIZE << order, 0);
+		*_cur_size += PAGE_SIZE << order;
+	} while (*_cur_size < size);
+
+	return 0;
+}
+EXPORT_SYMBOL(bvecq_expand_buffer);
+
+/**
+ * bvecq_shorten_buffer - Shorten a bvec queue buffer
+ * @bq: The start of the buffer to shorten
+ * @slot: The slot to start from
+ * @size: The size to retain
+ *
+ * Shorten the content of a bvec queue down to the minimum number of segments,
+ * starting at the specified segment, to retain the specified size.
+ *
+ * Return: 0 if successful; -EMSGSIZE if there is insufficient content.
+ */
+int bvecq_shorten_buffer(struct bvecq *bq, unsigned int slot, size_t size)
+{
+	ssize_t retain = size;
+
+	/* Skip through the segments we want to keep. */
+	for (; bq; bq = bq->next) {
+		for (; slot < bq->nr_slots; slot++) {
+			retain -= bq->bv[slot].bv_len;
+			if (retain < 0)
+				goto found;
+		}
+		slot = 0;
+	}
+	if (WARN_ON_ONCE(retain > 0))
+		return -EMSGSIZE;
+	return 0;
+
+found:
+	/* Shorten the entry to be retained and clean the rest of this bvecq. */
+	bq->bv[slot].bv_len += retain;
+	slot++;
+	for (int i = slot; i < bq->nr_slots; i++)
+		bvecq_free_seg(bq, i);
+	bq->nr_slots = slot;
+
+	/* Free the queue tail. */
+	bvecq_put(bq->next);
+	bq->next = NULL;
+	return 0;
+}
+EXPORT_SYMBOL(bvecq_shorten_buffer);
+
+/**
+ * bvecq_buffer_init - Initialise a buffer and set position
+ * @pos: The position to point at the new buffer.
+ * @gfp: The allocation constraints.
+ *
+ * Initialise a rolling buffer.  We allocate an unpopulated bvecq node to so
+ * that the pointers can be independently driven by the producer and the
+ * consumer.
+ *
+ * Return 0 if successful; -ENOMEM on allocation failure.
+ */
+int bvecq_buffer_init(struct bvecq_pos *pos, gfp_t gfp)
+{
+	struct bvecq *bq;
+
+	bq = bvecq_alloc_one(13, gfp);
+	if (!bq)
+		return -ENOMEM;
+
+	pos->bvecq  = bq; /* Comes with a ref. */
+	pos->slot   = 0;
+	pos->offset = 0;
+	return 0;
+}
+
+/**
+ * bvecq_buffer_make_space - Start a new bvecq node in a buffer
+ * @pos: The position of the last node.
+ * @gfp: The allocation constraints.
+ *
+ * Add a new node on to the buffer chain at the specified position, either
+ * because the previous one is full or because we have a discontiguity to
+ * contend with, and update @pos to point to it.
+ *
+ * Return: 0 if successful; -ENOMEM on allocation failure.
+ */
+int bvecq_buffer_make_space(struct bvecq_pos *pos, gfp_t gfp)
+{
+	struct bvecq *bq, *head = pos->bvecq;
+
+	bq = bvecq_alloc_one(14, gfp);
+	if (!bq)
+		return -ENOMEM;
+	bq->prev = head;
+
+	pos->bvecq = bvecq_get(bq);
+	pos->slot = 0;
+	pos->offset = 0;
+
+	/* Make sure the initialisation is stored before the next pointer.
+	 *
+	 * [!] NOTE: After we set head->next, the consumer is at liberty to
+	 * immediately delete the old head.
+	 */
+	smp_store_release(&head->next, bq);
+	bvecq_put(head);
+	return 0;
+}
+
+/**
+ * bvecq_pos_advance - Advance a bvecq position
+ * @pos: The position to advance.
+ * @amount: The amount of bytes to advance by.
+ *
+ * Advance the specified bvecq position by @amount bytes.  @pos is updated and
+ * bvecq ref counts may have been manipulated.  If the position hits the end of
+ * the queue, then it is left pointing beyond the last slot of the last bvecq
+ * so that it doesn't break the chain.
+ */
+void bvecq_pos_advance(struct bvecq_pos *pos, size_t amount)
+{
+	struct bvecq *bq = pos->bvecq;
+	unsigned int slot = pos->slot;
+	size_t offset = pos->offset;
+
+	if (slot >= bq->nr_slots) {
+		bq = bq->next;
+		slot = 0;
+	}
+
+	while (amount) {
+		const struct bio_vec *bv = &bq->bv[slot];
+		size_t part = umin(bv->bv_len - offset, amount);
+
+		if (likely(part < bv->bv_len)) {
+			offset += part;
+			break;
+		}
+		amount -= part;
+		offset = 0;
+		slot++;
+		if (slot >= bq->nr_slots) {
+			if (!bq->next)
+				break;
+			bq = bq->next;
+			slot = 0;
+		}
+	}
+
+	pos->slot   = slot;
+	pos->offset = offset;
+	bvecq_pos_move(pos, bq);
+}
+
+/**
+ * bvecq_zero - Clear memory starting at the bvecq position.
+ * @pos: The position in the bvecq chain to start clearing.
+ * @amount: The number of bytes to clear.
+ *
+ * Clear memory fragments pointed to by a bvec queue.  @pos is updated and
+ * bvecq ref counts may have been manipulated.  If the position hits the end of
+ * the queue, then it is left pointing beyond the last slot of the last bvecq
+ * so that it doesn't break the chain.
+ *
+ * Return: The number of bytes cleared.
+ */
+ssize_t bvecq_zero(struct bvecq_pos *pos, size_t amount)
+{
+	struct bvecq *bq = pos->bvecq;
+	unsigned int slot = pos->slot;
+	ssize_t cleared = 0;
+	size_t offset = pos->offset;
+
+	if (WARN_ON_ONCE(!bq))
+		return 0;
+
+	if (slot >= bq->nr_slots) {
+		bq = bq->next;
+		if (WARN_ON_ONCE(!bq))
+			return 0;
+		slot = 0;
+	}
+
+	do {
+		const struct bio_vec *bv = &bq->bv[slot];
+
+		if (offset < bv->bv_len) {
+			size_t part = umin(amount - cleared, bv->bv_len - offset);
+
+			memzero_page(bv->bv_page, bv->bv_offset + offset, part);
+
+			offset += part;
+			cleared += part;
+		}
+
+		if (offset >= bv->bv_len) {
+			offset = 0;
+			slot++;
+			if (slot >= bq->nr_slots) {
+				if (!bq->next)
+					break;
+				bq = bq->next;
+				slot = 0;
+			}
+		}
+	} while (cleared < amount);
+
+	bvecq_pos_move(pos, bq);
+	pos->slot = slot;
+	pos->offset = offset;
+	return cleared;
+}
+
+/**
+ * bvecq_slice - Find a slice of a bvecq queue
+ * @pos: The position to start at.
+ * @max_size: The maximum size of the slice (or ULONG_MAX).
+ * @max_segs: The maximum number of segments in the slice (or INT_MAX).
+ * @_nr_segs: Where to put the number of segments (updated).
+ *
+ * Determine the size and number of segments that can be obtained the next
+ * slice of bvec queue up to the maximum size and segment count specified.  The
+ * slice is also limited if a discontiguity is found.
+ *
+ * @pos is updated to the end of the slice.  If the position hits the end of
+ * the queue, then it is left pointing beyond the last slot of the last bvecq
+ * so that it doesn't break the chain.
+ *
+ * Return: The number of bytes in the slice.
+ */
+size_t bvecq_slice(struct bvecq_pos *pos, size_t max_size,
+		   unsigned int max_segs, unsigned int *_nr_segs)
+{
+	struct bvecq *bq;
+	unsigned int slot = pos->slot, nsegs = 0;
+	size_t size = 0;
+	size_t offset = pos->offset;
+
+	bq = pos->bvecq;
+	for (;;) {
+		for (; slot < bq->nr_slots; slot++) {
+			const struct bio_vec *bvec = &bq->bv[slot];
+
+			if (offset < bvec->bv_len && bvec->bv_page) {
+				size_t part = umin(bvec->bv_len - offset, max_size);
+
+				size += part;
+				offset += part;
+				max_size -= part;
+				nsegs++;
+				if (!max_size || nsegs >= max_segs)
+					goto out;
+			}
+			offset = 0;
+		}
+
+		/* pos->bvecq isn't allowed to go NULL as the queue may get
+		 * extended and we would lose our place.
+		 */
+		if (!bq->next)
+			break;
+		slot = 0;
+		bq = bq->next;
+		if (bq->discontig && size > 0)
+			break;
+	}
+
+out:
+	*_nr_segs = nsegs;
+	if (slot == bq->nr_slots && bq->next) {
+		bq = bq->next;
+		slot = 0;
+		offset = 0;
+	}
+	bvecq_pos_move(pos, bq);
+	pos->slot = slot;
+	pos->offset = offset;
+	return size;
+}
+
+/**
+ * bvecq_extract - Extract a slice of a bvecq queue into a new bvecq queue
+ * @pos: The position to start at.
+ * @max_size: The maximum size of the slice (or ULONG_MAX).
+ * @max_segs: The maximum number of segments in the slice (or INT_MAX).
+ * @to: Where to put the extraction bvecq chain head (updated).
+ *
+ * Allocate a new bvecq and extract into it memory fragments from a slice of
+ * bvec queue, starting at @pos.  The slice is also limited if a discontiguity
+ * is found.  No refs are taken on the page.
+ *
+ * @pos is updated to the end of the slice.  If the position hits the end of
+ * the queue, then it is left pointing beyond the last slot of the last bvecq
+ * so that it doesn't break the chain.
+ *
+ * If successful, *@to is set to point to the head of the newly allocated chain
+ * and the caller inherits a ref to it.
+ *
+ * Return: The number of bytes extracted; -ENOMEM on allocation failure or -EIO
+ * if no segments were available to extract.
+ */
+ssize_t bvecq_extract(struct bvecq_pos *pos, size_t max_size,
+		      unsigned int max_segs, struct bvecq **to)
+{
+	struct bvecq_pos tmp_pos;
+	struct bvecq *src, *dst = NULL;
+	unsigned int slot = pos->slot, nsegs;
+	ssize_t extracted = 0;
+	size_t offset = pos->offset, amount;
+
+	*to = NULL;
+	if (WARN_ON_ONCE(!max_segs))
+		max_segs = INT_MAX;
+
+	bvecq_pos_set(&tmp_pos, pos);
+	amount = bvecq_slice(&tmp_pos, max_size, max_segs, &nsegs);
+	bvecq_pos_unset(&tmp_pos);
+	if (nsegs == 0)
+		return -EIO;
+
+	dst = bvecq_alloc_chain(nsegs, GFP_KERNEL);
+	if (!dst)
+		return -ENOMEM;
+	*to = dst;
+	max_segs = nsegs;
+	nsegs = 0;
+
+	/* Transcribe the segments */
+	src = pos->bvecq;
+	for (;;) {
+		for (; slot < src->nr_slots; slot++) {
+			const struct bio_vec *sv = &src->bv[slot];
+			struct bio_vec *dv = &dst->bv[dst->nr_slots];
+
+			_debug("EXTR BQ=%x[%x] off=%zx am=%zx p=%lx",
+			       src->priv, slot, offset, amount, page_to_pfn(sv->bv_page));
+
+			if (offset < sv->bv_len && sv->bv_page) {
+				size_t part = umin(sv->bv_len - offset, amount);
+
+				bvec_set_page(dv, sv->bv_page, part,
+					      sv->bv_offset + offset);
+				extracted += part;
+				amount -= part;
+				offset += part;
+				trace_netfs_bv_slot(dst, dst->nr_slots);
+				dst->nr_slots++;
+				nsegs++;
+				if (bvecq_is_full(dst))
+					dst = dst->next;
+				if (nsegs >= max_segs)
+					goto out;
+				if (amount == 0)
+					goto out;
+			}
+			offset = 0;
+		}
+
+		/* pos->bvecq isn't allowed to go NULL as the queue may get
+		 * extended and we would lose our place.
+		 */
+		if (!src->next)
+			break;
+		slot = 0;
+		src = src->next;
+		if (src->discontig && extracted > 0)
+			break;
+	}
+
+out:
+	if (slot == src->nr_slots && src->next) {
+		src = src->next;
+		slot = 0;
+		offset = 0;
+	}
+	bvecq_pos_move(pos, src);
+	pos->slot = slot;
+	pos->offset = offset;
+	return extracted;
+}
+
+/**
+ * bvecq_load_from_ra - Allocate a bvecq chain and load from readahead
+ * @pos: Blank position object to attach the new chain to.
+ * @ractl: The readahead control context.
+ *
+ * Decant the set of folios to be read from the readahead context into a bvecq
+ * chain.  Each folio occupies one bio_vec element.
+ *
+ * Return: Amount of data loaded or -ENOMEM on allocation failure.
+ */
+ssize_t bvecq_load_from_ra(struct bvecq_pos *pos, struct readahead_control *ractl)
+{
+	XA_STATE(xas, &ractl->mapping->i_pages, ractl->_index);
+	struct folio *folio;
+	struct bvecq *bq;
+	size_t loaded = 0;
+
+	bq = bvecq_alloc_chain(ractl->_nr_folios, GFP_NOFS);
+	if (!bq)
+		return -ENOMEM;
+
+	pos->bvecq  = bq;
+	pos->slot   = 0;
+	pos->offset = 0;
+
+	rcu_read_lock();
+
+	xas_for_each(&xas, folio, ractl->_index + ractl->_nr_pages - 1) {
+		size_t len;
+
+		if (xas_retry(&xas, folio))
+			continue;
+		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+		len = folio_size(folio);
+		bvec_set_folio(&bq->bv[bq->nr_slots++], folio, len, 0);
+		loaded += len;
+		trace_netfs_folio(folio, netfs_folio_trace_read);
+
+		if (bq->nr_slots >= bq->max_slots) {
+			bq = bq->next;
+			if (!bq)
+				break;
+		}
+	}
+
+	rcu_read_unlock();
+
+	ractl->_index += ractl->_nr_pages;
+	ractl->_nr_pages = 0;
+	return loaded;
+}
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 2fcf31de5f2c..ad47bcc1947b 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -168,6 +168,7 @@ extern atomic_t netfs_n_wh_retry_write_subreq;
 extern atomic_t netfs_n_wb_lock_skip;
 extern atomic_t netfs_n_wb_lock_wait;
 extern atomic_t netfs_n_folioq;
+extern atomic_t netfs_n_bvecq;
 
 int netfs_stats_show(struct seq_file *m, void *v);
 
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index ab6b916addc4..84c2a4bcc762 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -48,6 +48,7 @@ atomic_t netfs_n_wh_retry_write_subreq;
 atomic_t netfs_n_wb_lock_skip;
 atomic_t netfs_n_wb_lock_wait;
 atomic_t netfs_n_folioq;
+atomic_t netfs_n_bvecq;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
@@ -90,9 +91,10 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_rh_retry_read_subreq),
 		   atomic_read(&netfs_n_wh_retry_write_req),
 		   atomic_read(&netfs_n_wh_retry_write_subreq));
-	seq_printf(m, "Objs   : rr=%u sr=%u foq=%u wsc=%u\n",
+	seq_printf(m, "Objs   : rr=%u sr=%u bq=%u foq=%u wsc=%u\n",
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq),
+		   atomic_read(&netfs_n_bvecq),
 		   atomic_read(&netfs_n_folioq),
 		   atomic_read(&netfs_n_wh_wstream_conflict));
 	seq_printf(m, "WbLock : skip=%u wait=%u\n",
diff --git a/include/linux/bvecq.h b/include/linux/bvecq.h
index 462125af1cc7..6c58a7fb6472 100644
--- a/include/linux/bvecq.h
+++ b/include/linux/bvecq.h
@@ -17,7 +17,7 @@
  * iterated over with an ITER_BVECQ iterator.  The list is non-circular; next
  * and prev are NULL at the ends.
  *
- * The bv pointer points to the segment array; this may be __bv if allocated
+ * The bv pointer points to the bio_vec array; this may be __bv if allocated
  * together.  The caller is responsible for determining whether or not this is
  * the case as the array pointed to by bv may be follow on directly from the
  * bvecq by accident of allocation (ie. ->bv == ->__bv is *not* sufficient to
@@ -33,8 +33,8 @@ struct bvecq {
 	unsigned long long fpos;	/* File position */
 	refcount_t	ref;
 	u32		priv;		/* Private data */
-	u16		nr_segs;	/* Number of elements in bv[] used */
-	u16		max_segs;	/* Number of elements allocated in bv[] */
+	u16		nr_slots;	/* Number of elements in bv[] used */
+	u16		max_slots;	/* Number of elements allocated in bv[] */
 	bool		inline_bv:1;	/* T if __bv[] is being used */
 	bool		free:1;		/* T if the pages need freeing */
 	bool		unpin:1;	/* T if the pages need unpinning, not freeing */
@@ -43,4 +43,163 @@ struct bvecq {
 	struct bio_vec	__bv[];		/* Default array (if ->inline_bv) */
 };
 
+/*
+ * Position in a bio_vec queue.  The bvecq holds a ref on the queue segment it
+ * points to.
+ */
+struct bvecq_pos {
+	struct bvecq		*bvecq;		/* The first bvecq */
+	unsigned int		offset;		/* The offset within the starting slot */
+	u16			slot;		/* The starting slot */
+};
+
+void bvecq_dump(const struct bvecq *bq);
+struct bvecq *bvecq_alloc_one(size_t nr_slots, gfp_t gfp);
+struct bvecq *bvecq_alloc_chain(size_t nr_slots, gfp_t gfp);
+struct bvecq *bvecq_alloc_buffer(size_t size, unsigned int pre_slots, gfp_t gfp);
+void bvecq_put(struct bvecq *bq);
+int bvecq_expand_buffer(struct bvecq **_buffer, size_t *_cur_size, ssize_t size, gfp_t gfp);
+int bvecq_shorten_buffer(struct bvecq *bq, unsigned int slot, size_t size);
+int bvecq_buffer_init(struct bvecq_pos *pos, gfp_t gfp);
+int bvecq_buffer_make_space(struct bvecq_pos *pos, gfp_t gfp);
+void bvecq_pos_advance(struct bvecq_pos *pos, size_t amount);
+ssize_t bvecq_zero(struct bvecq_pos *pos, size_t amount);
+size_t bvecq_slice(struct bvecq_pos *pos, size_t max_size,
+		   unsigned int max_segs, unsigned int *_nr_segs);
+ssize_t bvecq_extract(struct bvecq_pos *pos, size_t max_size,
+		      unsigned int max_segs, struct bvecq **to);
+ssize_t bvecq_load_from_ra(struct bvecq_pos *pos, struct readahead_control *ractl);
+
+/**
+ * bvecq_get - Get a ref on a bvecq
+ * @bq: The bvecq to get a ref on
+ */
+static inline struct bvecq *bvecq_get(struct bvecq *bq)
+{
+	refcount_inc(&bq->ref);
+	return bq;
+}
+
+/**
+ * bvecq_is_full - Determine if a bvecq is full
+ * @bvecq: The object to query
+ *
+ * Return: true if full; false if not.
+ */
+static inline bool bvecq_is_full(const struct bvecq *bvecq)
+{
+	return bvecq->nr_slots >= bvecq->max_slots;
+}
+
+/**
+ * bvecq_pos_set - Set one position to be the same as another
+ * @pos: The position object to set
+ * @at: The source position.
+ *
+ * Set @pos to have the same position as @at.  This may take a ref on the
+ * bvecq pointed to.
+ */
+static inline void bvecq_pos_set(struct bvecq_pos *pos, const struct bvecq_pos *at)
+{
+	*pos = *at;
+	bvecq_get(pos->bvecq);
+}
+
+/**
+ * bvecq_pos_unset - Unset a position
+ * @pos: The position object to unset
+ *
+ * Unset @pos.  This does any needed ref cleanup.
+ */
+static inline void bvecq_pos_unset(struct bvecq_pos *pos)
+{
+	bvecq_put(pos->bvecq);
+	pos->bvecq = NULL;
+	pos->slot = 0;
+	pos->offset = 0;
+}
+
+/**
+ * bvecq_pos_transfer - Transfer one position to another, clearing the first
+ * @pos: The position object to set
+ * @from: The source position to clear.
+ *
+ * Set @pos to have the same position as @from and then clear @from.  This may
+ * transfer a ref on the bvecq pointed to.
+ */
+static inline void bvecq_pos_transfer(struct bvecq_pos *pos, struct bvecq_pos *from)
+{
+	*pos = *from;
+	from->bvecq = NULL;
+	from->slot = 0;
+	from->offset = 0;
+}
+
+/**
+ * bvecq_pos_move - Update a position to a new bvecq
+ * @pos: The position object to update.
+ * @to: The new bvecq to point at.
+ *
+ * Update @pos to point to @to if it doesn't already do so.  This may
+ * manipulate refs on the bvecqs pointed to.
+ */
+static inline void bvecq_pos_move(struct bvecq_pos *pos, struct bvecq *to)
+{
+	struct bvecq *old = pos->bvecq;
+
+	if (old != to) {
+		pos->bvecq = bvecq_get(to);
+		bvecq_put(old);
+	}
+}
+
+/**
+ * bvecq_pos_step - Step a position to the next slot if possible
+ * @pos: The position object to step.
+ *
+ * Update @pos to point to the next slot in the queue if not at the end.  This
+ * may manipulate refs on the bvecqs pointed to.
+ *
+ * Return: true if successful, false if was at the end.
+ */
+static inline bool bvecq_pos_step(struct bvecq_pos *pos)
+{
+	struct bvecq *bq = pos->bvecq;
+
+	pos->slot++;
+	pos->offset = 0;
+	if (pos->slot <= bq->nr_slots)
+		return true;
+	if (!bq->next)
+		return false;
+	bvecq_pos_move(pos, bq->next);
+	return true;
+}
+
+/**
+ * bvecq_delete_spent - Delete the bvecq at the front if possible
+ * @pos: The position object to update.
+ *
+ * Delete the used up bvecq at the front of the queue that @pos points to if it
+ * is not the last node in the queue; if it is the last node in the queue, it
+ * is kept so that the queue doesn't become detached from the other end.  This
+ * may manipulate refs on the bvecqs pointed to.
+ */
+static inline struct bvecq *bvecq_delete_spent(struct bvecq_pos *pos)
+{
+	struct bvecq *spent = pos->bvecq;
+	/* Read the contents of the queue node after the pointer to it. */
+	struct bvecq *next = smp_load_acquire(&spent->next);
+
+	if (!next)
+		return NULL;
+	next->prev = NULL;
+	spent->next = NULL;
+	bvecq_put(spent);
+	pos->bvecq = next; /* We take spent's ref */
+	pos->slot = 0;
+	pos->offset = 0;
+	return next;
+}
+
 #endif /* _LINUX_BVECQ_H */
diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index 999607ece481..309642b3901f 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -152,7 +152,7 @@ size_t iterate_bvecq(struct iov_iter *iter, size_t len, void *priv, void *priv2,
 	unsigned int slot = iter->bvecq_slot;
 	size_t progress = 0, skip = iter->iov_offset;
 
-	if (slot == bq->nr_segs) {
+	if (slot == bq->nr_slots) {
 		/* The iterator may have been extended. */
 		bq = bq->next;
 		slot = 0;
@@ -176,7 +176,7 @@ size_t iterate_bvecq(struct iov_iter *iter, size_t len, void *priv, void *priv2,
 		if (skip >= bvec->bv_len) {
 			skip = 0;
 			slot++;
-			if (slot >= bq->nr_segs) {
+			if (slot >= bq->nr_slots) {
 				if (!bq->next)
 					break;
 				bq = bq->next;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index cc56b6512769..5bc48aacf7f6 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -17,6 +17,7 @@
 #include <linux/workqueue.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/bvecq.h>
 #include <linux/uio.h>
 #include <linux/rolling_buffer.h>
 
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index b8236f9e940e..fbb094231659 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -779,6 +779,30 @@ TRACE_EVENT(netfs_folioq,
 		      __print_symbolic(__entry->trace, netfs_folioq_traces))
 	    );
 
+TRACE_EVENT(netfs_bv_slot,
+	    TP_PROTO(const struct bvecq *bq, int slot),
+
+	    TP_ARGS(bq, slot),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned long,		pfn)
+		    __field(unsigned int,		offset)
+		    __field(unsigned int,		len)
+		    __field(unsigned int,		slot)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->slot = slot;
+		    __entry->pfn = page_to_pfn(bq->bv[slot].bv_page);
+		    __entry->offset = bq->bv[slot].bv_offset;
+		    __entry->len = bq->bv[slot].bv_len;
+			   ),
+
+	    TP_printk("bq[%x] p=%lx %x-%x",
+		      __entry->slot,
+		      __entry->pfn, __entry->offset, __entry->offset + __entry->len)
+	    );
+
 #undef EM
 #undef E_
 #endif /* _TRACE_NETFS_H */
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index df8d037894b1..4f091e6d4a22 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -580,7 +580,7 @@ static void iov_iter_bvecq_advance(struct iov_iter *i, size_t by)
 		return;
 	i->count -= by;
 
-	if (slot >= bq->nr_segs) {
+	if (slot >= bq->nr_slots) {
 		bq = bq->next;
 		slot = 0;
 	}
@@ -593,7 +593,7 @@ static void iov_iter_bvecq_advance(struct iov_iter *i, size_t by)
 			break;
 		by -= len;
 		slot++;
-		if (slot >= bq->nr_segs && bq->next) {
+		if (slot >= bq->nr_slots && bq->next) {
 			bq = bq->next;
 			slot = 0;
 		}
@@ -662,7 +662,7 @@ static void iov_iter_bvecq_revert(struct iov_iter *i, size_t unroll)
 
 		if (slot == 0) {
 			bq = bq->prev;
-			slot = bq->nr_segs;
+			slot = bq->nr_slots;
 		}
 		slot--;
 
@@ -947,7 +947,7 @@ static unsigned long iov_iter_alignment_bvecq(const struct iov_iter *iter)
 		return res;
 
 	for (bq = iter->bvecq; bq; bq = bq->next) {
-		for (; slot < bq->nr_segs; slot++) {
+		for (; slot < bq->nr_slots; slot++) {
 			const struct bio_vec *bvec = &bq->bv[slot];
 			size_t part = umin(bvec->bv_len - skip, size);
 
@@ -1331,7 +1331,7 @@ static size_t iov_npages_bvecq(const struct iov_iter *iter, size_t maxpages)
 	size_t size = iter->count;
 
 	for (bq = iter->bvecq; bq; bq = bq->next) {
-		for (; slot < bq->nr_segs; slot++) {
+		for (; slot < bq->nr_slots; slot++) {
 			const struct bio_vec *bvec = &bq->bv[slot];
 			size_t offs = (bvec->bv_offset + skip) % PAGE_SIZE;
 			size_t part = umin(bvec->bv_len - skip, size);
@@ -1731,7 +1731,7 @@ static ssize_t iov_iter_extract_bvecq_pages(struct iov_iter *iter,
 	unsigned int seg = iter->bvecq_slot, count = 0, nr = 0;
 	size_t extracted = 0, offset = iter->iov_offset;
 
-	if (seg >= bvecq->nr_segs) {
+	if (seg >= bvecq->nr_slots) {
 		bvecq = bvecq->next;
 		if (WARN_ON_ONCE(!bvecq))
 			return 0;
@@ -1763,7 +1763,7 @@ static ssize_t iov_iter_extract_bvecq_pages(struct iov_iter *iter,
 		if (offset >= blen) {
 			offset = 0;
 			seg++;
-			if (seg >= bvecq->nr_segs) {
+			if (seg >= bvecq->nr_slots) {
 				if (!bvecq->next) {
 					WARN_ON_ONCE(extracted < iter->count);
 					break;
@@ -1816,7 +1816,7 @@ static ssize_t iov_iter_extract_bvecq_pages(struct iov_iter *iter,
 		if (offset >= blen) {
 			offset = 0;
 			seg++;
-			if (seg >= bvecq->nr_segs) {
+			if (seg >= bvecq->nr_slots) {
 				if (!bvecq->next) {
 					WARN_ON_ONCE(extracted < iter->count);
 					break;
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 03e3883a1a2d..93a3d194a914 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1345,7 +1345,7 @@ static ssize_t extract_bvecq_to_sg(struct iov_iter *iter,
 	ssize_t ret = 0;
 	size_t offset = iter->iov_offset;
 
-	if (seg >= bvecq->nr_segs) {
+	if (seg >= bvecq->nr_slots) {
 		bvecq = bvecq->next;
 		if (WARN_ON_ONCE(!bvecq))
 			return 0;
@@ -1373,7 +1373,7 @@ static ssize_t extract_bvecq_to_sg(struct iov_iter *iter,
 		if (offset >= blen) {
 			offset = 0;
 			seg++;
-			if (seg >= bvecq->nr_segs) {
+			if (seg >= bvecq->nr_slots) {
 				if (!bvecq->next) {
 					WARN_ON_ONCE(ret < iter->count);
 					break;
diff --git a/lib/tests/kunit_iov_iter.c b/lib/tests/kunit_iov_iter.c
index 5bc941f64343..ff0621636ff1 100644
--- a/lib/tests/kunit_iov_iter.c
+++ b/lib/tests/kunit_iov_iter.c
@@ -543,28 +543,28 @@ static void iov_kunit_destroy_bvecq(void *data)
 
 	for (bq = data; bq; bq = next) {
 		next = bq->next;
-		for (int i = 0; i < bq->nr_segs; i++)
+		for (int i = 0; i < bq->nr_slots; i++)
 			if (bq->bv[i].bv_page)
 				put_page(bq->bv[i].bv_page);
 		kfree(bq);
 	}
 }
 
-static struct bvecq *iov_kunit_alloc_bvecq(struct kunit *test, unsigned int max_segs)
+static struct bvecq *iov_kunit_alloc_bvecq(struct kunit *test, unsigned int max_slots)
 {
 	struct bvecq *bq;
 
-	bq = kzalloc(struct_size(bq, __bv, max_segs), GFP_KERNEL);
+	bq = kzalloc(struct_size(bq, __bv, max_slots), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bq);
-	bq->max_segs = max_segs;
+	bq->max_slots = max_slots;
 	return bq;
 }
 
-static struct bvecq *iov_kunit_create_bvecq(struct kunit *test, unsigned int max_segs)
+static struct bvecq *iov_kunit_create_bvecq(struct kunit *test, unsigned int max_slots)
 {
 	struct bvecq *bq;
 
-	bq = iov_kunit_alloc_bvecq(test, max_segs);
+	bq = iov_kunit_alloc_bvecq(test, max_slots);
 	kunit_add_action_or_reset(test, iov_kunit_destroy_bvecq, bq);
 	return bq;
 }
@@ -578,13 +578,13 @@ static void __init iov_kunit_load_bvecq(struct kunit *test,
 	size_t size = 0;
 
 	for (int i = 0; i < npages; i++) {
-		if (bq->nr_segs >= bq->max_segs) {
+		if (bq->nr_slots >= bq->max_slots) {
 			bq->next = iov_kunit_alloc_bvecq(test, 8);
 			bq->next->prev = bq;
 			bq = bq->next;
 		}
-		bvec_set_page(&bq->bv[bq->nr_segs], pages[i], PAGE_SIZE, 0);
-		bq->nr_segs++;
+		bvec_set_page(&bq->bv[bq->nr_slots], pages[i], PAGE_SIZE, 0);
+		bq->nr_slots++;
 		size += PAGE_SIZE;
 	}
 	iov_iter_bvec_queue(iter, dir, bq_head, 0, 0, size);


