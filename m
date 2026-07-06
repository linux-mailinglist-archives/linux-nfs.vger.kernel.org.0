Return-Path: <linux-nfs+bounces-23094-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /S4gMNPQS2o5awEAu9opvQ
	(envelope-from <linux-nfs+bounces-23094-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 17:59:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F98712F1C
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 17:59:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="DEA1ISM/";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23094-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23094-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A4B231D931B
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D2243B6EA;
	Mon,  6 Jul 2026 15:36:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A943B6E6
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 15:36:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352205; cv=none; b=LqS6IZkYLNrgfCBQzjrM6m/rEpaZQC/2hxWeQodoC0qAzFq/DsIYuFLkz09AUmekO4GtRNDeY96Jhq9pe0cjXnRg+0n7upsXJ5sUvy6ZRoXZjfgzo2unv1/5YOd/n3j2niZZ/QjfPxrn1OaKhDbv/+7AJ4TKZlhLM/PJFkK6Jps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352205; c=relaxed/simple;
	bh=Ow4fiugH+7EidhSkpBGys6+THliwj+tmze/zcGqUt94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2L4yXO9apI+eJHoUBTOhB4hcGgrYJVi0QcnkSc7/juHzieD/AYx3b5j2BSrNuDIl0hUy9/rw/dzxJgC7Uxcaw6C3ZmdX0G3BbWXduosyDGb7VbgMPJxucrEwuORHJ2i+lkDih6ixrQIH6djzH2Om91svH7QZVub1Rja7ukjEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEA1ISM/; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783352201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JosLALPUXJy0yhAzS1JZsdigo/2vkT0o1MZ+E4rcuiE=;
	b=DEA1ISM/YLvFVx+nXJQY+IrH43lVyGx18WB3PlHdXCNftIACyH7zyWdd3bYsCOoLdSbVuc
	hJDvx1WxIp9SWv10NYP16R4OGTYMp55FzHqHZEZaWWBVA8NpLfs163w6pCqfHPR62X9u+O
	fioo5F1t7KYGsIwebS+jz1VZ4YlrUGk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-gSpsSTTdNQeYdwOTFu5CaA-1; Mon,
 06 Jul 2026 11:36:35 -0400
X-MC-Unique: gSpsSTTdNQeYdwOTFu5CaA-1
X-Mimecast-MFC-AGG-ID: gSpsSTTdNQeYdwOTFu5CaA_1783352192
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D3421955F21;
	Mon,  6 Jul 2026 15:36:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 019F218005A2;
	Mon,  6 Jul 2026 15:36:25 +0000 (UTC)
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
	Stefan Metzmacher <metze@samba.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/21] iov_iter: Remove ITER_FOLIOQ
Date: Mon,  6 Jul 2026 16:34:03 +0100
Message-ID: <20260706153408.1231650-18-dhowells@redhat.com>
In-Reply-To: <20260706153408.1231650-1-dhowells@redhat.com>
References: <20260706153408.1231650-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-23094-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:metze@samba.org,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email,vger.kernel.org:from_smtp,samba.org:email,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53F98712F1C

Remove ITER_FOLIOQ as it's no longer used.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/iov_iter.h   |  65 +--------
 include/linux/uio.h        |  12 --
 lib/iov_iter.c             | 175 +-----------------------
 lib/scatterlist.c          |  69 +---------
 lib/tests/kunit_iov_iter.c | 271 -------------------------------------
 5 files changed, 7 insertions(+), 585 deletions(-)

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index 04b8a6d943fa..4e7d69b4ace2 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -11,7 +11,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/bvecq.h>
-#include <linux/folio_queue.h>
 
 typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
 			     void *priv, void *priv2);
@@ -207,62 +206,6 @@ size_t iterate_bvecq(struct iov_iter *iter, size_t len, void *priv, void *priv2,
 	return progress;
 }
 
