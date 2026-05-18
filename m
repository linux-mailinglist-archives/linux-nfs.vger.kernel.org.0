Return-Path: <linux-nfs+bounces-21679-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNyAJQaVC2ohJgUAu9opvQ
	(envelope-from <linux-nfs+bounces-21679-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 00:39:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E739E574AB0
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 00:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 747B33070208
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 22:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2733B27C6;
	Mon, 18 May 2026 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KloQK+S3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB453B27E2
	for <linux-nfs@vger.kernel.org>; Mon, 18 May 2026 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143495; cv=none; b=lNH8ZSHlfHsxBu3KegiXoPcxaaF7YBrf2qiKfJ9EEh8+XFLs8mOqrk11eWxj9DQKwBsOwF0qDx6CLNalbumOJUrFXSsI3kn7GEnDwalIkznaPNKfLUkD5wpY2HOj8x2LCGp2l+AnW80WhKOfOz97AwwRL23pEes05wqoTIxP17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143495; c=relaxed/simple;
	bh=n7VZ60VhzHmlQt4Oryuyi9u8opzqejbmXt0GXaOk3a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9qIWCQncxMvB20rFOqFbS6fCmWt4P+00zO4FaTvyBb8QF1xniSaoy9yRj/m10ZJsw1ekRCbvs0RPexXl8OOM8Gi4/uNJdWKp+GCaOqlKnLa9SEIoDGGKZ923bUmGuMtcZ27rArjO59jFvx+DpSU0Ef0Ck+zXdUMRAqlS1fR2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KloQK+S3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779143492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h6cK/+wZZBgV9aDVhNdrE2DJVenyEWleKupZz8Kyaho=;
	b=KloQK+S3PJ7bw+dIZMk3ynFSfqzIGO5UbGpq6TC2KyIgKHCFnVBh0G1Yoffmkt3PWAE1kD
	KbobwpEUa4zIHOkE/+QwK13Y5yf+o3m3XKYBkrqv8xGG2JmbO4DEKwDXlDpYD6RQLRXCC0
	mQW/8ncfl1YYcUqsXRln3lJi+917k2c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-4VU8WuiPP_uwOBmn2F2DFw-1; Mon,
 18 May 2026 18:31:25 -0400
X-MC-Unique: 4VU8WuiPP_uwOBmn2F2DFw-1
X-Mimecast-MFC-AGG-ID: 4VU8WuiPP_uwOBmn2F2DFw_1779143482
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 728C6180047F;
	Mon, 18 May 2026 22:31:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D78B1956053;
	Mon, 18 May 2026 22:31:14 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/21] netfs: Add some tools for managing bvecq chains
