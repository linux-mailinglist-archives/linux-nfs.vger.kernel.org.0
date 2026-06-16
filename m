Return-Path: <linux-nfs+bounces-22585-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id czQrKhoiMWoncQUAu9opvQ
	(envelope-from <linux-nfs+bounces-22585-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:14:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CE568E120
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:14:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QBRBrMq+;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22585-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22585-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B811300E313
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 10:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDA43E9FE;
	Tue, 16 Jun 2026 10:10:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705E43E492
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 10:10:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604648; cv=none; b=F6sEDtCdFRAJhwQzNlzUz401tu0w5XB3mU6vTt/Jn9c6qtAf7GOqtxZGXSEaNJHXyqlVd3KwHJjbNiYspXNwNxmYg5h2VYKnGUWYEP6lhKgh/AE/KKx+1xpL94eJxjIcJelTm+oqFfupXO9scj9mpOUzcjmdX898F7Ykh72ojN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604648; c=relaxed/simple;
	bh=bctK2Bk8K4SlcKZNBiRWZ1222z2tioPHoSFiCjMzuWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTz9XtsnthdU5/f6FYO/oAkdbAyVclnsR9EBeqymopTDXiPYBXhlMcAZFOzQl3KIhVfzHmJk3NcQsrgWUKbfpOj9Zc/MQJ5g0xLxh6ps2R3TNV37f7JF9USYS0BGEvOGa8Yr3ExKg0IOnO3+HG8wjjDGafTYAw+k7PES6XP6nTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBRBrMq+; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781604645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRy/mM5NGACWbc/OfQPTMeIFGoXLZ9WFzY3R2BDSxrE=;
	b=QBRBrMq+ZaQAAdZKaYbYnuvfwYzhnbhYiQiHG4eb4gNN7I3jue1vCkUylYwhSblcfPeaIw
	N6IGt99pvbVK3lvhTI+koFyNEGTMLplFUWdVr2gf3oAunXsDB3FCKsvOWNsxOM81C8T6Xn
	YPPMwvODRwPo+nAw0GkMpmWtqYaH8HM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-OVzIrBkYMdWzZQafhbBlXg-1; Tue,
 16 Jun 2026 06:10:40 -0400
X-MC-Unique: OVzIrBkYMdWzZQafhbBlXg-1
X-Mimecast-MFC-AGG-ID: OVzIrBkYMdWzZQafhbBlXg_1781604637
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A130F1955F56;
	Tue, 16 Jun 2026 10:10:37 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 445483008B37;
	Tue, 16 Jun 2026 10:10:31 +0000 (UTC)
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
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v4 15/30] iov_iter: Add a segmented queue of bio_vec[]
Date: Tue, 16 Jun 2026 11:08:04 +0100
Message-ID: <20260616100821.2062304-16-dhowells@redhat.com>
In-Reply-To: <20260616100821.2062304-1-dhowells@redhat.com>
References: <20260616100821.2062304-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22585-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,linux.dev:email,manguebit.org:email,infradead.org:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4CE568E120

Add the concept of a segmented queue of bio_vec[] arrays.  This allows an
indefinite quantity of elements to be handled and allows things like
network filesystems and crypto drivers to glue bits on the ends without
having to reallocate the array.

The bvecq struct that defines each segment also carries capacity/usage
information along with flags indicating whether the constituent memory
regions need freeing or unpinning and the file position of the first
element in a segment.  The bvecq structs are refcounted to allow a queue to
be extracted in batches and split between a number of subrequests.

The bvecq can have the bio_vec[] it manages allocated in with it, but this
is not required.  A flag is provided for if this is the case as comparing
->bv to ->__bv is not sufficient to detect this case.

Add an iterator type ITER_BVECQ for it.  This is intended to replace
ITER_FOLIOQ (and ITER_XARRAY).

Note that the prev pointer is only really needed for iov_iter_revert() and
could be dispensed with if struct iov_iter contained the head information
as well as the current point.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/bvecq.h      |  56 +++++++
 include/linux/iov_iter.h   |  74 ++++++++-
 include/linux/uio.h        |  11 ++
 lib/iov_iter.c             | 324 ++++++++++++++++++++++++++++++++++++-
 lib/scatterlist.c          |  67 +++++++-
 lib/tests/kunit_iov_iter.c | 262 ++++++++++++++++++++++++++++++
 6 files changed, 788 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/bvecq.h