-/*
- * Handle ITER_FOLIOQ.
- */
-static __always_inline
-size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2,
-		      iov_step_f step)
-{
-	const struct folio_queue *folioq = iter->folioq;
-	unsigned int slot = iter->folioq_slot;
-	size_t progress = 0, skip = iter->iov_offset;
-
-	if (slot == folioq_nr_slots(folioq)) {
-		/* The iterator may have been extended. */
-		folioq = folioq->next;
-		slot = 0;
-	}
-
-	do {
-		struct folio *folio = folioq_folio(folioq, slot);
-		size_t part, remain = 0, consumed;
-		size_t fsize;
-		void *base;
-
-		if (!folio)
-			break;
-
-		fsize = folioq_folio_size(folioq, slot);
-		if (skip < fsize) {
-			base = kmap_local_folio(folio, skip);
-			part = umin(len, PAGE_SIZE - skip % PAGE_SIZE);
-			remain = step(base, progress, part, priv, priv2);
-			kunmap_local(base);
-			consumed = part - remain;
-			len -= consumed;
-			progress += consumed;
-			skip += consumed;
-		}
-		if (skip >= fsize) {
-			skip = 0;
-			slot++;
-			if (slot == folioq_nr_slots(folioq) && folioq->next) {
-				folioq = folioq->next;
-				slot = 0;
-			}
-		}
-		if (remain)
-			break;
-	} while (len);
-
-	iter->folioq_slot = slot;
-	iter->folioq = folioq;
-	iter->iov_offset = skip;
-	iter->count -= progress;
-	return progress;
-}
-
 /*
  * Handle ITER_XARRAY.
  */
@@ -374,8 +317,6 @@ size_t iterate_and_advance2(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_kvec(iter, len, priv, priv2, step);
 	if (iov_iter_is_bvecq(iter))
 		return iterate_bvecq(iter, len, priv, priv2, step);
-	if (iov_iter_is_folioq(iter))
-		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, priv2, step);
 	return iterate_discard(iter, len, priv, priv2, step);
@@ -410,8 +351,8 @@ size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
  * buffer is presented in segments, which for kernel iteration are broken up by
  * physical pages and mapped, with the mapped address being presented.
  *
- * [!] Note This will only handle BVEC, KVEC, BVECQ, FOLIOQ, XARRAY and
- * DISCARD-type iterators; it will not handle UBUF or IOVEC-type iterators.
+ * [!] Note This will only handle BVEC, KVEC, BVECQ, XARRAY and DISCARD-type
+ * iterators; it will not handle UBUF or IOVEC-type iterators.
  *
  * A step functions, @step, must be provided, one for handling mapped kernel
  * addresses and the other is given user addresses which have the potential to
@@ -440,8 +381,6 @@ size_t iterate_and_advance_kernel(struct iov_iter *iter, size_t len, void *priv,
 		return iterate_kvec(iter, len, priv, priv2, step);
 	if (iov_iter_is_bvecq(iter))
 		return iterate_bvecq(iter, len, priv, priv2, step);
-	if (iov_iter_is_folioq(iter))
-		return iterate_folioq(iter, len, priv, priv2, step);
 	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, priv2, step);
 	return iterate_discard(iter, len, priv, priv2, step);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index f7cfa6ea8213..e84a0c4f28c6 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -11,7 +11,6 @@
 #include <uapi/linux/uio.h>
 
 struct page;
-struct folio_queue;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -27,7 +26,6 @@ enum iter_type {
 	ITER_BVEC,
 	ITER_KVEC,
 	ITER_BVECQ,
-	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
 };
@@ -70,7 +68,6 @@ struct iov_iter {
 				const struct kvec *kvec;
 				const struct bio_vec *bvec;
 				const struct bvecq *bvecq;
-				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
 			};
@@ -80,7 +77,6 @@ struct iov_iter {
 	union {
 		unsigned long nr_segs;
 		u16 bvecq_slot;
-		u8 folioq_slot;
 		loff_t xarray_start;
 	};
 };
@@ -153,11 +149,6 @@ static inline bool iov_iter_is_bvecq(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_BVECQ;
 }
 
