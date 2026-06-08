Return-Path: <linux-nfs+bounces-22358-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h+JVLnPxJmqloAIAu9opvQ
	(envelope-from <linux-nfs+bounces-22358-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 18:44:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4412A658DA2
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 18:44:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=SRwy2AW2;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22358-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22358-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B4C3355EF53
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3DE481AB5;
	Mon,  8 Jun 2026 14:55:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5D481A8F
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2026 14:55:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930559; cv=none; b=GuDak7RIm6N3GmdvhOGPYS/yxJjs6DTOjvdDHnCu7nZkn8YFBSOCUxhkUmfaBr15yGV6dWvD7W5baZGKsg9PQ6wtsxmUALd+l5LYET8lWckPdfB0Hqlb/DsDGBGCriVb8ifJFP2w4HZJte8GC8OBoA5hGzYsRU2ufu8G7bB10rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930559; c=relaxed/simple;
	bh=0C4gcVZKHQyqmJ8NewTG/Zw/3dNQrnlhH5C2JawXraI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJWKmWG/uTziPzkrYC02fmZiXyP/mOUEw+LWapvyX3wiJVZ8yLrHaBk78TA97wYcib1QLgjwY1WBBEZIuwppnG5oc14FlG4EH0GLxpEUJ6qM8rByE4l8FY0gK4+hA18/S5jT9M4vQnYyA9x/Wlz5PxJxYhc/sufu9/lW/DtQldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRwy2AW2; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780930552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2ry9yfrsp4bz8l1rJhaUu5Q7jTF4XqPXt4HsPXH488=;
	b=SRwy2AW2YN//5SujfVTn60QOb9h47IlXkGbbT/2uDGBvinXhq6S2edJjd7oejMKnrwNYk4
	Nw9qp9YI/OJAJ4OVBcdX8VC9SnV1Q4fF/PC1KUfsrvGmqcFJYvmjDR9QDqXYk91MdSpGLI
	uqQYCU8PO1eOB8A6Evtexm+VjBhZvlA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-IeqPMvgxOP6dxbSt13DTxQ-1; Mon,
 08 Jun 2026 10:55:51 -0400
X-MC-Unique: IeqPMvgxOP6dxbSt13DTxQ-1
X-Mimecast-MFC-AGG-ID: IeqPMvgxOP6dxbSt13DTxQ_1780930548
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1575180064A;
	Mon,  8 Jun 2026 14:55:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 746EA19541B0;
	Mon,  8 Jun 2026 14:55:41 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v3 07/22] iov_iter: Make iov_iter_get_pages*() wrap iov_iter_extract_pages()
Date: Mon,  8 Jun 2026 15:54:15 +0100
Message-ID: <20260608145432.681865-8-dhowells@redhat.com>
In-Reply-To: <20260608145432.681865-1-dhowells@redhat.com>
References: <20260608145432.681865-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-22358-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4412A658DA2

Make iov_iter_get_pages*() wrap iov_iter_extract_pages() for kernel
iterator types (e.g. ITER_BVEC, ITER_FOLIOQ, ITER_XARRAY).  The pages
obtained have their refcounts incremented afterwards if they're not slab
pages.  ITER_KVEC is left returning -EFAULT.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 lib/iov_iter.c | 164 ++++++-------------------------------------------
 1 file changed, 19 insertions(+), 145 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af7..cac7d7364bc2 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -910,118 +910,34 @@ static int want_pages_array(struct page ***res, size_t size,
 	return count;
 }
 
-static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
+/*
+ * Wrap iov_iter_extract_pages() and then pin the non-slab pages we got back.
+ * This only works for non-user iterator types as get_pages uses get_user_pages
+ * not pin_user_pages.
+ */
+static ssize_t iter_get_kernel_pages(struct iov_iter *iter,
 				     struct page ***ppages, size_t maxsize,
 				     unsigned maxpages, size_t *_start_offset)
 {
-	const struct folio_queue *folioq = iter->folioq;
 	struct page **pages;
-	unsigned int slot = iter->folioq_slot;
-	size_t extracted = 0, count = iter->count, iov_offset = iter->iov_offset;
+	ssize_t ret, done;
 
-	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = folioq->next;
-		slot = 0;
-		if (WARN_ON(iov_offset != 0))
-			return -EIO;
-	}
+	ret = iov_iter_extract_pages(iter, ppages, maxsize, maxpages,
+				     0, _start_offset);
+	if (ret <= 0)
+		return ret;
 
-	maxpages = want_pages_array(ppages, maxsize, iov_offset & ~PAGE_MASK, maxpages);
-	if (!maxpages)
-		return -ENOMEM;
-	*_start_offset = iov_offset & ~PAGE_MASK;
 	pages = *ppages;