diff --git a/include/linux/bvecq.h b/include/linux/bvecq.h
new file mode 100644
index 000000000000..15f16f905877
--- /dev/null
+++ b/include/linux/bvecq.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Implementation of a segmented queue of bio_vec[].
+ *
+ * Copyright (C) 2026 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _LINUX_BVECQ_H
+#define _LINUX_BVECQ_H
+
+#include <linux/bvec.h>
+
+/*
+ * The type of memory retention used by the elements in bvecq->bv[] and how to
+ * clean it up.
+ */
+enum bvecq_mem {
+	BVECQ_MEM_EXTERNAL,	/* Externally retained memory - no freeing */
+	BVECQ_MEM_PAGECACHE,	/* Ref'd pagecache pages - must put */
+	BVECQ_MEM_GUP,		/* Pinned memory from get_user_pages() - unpin */
+	BVECQ_MEM_ALLOCED,	/* Memory alloc'd by bvecq - can be freed/pooled */
+} __mode(byte);
+
+/*
+ * Segmented bio_vec queue.
+ *
+ * These can be linked together to form messages of indefinite length and
+ * iterated over with an ITER_BVECQ iterator.  The list is non-circular; next
+ * and prev are NULL at the ends.
+ *
+ * The bv pointer points to the bio_vec array; this may be __bv if allocated
+ * together.  The caller is responsible for determining whether or not this is
+ * the case as the array pointed to by bv may be follow on directly from the
+ * bvecq by accident of allocation (ie. ->bv == ->__bv is *not* sufficient to
+ * determine this).
+ *
+ * The file position and discontiguity flag allow non-contiguous data sets to
+ * be chained together, but still teased apart without the need to convert the
+ * info in the bio_vec back into a folio pointer.
+ */
+struct bvecq {
+	struct bvecq	*next;		/* Next bvec in the list or NULL */
+	struct bvecq	*prev;		/* Prev bvec in the list or NULL */
+	unsigned long long fpos;	/* File position */
+	refcount_t	ref;
+	u32		priv;		/* Private data */
+	u16		nr_slots;	/* Number of elements in bv[] used */
+	u16		max_slots;	/* Number of elements allocated in bv[] */
+	enum bvecq_mem	mem_type:3;	/* What sort of memory and how to free it */
+	bool		inline_bv:1;	/* T if __bv[] is being used */
+	bool		discontig:1;	/* T if not contiguous with previous bvecq */
+	struct bio_vec	*bv;		/* Pointer to array of page fragments */
+	struct bio_vec	__bv[];		/* Default array (if ->inline_bv) */
+};
+
+#endif /* _LINUX_BVECQ_H */
diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index f9a17fbbd398..04b8a6d943fa 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -10,6 +10,7 @@
 
 #include <linux/uio.h>
 #include <linux/bvec.h>
+#include <linux/bvecq.h>
 #include <linux/folio_queue.h>
 
 typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
@@ -141,6 +142,71 @@ size_t iterate_bvec(struct iov_iter *iter, size_t len, void *priv, void *priv2,
 	return progress;
 }
 
+/*
+ * Handle ITER_BVECQ.
+ */
+static __always_inline
+size_t iterate_bvecq(struct iov_iter *iter, size_t len, void *priv, void *priv2,
+		     iov_step_f step)
+{
+	const struct bvecq *bq = iter->bvecq;
+	unsigned int slot = iter->bvecq_slot;
+	size_t progress = 0, skip = iter->iov_offset;
+
+	do {
+		const struct bio_vec *bvec;
+		struct page *page;
+		size_t poff, plen;
+		void *base;
+
+		if (slot >= bq->nr_slots) {
+			if (!bq->next)
+				break;
+			bq = bq->next;
+			slot = 0;
+			continue;
+		}
+
+		bvec = &bq->bv[slot];
+		/*
+		 * The caller must ensure that a slot with bv_len>0 has a valid
+		 * bv_page.
+		 */
+		page = bvec->bv_page + (bvec->bv_offset + skip) / PAGE_SIZE;
+		poff = (bvec->bv_offset + skip) % PAGE_SIZE;
+		plen = umin(bvec->bv_len - skip, len);
+
+		while (plen > 0) {
+			size_t part, remain, consumed;
+
+			part = umin(plen, PAGE_SIZE - poff);
+			base = kmap_local_page(page) + poff;
+			remain = step(base, progress, part, priv, priv2);
+			kunmap_local(base);
+
+			consumed = part - remain;
+			progress += consumed;
+			skip += consumed;
+			len -= consumed;
+			if (!len || remain)
+				goto stop;
+			page++;
+			poff = 0;
+			plen -= consumed;
+		}
+
+		skip = 0;
+		slot++;
+	} while (len);
+
+stop:
+	iter->bvecq_slot = slot;
+	iter->bvecq = bq;
+	iter->iov_offset = skip;
+	iter->count -= progress;
+	return progress;
+}
+
 /*
  * Handle ITER_FOLIOQ.
  */