-static inline bool iov_iter_is_folioq(const struct iov_iter *i)
-{
-	return iov_iter_type(i) == ITER_FOLIOQ;
-}
-
 static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 {
 	return iov_iter_type(i) == ITER_XARRAY;
@@ -306,9 +297,6 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 void iov_iter_bvec_queue(struct iov_iter *i, unsigned int direction,
 			 const struct bvecq *bvecq,
 			 unsigned int first_slot, unsigned int offset, size_t count);
-void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
-			  const struct folio_queue *folioq,
-			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 29ec77a0d2b4..25e1527d34a6 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -572,39 +572,6 @@ static void iov_iter_bvecq_advance(struct iov_iter *i, size_t by)
 	i->bvecq = bq;
 }
 
-static void iov_iter_folioq_advance(struct iov_iter *i, size_t size)
-{
-	const struct folio_queue *folioq = i->folioq;
-	unsigned int slot = i->folioq_slot;
-
-	if (!i->count)
-		return;
-	i->count -= size;
-
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = folioq->next;
-		slot = 0;
-	}
-
-	size += i->iov_offset; /* From beginning of current segment. */
-	do {
-		size_t fsize = folioq_folio_size(folioq, slot);
-
-		if (likely(size < fsize))
-			break;
-		size -= fsize;
-		slot++;
-		if (slot >= folioq_nr_slots(folioq) && folioq->next) {
-			folioq = folioq->next;
-			slot = 0;
-		}
-	} while (size);
-
-	i->iov_offset = size;
-	i->folioq_slot = slot;
-	i->folioq = folioq;
-}
-
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
@@ -619,8 +586,6 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		iov_iter_bvec_advance(i, size);
 	} else if (iov_iter_is_bvecq(i)) {
 		iov_iter_bvecq_advance(i, size);
-	} else if (iov_iter_is_folioq(i)) {
-		iov_iter_folioq_advance(i, size);
 	} else if (iov_iter_is_discard(i)) {
 		i->count -= size;
 	}
@@ -654,32 +619,6 @@ static void iov_iter_bvecq_revert(struct iov_iter *i, size_t unroll)
 	i->bvecq = bq;
 }
 
-static void iov_iter_folioq_revert(struct iov_iter *i, size_t unroll)
-{
-	const struct folio_queue *folioq = i->folioq;
-	unsigned int slot = i->folioq_slot;
-
-	for (;;) {
-		size_t fsize;
-
-		if (slot == 0) {
-			folioq = folioq->prev;
-			slot = folioq_nr_slots(folioq);
-		}
-		slot--;
-
-		fsize = folioq_folio_size(folioq, slot);
-		if (unroll <= fsize) {
-			i->iov_offset = fsize - unroll;
-			break;
-		}
-		unroll -= fsize;
-	}
-
-	i->folioq_slot = slot;
-	i->folioq = folioq;
-}
-
 void iov_iter_revert(struct iov_iter *i, size_t unroll)
 {
 	if (!unroll)
@@ -714,9 +653,6 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 	} else if (iov_iter_is_bvecq(i)) {
 		i->iov_offset = 0;
 		iov_iter_bvecq_revert(i, unroll);
-	} else if (iov_iter_is_folioq(i)) {
-		i->iov_offset = 0;
-		iov_iter_folioq_revert(i, unroll);
 	} else { /* same logics for iovec and kvec */
 		const struct iovec *iov = iter_iov(i);
 		while (1) {
@@ -760,8 +696,6 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 		}
 		return umin(i->count, bq->bv[slot].bv_len - offset);
 	}
-	if (unlikely(iov_iter_is_folioq(i)))
-		return umin(folioq_folio_size(i->folioq, i->folioq_slot), i->count);
 	return i->count;
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
@@ -827,36 +761,6 @@ void iov_iter_bvec_queue(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_bvec_queue);
 
