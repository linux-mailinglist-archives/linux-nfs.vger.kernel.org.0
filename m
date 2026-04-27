Return-Path: <linux-nfs+bounces-21180-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHR1DHpr72nRBAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21180-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:58:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E358B473DFF
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2AA53059CF8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1C83D3D02;
	Mon, 27 Apr 2026 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjOam5DL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D8C3D3CFB;
	Mon, 27 Apr 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297870; cv=none; b=cBcHGto/qxRJlUB8CtQkIF9pcjansMoLIY94ZfJNRc4SyRb+kbbhpDT4vztHRc10PtprdHu1XXTMLKGPAVi9BJJycoFNc3gHfNCe7hiDixFGsI3j4pNBFrjvjdyyCkoKT5NgpxvMbNS3j064Ha9Fxkt6Rx+w3kJumTfmIeXROo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297870; c=relaxed/simple;
	bh=XMhgRYzG7QWFcbaqkjHjqi4dadHAsZUNTdHXj8Qt44Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5Dg1KhiE1mzPncObiu0vj9QiGyAMcUQqlP/WSMhuhqFSeSQahZniKGfZW35dxIAu31aSQct6OTzuDzZHWha/g4NI/PM+mt9zErMcPQyqEAh/YgxkFkZ4J5ecOTauC6auhiX7RsL+W/gYq4/rEydxk0jRIi1AOJp70fxgc3QbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjOam5DL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DFEC19425;
	Mon, 27 Apr 2026 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297869;
	bh=XMhgRYzG7QWFcbaqkjHjqi4dadHAsZUNTdHXj8Qt44Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WjOam5DLB0qKY6quH949oirhFtGmrm9z47gMfD/8YVA/JfeJixXRbnsfacnDCnSLe
	 GgQC3sZQWCzaGlI2SV9SNY1eRTnysDNKSCRZRe1KGw0DlMEZC/V7188euXm8IPUZkk
	 7rqd0M5OdDls7bmSxxtiuixHz/CTiILJzELNez3UwqVtrIrEjnGkrwbYt1bUgv1+nQ
	 Ac70HzkuKWONKoD3StAGEhSphBbxNGm4NImRct61s06g6V4jCA2LVhy+DGrf2H0rkD
	 6KL8giQYnOvV3aKVo3Dc84eBH80lbC5K29Eks2JMKJ75F8NUAMm9QBBY33UwRPNiaU
	 9lnSHnb9uY+dw==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:47 -0400
Subject: [PATCH 03/18] SUNRPC: Add helpers to convert xdr_buf byte ranges
 to scatterlists
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-3-1fc1253b64c0@oracle.com>
References: <20260427-crypto-krb5-api-v1-0-1fc1253b64c0@oracle.com>
In-Reply-To: <20260427-crypto-krb5-api-v1-0-1fc1253b64c0@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 David Howells <dhowells@redhat.com>, Simo Sorce <simo@redhat.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8352;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=7amdQDVK//MMHFziQYxn20KAzL97/6EltF3O+piKioY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nF/fVQJe8qlxhiRwAqGbKqygosuffgTKN3n
 RjAf6AXAo+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxQAKCRAzarMzb2Z/
 l4cpD/4otJKx/YDVj4n1kdwDPZsxtfcCiXegIq1a7xQ0IkRXEN7MSwIQeUnGdTYaV0Ct8M2tdsm
 x8tShgpTwT9TuuNCuPD80T0ad3c12GxqigLRON7h+gNn4WATTPjoQvmrKC9v/cT0nZBnIc4mCdO
 q3zqu1bTk9vxNjBxUj93WQ0s3vlsBA0UIn1t8TYlg2pHIamMl8SOACTFsONhYgm5RIQa4V4I/ck
 A3hc4OGynoH5i1GiFStSs+HROsvA+1/Csvc+xpdOR3UyeE6cykBfAfeIl9O6pdExUa5n8ch7V05
 8OLNer5VzqzM312ZskZSKWOx598m5SU+SaiTvFkybzQUzIkwVpbR+vt4LHDL6UZt3+q12/YNIZR
 GgwwJ230LlqzOJ+jQYL59140qtW2Drb9U2Zcrdlo9lfPbvSWrw/HOFQx2SCaZHLXPvGvy/l8r8x
 t9B1PMa+m3+6uvkHkTQltBzf4zvi8+s8Q7/6yZD/hn21uPrDyPucnYQMOPlom49vQn5J+jcV80A
 X1QGmSU7ZR2ASctcv16HPvDuQBnvEovi+kPZm3kJ/IS6R5AU73GYZmrMgV7jvLoGOXQM9tkKKSL
 mzV5+bRLSSOM9XyXT9zekEqnEffVL9ZG3MmDWR0ERYn8yjBaO+FEgZnHZyWVPeglbVGuJnEzKdI
 CVWr82f/W7YCbdw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: E358B473DFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21180-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

