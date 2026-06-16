Return-Path: <linux-nfs+bounces-22594-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qSi6A6glMWrVcgUAu9opvQ
	(envelope-from <linux-nfs+bounces-22594-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:30:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 659EE68E4B0
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:29:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=WlrXdxdF;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22594-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22594-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECADF32D224A
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 10:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BEA43E9CD;
	Tue, 16 Jun 2026 10:12:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE5450903
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 10:12:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604727; cv=none; b=btbygxijKKQmGRNoJxS5v3FvT8Z7Bcx34M0IXNGDkMuNJDym0LEdgL6G6f6/hlbr23RZgRE79ZwSJVslkAIqlDHUjwoRLcW4ePu2it4iCxvVRgWI2UclWDvIUph6NdyeIdf+B+s4sfOFGRzm0Lk+6mfyj37GisDR9vt1vMBth3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604727; c=relaxed/simple;
	bh=an8xTh0xmfEVpB4VFS88C9pqwoqvbo46Eot4fbSm+LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhBs+udRkaCEazZeT77K+P+k6l7Ngc98xSYRse0po7l+Q0eGUM84blaPz+slCB657RMhDXpxeVXSpLLtOaZIAwzbUlUtUKZws8RGtMn55uPXJeUp+QN5F7+gW385lCc2cvkqHR3e1/gOCZLbfwZKWRKO+8JElW14iF5789HcFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlrXdxdF; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781604724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+4rtAcrwO2ub9+eD6vC8aYBVb9UTy2QsOVmblQWlYk=;
	b=WlrXdxdFPEEmtphqT1x4feMGmcMwywwMDvPkbKxtGzKdYraZuOCFhzQrKN0yY/Wz3Faq0J
	rRDYb0WsWSE011SRFsZnhaQzfPY47TVxQN+NEvT0/TfG1rbDt4HKm3lMPAkBRWwL+Fmi7T
	7DGhLEzQL6w5d/X4ANG1C+wobm9ZA9M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-G5fRQU4UOdaOUZ6TW_YPtg-1; Tue,
 16 Jun 2026 06:12:03 -0400
X-MC-Unique: G5fRQU4UOdaOUZ6TW_YPtg-1
X-Mimecast-MFC-AGG-ID: G5fRQU4UOdaOUZ6TW_YPtg_1781604719
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8A1718DA5CD;
	Tue, 16 Jun 2026 10:11:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D698B3008B3D;
	Tue, 16 Jun 2026 10:11:43 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 24/30] netfs: Remove netfs_extract_user_iter()
Date: Tue, 16 Jun 2026 11:08:13 +0100
Message-ID: <20260616100821.2062304-25-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22594-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,samba.org:email,linux.dev:email,manguebit.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 659EE68E4B0

Remove netfs_extract_user_iter() as it has been replaced with
netfs_extract_iter().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/iterator.c   | 104 ------------------------------------------
 include/linux/netfs.h |   3 --
 2 files changed, 107 deletions(-)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 616afe53fedf..b1ae0540300a 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -151,110 +151,6 @@ ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pag
 EXPORT_SYMBOL_GPL(netfs_extract_iter);
 
 #if 0
-/**
- * netfs_extract_user_iter - Extract the pages from a user iterator into a bvec
- * @orig: The original iterator
- * @orig_len: The amount of iterator to copy
- * @new: The iterator to be set up
- * @extraction_flags: Flags to qualify the request
- *
- * Extract the page fragments from the given amount of the source iterator and
- * build up a second iterator that refers to all of those bits.  This allows
- * the original iterator to be disposed of.
- *
- * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be
- * allowed on the pages extracted.
- *
- * On success, the number of elements in the bvec is returned, the original
- * iterator will have been advanced by the amount extracted.
- *
- * The iov_iter_extract_mode() function should be used to query how cleanup
- * should be performed.
- */
-ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
-				struct iov_iter *new,
-				iov_iter_extraction_t extraction_flags)
-{
-	struct bio_vec *bv = NULL;
-	struct page **pages;
-	unsigned int cur_npages;
-	unsigned int max_pages;
-	unsigned int npages = 0;
-	unsigned int i;
-	ssize_t ret = 0;
-	size_t count = orig_len, offset, len;
-	size_t bv_size, pg_size;
-
-	if (WARN_ON_ONCE(!iter_is_ubuf(orig) && !iter_is_iovec(orig)))
-		return -EIO;
-
-	max_pages = iov_iter_npages(orig, INT_MAX);
-	bv_size = array_size(max_pages, sizeof(*bv));
-	bv = kvmalloc(bv_size, GFP_KERNEL);
-	if (!bv)
-		return -ENOMEM;
-
-	/* Put the page list at the end of the bvec list storage.  bvec
-	 * elements are larger than page pointers, so as long as we work
-	 * 0->last, we should be fine.
-	 */
-	pg_size = array_size(max_pages, sizeof(*pages));
-	pages = (void *)bv + bv_size - pg_size;
-
-	while (count && npages < max_pages) {
-		ret = iov_iter_extract_pages(orig, &pages, count,
-					     max_pages - npages, extraction_flags,
-					     &offset);
-		if (unlikely(ret <= 0)) {
-			ret = ret ?: -EIO;
-			break;
-		}
-
-		if (WARN(ret > count,
-			 "%s: extract_pages overrun %zd > %zu bytes\n",
-			 __func__, ret, count)) {
-			ret = -EIO;
-			break;
-		}
-
-		cur_npages = DIV_ROUND_UP(offset + ret, PAGE_SIZE);
-		if (WARN(cur_npages > max_pages - npages,
-			 "%s: extract_pages overrun %u > %u pages\n",
-			 __func__, npages + cur_npages, max_pages)) {
-			ret = -EIO;
-			break;
-		}
-
-		count -= ret;
-		ret += offset;
-
-		for (i = 0; i < cur_npages; i++) {
-			len = ret > PAGE_SIZE ? PAGE_SIZE : ret;
-			bvec_set_page(bv + npages + i, *pages++, len - offset, offset);
-			ret -= len;
-			offset = 0;
-		}
-
-		npages += cur_npages;
-	}
-
-	/* Note: Don't try to clean up after EIO.  Either we got no pages, so
-	 * nothing to clean up, or we got a buffer overrun, memory corruption
-	 * and can't trust the stuff in the buffer (a WARN was emitted).
-	 */
-
-	if (ret < 0 && (ret == -ENOMEM || npages == 0)) {
-		for (i = 0; i < npages; i++)
-			unpin_user_page(bv[i].bv_page);
-		kvfree(bv);
-		return ret;
-	}
-
-	iov_iter_bvec(new, orig->data_source, bv, npages, orig_len - count);
-	return npages;
-}
-EXPORT_SYMBOL_GPL(netfs_extract_user_iter);
-
 /*
  * Select the span of a bvec iterator we're going to use.  Limit it by both maximum
  * size and maximum number of segments.  Returns the size of the span in bytes.
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a4efa313087d..00bcda193b31 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -466,9 +466,6 @@ void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 ssize_t netfs_extract_iter(struct iov_iter *orig, size_t max_len, size_t max_pages,
 			   unsigned long long fpos, struct bvecq **_bvecq_head,
 			   iov_iter_extraction_t extraction_flags);
-ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
-				struct iov_iter *new,
-				iov_iter_extraction_t extraction_flags);
 size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 			size_t max_size, size_t max_segs);
 void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq);