-/**
- * iov_iter_folio_queue - Initialise an I/O iterator to use the folios in a folio queue
- * @i: The iterator to initialise.
- * @direction: The direction of the transfer.
- * @folioq: The starting point in the folio queue.
- * @first_slot: The first slot in the folio queue to use
- * @offset: The offset into the folio in the first slot to start at
- * @count: The size of the I/O buffer in bytes.
- *
- * Set up an I/O iterator to either draw data out of the pages attached to an
- * inode or to inject data into those pages.  The pages *must* be prevented
- * from evaporation, either by taking a ref on them or locking them by the
- * caller.
- */
-void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
-			  const struct folio_queue *folioq, unsigned int first_slot,
-			  unsigned int offset, size_t count)
-{
-	BUG_ON(direction & ~1);
-	*i = (struct iov_iter) {
-		.iter_type = ITER_FOLIOQ,
-		.data_source = direction,
-		.folioq = folioq,
-		.folioq_slot = first_slot,
-		.count = count,
-		.iov_offset = offset,
-	};
-}
-EXPORT_SYMBOL(iov_iter_folio_queue);
-
 /**
  * iov_iter_xarray - Initialise an I/O iterator to use the pages in an xarray
  * @i: The iterator to initialise.
@@ -998,9 +902,7 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	if (iov_iter_is_bvecq(i))
 		return iov_iter_alignment_bvecq(i);
 
-	/* With both xarray and folioq types, we're dealing with whole folios. */
-	if (iov_iter_is_folioq(i))
-		return i->iov_offset | i->count;
+	/* With the xarray type, we're dealing with whole folios. */
 	if (iov_iter_is_xarray(i))
 		return (i->xarray_start + i->iov_offset) | i->count;
 
@@ -1255,11 +1157,6 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		return bvec_npages(i, maxpages);
 	if (iov_iter_is_bvecq(i))
 		return iov_npages_bvecq(i, maxpages);