@@ -306,6 +372,8 @@ size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_bvec(iter, len, priv, priv2, step);
 	if (iov_iter_is_kvec(iter))
 		return iterate_kvec(iter, len, priv, priv2, step);
+	if (iov_iter_is_bvecq(iter))
+		return iterate_bvecq(iter, len, priv, priv2, step);
 	if (iov_iter_is_folioq(iter))
 		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
@@ -342,8 +410,8 @@ size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
  * buffer is presented in segments, which for kernel iteration are broken up by
  * physical pages and mapped, with the mapped address being presented.
  *
- * [!] Note This will only handle BVEC, KVEC, FOLIOQ, XARRAY and DISCARD-type
- * iterators; it will not handle UBUF or IOVEC-type iterators.
+ * [!] Note This will only handle BVEC, KVEC, BVECQ, FOLIOQ, XARRAY and
+ * DISCARD-type iterators; it will not handle UBUF or IOVEC-type iterators.
  *
  * A step functions, @step, must be provided, one for handling mapped kernel
  * addresses and the other is given user addresses which have the potential to
@@ -370,6 +438,8 @@ size_t iterate_and_advance_kernel(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_bvec(iter, len, priv, priv2, step);
 	if (iov_iter_is_kvec(iter))
 		return iterate_kvec(iter, len, priv, priv2, step);
+	if (iov_iter_is_bvecq(iter))
+		return iterate_bvecq(iter, len, priv, priv2, step);
 	if (iov_iter_is_folioq(iter))
 		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
diff --git a/include/linux/uio.h b/include/linux/uio.h
index a9bc5b3067e3..f7cfa6ea8213 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -26,6 +26,7 @@ enum iter_type {
 	ITER_IOVEC,
 	ITER_BVEC,
 	ITER_KVEC,
+	ITER_BVECQ,
 	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
@@ -68,6 +69,7 @@ struct iov_iter {
 				const struct iovec *__iov;
 				const struct kvec *kvec;
 				const struct bio_vec *bvec;
+				const struct bvecq *bvecq;
 				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
@@ -77,6 +79,7 @@ struct iov_iter {
 	};
 	union {
 		unsigned long nr_segs;
+		u16 bvecq_slot;
 		u8 folioq_slot;
 		loff_t xarray_start;
 	};
@@ -145,6 +148,11 @@ static inline bool iov_iter_is_discard(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_DISCARD;
 }
 
+static inline bool iov_iter_is_bvecq(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_BVECQ;
+}
+
 static inline bool iov_iter_is_folioq(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_FOLIOQ;
@@ -295,6 +303,9 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec
 void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
 			unsigned long nr_segs, size_t count);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
+void iov_iter_bvec_queue(struct iov_iter *i, unsigned int direction,
+			 const struct bvecq *bvecq,
+			 unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  const struct folio_queue *folioq,
 			  unsigned int first_slot, unsigned int offset, size_t count);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 49bca2c2f019..205d0da47b12 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -538,6 +538,40 @@ static void iov_iter_iovec_advance(struct iov_iter *i, size_t size)
 	i->__iov = iov;
 }
 
+static void iov_iter_bvecq_advance(struct iov_iter *i, size_t by)
+{
+	const struct bvecq *bq = i->bvecq;
+	unsigned int slot = i->bvecq_slot;
+
+	if (!i->count)
+		return;
+	i->count -= by;
+
+	by += i->iov_offset; /* From beginning of current segment. */
+	do {
+		size_t len;
+
+		if (slot >= bq->nr_slots) {
+			if (!bq->next)
+				break;
+			bq = bq->next;
+			slot = 0;
+			continue;
+		}
+
+		len = bq->bv[slot].bv_len;
+
+		if (likely(by < len))
+			break;
+		by -= len;
+		slot++;
+	} while (by);
+
+	i->iov_offset = by;
+	i->bvecq_slot = slot;
+	i->bvecq = bq;
+}
+
 static void iov_iter_folioq_advance(struct iov_iter *i, size_t size)
 {
 	const struct folio_queue *folioq = i->folioq;
@@ -583,6 +617,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		iov_iter_iovec_advance(i, size);
 	} else if (iov_iter_is_bvec(i)) {
 		iov_iter_bvec_advance(i, size);
+	} else if (iov_iter_is_bvecq(i)) {
+		iov_iter_bvecq_advance(i, size);
 	} else if (iov_iter_is_folioq(i)) {
 		iov_iter_folioq_advance(i, size);
 	} else if (iov_iter_is_discard(i)) {
@@ -591,6 +627,33 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 }
 EXPORT_SYMBOL(iov_iter_advance);
 
+static void iov_iter_bvecq_revert(struct iov_iter *i, size_t unroll)
+{
+	const struct bvecq *bq = i->bvecq;
+	unsigned int slot = i->bvecq_slot;
+
+	for (;;) {
+		size_t len;
+
+		if (slot == 0) {
+			bq = bq->prev;
+			slot = bq->nr_slots;
+			continue;
+		}
+		slot--;
+
+		len = bq->bv[slot].bv_len;
+		if (unroll <= len) {
+			i->iov_offset = len - unroll;
+			break;
+		}
+		unroll -= len;
+	}
+
+	i->bvecq_slot = slot;
+	i->bvecq = bq;
+}
+
 static void iov_iter_folioq_revert(struct iov_iter *i, size_t unroll)
 {
 	const struct folio_queue *folioq = i->folioq;
@@ -648,6 +711,9 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 			}
 			unroll -= n;
 		}
+	} else if (iov_iter_is_bvecq(i)) {
+		i->iov_offset = 0;
+		iov_iter_bvecq_revert(i, unroll);
 	} else if (iov_iter_is_folioq(i)) {
 		i->iov_offset = 0;
 		iov_iter_folioq_revert(i, unroll);
@@ -678,9 +744,24 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 		if (iov_iter_is_bvec(i))
 			return min(i->count, i->bvec->bv_len - i->iov_offset);
 	}
