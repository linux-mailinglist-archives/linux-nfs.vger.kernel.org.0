Return-Path: <linux-nfs+bounces-11674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39474AB4EA4
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 10:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B016817A18F
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C71520E318;
	Tue, 13 May 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IQtlXqHp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E61EB19F
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126675; cv=none; b=Z3uY4XHEIAVrNLT4AcKMQV1k+PH2zJoAZ66hU2ad0RfRu5mmJqh+3OQMHX8OYtaxdzVOl69XYJB+4m75p1vVtVUhiJZfRX4fdCAgf2rDUzvXX1bOrIogadRwYBjO3xSlk6OzXZMMNPUwIHXLIa6LWjM5NjZWEliVunlS8KbaJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126675; c=relaxed/simple;
	bh=I6DXiTcCVqDJsgdJwma7N2+1jGteDz/mTgYJXAJga8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3RlFcFWovNLmbuz4YJQm/MYNYk5vp7wtwF4NjWABKs4xO2TqPBH0wGq8sqEj4K6t5qzZLsjLdWlkw6tb1GMwYQK6Bvli4Y4272hspty6jOrrR6mVwDNCPAhv9gQIaG7C0GB43xJXeolRFI7hGBPbCLOGrBexfr8LJNXOiU8LuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IQtlXqHp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=459RM4mBtRNYqU+28uryMRSeLRVyQePqANTSTVesYaE=; b=IQtlXqHpi/vP0O8QXnpgbLkRtR
	rMoXtG+FEKbj9OslLYnNqxtjbCo9rdeFAV/QGACJwz1JvG657wNX+tQfI33wF2BRzt5R9YDgiv+iY
	3dpK/z1VqJCpQFKnFMbapphDrw9omInxQFBMSmZF0h/ny72ElV1pPGaoPgw4mBnmUypb0HqXnijnN
	l2vrjzo8o9PCntqp2Se1/dYOgE95+ue0PmQVR4fOkDVkh/UHkjq7bBfcoXTegFApeKIw8G2/VFlsw
	7fpS1KhQV8M4H5AOIRAXXe9ts0HbxFZdnOWFcK+Rw0cBoFgbZ9UFPc2lNr1rSeKCno0IXXuRbaO2W
	qlw5w4Wg==;
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uElSQ-0000000BpCJ-23mp;
	Tue, 13 May 2025 08:57:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] sunrpc: simplify xdr_partial_copy_from_skb
Date: Tue, 13 May 2025 10:57:25 +0200
Message-ID: <20250513085739.894150-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513085739.894150-1-hch@lst.de>
References: <20250513085739.894150-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

csum_partial_copy_to_xdr can handle a checksumming and non-checksumming
case and implements this using a callback, which leads to a lot of
boilerplate code and indirect calls in the fast path.

Switch to storing a no_checksum flag in struct xdr_skb_reader instead
to remove the indirect call and simplify the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/sunrpc/socklib.c | 143 +++++++++++++++----------------------------
 1 file changed, 50 insertions(+), 93 deletions(-)

diff --git a/net/sunrpc/socklib.c b/net/sunrpc/socklib.c
index 1b2b84feeec6..7196e7042e0f 100644
--- a/net/sunrpc/socklib.c
+++ b/net/sunrpc/socklib.c
@@ -27,97 +27,60 @@
 struct xdr_skb_reader {
 	struct sk_buff	*skb;
 	unsigned int	offset;
+	bool		no_checksum;
 	size_t		count;
 	__wsum		csum;
 };
 
-typedef size_t (*xdr_skb_read_actor)(struct xdr_skb_reader *desc, void *to,
-				     size_t len);
-
 /**
  * xdr_skb_read_bits - copy some data bits from skb to internal buffer
  * @desc: sk_buff copy helper
  * @to: copy destination
  * @len: number of bytes to copy
  *
- * Possibly called several times to iterate over an sk_buff and copy
- * data out of it.
+ * Possibly called several times to iterate over an sk_buff and copy data out of
+ * it.
  */
 static size_t
 xdr_skb_read_bits(struct xdr_skb_reader *desc, void *to, size_t len)
 {
-	if (len > desc->count)
-		len = desc->count;
-	if (unlikely(skb_copy_bits(desc->skb, desc->offset, to, len)))
-		return 0;
-	desc->count -= len;
-	desc->offset += len;
-	return len;
-}
+	len = min(len, desc->count);
+
+	if (desc->no_checksum) {
+		if (unlikely(skb_copy_bits(desc->skb, desc->offset, to, len)))
+			return 0;
+	} else {
+		__wsum csum;
+
+		csum = skb_copy_and_csum_bits(desc->skb, desc->offset, to, len);
+		desc->csum = csum_block_add(desc->csum, csum, desc->offset);
+	}
 
-/**
- * xdr_skb_read_and_csum_bits - copy and checksum from skb to buffer
- * @desc: sk_buff copy helper
- * @to: copy destination
- * @len: number of bytes to copy
- *
- * Same as skb_read_bits, but calculate a checksum at the same time.
- */
-static size_t xdr_skb_read_and_csum_bits(struct xdr_skb_reader *desc, void *to, size_t len)
-{
-	unsigned int pos;
-	__wsum csum2;
-
-	if (len > desc->count)
-		len = desc->count;
-	pos = desc->offset;
-	csum2 = skb_copy_and_csum_bits(desc->skb, pos, to, len);
-	desc->csum = csum_block_add(desc->csum, csum2, pos);
 	desc->count -= len;
 	desc->offset += len;
 	return len;
 }
 