-	if (iov_iter_is_folioq(i)) {
-		unsigned offset = i->iov_offset % PAGE_SIZE;
-		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
-		return min(npages, maxpages);
-	}
 	if (iov_iter_is_xarray(i)) {
 		unsigned offset = (i->xarray_start + i->iov_offset) % PAGE_SIZE;
 		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
@@ -1682,68 +1579,6 @@ static ssize_t iov_iter_extract_bvecq_pages(struct iov_iter *iter,
 	return extracted;
 }
 
-/*
- * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
- * not get references on the pages, nor does it get a pin on them.
- */
-static ssize_t iov_iter_extract_folioq_pages(struct iov_iter *i,
-					     struct page ***pages, size_t maxsize,
-					     unsigned int maxpages,
-					     iov_iter_extraction_t extraction_flags,
-					     size_t *offset0)
-{
-	const struct folio_queue *folioq = i->folioq;
-	struct page **p;
-	unsigned int nr = 0;
-	size_t extracted = 0, offset, slot = i->folioq_slot;
-
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = folioq->next;
-		slot = 0;
-		if (WARN_ON(i->iov_offset != 0))
-			return -EIO;
-	}
-
-	offset = i->iov_offset & ~PAGE_MASK;
-	*offset0 = offset;
-
-	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
-	if (!maxpages)
-		return -ENOMEM;
-	p = *pages;
-
-	for (;;) {
-		struct folio *folio = folioq_folio(folioq, slot);
-		size_t offset = i->iov_offset, fsize = folioq_folio_size(folioq, slot);
-		size_t part = PAGE_SIZE - offset % PAGE_SIZE;
-
-		if (offset < fsize) {
-			part = umin(part, umin(maxsize - extracted, fsize - offset));
-			i->count -= part;
-			i->iov_offset += part;
-			extracted += part;
-
-			p[nr++] = folio_page(folio, offset / PAGE_SIZE);
-		}
-
-		if (nr >= maxpages || extracted >= maxsize)
-			break;
-
-		if (i->iov_offset >= fsize) {
-			i->iov_offset = 0;
-			slot++;
-			if (slot == folioq_nr_slots(folioq) && folioq->next) {
-				folioq = folioq->next;
-				slot = 0;
-			}
-		}
-	}
-
-	i->folioq = folioq;
-	i->folioq_slot = slot;
-	return extracted;
-}
-
 /*
  * Extract a list of contiguous pages from an ITER_XARRAY iterator.  This does not
  * get references on the pages, nor does it get a pin on them.
@@ -2006,8 +1841,8 @@ static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
  *      added to the pages, but refs will not be taken.
  *      iov_iter_extract_will_pin() will return true.
  *
- *  (*) If the iterator is ITER_KVEC, ITER_BVEC, ITER_FOLIOQ or ITER_XARRAY, the
- *      pages are merely listed; no extra refs or pins are obtained.
+ *  (*) If the iterator is ITER_KVEC, ITER_BVEC, ITER_XARRAY, the pages are
+ *      merely listed; no extra refs or pins are obtained.
  *      iov_iter_extract_will_pin() will return 0.
  *
  * Note also:
@@ -2046,10 +1881,6 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 		return iov_iter_extract_bvecq_pages(i, pages, maxsize,
 						    maxpages, extraction_flags,
 						    offset0);
-	if (iov_iter_is_folioq(i))
-		return iov_iter_extract_folioq_pages(i, pages, maxsize,
-						     maxpages, extraction_flags,
-						     offset0);
 	if (iov_iter_is_xarray(i))
 		return iov_iter_extract_xarray_pages(i, pages, maxsize,
 						     maxpages, extraction_flags,
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 23e5a180103b..b9a7298306d9 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -12,7 +12,6 @@
 #include <linux/bvec.h>
 #include <linux/bvecq.h>
 #include <linux/uio.h>
-#include <linux/folio_queue.h>
 
 /**
  * sg_nents - return total count of entries in scatterlist
@@ -1327,67 +1326,6 @@ static ssize_t extract_bvecq_to_sg(struct iov_iter *iter,
 	return ret;
 }
 
-/*
- * Extract up to sg_max folios from an FOLIOQ-type iterator and add them to
- * the scatterlist.  The pages are not pinned.
- */
-static ssize_t extract_folioq_to_sg(struct iov_iter *iter,
-				   ssize_t maxsize,
-				   struct sg_table *sgtable,
-				   unsigned int sg_max,
-				   iov_iter_extraction_t extraction_flags)
-{
-	const struct folio_queue *folioq = iter->folioq;
-	struct scatterlist *sg = sgtable->sgl + sgtable->nents;
-	unsigned int slot = iter->folioq_slot;
-	ssize_t ret = 0;
-	size_t offset = iter->iov_offset;
-
-	BUG_ON(!folioq);
-
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = folioq->next;
-		if (WARN_ON_ONCE(!folioq))
-			return 0;
-		slot = 0;
-	}
-
-	do {
-		struct folio *folio = folioq_folio(folioq, slot);
-		size_t fsize = folioq_folio_size(folioq, slot);
-
-		if (offset < fsize) {
-			size_t part = umin(maxsize - ret, fsize - offset);
-
-			sg_set_page(sg, folio_page(folio, 0), part, offset);
-			sgtable->nents++;
-			sg++;
-			sg_max--;
-			offset += part;
-			ret += part;
-		}
-
-		if (offset >= fsize) {
-			offset = 0;
-			slot++;
-			if (slot >= folioq_nr_slots(folioq)) {
-				if (!folioq->next) {
-					WARN_ON_ONCE(ret < iter->count);
-					break;
-				}
-				folioq = folioq->next;
-				slot = 0;
-			}
-		}
-	} while (sg_max > 0 && ret < maxsize);
-
-	iter->folioq = folioq;
-	iter->folioq_slot = slot;
-	iter->iov_offset = offset;
-	iter->count -= ret;
-	return ret;
-}
-
 /*
  * Extract up to sg_max folios from an XARRAY-type iterator and add them to
  * the scatterlist.  The pages are not pinned.
@@ -1451,8 +1389,8 @@ static ssize_t extract_xarray_to_sg(struct iov_iter *iter,
  * addition of @sg_max elements.
  *
  * The pages referred to by UBUF- and IOVEC-type iterators are extracted and
- * pinned; BVEC-, BVECQ-, KVEC-, FOLIOQ- and XARRAY-type are extracted but
- * aren't pinned; DISCARD-type is not supported.
+ * pinned; BVEC-, BVECQ-, KVEC-, XARRAY-type are extracted but aren't pinned;
+ * DISCARD-type is not supported.
  *
  * No end mark is placed on the scatterlist; that's left to the caller.
  *
@@ -1487,9 +1425,6 @@ ssize_t extract_iter_to_sg(struct iov_iter *iter, size_t maxsize,
 	case ITER_BVECQ:
 		return extract_bvecq_to_sg(iter, maxsize, sgtable, sg_max,
 					   extraction_flags);
-	case ITER_FOLIOQ:
-		return extract_folioq_to_sg(iter, maxsize, sgtable, sg_max,
-					    extraction_flags);
 	case ITER_XARRAY:
 		return extract_xarray_to_sg(iter, maxsize, sgtable, sg_max,
 					    extraction_flags);
diff --git a/lib/tests/kunit_iov_iter.c b/lib/tests/kunit_iov_iter.c
index 8426c33e48a4..3b1416b94af1 100644
--- a/lib/tests/kunit_iov_iter.c
+++ b/lib/tests/kunit_iov_iter.c
@@ -13,7 +13,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/bvecq.h>
-#include <linux/folio_queue.h>
 #include <linux/scatterlist.h>
 #include <linux/minmax.h>
 #include <linux/mman.h>
@@ -383,176 +382,6 @@ static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 	KUNIT_SUCCEED(test);
 }
 
-static void iov_kunit_destroy_folioq(void *data)
-{
-	struct folio_queue *folioq, *next;
-
-	for (folioq = data; folioq; folioq = next) {
-		next = folioq->next;
-		kfree(folioq);
-	}
-}
-
-static void __init iov_kunit_load_folioq(struct kunit *test,
-					struct iov_iter *iter, int dir,
-					struct folio_queue *folioq,
-					struct page **pages, size_t npages)
-{
-	struct folio_queue *p = folioq;
-	size_t size = 0;
-	int i;
-
-	for (i = 0; i < npages; i++) {
-		if (folioq_full(p)) {
-			p->next = kzalloc_obj(struct folio_queue);
-			KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p->next);
-			folioq_init(p->next, 0);
-			p->next->prev = p;
-			p = p->next;
-		}
-		folioq_append(p, page_folio(pages[i]));
-		size += PAGE_SIZE;
-	}
-	iov_iter_folio_queue(iter, dir, folioq, 0, 0, size);
-}
-
-static struct folio_queue *iov_kunit_create_folioq(struct kunit *test)
-{
-	struct folio_queue *folioq;
-
-	folioq = kzalloc_obj(struct folio_queue);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, folioq);
-	kunit_add_action_or_reset(test, iov_kunit_destroy_folioq, folioq);
-	folioq_init(folioq, 0);
-	return folioq;
-}
-
-/*
- * Test copying to a ITER_FOLIOQ-type iterator.
- */
-static void __init iov_kunit_copy_to_folioq(struct kunit *test)
-{
-	const struct kvec_test_range *pr;
-	struct iov_iter iter;
-	struct folio_queue *folioq;
-	struct page **spages, **bpages;
-	u8 *scratch, *buffer;
-	size_t bufsize, npages, size, copied;
-	int i, patt;
-
-	bufsize = 0x100000;
-	npages = bufsize / PAGE_SIZE;
-
-	folioq = iov_kunit_create_folioq(test);
-
-	scratch = iov_kunit_create_buffer(test, &spages, npages);
-	for (i = 0; i < bufsize; i++)
-		scratch[i] = pattern(i);
-
-	buffer = iov_kunit_create_buffer(test, &bpages, npages);
-	memset(buffer, 0, bufsize);
-
-	iov_kunit_load_folioq(test, &iter, READ, folioq, bpages, npages);
-
-	i = 0;
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		size = pr->to - pr->from;
-		KUNIT_ASSERT_LE(test, pr->to, bufsize);
-
-		iov_iter_folio_queue(&iter, READ, folioq, 0, 0, pr->to);
-		iov_iter_advance(&iter, pr->from);
-		copied = copy_to_iter(scratch + i, size, &iter);
-
-		KUNIT_EXPECT_EQ(test, copied, size);
-		KUNIT_EXPECT_EQ(test, iter.count, 0);
-		KUNIT_EXPECT_EQ(test, iter.iov_offset, pr->to % PAGE_SIZE);
-		i += size;
-		if (test->status == KUNIT_FAILURE)
-			goto stop;
-	}
-
-	/* Build the expected image in the scratch buffer. */
-	patt = 0;
-	memset(scratch, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
-		for (i = pr->from; i < pr->to; i++)
-			scratch[i] = pattern(patt++);
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
-		if (buffer[i] != scratch[i])
-			return;
-	}
-
-stop:
-	KUNIT_SUCCEED(test);
-}
-
-/*
- * Test copying from a ITER_FOLIOQ-type iterator.
- */
-static void __init iov_kunit_copy_from_folioq(struct kunit *test)
-{
-	const struct kvec_test_range *pr;
-	struct iov_iter iter;
-	struct folio_queue *folioq;
-	struct page **spages, **bpages;
-	u8 *scratch, *buffer;
-	size_t bufsize, npages, size, copied;
-	int i, j;
-
-	bufsize = 0x100000;
-	npages = bufsize / PAGE_SIZE;
-
-	folioq = iov_kunit_create_folioq(test);
-
-	buffer = iov_kunit_create_buffer(test, &bpages, npages);
-	for (i = 0; i < bufsize; i++)
-		buffer[i] = pattern(i);
-
-	scratch = iov_kunit_create_buffer(test, &spages, npages);
-	memset(scratch, 0, bufsize);
-
-	iov_kunit_load_folioq(test, &iter, READ, folioq, bpages, npages);
-
-	i = 0;
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		size = pr->to - pr->from;
-		KUNIT_ASSERT_LE(test, pr->to, bufsize);
-
-		iov_iter_folio_queue(&iter, WRITE, folioq, 0, 0, pr->to);
-		iov_iter_advance(&iter, pr->from);
-		copied = copy_from_iter(scratch + i, size, &iter);
-
-		KUNIT_EXPECT_EQ(test, copied, size);
-		KUNIT_EXPECT_EQ(test, iter.count, 0);
-		KUNIT_EXPECT_EQ(test, iter.iov_offset, pr->to % PAGE_SIZE);
-		i += size;
-	}
-
-	/* Build the expected image in the main buffer. */
-	i = 0;
-	memset(buffer, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		for (j = pr->from; j < pr->to; j++) {
-			buffer[i++] = pattern(j);
-			if (i >= bufsize)
-				goto stop;
-		}
-	}
-stop:
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
-		if (scratch[i] != buffer[i])
-			return;
-	}
-
-	KUNIT_SUCCEED(test);
-}
-
 static void iov_kunit_destroy_bvecq(void *data)
 {
 	struct bvecq *bq, *next;
@@ -1126,85 +955,6 @@ static void __init iov_kunit_extract_pages_bvecq(struct kunit *test)
 	KUNIT_SUCCEED(test);
 }
 