Date: Mon, 18 May 2026 23:29:40 +0100
Message-ID: <20260518222959.488126-9-dhowells@redhat.com>
In-Reply-To: <20260518222959.488126-1-dhowells@redhat.com>
References: <20260518222959.488126-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21679-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,infradead.org:email,manguebit.org:email]
X-Rspamd-Queue-Id: E739E574AB0
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
 fs/netfs/bvecq.c             | 763 +++++++++++++++++++++++++++++++++++
 fs/netfs/internal.h          |   1 +
 fs/netfs/stats.c             |   4 +-
 include/linux/bvecq.h        | 269 ++++++++++++
 include/linux/netfs.h        |   1 +
 include/trace/events/netfs.h |  24 ++
 7 files changed, 1062 insertions(+), 1 deletion(-)
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
index 000000000000..b3822fe87f64
--- /dev/null
+++ b/fs/netfs/bvecq.c
@@ -0,0 +1,763 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Buffering helpers for bvec queues
+ *
+ * Copyright (C) 2026 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/bvecq.h>
+#include "internal.h"
+
+void bvecq_dump(const struct bvecq *bq)
+{
+	int b = 0;
+
+	for (; bq; bq = bq->next, b++) {
+		int skipz = 0;
+
+		pr_notice("BQ[%u] %u/%u fp=%llx%s\n",
+			  b, bq->nr_slots, bq->max_slots, bq->fpos,
+			  bq->discontig ? " discontig" : "");
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
+	bq = kmalloc(size, gfp & ~GFP_ZONEMASK);
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
+ * bvecq_alloc_buffer2 - Allocate a bvecq chain and populate with buffers
+ * @size: Target size of the buffer (can be 0 for an empty buffer)
+ * @pre_slots: Number of preamble slots to set aside
+ * @gfp: The allocation constraints.
+ *
+ * Allocate a chain of bvecq nodes and populate the slots with sufficient pages
+ * to provide at least the requested amount of space, leaving the first
+ * @pre_slots slots unset.  The pre-slots must all fit into the the first
+ * bvecq.
+ *
+ * The pages allocated may be compound pages larger than PAGE_SIZE and thus
+ * occupy fewer slots.  The pages have their refcounts set to 1 and can be
+ * passed to MSG_SPLICE_PAGES.
+ *
+ * Return: The first node pointer or NULL on allocation failure.
+ */
+struct bvecq *bvecq_alloc_buffer2(size_t size, unsigned int pre_slots, gfp_t gfp)
+{
+	struct bvecq *head = NULL, *tail = NULL, *p = NULL;
+	size_t nr_per_bq = BVECQ_STD_SLOTS;
+	size_t count = DIV_ROUND_UP(size, PAGE_SIZE);
+
+	_enter("%zx,%zx,%u", size, count, pre_slots);
+
+	if (WARN_ON_ONCE(pre_slots > nr_per_bq))
+		return NULL;
+
+	do {
+		struct page **pages;
+		int want, got;
+
+		p = bvecq_alloc_one(min(pre_slots + count, nr_per_bq), gfp);
+		if (!p)
+			goto oom;
+
+		p->mem_type = BVECQ_MEM_ALLOCED;
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
+		/* Need to clear pre slots and pages[], so just clear all. */
+		memset(p->bv, 0, p->max_slots * sizeof(p->bv[0]));
+
+		pages = (struct page **)&p->bv[p->max_slots];
+		pages -= p->max_slots - pre_slots;
+
+		want = min(count, p->max_slots - pre_slots);
+		got = alloc_pages_bulk(gfp, want, pages);
+		if (got < want) {
+			for (int i = 0; i < got; i++) {
+				__free_page(pages[i]);
+				pages[i] = NULL;
+			}
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
+EXPORT_SYMBOL(bvecq_alloc_buffer2);
+
+/*
+ * Free the page pointed to by a slot as necessary.
+ */
+static void bvecq_free_slot(struct bvecq *bq, unsigned int slot)
+{
+	struct page *page = bq->bv[slot].bv_page;
+
+	if (!page)
+		return;
+
+	switch (bq->mem_type) {
+	case BVECQ_MEM_EXTERNAL:
+		break;
+	case BVECQ_MEM_PAGECACHE:
+		put_page(page);
+		break;
+	case BVECQ_MEM_GUP:
+		unpin_user_page(page);
+		break;
+	case BVECQ_MEM_ALLOCED:
+		__free_pages(page, compound_order(page));
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
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
+		for (int slot = 0; slot < bq->nr_slots; slot++)
+			bvecq_free_slot(bq, slot);
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
+			p = bvecq_alloc_one(BVECQ_STD_SLOTS, gfp);
+			if (!p)
+				return -ENOMEM;
+			if (tail) {
+				tail->next = p;
+				p->prev = tail;
+			} else {
+				*_buffer = p;
+			}
+			tail = p;
+			p->mem_type = BVECQ_MEM_ALLOCED;
+		}
+
+		if (size - *_cur_size > PAGE_SIZE)
+			order = umin(ilog2(size - *_cur_size) - PAGE_SHIFT,
+				     MAX_PAGECACHE_ORDER);
+
+		page = alloc_pages(gfp | __GFP_COMP, order);
+		if (!page && order > 0) {
+			page = alloc_pages(gfp | __GFP_COMP, 0);
+			order = 0;
+		}
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
+ * Shorten the content of a bvec queue down to the minimum number of slots,
+ * starting at the specified slot, to retain the specified size.
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
+		bvecq_free_slot(bq, i);
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
+	bq = bvecq_alloc_one(BVECQ_STD_SLOTS, gfp);
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
+ * bvecq_buffer_append - Append a new bvecq node to a buffer
+ * @pos: The position of the last node.
+ * @bq: The buffer to add.
+ *
+ * Add a new node on to the buffer chain at the specified position, either
+ * because the previous one is full or because we have a discontiguity to
+ * contend with, and update @pos to point to it.
+ */
+void bvecq_buffer_append(struct bvecq_pos *pos, struct bvecq *bq)
+{
+	struct bvecq *head = pos->bvecq;
+
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
+	while (amount) {
+		size_t part;
+
+		while (bvecq_acquire_slot(bq, slot)) {
+			if (!bq->next) {
+				WARN_ON_ONCE(amount > 0);
+				break;
+			}
+			bq = bq->next;
+			slot = 0;
+		}
+
+		part = bq->bv[slot].bv_len - offset;
+
+		if (part > amount) {
+			offset += amount;
+			break;
+		}
+		amount -= part;
+		offset = 0;
+		slot++;
+	}
+
+	pos->slot   = slot;
+	pos->offset = offset;
+	bvecq_pos_move(pos, bq);
+}
+
+/*
+ * Clear part of the memory pointed to by a bio_vec.
+ */
+static void bvec_zero(const struct bio_vec *bv, size_t offset, size_t len)
+{
+	struct page *page = bv->bv_page;
+
+	offset += bv->bv_offset;
+
+	page  += offset / PAGE_SIZE;
+	offset = offset % PAGE_SIZE;
+
+	while (len) {
+		size_t part = umin(len, PAGE_SIZE - offset);
+		char *p = kmap_local_page(page);
+
+		memset(p + offset, 0, part);
+		kunmap_local(p);
+
+		len -= part;
+		offset = 0;
+		page++;
+	}
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
+	struct bvecq *bq;
+	unsigned int slot = pos->slot;
+	size_t cleared = 0, offset = pos->offset;
+
+	bq = pos->bvecq;
+	for (;;) {
+		for (; slot < bq->nr_slots; slot++) {
+			const struct bio_vec *bvec = &bq->bv[slot];
+
+			if (offset < bvec->bv_len && bvec->bv_page) {
+				size_t part = umin(bvec->bv_len - offset, amount);
+
+				bvec_zero(bvec, offset, part);
+
+				cleared += part;
+				offset += part;
+				amount -= part;
+				if (!amount)
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
+	}
+
+out:
+	if (slot == bq->nr_slots && bq->next) {
+		bq = bq->next;
+		slot = 0;
+		offset = 0;
+	}
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
+ * @max_slots: The maximum number of slots in the slice (or INT_MAX).
+ * @_nr_slots: Where to put the number of slots (updated).
+ *
+ * Determine the size and number of slots that can be obtained the next slice
+ * of bvec queue up to the maximum size and slot count specified.  The slice is
+ * also limited if a discontiguity is found.
+ *
+ * @pos is updated to the end of the slice.  If the position hits the end of
+ * the queue, then it is left pointing beyond the last slot of the last bvecq
+ * so that it doesn't break the chain.
+ *
+ * Return: The number of bytes in the slice.
+ */
+size_t bvecq_slice(struct bvecq_pos *pos, size_t max_size,
+		   unsigned int max_slots, unsigned int *_nr_slots)
+{
+	struct bvecq *bq;
+	unsigned int slot = pos->slot, nslots = 0;
+	size_t size = 0, offset = pos->offset;
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
+				nslots++;
+				if (!max_size || nslots >= max_slots)
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
+	*_nr_slots = nslots;
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
+ * @max_slots: The maximum number of slots in the slice (or INT_MAX).
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
+ * if no slots were available to extract.
+ */
+ssize_t bvecq_extract(struct bvecq_pos *pos, size_t max_size,
+		      unsigned int max_slots, struct bvecq **to)
+{
+	struct bvecq_pos tmp_pos;
+	struct bvecq *src, *dst = NULL;
+	unsigned int slot = pos->slot, dslot = 0, nslots;
+	ssize_t extracted = 0;
+	size_t offset = pos->offset, amount;
+
+	*to = NULL;
+	if (WARN_ON_ONCE(!max_slots))
+		max_slots = INT_MAX;
+
+	bvecq_pos_set(&tmp_pos, pos);
+	amount = bvecq_slice(&tmp_pos, max_size, max_slots, &nslots);
+	bvecq_pos_unset(&tmp_pos);
+	if (nslots == 0)
+		return -EIO;
+
+	dst = bvecq_alloc_chain(nslots, GFP_KERNEL);
+	if (!dst)
+		return -ENOMEM;
+	*to = dst;
+	max_slots = nslots;
+	nslots = 0;
+
+	/* Transcribe the slots */
+	src = pos->bvecq;
+	for (;;) {
+		for (; slot < src->nr_slots; slot++) {
+			const struct bio_vec *sv = &src->bv[slot];
+			struct bio_vec *dv = &dst->bv[dslot];
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
+				trace_netfs_bv_slot(dst, dslot);
+				dslot++;
+				nslots++;
+				if (dslot >= dst->max_slots) {
+					bvecq_filled_to(dst, dslot);
+					dst = dst->next;
+					dslot = 0;
+				}
+				if (nslots >= max_slots)
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
+	if (dst)
+		bvecq_filled_to(dst, dslot);
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
+	unsigned int slot = 0;
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
+		bvec_set_folio(&bq->bv[slot], folio, len, 0);
+		loaded += len;
+		slot++;
+		trace_netfs_folio(folio, netfs_folio_trace_read);
+
+		if (slot >= bq->max_slots) {
+			bvecq_filled_to(bq, slot);
+			bq = bq->next;
+			if (!bq)
+				break;
+			slot = 0;
+		}
+	}
+
+	rcu_read_unlock();
+
+	if (bq)
+		bvecq_filled_to(bq, slot);
+
+	ractl->_index += ractl->_nr_pages;
+	ractl->_nr_pages = 0;
+	return loaded;
+}
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 4b0f9304b970..53e1fcc42a19 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -172,6 +172,7 @@ extern atomic_t netfs_n_wh_retry_write_subreq;
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
index 15f16f905877..dd2e60e3b743 100644
--- a/include/linux/bvecq.h
+++ b/include/linux/bvecq.h
@@ -53,4 +53,273 @@ struct bvecq {
 	struct bio_vec	__bv[];		/* Default array (if ->inline_bv) */
 };
 
+#if BITS_PER_LONG == 64
+/* Number of slots in __bv[] for a bvecq in a 512-byte kmalloc block. */
+#define BVECQ_STD_SLOTS		29	/* 2 words/slot; 32 slots; bvecq is 6 words (3 slots) */
+#elif  BITS_PER_LONG == 32
+/* Number of slots in __bv[] for a bvecq in a 256-byte kmalloc block. */
+#define BVECQ_STD_SLOTS		18	/* 3 words/slot; 21 slots; bvecq is 9 words (3 slots) */
+#else
+#error BVECQ_STD_SLOTS undetermined
+#endif
+
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
+struct bvecq *bvecq_alloc_buffer2(size_t size, unsigned int pre_slots, gfp_t gfp);
+void bvecq_put(struct bvecq *bq);
+int bvecq_expand_buffer(struct bvecq **_buffer, size_t *_cur_size, ssize_t size, gfp_t gfp);
+int bvecq_shorten_buffer(struct bvecq *bq, unsigned int slot, size_t size);
+int bvecq_buffer_init(struct bvecq_pos *pos, gfp_t gfp);
+void bvecq_buffer_append(struct bvecq_pos *pos, struct bvecq *bq);
+void bvecq_pos_advance(struct bvecq_pos *pos, size_t amount);
+ssize_t bvecq_zero(struct bvecq_pos *pos, size_t amount);
+size_t bvecq_slice(struct bvecq_pos *pos, size_t max_size,
+		   unsigned int max_slots, unsigned int *_nr_slots);
+ssize_t bvecq_extract(struct bvecq_pos *pos, size_t max_size,
+		      unsigned int max_slots, struct bvecq **to);
+ssize_t bvecq_load_from_ra(struct bvecq_pos *pos, struct readahead_control *ractl);
+
+/**
+ * bvecq_alloc_buffer - Allocate a bvecq chain and populate with buffers
+ * @size: Target size of the buffer (can be 0 for an empty buffer)
+ * @gfp: The allocation constraints.
+ *
+ * Wrapper around %bvecq_alloc_buffer2().
+ */
+static inline struct bvecq *bvecq_alloc_buffer(size_t size, gfp_t gfp)
+{
+	return bvecq_alloc_buffer2(size, 0, gfp);
+}
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
+ * bvecq_filled_to - Release filled slots with release barrier
+ * @bvecq: The object modified
+ * @to: The latest slot filled + 1
+ */
+static inline void bvecq_filled_to(struct bvecq *bvecq, unsigned int to)
+{
+	/* Set the slot counter after filling the slot */
+	smp_store_release(&bvecq->nr_slots, to);
+}
+
+/**
+ * bvecq_nr_slots_acquire - Get the number of filled slots with acquire barrier
+ * @bvecq: The object to query
+ *
+ * Return: The number of filled slots
+ */
+static inline unsigned int bvecq_nr_slots_acquire(const struct bvecq *bvecq)
+{
+	/* Read the slot counter before looking at the slot */
+	return smp_load_acquire(&bvecq->nr_slots);
+}
+
+/**
+ * bvecq_acquire_slot - Determine if a slot is valid with acquire barrier
+ * @bvecq: The object to query
+ * @slot: The next slot
+ *
+ * Return: true if valid; false if might not be valid
+ */
+static inline bool bvecq_acquire_slot(const struct bvecq *bvecq, unsigned int slot)
+{
+	/* Read the slot counter before looking at the slot */
+	return slot < bvecq_nr_slots_acquire(bvecq);
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
+ * bvecq_pos_nudge - Nudge a position onto the next segment if current used up
+ * @pos: The position object to nudge.
+ *
+ * Update @pos to point to the next segment in the chain if we've used up the
+ * current segment.  This may manipulate refs on the bvecqs pointed to.
+ *
+ * Return: true if found a new segment, false if hit the end.
+ */
+static inline bool bvecq_pos_nudge(struct bvecq_pos *pos)
+{
+	struct bvecq *bq = pos->bvecq;
+
+	for (;;) {
+		if (!bvecq_acquire_slot(bq, pos->slot)) {
+			bq = bq->next;
+			if (!bq)
+				return false;
+			bvecq_pos_move(pos, bq);
+			pos->slot = 0;
+			pos->offset = 0;
+			continue;
+		}
+		if (pos->offset >= bq->bv[pos->slot].bv_len) {
+			pos->slot++;
+			pos->offset = 0;
+			continue;
+		}
+		return true;
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
+ * @slot: Current slot.
+ *
+ * Delete the used up bvecq at the front of the queue that @pos points to if it
+ * is not the last node in the queue; if it is the last node in the queue, it
+ * is kept so that the queue doesn't become detached from the other end.  This
+ * may manipulate refs on the bvecqs pointed to.  It is also possible that the
+ * producer will fill more slots in the current bvecq.
+ *
+ * Also, we have to be very careful: the consumer can catch the producer, which
+ * could lead to us having nothing left in the queue, causing the front and
+ * back pointers to end up on different tracks.  To avoid this, we must always
+ * keep at least one segment in the queue.
+ *
+ * The caller must reload from @pos after calling this.
+ *
+ * Return: true if there's more available; false if not.
+ */
+static inline bool bvecq_delete_spent(struct bvecq_pos *pos, unsigned int slot)
+{
+	struct bvecq *spent = pos->bvecq;
+	struct bvecq *next;
+
+again:
+	/* Read the contents of the queue node after the pointer to it. */
+	next = smp_load_acquire(&spent->next);
+	if (!next)
+		return false; /* Nothing more to consume at the moment. */
+	if (slot < bvecq_nr_slots_acquire(spent))
+		return true; /* The producer added more. */
+	next->prev = NULL;
+	spent->next = NULL;
+	bvecq_put(spent);
+	pos->bvecq = next; /* We take spent's ref. */
+	pos->slot = 0;
+	pos->offset = 0;
+	if (!bvecq_acquire_slot(next, 0)) {
+		spent = next;
+		slot = 0;
+		goto again;
+	}
+	return true;
+}
+
 #endif /* _LINUX_BVECQ_H */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f7f55b7621f3..12e5c51c11c8 100644
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
index 83266835b7ad..d5723ce18cbb 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -799,6 +799,30 @@ TRACE_EVENT(netfs_folioq,
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