The crypto/krb5 library accepts data in scatterlist form, but
the GSS-API layer presents RPC payloads as struct xdr_buf.
Bridge that gap with a pair of helper functions:

  xdr_buf_to_sg()        - populate a caller-supplied scatterlist
                           array from a byte range
  xdr_buf_to_sg_alloc()  - populate a caller-supplied inline
                           scatterlist, chaining to a heap-
                           allocated overflow for large payloads

The inline array (typically stack-allocated at eight entries)
covers the common case of small RPCs with no heap allocation
on the encrypt/decrypt path. Only buffers spanning many pages
incur a kmalloc for the chained extension.

The segment-walking logic follows the same head, page array,
tail traversal as xdr_process_buf(), but populates a
scatterlist directly rather than invoking a per-segment
callback. sg_next() traversal makes the walker safe for
chained scatterlists. Once subsequent patches reroute all
per-message crypto operations through crypto/krb5,
xdr_process_buf() loses its last callers and is removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h |  15 ++++
 net/sunrpc/xdr.c           | 199 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index b639a6fafcbc..f82446993fde 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -140,6 +140,21 @@ int	xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp);
 void	xdr_free_bvec(struct xdr_buf *buf);
 unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 			     const struct xdr_buf *xdr);
+int xdr_buf_to_sg(const struct xdr_buf *buf, unsigned int offset,
+		  unsigned int len, struct scatterlist *sg, unsigned int nsg);
+int xdr_buf_to_sg_alloc(const struct xdr_buf *buf, unsigned int offset,
+			unsigned int len, struct scatterlist *sg_head,
+			unsigned int sg_head_nents,
+			struct scatterlist **sg_overflow, gfp_t gfp);
+
+/*
+ * Inline scatterlist entries for xdr_buf_to_sg_alloc().  Sized to cover the
+ * head kvec, tail kvec, and a few page fragments without any heap allocation.
+ */
+enum {
+	XDR_BUF_TO_SG_NENTS	= 8,
+};
+
 
 static inline __be32 *xdr_encode_array(__be32 *p, const void *s, unsigned int len)
 {
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index e83d5d0be78b..516833b4c114 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -187,6 +187,205 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 }
 EXPORT_SYMBOL_GPL(xdr_buf_to_bvec);
 