-/*
- * Test the extraction of ITER_FOLIOQ-type iterators.
- */
-static void __init iov_kunit_extract_pages_folioq(struct kunit *test)
-{
-	const struct kvec_test_range *pr;
-	struct folio_queue *folioq;
-	struct iov_iter iter;
-	struct page **bpages, *pagelist[8], **pages = pagelist;
-	ssize_t len;
-	size_t bufsize, size = 0, npages;
-	int i, from;
-
-	bufsize = 0x100000;
-	npages = bufsize / PAGE_SIZE;
-
-	folioq = iov_kunit_create_folioq(test);
-
-	iov_kunit_create_buffer(test, &bpages, npages);
-	iov_kunit_load_folioq(test, &iter, READ, folioq, bpages, npages);
-
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		from = pr->from;
-		size = pr->to - from;
-		KUNIT_ASSERT_LE(test, pr->to, bufsize);
-
-		iov_iter_folio_queue(&iter, WRITE, folioq, 0, 0, pr->to);
-		iov_iter_advance(&iter, from);
-
-		do {
-			size_t offset0 = LONG_MAX;
-
-			for (i = 0; i < ARRAY_SIZE(pagelist); i++)
-				pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
-
-			len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
-						     ARRAY_SIZE(pagelist), 0, &offset0);
-			KUNIT_EXPECT_GE(test, len, 0);
-			if (len < 0)
-				break;
-			KUNIT_EXPECT_LE(test, len, size);
-			KUNIT_EXPECT_EQ(test, iter.count, size - len);
-			if (len == 0)
-				break;
-			size -= len;
-			KUNIT_EXPECT_GE(test, (ssize_t)offset0, 0);
-			KUNIT_EXPECT_LT(test, offset0, PAGE_SIZE);
-
-			for (i = 0; i < ARRAY_SIZE(pagelist); i++) {
-				struct page *p;
-				ssize_t part = min_t(ssize_t, len, PAGE_SIZE - offset0);
-				int ix;
-
-				KUNIT_ASSERT_GE(test, part, 0);
-				ix = from / PAGE_SIZE;
-				KUNIT_ASSERT_LT(test, ix, npages);
-				p = bpages[ix];
-				KUNIT_EXPECT_PTR_EQ(test, pagelist[i], p);
-				KUNIT_EXPECT_EQ(test, offset0, from % PAGE_SIZE);
-				from += part;
-				len -= part;
-				KUNIT_ASSERT_GE(test, len, 0);
-				if (len == 0)
-					break;
-				offset0 = 0;
-			}
-
-			if (test->status == KUNIT_FAILURE)
-				goto stop;
-		} while (iov_iter_count(&iter) > 0);
-
-		KUNIT_EXPECT_EQ(test, size, 0);
-		KUNIT_EXPECT_EQ(test, iter.count, 0);
-	}
-
-stop:
-	KUNIT_SUCCEED(test);
-}
-
 /*
  * Test the extraction of ITER_XARRAY-type iterators.
  */