+	if (!i->count)
+		return 0;
+	if (unlikely(iov_iter_is_bvecq(i))) {
+		const struct bvecq *bq = i->bvecq;
+		unsigned int slot = i->bvecq_slot;
+		size_t offset = i->iov_offset;
+
+		while (slot >= bq->nr_slots) {
+			bq = bq->next;
+			if (!bq)
+				return 0;
+			slot = 0;
+			offset = 0;
+		}
+		return umin(i->count, bq->bv[slot].bv_len - offset);
+	}
 	if (unlikely(iov_iter_is_folioq(i)))
-		return !i->count ? 0 :
-			umin(folioq_folio_size(i->folioq, i->folioq_slot), i->count);
+		return umin(folioq_folio_size(i->folioq, i->folioq_slot), i->count);
 	return i->count;
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
@@ -717,6 +798,35 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_bvec);
 
+/**
+ * iov_iter_bvec_queue - Initialise an I/O iterator to use a segmented bvec queue
+ * @i: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @bvecq: The starting point in the bvec queue.
+ * @first_slot: The first slot in the bvec queue to use
+ * @offset: The offset into the bvec in the first slot to start at
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator to either draw data out of the buffers attached to an
+ * inode or to inject data into those buffers.  The pages *must* be prevented
+ * from evaporation, either by the caller.
+ */
+void iov_iter_bvec_queue(struct iov_iter *i, unsigned int direction,
+			 const struct bvecq *bvecq, unsigned int first_slot,
+			 unsigned int offset, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter) {
+		.iter_type	= ITER_BVECQ,
+		.data_source	= direction,
+		.bvecq		= bvecq,
+		.bvecq_slot	= first_slot,
+		.count		= count,
+		.iov_offset	= offset,
+	};
+}
+EXPORT_SYMBOL(iov_iter_bvec_queue);
+
 /**
  * iov_iter_folio_queue - Initialise an I/O iterator to use the folios in a folio queue
  * @i: The iterator to initialise.
@@ -839,6 +949,37 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 	return res;
 }
 
+static unsigned long iov_iter_alignment_bvecq(const struct iov_iter *iter)
+{
+	const struct bvecq *bq;
+	unsigned long res = 0;
+	unsigned int slot = iter->bvecq_slot;
+	size_t skip = iter->iov_offset;
+	size_t size = iter->count;
+
+	if (!size)
+		return res;
+
+	for (bq = iter->bvecq; bq; bq = bq->next) {
+		for (; slot < bq->nr_slots; slot++) {
+			const struct bio_vec *bvec = &bq->bv[slot];
+			size_t part = umin(bvec->bv_len - skip, size);
+
+			res |= bvec->bv_offset + skip;
+			res |= part;
+
+			size -= part;
+			if (size == 0)
+				return res;
+			skip = 0;
+		}
+
+		slot = 0;
+	}
+
+	return res;
+}
+
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
 	if (likely(iter_is_ubuf(i))) {
@@ -854,6 +995,8 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 
 	if (iov_iter_is_bvec(i))
 		return iov_iter_alignment_bvec(i);
+	if (iov_iter_is_bvecq(i))
+		return iov_iter_alignment_bvecq(i);
 
 	/* With both xarray and folioq types, we're dealing with whole folios. */
 	if (iov_iter_is_folioq(i))
@@ -1066,6 +1209,36 @@ static int bvec_npages(const struct iov_iter *i, int maxpages)
 	return npages;
 }
 