+	for (done = ret + *_start_offset; done > 0; done -= PAGE_SIZE) {
+		struct folio *folio = page_folio(*pages);
 
-	for (;;) {
-		struct folio *folio = folioq_folio(folioq, slot);
-		size_t offset = iov_offset, fsize = folioq_folio_size(folioq, slot);
-		size_t part = PAGE_SIZE - offset % PAGE_SIZE;
-
-		if (offset < fsize) {
-			part = umin(part, umin(maxsize - extracted, fsize - offset));
-			count -= part;
-			iov_offset += part;
-			extracted += part;
-
-			*pages = folio_page(folio, offset / PAGE_SIZE);
-			get_page(*pages);
-			pages++;
-			maxpages--;
-		}
-
-		if (maxpages == 0 || extracted >= maxsize)
-			break;
-
-		if (iov_offset >= fsize) {
-			iov_offset = 0;
-			slot++;
-			if (slot == folioq_nr_slots(folioq) && folioq->next) {
-				folioq = folioq->next;
-				slot = 0;
-			}
-		}
-	}
-
-	iter->count = count;
-	iter->iov_offset = iov_offset;
-	iter->folioq = folioq;
-	iter->folioq_slot = slot;
-	return extracted;
-}
-
-static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
-					  pgoff_t index, unsigned int nr_pages)
-{
-	XA_STATE(xas, xa, index);
-	struct folio *folio;
-	unsigned int ret = 0;
-
-	rcu_read_lock();
-	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
-		if (xas_retry(&xas, folio))
-			continue;
-
-		/* Has the folio moved or been split? */
-		if (unlikely(folio != xas_reload(&xas))) {
-			xas_reset(&xas);
-			continue;
-		}
-
-		pages[ret] = folio_file_page(folio, xas.xa_index);
-		folio_get(folio);
-		if (++ret == nr_pages)
-			break;
+		if (!folio_test_slab(folio))
+			folio_get(folio);
+		pages++;
 	}
-	rcu_read_unlock();
 	return ret;
 }
 
-static ssize_t iter_xarray_get_pages(struct iov_iter *i,
-				     struct page ***pages, size_t maxsize,
-				     unsigned maxpages, size_t *_start_offset)
-{
-	unsigned nr, offset, count;
-	pgoff_t index;
-	loff_t pos;
-
-	pos = i->xarray_start + i->iov_offset;
-	index = pos >> PAGE_SHIFT;
-	offset = pos & ~PAGE_MASK;
-	*_start_offset = offset;
-
-	count = want_pages_array(pages, maxsize, offset, maxpages);
-	if (!count)
-		return -ENOMEM;
-	nr = iter_xarray_populate_pages(*pages, i->xarray, index, count);
-	if (nr == 0)
-		return 0;
-
-	maxsize = min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
-	i->iov_offset += maxsize;
-	i->count -= maxsize;
-	return maxsize;
-}
-
 /* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
 static unsigned long first_iovec_segment(const struct iov_iter *i, size_t *size)
 {
@@ -1044,22 +960,6 @@ static unsigned long first_iovec_segment(const struct iov_iter *i, size_t *size)
 	BUG(); // if it had been empty, we wouldn't get called
 }
 
-/* must be done on non-empty ITER_BVEC one */
-static struct page *first_bvec_segment(const struct iov_iter *i,
-				       size_t *size, size_t *start)
-{
-	struct page *page;
-	size_t skip = i->iov_offset, len;
-
-	len = i->bvec->bv_len - skip;
-	if (*size > len)
-		*size = len;
-	skip += i->bvec->bv_offset;
-	page = i->bvec->bv_page + skip / PAGE_SIZE;
-	*start = skip % PAGE_SIZE;
-	return page;
-}
-
 static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   unsigned int maxpages, size_t *start)
@@ -1095,36 +995,10 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		iov_iter_advance(i, maxsize);
 		return maxsize;
 	}
-	if (iov_iter_is_bvec(i)) {
-		struct page **p;
-		struct page *page;
 
-		page = first_bvec_segment(i, &maxsize, start);
-		n = want_pages_array(pages, maxsize, *start, maxpages);
-		if (!n)
-			return -ENOMEM;
-		p = *pages;
-		for (int k = 0; k < n; k++) {
-			struct folio *folio = page_folio(page + k);
-			p[k] = page + k;
-			if (!folio_test_slab(folio))
-				folio_get(folio);
-		}
-		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
-		i->count -= maxsize;
-		i->iov_offset += maxsize;
-		if (i->iov_offset == i->bvec->bv_len) {
-			i->iov_offset = 0;
-			i->bvec++;
-			i->nr_segs--;
-		}
-		return maxsize;
-	}
-	if (iov_iter_is_folioq(i))
-		return iter_folioq_get_pages(i, pages, maxsize, maxpages, start);
-	if (iov_iter_is_xarray(i))
-		return iter_xarray_get_pages(i, pages, maxsize, maxpages, start);
-	return -EFAULT;
+	if (iov_iter_is_kvec(i))
+		return -EFAULT;
+	return iter_get_kernel_pages(i, pages, maxsize, maxpages, start);
 }
 
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,