-/**
- * xdr_partial_copy_from_skb - copy data out of an skb
- * @xdr: target XDR buffer
- * @base: starting offset
- * @desc: sk_buff copy helper
- * @copy_actor: virtual method for copying data
- *
- */
 static ssize_t
-xdr_partial_copy_from_skb(struct xdr_buf *xdr, unsigned int base, struct xdr_skb_reader *desc, xdr_skb_read_actor copy_actor)
+xdr_partial_copy_from_skb(struct xdr_buf *xdr, struct xdr_skb_reader *desc)
 {
-	struct page	**ppage = xdr->pages;
-	unsigned int	len, pglen = xdr->page_len;
-	ssize_t		copied = 0;
-	size_t		ret;
-
-	len = xdr->head[0].iov_len;
-	if (base < len) {
-		len -= base;
-		ret = copy_actor(desc, (char *)xdr->head[0].iov_base + base, len);
-		copied += ret;
-		if (ret != len || !desc->count)
-			goto out;
-		base = 0;
-	} else
-		base -= len;
-
-	if (unlikely(pglen == 0))
-		goto copy_tail;
-	if (unlikely(base >= pglen)) {
-		base -= pglen;
-		goto copy_tail;
-	}
-	if (base || xdr->page_base) {
-		pglen -= base;
-		base += xdr->page_base;
-		ppage += base >> PAGE_SHIFT;
-		base &= ~PAGE_MASK;
-	}
-	do {
+	struct page **ppage = xdr->pages + (xdr->page_base >> PAGE_SHIFT);
+	unsigned int poff = xdr->page_base & ~PAGE_MASK;
+	unsigned int pglen = xdr->page_len;
+	ssize_t copied = 0;
+	size_t ret;
+
+	if (xdr->head[0].iov_len == 0)
+		return 0;
+
+	ret = xdr_skb_read_bits(desc, xdr->head[0].iov_base,
+			xdr->head[0].iov_len);
+	if (ret != xdr->head[0].iov_len || !desc->count)
+		return ret;
+	copied += ret;
+
+	while (pglen) {
+		unsigned int len = min(PAGE_SIZE - poff, pglen);
 		char *kaddr;
 
 		/* ACL likes to be lazy in allocating pages - ACLs
@@ -126,36 +89,29 @@ xdr_partial_copy_from_skb(struct xdr_buf *xdr, unsigned int base, struct xdr_skb
 			*ppage = alloc_page(GFP_NOWAIT | __GFP_NOWARN);
 			if (unlikely(*ppage == NULL)) {
 				if (copied == 0)
-					copied = -ENOMEM;
-				goto out;
+					return -ENOMEM;
+				return copied;
 			}
 		}
 
-		len = PAGE_SIZE;
 		kaddr = kmap_atomic(*ppage);
-		if (base) {
-			len -= base;
-			if (pglen < len)
-				len = pglen;
-			ret = copy_actor(desc, kaddr + base, len);
-			base = 0;
-		} else {
-			if (pglen < len)
-				len = pglen;
-			ret = copy_actor(desc, kaddr, len);
-		}
+		ret = xdr_skb_read_bits(desc, kaddr + poff, len);
 		flush_dcache_page(*ppage);
 		kunmap_atomic(kaddr);
+
 		copied += ret;
 		if (ret != len || !desc->count)
-			goto out;
+			return copied;
 		ppage++;
-	} while ((pglen -= len) != 0);
-copy_tail:
-	len = xdr->tail[0].iov_len;
-	if (base < len)
-		copied += copy_actor(desc, (char *)xdr->tail[0].iov_base + base, len - base);
-out:
+		pglen -= len;
+		poff = 0;
+	}
+
+	if (xdr->tail[0].iov_len) {
+		copied += xdr_skb_read_bits(desc, xdr->tail[0].iov_base,
+					xdr->tail[0].iov_len);
+	}
+
 	return copied;
 }
 
@@ -174,12 +130,13 @@ int csum_partial_copy_to_xdr(struct xdr_buf *xdr, struct sk_buff *skb)
 	desc.skb = skb;
 	desc.offset = 0;
 	desc.count = skb->len - desc.offset;
+	desc.no_checksum = skb_csum_unnecessary(skb);
 
-	if (skb_csum_unnecessary(skb))
+	if (desc.no_checksum)
 		goto no_checksum;
 
 	desc.csum = csum_partial(skb->data, desc.offset, skb->csum);
-	if (xdr_partial_copy_from_skb(xdr, 0, &desc, xdr_skb_read_and_csum_bits) < 0)
+	if (xdr_partial_copy_from_skb(xdr, &desc) < 0)
 		return -1;
 	if (desc.offset != skb->len) {
 		__wsum csum2;
@@ -195,7 +152,7 @@ int csum_partial_copy_to_xdr(struct xdr_buf *xdr, struct sk_buff *skb)
 		netdev_rx_csum_fault(skb->dev, skb);
 	return 0;
 no_checksum:
-	if (xdr_partial_copy_from_skb(xdr, 0, &desc, xdr_skb_read_bits) < 0)
+	if (xdr_partial_copy_from_skb(xdr, &desc) < 0)
 		return -1;
 	if (desc.count)
 		return -1;
-- 
2.47.2