+static size_t iov_npages_bvecq(const struct iov_iter *iter, size_t maxpages)
+{
+	const struct bvecq *bq;
+	unsigned int slot = iter->bvecq_slot;
+	size_t npages = 0;
+	size_t skip = iter->iov_offset;
+	size_t size = iter->count;
+
+	for (bq = iter->bvecq; bq; bq = bq->next) {
+		for (; slot < bq->nr_slots; slot++) {
+			const struct bio_vec *bvec = &bq->bv[slot];
+			size_t offs = (bvec->bv_offset + skip) % PAGE_SIZE;
+			size_t part = umin(bvec->bv_len - skip, size);
+
+			npages += DIV_ROUND_UP(offs + part, PAGE_SIZE);
+			if (npages >= maxpages)
+				goto out;
+
+			size -= part;
+			if (!size)
+				goto out;
+			skip = 0;
+		}
+
+		slot = 0;
+	}
+out:
+	return umin(npages, maxpages);
+}
+
 int iov_iter_npages(const struct iov_iter *i, int maxpages)
 {
 	if (unlikely(!i->count))
@@ -1080,6 +1253,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		return iov_npages(i, maxpages);
 	if (iov_iter_is_bvec(i))
 		return bvec_npages(i, maxpages);
+	if (iov_iter_is_bvecq(i))
+		return iov_npages_bvecq(i, maxpages);
 	if (iov_iter_is_folioq(i)) {
 		unsigned offset = i->iov_offset % PAGE_SIZE;
 		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
@@ -1366,6 +1541,147 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 	i->nr_segs = state->nr_segs;
 }
 
+/*
+ * Count the number of virtually contiguous pages coming up next in an
+ * ITER_BVECQ iterator, up to the specified maxima.
+ */
+static unsigned int iter_count_bvecq_pages(const struct iov_iter *iter,
+					   size_t maxsize,
+					   unsigned int maxpages)
+{
+	const struct bvecq *bvecq = iter->bvecq;
+	unsigned int slot = iter->bvecq_slot;
+	ssize_t remain = umin(maxsize, iter->count);
+	size_t count = 0, offset = iter->iov_offset;
+
+	do {
+		const struct bio_vec *bv;
+		size_t boff, blen;
+
+		if (slot >= bvecq->nr_slots) {
+			if (!bvecq->next) {
+				WARN_ON_ONCE(remain > 0);
+				break;
+			}
+			bvecq = bvecq->next;
+			slot = 0;
+			offset = 0;
+			continue;
+		}
+
+		bv = &bvecq->bv[slot++];
+		boff = bv->bv_offset;
+		blen = bv->bv_len;
+
+		if (unlikely(!bv->bv_page)) {
+			if (blen && count > 0)
+				break;
+			continue;
+		}
+		if (!PAGE_ALIGNED(boff) && count > 0)
+			break;
+
+		boff += offset;
+		blen -= offset;
+		offset = 0;
+		if (!blen)
+			continue;
+
+		blen = umin(blen, remain);
+		remain -= blen;
+		blen += offset_in_page(boff);
+		count += DIV_ROUND_UP(blen, PAGE_SIZE);
+
+		if (!PAGE_ALIGNED(blen))
+			break;
+	} while (remain > 0 && count < maxpages);
+
+	return umin(count, maxpages);
+}
+
+/*
+ * Extract a list of virtually contiguous pages from an ITER_BVECQ iterator.
+ * This does not get references on the pages, nor does it get a pin on them.
+ */
+static ssize_t iov_iter_extract_bvecq_pages(struct iov_iter *iter,
+					    struct page ***pages, size_t maxsize,
+					    unsigned int maxpages,
+					    iov_iter_extraction_t extraction_flags,
+					    size_t *offset0)
+{
+	const struct bvecq *bvecq;
+	struct page **p;
+	unsigned int slot, nr = 0;
+	size_t extracted = 0, offset;
+
+	/* Count the next run of virtually contiguous pages. */
+	maxpages = iter_count_bvecq_pages(iter, maxsize, maxpages);
+
+	if (!*pages) {
+		*pages = kvmalloc_array(maxpages, sizeof(struct page *), GFP_KERNEL);
+		if (!*pages)
+			return -ENOMEM;
+	}
+
+	p = *pages;
+
+	/* Now transcribe the page pointers. */
+	extracted = 0;
+	bvecq = iter->bvecq;
+	offset = iter->iov_offset;
+	slot = iter->bvecq_slot;
+
+	do {
+		const struct bio_vec *bv;
+		size_t boff, blen;
+
+		if (slot >= bvecq->nr_slots) {
+			if (!bvecq->next) {
+				WARN_ON_ONCE(extracted < iter->count);
+				break;
+			}
+			bvecq = bvecq->next;
+			slot = 0;
+			offset = 0;
+			continue;
+		}
+
+		bv = &bvecq->bv[slot];
+		boff = bv->bv_offset;
+		blen = bv->bv_len;
+
+		if (!bv->bv_page)
+			blen = 0;
+
+		if (offset < blen) {
+			size_t part = umin(maxsize - extracted, blen - offset);
+			size_t poff = (boff + offset) % PAGE_SIZE;
+			size_t pix = (boff + offset) / PAGE_SIZE;
+
+			if (poff + part > PAGE_SIZE)
+				part = PAGE_SIZE - poff;
+
+			if (!extracted)
+				*offset0 = poff;
+
+			p[nr++] = bv->bv_page + pix;
+			offset += part;
+			extracted += part;
+		}
+
+		if (offset >= blen) {
+			offset = 0;
+			slot++;
+		}
+	} while (nr < maxpages && extracted < maxsize);
+
+	iter->bvecq = bvecq;
+	iter->bvecq_slot = slot;
+	iter->iov_offset = offset;
+	iter->count -= extracted;
+	return extracted;
+}
+
 /*
  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
  * not get references on the pages, nor does it get a pin on them.
@@ -1713,6 +2029,10 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 		return iov_iter_extract_bvec_pages(i, pages, maxsize,
 						   maxpages, extraction_flags,
 						   offset0);
+	if (iov_iter_is_bvecq(i))
+		return iov_iter_extract_bvecq_pages(i, pages, maxsize,
+						    maxpages, extraction_flags,
+						    offset0);
 	if (iov_iter_is_folioq(i))
 		return iov_iter_extract_folioq_pages(i, pages, maxsize,
 						     maxpages, extraction_flags,
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 6ea40d2e6247..23e5a180103b 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -10,6 +10,7 @@
 #include <linux/highmem.h>
 #include <linux/kmemleak.h>
 #include <linux/bvec.h>
+#include <linux/bvecq.h>
 #include <linux/uio.h>
 #include <linux/folio_queue.h>
 
@@ -1267,6 +1268,65 @@ static ssize_t extract_kvec_to_sg(struct iov_iter *iter,
 	return ret;
 }
 
+/*
+ * Extract up to sg_max folios from an BVECQ-type iterator and add them to
+ * the scatterlist.  The pages are not pinned.
+ */
+static ssize_t extract_bvecq_to_sg(struct iov_iter *iter,
+				   ssize_t maxsize,
+				   struct sg_table *sgtable,
+				   unsigned int sg_max,
+				   iov_iter_extraction_t extraction_flags)
+{
+	const struct bvecq *bvecq = iter->bvecq;
+	struct scatterlist *sg = sgtable->sgl + sgtable->nents;
+	unsigned int slot = iter->bvecq_slot;
+	ssize_t ret = 0;
+	size_t offset = iter->iov_offset;
+
+	maxsize = umin(maxsize, iov_iter_count(iter));
+
+	while (sg_max > 0 && ret < maxsize) {
+		const struct bio_vec *bv;
+		size_t blen, part;
+
+		if (slot >= bvecq->nr_slots) {
+			if (!bvecq->next) {
+				WARN_ON_ONCE(ret < iter->count);
+				break;
+			}
+			bvecq = bvecq->next;
+			slot = 0;
+			offset = 0;
+			continue;
+		}
+
+		bv = &bvecq->bv[slot];
+		blen = bv->bv_len;
+
+		if (offset >= blen) {
+			offset = 0;
+			slot++;
+			continue;
+		}
+
+		part = umin(maxsize - ret, blen - offset);
+
+		sg_set_page(sg, bv->bv_page, part, bv->bv_offset + offset);
+		sgtable->nents++;
+		sg++;
+		sg_max--;
+		offset += part;
+		ret += part;
+	}
+
+	iter->bvecq = bvecq;
+	iter->bvecq_slot = slot;
+	iter->iov_offset = offset;
+	iter->count -= ret;
+	return ret;
+}
+
 /*
  * Extract up to sg_max folios from an FOLIOQ-type iterator and add them to
  * the scatterlist.  The pages are not pinned.
@@ -1391,8 +1451,8 @@ static ssize_t extract_xarray_to_sg(struct iov_iter *iter,
  * addition of @sg_max elements.
  *
  * The pages referred to by UBUF- and IOVEC-type iterators are extracted and
- * pinned; BVEC-, KVEC-, FOLIOQ- and XARRAY-type are extracted but aren't
- * pinned; DISCARD-type is not supported.
+ * pinned; BVEC-, BVECQ-, KVEC-, FOLIOQ- and XARRAY-type are extracted but
+ * aren't pinned; DISCARD-type is not supported.
  *
  * No end mark is placed on the scatterlist; that's left to the caller.
  *
@@ -1424,6 +1484,9 @@ ssize_t extract_iter_to_sg(struct iov_iter *iter, size_t maxsize,
 	case ITER_KVEC:
 		return extract_kvec_to_sg(iter, maxsize, sgtable, sg_max,
 					  extraction_flags);
+	case ITER_BVECQ:
+		return extract_bvecq_to_sg(iter, maxsize, sgtable, sg_max,
+					   extraction_flags);
 	case ITER_FOLIOQ:
 		return extract_folioq_to_sg(iter, maxsize, sgtable, sg_max,
 					    extraction_flags);
diff --git a/lib/tests/kunit_iov_iter.c b/lib/tests/kunit_iov_iter.c
index e7e154f94f66..df3e78e7c7aa 100644
--- a/lib/tests/kunit_iov_iter.c
+++ b/lib/tests/kunit_iov_iter.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/uio.h>
 #include <linux/bvec.h>
+#include <linux/bvecq.h>
 #include <linux/folio_queue.h>
 #include <linux/scatterlist.h>
 #include <linux/minmax.h>
@@ -544,6 +545,185 @@ static void __init iov_kunit_copy_from_folioq(struct kunit *test)
 	KUNIT_SUCCEED(test);
 }
 
+static void iov_kunit_destroy_bvecq(void *data)
+{
+	struct bvecq *bq, *next;
+
+	for (bq = data; bq; bq = next) {
+		next = bq->next;
+		for (int i = 0; i < bq->nr_slots; i++)
+			if (bq->bv[i].bv_page)
+				put_page(bq->bv[i].bv_page);
+		kfree(bq);
+	}
+}
+
+static struct bvecq *iov_kunit_alloc_bvecq(struct kunit *test, unsigned int max_slots)
+{
+	struct bvecq *bq;
+
+	bq = kzalloc(struct_size(bq, __bv, max_slots), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bq);
+	bq->max_slots = max_slots;
+	bq->bv = bq->__bv;
+	bq->inline_bv = true;
+	return bq;
+}
+
+static struct bvecq *iov_kunit_create_bvecq(struct kunit *test, unsigned int max_slots)
+{
+	struct bvecq *bq;
+
+	bq = iov_kunit_alloc_bvecq(test, max_slots);
+	kunit_add_action_or_reset(test, iov_kunit_destroy_bvecq, bq);
+	return bq;
+}
+
+static void __init iov_kunit_load_bvecq(struct kunit *test,
+					struct iov_iter *iter, int dir,
+					struct bvecq *bq_head,
+					struct page **pages, size_t npages)
+{
+	struct bvecq *bq = bq_head;
+	size_t size = 0;
+
+	for (int i = 0; i < npages; i++) {
+		if (bq->nr_slots >= bq->max_slots) {
+			bq->next = iov_kunit_alloc_bvecq(test, 13);
+			bq->next->prev = bq;
+			bq = bq->next;
+		}
+		bvec_set_page(&bq->bv[bq->nr_slots], pages[i], PAGE_SIZE, 0);
+		bq->nr_slots++;
+		size += PAGE_SIZE;
+	}
+	iov_iter_bvec_queue(iter, dir, bq_head, 0, 0, size);
+}
+
+/*
+ * Test copying to a ITER_BVECQ-type iterator.
+ */
+static void __init iov_kunit_copy_to_bvecq(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct bvecq *bq;
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, patt;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	bq = iov_kunit_create_bvecq(test, 13);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	for (i = 0; i < bufsize; i++)
+		scratch[i] = pattern(i);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	memset(buffer, 0, bufsize);
+
+	iov_kunit_load_bvecq(test, &iter, READ, bq, bpages, npages);
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_bvec_queue(&iter, READ, bq, 0, 0, pr->to);
+		iov_iter_advance(&iter, pr->from);
+		copied = copy_to_iter(scratch + i, size, &iter);
+
+		KUNIT_EXPECT_EQ(test, copied, size);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+		i += size;
+		if (test->status == KUNIT_FAILURE)
+			goto stop;
+	}
+
+	/* Build the expected image in the scratch buffer. */
+	patt = 0;
+	memset(scratch, 0, bufsize);
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
+		for (i = pr->from; i < pr->to; i++)
+			scratch[i] = pattern(patt++);
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
+		if (buffer[i] != scratch[i])
+			return;
+	}
+
+stop:
+	KUNIT_SUCCEED(test);
+}
+
+/*
+ * Test copying from a ITER_BVECQ-type iterator.
+ */
+static void __init iov_kunit_copy_from_bvecq(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct bvecq *bq;
+	struct page **spages, **bpages;
+	u8 *scratch, *buffer;
+	size_t bufsize, npages, size, copied;
+	int i, j;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	bq = iov_kunit_create_bvecq(test, 13);
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+	for (i = 0; i < bufsize; i++)
+		buffer[i] = pattern(i);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	memset(scratch, 0, bufsize);
+
+	iov_kunit_load_bvecq(test, &iter, READ, bq, bpages, npages);
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_bvec_queue(&iter, WRITE, bq, 0, 0, pr->to);
+		iov_iter_advance(&iter, pr->from);
+		copied = copy_from_iter(scratch + i, size, &iter);
+
+		KUNIT_EXPECT_EQ(test, copied, size);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+		i += size;
+	}
+
+	/* Build the expected image in the main buffer. */
+	i = 0;
+	memset(buffer, 0, bufsize);
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		for (j = pr->from; j < pr->to; j++) {
+			buffer[i++] = pattern(j);
+			if (i >= bufsize)
+				goto stop;
+		}
+	}
+stop:
+
+	/* Compare the images */
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
+		if (scratch[i] != buffer[i])
+			return;
+	}
+
+	KUNIT_SUCCEED(test);
+}
+
 static void iov_kunit_destroy_xarray(void *data)
 {
 	struct xarray *xarray = data;
@@ -859,6 +1039,85 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 	KUNIT_SUCCEED(test);
 }
 
