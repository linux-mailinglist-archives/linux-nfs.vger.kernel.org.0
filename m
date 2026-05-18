Return-Path: <linux-nfs+bounces-21680-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNEhNqSWC2rXJgUAu9opvQ
	(envelope-from <linux-nfs+bounces-21680-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 00:45:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E0E574C47
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 00:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF6FB312832C
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 22:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5FD3B0AE6;
	Mon, 18 May 2026 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd62IwH1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9583B3891
	for <linux-nfs@vger.kernel.org>; Mon, 18 May 2026 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143501; cv=none; b=ByEqi5tiIkZV6T8K9Yj9J6t1lfCPPInTmxL0ReatcPy1/NAgfk7TaKWY1QEgy/WO8zGmbisGLyCnrMNyLx+KxI1tkljwUPbWIBvCl/Diq/1dHnOmn/MJvyMp9HRtjTKg/2winUdtPqhT9otgrxkV/y18f/Ngtru1dOEDX0M7VTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143501; c=relaxed/simple;
	bh=q0nHBdS8B0gFtMjCdDHzxTp81+J/3i877MqD45cDrfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8OyGo2+HZ+67TwuydugoQBaTLqD1V+AxMG9wl1kp8/+twGckkXPl3Yhlvve6DUbF9GVWE+kiTDe+MvbUEySqWfxqK7Djx19I7pD9EjAejzN/nUvSQRVoLcku4Y1S8DStnrxBkJ1PgJaqSef07lIzrfnPtuMx2OOg6Y1PG/a59E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yd62IwH1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779143498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbkc2ThYu5P21iahS6kl0ozQ9hmor5lbvUCQK6sK6n0=;
	b=Yd62IwH1SxfqkSDPAK/tkn/2Q8vsBFeil5/uGeZIJDamEXyCZz43I0GgqtprYVU0XMCPF4
	l6PlTA+M4QZLOniR2XpO00MtEr3W2h8PpYYeHDsEF1DCt/PjZGt0gEcGGePEhTdvW3Iowp
	YUG/1jW/bGXVQQbI8/D/GUFqy8XAfEE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-NHnU8fn0NzaoB1QLdEw12w-1; Mon,
 18 May 2026 18:31:33 -0400
X-MC-Unique: NHnU8fn0NzaoB1QLdEw12w-1
X-Mimecast-MFC-AGG-ID: NHnU8fn0NzaoB1QLdEw12w_1779143490
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F7E9195608A;
	Mon, 18 May 2026 22:31:30 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44FEF180034E;
	Mon, 18 May 2026 22:31:23 +0000 (UTC)
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
Subject: [PATCH v2 09/21] netfs: Add a function to extract from an iter into a bvecq
Date: Mon, 18 May 2026 23:29:41 +0100
Message-ID: <20260518222959.488126-10-dhowells@redhat.com>
In-Reply-To: <20260518222959.488126-1-dhowells@redhat.com>
References: <20260518222959.488126-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21680-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,manguebit.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,samba.org:email]
X-Rspamd-Queue-Id: 40E0E574C47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a function to extract a slice of data from an iterator of any type into
a bvec queue chain.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/iterator.c   | 125 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |   3 +
 2 files changed, 128 insertions(+)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index b375567e0520..d2c3055a488c 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -13,6 +13,131 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+/**
+ * netfs_extract_iter - Extract virtually contiguous pages from an iterator into a bvecq
+ * @orig: The original iterator
+ * @max_len: Maximum number of bytes to extract
+ * @max_pages: Maximum number of pages to extract
+ * @fpos: Starting file position to label the bvecq with
+ * @_bvecq_head: Where to cache the bvec queue
+ * @extraction_flags: Flags to qualify the request
+ *
+ * Extract virtually contiguous page fragments from the source iterator up to
+ * the given maxima and build bvec queue that refers to all of those bits.
+ * This allows the original iterator to disposed of.
+ *
+ * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be
+ * allowed on the pages extracted.
+ *
+ * On success, the amount of data in the bvec is returned, the original
+ * iterator will have been advanced by the amount extracted.
+ *
+ * The bvecq segments are marked with indications on how to get clean up the
+ * extracted fragments.
+ */
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pages,
+			   unsigned long long fpos, struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags)
+{
+	struct bvecq *bq_tail = NULL;
+	ssize_t ret = 0;
+	size_t extracted = 0;
+
+	_enter("{%u,%zx},%zx", orig->iter_type, orig->count, max_len);
+
+	if (max_len > orig->count)
+		max_len = orig->count;
+	if (WARN_ON_ONCE(!max_len || !max_pages))
+		return 0;
+
+	max_pages = iov_iter_npages(orig, max_pages);
+	if (!max_pages)
+		return 0;
+
+	do {
+		struct bvecq *bq;
+
+		bq = bvecq_alloc_one(max_pages, GFP_NOFS);
+		if (!bq) {
+			ret = -ENOMEM;
+			break;
+		}
+		if (user_backed_iter(orig))
+			bq->mem_type = iov_iter_extract_will_pin(orig) ?
+				BVECQ_MEM_GUP : BVECQ_MEM_PAGECACHE;
+		bq->prev	= bq_tail;
+		bq->fpos	= fpos + extracted;
+
+		if (bq_tail)
+			bq_tail->next = bq;
+		else
+			*_bvecq_head = bq;
+		bq_tail = bq;
+
+		if (max_len == 0)
+			break;
+
+		struct bio_vec *bv = bq->bv;
+		do {
+			struct page **pages;
+			ssize_t got;
+			size_t offset;
+			size_t space = bq->max_slots - bq->nr_slots;
+			size_t bv_size = array_size(bq->max_slots, sizeof(*bv));
+			size_t pg_size = array_size(space, sizeof(*pages));
+
+			/* Put the page list at the end of the bvec list
+			 * storage.  bvec elements are larger than page
+			 * pointers, so as long as we work 0->last, we should
+			 * be fine.
+			 */
+			pages = (void *)bv + bv_size - pg_size;
+
+			got = iov_iter_extract_pages(orig, &pages, max_len,
+						     space, extraction_flags, &offset);
+			if (got < 0) {
+				ret = got;
+				goto out;
+			}
+
+			if (got == 0) {
+				pr_err("extract_pages gave nothing from %zu, %zu\n",
+				       extracted, max_len);
+				ret = -EIO;
+				goto out;
+			}
+
+			if (WARN(got > max_len,
+				 "%s: extract_pages overrun %zd > %zu bytes\n",
+				 __func__, got, max_len)) {
+				ret = -EIO;
+				break;
+			}
+
+			extracted += got;
+			max_len -= got;
+
+			do {
+				size_t len = umin(got, PAGE_SIZE - offset);
+
+				BUG_ON(bq->nr_slots >= bq->max_slots);
+
+				bvec_set_page(&bq->bv[bq->nr_slots],
+					      *pages++, len, offset);
+				bq->nr_slots++;
+				got -= len;
+				offset = 0;
+			} while (got > 0);
+		} while (max_len > 0 && !bvecq_is_full(bq));
+
+		max_pages -= bq->nr_slots;
+	} while (max_len > 0 && max_pages > 0);
+
+out:
+	return extracted ?: ret;
+}
+EXPORT_SYMBOL_GPL(netfs_extract_iter);
+
 /**
  * netfs_extract_user_iter - Extract the pages from a user iterator into a bvec
  * @orig: The original iterator
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 12e5c51c11c8..40f45ecf1db8 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -460,6 +460,9 @@ void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pages,
+			   unsigned long long fpos, struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags);
 ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				struct iov_iter *new,
 				iov_iter_extraction_t extraction_flags);