+/**
+ * xdr_buf_to_sg - Populate a scatterlist from an xdr_buf range
+ * @buf: xdr_buf to map
+ * @offset: starting byte offset within @buf
+ * @len: number of bytes to cover
+ * @sg: scatterlist array initialized with sg_init_table()
+ * @nsg: number of entries available in @sg
+ *
+ * @sg is traversed with sg_next(), so callers may pass a list
+ * assembled with sg_chain().
+ *
+ * Return: on success, the number of scatterlist entries used; the
+ * last used entry is marked with sg_mark_end().  On failure, a
+ * negative errno.
+ */
+int xdr_buf_to_sg(const struct xdr_buf *buf, unsigned int offset,
+		  unsigned int len, struct scatterlist *sg, unsigned int nsg)
+{
+	unsigned int page_len, thislen, page_offset;
+	struct scatterlist *cur = sg, *prev = NULL;
+	int nents = 0;
+	int i;
+
+	if (len == 0)
+		return 0;
+
+	if (offset >= buf->head[0].iov_len) {
+		offset -= buf->head[0].iov_len;
+	} else {
+		thislen = min_t(unsigned int,
+				buf->head[0].iov_len - offset, len);
+		if (nents >= nsg)
+			return -ENOSPC;
+		sg_set_buf(cur, buf->head[0].iov_base + offset,
+			   thislen);
+		prev = cur;
+		cur = sg_next(cur);
+		nents++;
+		len -= thislen;
+		offset = 0;
+	}
+	if (len == 0)
+		goto done;
+
+	if (offset >= buf->page_len) {
+		offset -= buf->page_len;
+	} else {
+		page_len = min(buf->page_len - offset, len);
+		len -= page_len;
+		page_offset = (offset + buf->page_base) & (PAGE_SIZE - 1);
+		i = (offset + buf->page_base) >> PAGE_SHIFT;
+		thislen = PAGE_SIZE - page_offset;
+		do {
+			if (thislen > page_len)
+				thislen = page_len;
+			if (nents >= nsg)
+				return -ENOSPC;
+			sg_set_page(cur, buf->pages[i],
+				    thislen, page_offset);
+			prev = cur;
+			cur = sg_next(cur);
+			nents++;
+			page_len -= thislen;
+			i++;
+			page_offset = 0;
+			thislen = PAGE_SIZE;
+		} while (page_len != 0);
+		offset = 0;
+	}
+	if (len == 0)
+		goto done;
+
+	if (offset < buf->tail[0].iov_len) {
+		thislen = min_t(unsigned int,
+				buf->tail[0].iov_len - offset, len);
+		if (nents >= nsg)
+			return -ENOSPC;
+		sg_set_buf(cur, buf->tail[0].iov_base + offset,
+			   thislen);
+		prev = cur;
+		nents++;
+		len -= thislen;
+	}
+	if (len != 0)
+		return -EINVAL;
+
+done:
+	if (prev)
+		sg_mark_end(prev);
+	return nents;
+}
+EXPORT_SYMBOL_GPL(xdr_buf_to_sg);
+
+/*
+ * Count the scatterlist entries needed to cover [offset, offset + len)
+ * within @buf.  Mirrors the walk in xdr_buf_to_sg() so the caller can
+ * size an allocation that matches the requested sub-range rather than
+ * the full xdr_buf.
+ */
+static unsigned int xdr_buf_sg_nents(const struct xdr_buf *buf,
+				     unsigned int offset, unsigned int len)
+{
+	unsigned int nsg = 0, thislen, page_offset;
+
+	if (len == 0)
+		return 0;
+
+	if (offset < buf->head[0].iov_len) {
+		thislen = min_t(unsigned int,
+				buf->head[0].iov_len - offset, len);
+		nsg++;
+		len -= thislen;
+		offset = 0;
+	} else {
+		offset -= buf->head[0].iov_len;
+	}
+	if (len == 0)
+		return nsg;
+
+	if (offset < buf->page_len) {
+		thislen = min(buf->page_len - offset, len);
+		page_offset = (offset + buf->page_base) & (PAGE_SIZE - 1);
+		nsg += DIV_ROUND_UP(page_offset + thislen, PAGE_SIZE);
+		len -= thislen;
+		offset = 0;
+	} else {
+		offset -= buf->page_len;
+	}
+	if (len == 0)
+		return nsg;
+
+	if (offset < buf->tail[0].iov_len)
+		nsg++;
+	return nsg;
+}
+
+/**
+ * xdr_buf_to_sg_alloc - Populate a scatterlist for an xdr_buf range
+ * @buf: xdr_buf to map
+ * @offset: starting byte offset within @buf
+ * @len: number of bytes to cover
+ * @sg_head: caller-provided scatterlist array (typically stack-allocated)
+ * @sg_head_nents: number of entries in @sg_head
+ * @sg_overflow: OUT: chained extension, or NULL when @sg_head sufficed
+ * @gfp: memory allocation flags for overflow
+ *
+ * Populates @sg_head directly when the xdr_buf fits.  When more
+ * entries are needed, an overflow scatterlist is allocated and
+ * chained from @sg_head so that the result is traversable with
+ * sg_next().
+ *
+ * Return: on success, the number of populated scatterlist entries
+ * (counting only data entries, not chain entries).  @sg_head is
+ * the head of the resulting list.  Caller must kfree @sg_overflow
+ * when done.  On failure, a negative errno.
+ */
+int xdr_buf_to_sg_alloc(const struct xdr_buf *buf, unsigned int offset,
+			unsigned int len, struct scatterlist *sg_head,
+			unsigned int sg_head_nents,
+			struct scatterlist **sg_overflow, gfp_t gfp)
+{
+	unsigned int nsg;
+	int ret;
+
+	*sg_overflow = NULL;
+	if (len == 0)
+		return 0;
+
+	nsg = xdr_buf_sg_nents(buf, offset, len);
+	if (nsg == 0)
+		return -EINVAL;
+
+	if (nsg <= sg_head_nents) {
+		sg_init_table(sg_head, nsg);
+	} else {
+		/* +1 replaces the slot sg_chain() consumes as the link. */
+		unsigned int overflow_nents = nsg - sg_head_nents + 1;
+		struct scatterlist *overflow;
+
+		overflow = kmalloc_array(overflow_nents, sizeof(*overflow),
+					 gfp);
+		if (!overflow)
+			return -ENOMEM;
+
+		sg_init_table(sg_head, sg_head_nents);
+		sg_init_table(overflow, overflow_nents);
+		sg_chain(sg_head, sg_head_nents, overflow);
+		*sg_overflow = overflow;
+	}
+
+	ret = xdr_buf_to_sg(buf, offset, len, sg_head, nsg);
+	if (ret < 0) {
+		kfree(*sg_overflow);
+		*sg_overflow = NULL;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xdr_buf_to_sg_alloc);
+
 /**
  * xdr_inline_pages - Prepare receive buffer for a large reply
  * @xdr: xdr_buf into which reply will be placed

-- 
2.53.0