@@ -1432,23 +1182,6 @@ static void __init iov_kunit_iter_to_sg_bvec(struct kunit *test)
 	iov_kunit_iter_to_sg_check(test, &iter, bufsize, &data);
 }
 
-static void __init iov_kunit_iter_to_sg_folioq(struct kunit *test)
-{
-	struct iov_kunit_iter_to_sg_data data;
-	struct folio_queue *folioq;
-	struct iov_iter iter;
-	size_t bufsize;
-
-	bufsize = 0x200000;
-	iov_kunit_iter_to_sg_init(test, bufsize, false, &data);
-
-	folioq = iov_kunit_create_folioq(test);
-	iov_kunit_load_folioq(test, &iter, READ, folioq, data.pages,
-			      data.npages);
-
-	iov_kunit_iter_to_sg_check(test, &iter, bufsize, &data);
-}
-
 static void __init iov_kunit_iter_to_sg_xarray(struct kunit *test)
 {
 	struct iov_kunit_iter_to_sg_data data;
@@ -1487,18 +1220,14 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_copy_from_bvec),
 	KUNIT_CASE(iov_kunit_copy_to_bvecq),
 	KUNIT_CASE(iov_kunit_copy_from_bvecq),
-	KUNIT_CASE(iov_kunit_copy_to_folioq),
-	KUNIT_CASE(iov_kunit_copy_from_folioq),
 	KUNIT_CASE(iov_kunit_copy_to_xarray),
 	KUNIT_CASE(iov_kunit_copy_from_xarray),
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvecq),
-	KUNIT_CASE(iov_kunit_extract_pages_folioq),
 	KUNIT_CASE(iov_kunit_extract_pages_xarray),
 	KUNIT_CASE(iov_kunit_iter_to_sg_kvec),
 	KUNIT_CASE(iov_kunit_iter_to_sg_bvec),
-	KUNIT_CASE(iov_kunit_iter_to_sg_folioq),
 	KUNIT_CASE(iov_kunit_iter_to_sg_xarray),
 	KUNIT_CASE(iov_kunit_iter_to_sg_ubuf),
 	{}