+/*
+ * Test the extraction of ITER_BVECQ-type iterators.
+ */
+static void __init iov_kunit_extract_pages_bvecq(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct bvecq *bq;
+	struct page **bpages, *pagelist[8], **pages = pagelist;
+	ssize_t len;
+	size_t bufsize, size = 0, npages;
+	int i, from;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	bq = iov_kunit_create_bvecq(test, 13);
+
+	iov_kunit_create_buffer(test, &bpages, npages);
+	iov_kunit_load_bvecq(test, &iter, READ, bq, bpages, npages);
+
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		from = pr->from;
+		size = pr->to - from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_bvec_queue(&iter, WRITE, bq, 0, 0, pr->to);
+		iov_iter_advance(&iter, from);
+
+		do {
+			size_t offset0 = LONG_MAX;
+
+			for (i = 0; i < ARRAY_SIZE(pagelist); i++)
+				pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
+
+			len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
+						     ARRAY_SIZE(pagelist), 0, &offset0);
+			KUNIT_EXPECT_GE(test, len, 0);
+			if (len < 0)
+				break;
+			KUNIT_EXPECT_LE(test, len, size);
+			KUNIT_EXPECT_EQ(test, iter.count, size - len);
+			if (len == 0)
+				break;
+			size -= len;
+			KUNIT_EXPECT_GE(test, (ssize_t)offset0, 0);
+			KUNIT_EXPECT_LT(test, offset0, PAGE_SIZE);
+
+			for (i = 0; i < ARRAY_SIZE(pagelist); i++) {
+				struct page *p;
+				ssize_t part = min_t(ssize_t, len, PAGE_SIZE - offset0);
+				int ix;
+
+				KUNIT_ASSERT_GE(test, part, 0);
+				ix = from / PAGE_SIZE;
+				KUNIT_ASSERT_LT(test, ix, npages);
+				p = bpages[ix];
+				KUNIT_EXPECT_PTR_EQ(test, pagelist[i], p);
+				KUNIT_EXPECT_EQ(test, offset0, from % PAGE_SIZE);
+				from += part;
+				len -= part;
+				KUNIT_ASSERT_GE(test, len, 0);
+				if (len == 0)
+					break;
+				offset0 = 0;
+			}
+
+			if (test->status == KUNIT_FAILURE)
+				goto stop;
+		} while (iov_iter_count(&iter) > 0);
+
+		KUNIT_EXPECT_EQ(test, size, 0);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+	}
+
+stop:
+	KUNIT_SUCCEED(test);
+}
+
 /*
  * Test the extraction of ITER_FOLIOQ-type iterators.
  */
@@ -1218,12 +1477,15 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_copy_from_kvec),
 	KUNIT_CASE(iov_kunit_copy_to_bvec),
 	KUNIT_CASE(iov_kunit_copy_from_bvec),
+	KUNIT_CASE(iov_kunit_copy_to_bvecq),
+	KUNIT_CASE(iov_kunit_copy_from_bvecq),
 	KUNIT_CASE(iov_kunit_copy_to_folioq),
 	KUNIT_CASE(iov_kunit_copy_from_folioq),
 	KUNIT_CASE(iov_kunit_copy_to_xarray),
 	KUNIT_CASE(iov_kunit_copy_from_xarray),
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvec),
+	KUNIT_CASE(iov_kunit_extract_pages_bvecq),
 	KUNIT_CASE(iov_kunit_extract_pages_folioq),
 	KUNIT_CASE(iov_kunit_extract_pages_xarray),
 	KUNIT_CASE(iov_kunit_iter_to_sg_kvec),


