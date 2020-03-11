Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010B0182302
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbgCKUAB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 16:00:01 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:58410 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbgCKUAA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 16:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956800; x=1615492800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tGWjxPipVgUTROEGt9BdX7wONo6ZrvxHpVqd+apg2tA=;
  b=HU2lPWTh5IKxFS3pX1YQbcrJgiSyBZ9zMl3+SI+YceKpkSYJ5IC/i1o0
   F7CCo/ApmeFq5x0QGVsOnuxVqNP40ytzKxdaOyeXgft2P/1rRi2n4ntdQ
   P3vtSzm80KDWHMr4xr9fW+WZIIy1LTgrYdcNL1nT+f9YdHzCm1zD2f9NP
   M=;
IronPort-SDR: pH7/+iYXOavaTw5dUGvF0pKmxjKSZ+EgFxMXEaVBjHnq2rtN2ct3T0x41iRkeUi12B4e2XbZp7
 pv4R1NyaIPsA==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="20833432"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 Mar 2020 19:59:59 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id EC787A2495;
        Wed, 11 Mar 2020 19:59:56 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:55 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 21555DEF49; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 11/14] nfsd: add user xattr RPC XDR encoding/decoding logic
Date:   Wed, 11 Mar 2020 19:59:51 +0000
Message-ID: <20200311195954.27117-12-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add functions to calculate the reply size for the user extended attribute
operations, and implement the XDR encode / decode logic for these
operations.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4proc.c |  36 +++++
 fs/nfsd/nfs4xdr.c  | 448 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 484 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a76b9025a357..44d488bdebd9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2778,6 +2778,42 @@ static inline u32 nfsd4_seek_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
 	return (op_encode_hdr_size + 3) * sizeof(__be32);
 }
 
+static inline u32 nfsd4_getxattr_rsize(struct svc_rqst *rqstp,
+				       struct nfsd4_op *op)
+{
+	u32 maxcount, rlen;
+
+	maxcount = svc_max_payload(rqstp);
+	rlen = min_t(u32, XATTR_SIZE_MAX, maxcount);
+
+	return (op_encode_hdr_size + 1 + XDR_QUADLEN(rlen)) * sizeof(__be32);
+}
+
+static inline u32 nfsd4_setxattr_rsize(struct svc_rqst *rqstp,
+				       struct nfsd4_op *op)
+{
+	return (op_encode_hdr_size + op_encode_change_info_maxsz)
+		* sizeof(__be32);
+}
+static inline u32 nfsd4_listxattrs_rsize(struct svc_rqst *rqstp,
+					 struct nfsd4_op *op)
+{
+	u32 maxcount, rlen;
+
+	maxcount = svc_max_payload(rqstp);
+	rlen = min(op->u.listxattrs.lsxa_maxcount, maxcount);
+
+	return (op_encode_hdr_size + 4 + XDR_QUADLEN(rlen)) * sizeof(__be32);
+}
+
+static inline u32 nfsd4_removexattr_rsize(struct svc_rqst *rqstp,
+					  struct nfsd4_op *op)
+{
+	return (op_encode_hdr_size + op_encode_change_info_maxsz)
+		* sizeof(__be32);
+}
+
+
 static const struct nfsd4_operation nfsd4_ops[LAST_NFS4_OP + 1] = {
 	[OP_ACCESS] = {
 		.op_func = nfsd4_access,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b12d7ac6f52c..41c8b95ca1c5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1879,6 +1879,224 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
 	DECODE_TAIL;
 }
 
+/*
+ * XDR data that is more than PAGE_SIZE in size is normally part of a
+ * read or write. However, the size of extended attributes is limited
+ * by the maximum request size, and then further limited by the underlying
+ * filesystem limits. This can exceed PAGE_SIZE (currently, XATTR_SIZE_MAX
+ * is 64k). Since there is no kvec- or page-based interface to xattrs,
+ * and we're not dealing with contiguous pages, we need to do some copying.
+ */
+
+/*
+ * Decode int to buffer. Uses head and pages constructed by
+ * svcxdr_construct_vector.
+ */
+static int
+nfsd4_vbuf_from_stream(struct nfsd4_compoundargs *argp, struct kvec *head,
+		       struct page **pages, char **bufp, u32 buflen)
+{
+	char *tmp, *dp;
+	u32 len;
+
+	if (buflen <= head->iov_len) {
+		/*
+		 * We're in luck, the head has enough space. Just return
+		 * the head, no need for copying.
+		 */
+		*bufp = head->iov_base;
+		return 0;
+	}
+
+	tmp = svcxdr_tmpalloc(argp, buflen);
+	if (tmp == NULL)
+		return nfserr_jukebox;
+
+	dp = tmp;
+	memcpy(dp, head->iov_base, head->iov_len);
+	buflen -= head->iov_len;
+	dp += head->iov_len;
+
+	while (buflen > 0) {
+		len = min_t(u32, buflen, PAGE_SIZE);
+		memcpy(dp, page_address(*pages), len);
+
+		buflen -= len;
+		dp += len;
+		pages++;
+	}
+
+	*bufp = tmp;
+	return 0;
+}
+
+/*
+ * Get a user extended attribute name from the XDR buffer.
+ * It will not have the "user." prefix, so prepend it.
+ * Lastly, check for nul characters in the name.
+ */
+static int
+nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
+{
+	DECODE_HEAD;
+	char *name, *sp, *dp;
+	u32 namelen, cnt;
+
+	READ_BUF(4);
+	namelen = be32_to_cpup(p++);
+
+	if (namelen > (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN))
+		return nfserr_nametoolong;
+
+	if (namelen == 0)
+		goto xdr_error;
+
+	READ_BUF(namelen);
+
+	name = svcxdr_tmpalloc(argp, namelen + XATTR_USER_PREFIX_LEN + 1);
+	if (!name)
+		return nfserr_jukebox;
+
+	memcpy(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
+
+	/*
+	 * Copy the extended attribute name over while checking for 0
+	 * characters.
+	 */
+	sp = (char *)p;
+	dp = name + XATTR_USER_PREFIX_LEN;
+	cnt = namelen;
+
+	while (cnt-- > 0) {
+		if (*sp == '\0')
+			goto xdr_error;
+		*dp++ = *sp++;
+	}
+	*dp = '\0';
+
+	*namep = name;
+
+	DECODE_TAIL;
+}
+
+/*
+ * A GETXATTR op request comes without a length specifier. We just set the
+ * maximum length for the reply based on XATTR_SIZE_MAX and the maximum
+ * channel reply size, allocate a buffer of that length and pass it to
+ * vfs_getxattr.
+ */
+static __be32
+nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
+		      struct nfsd4_getxattr *getxattr)
+{
+	int status;
+	u32 maxcount;
+
+	status = nfsd4_decode_xattr_name(argp, &getxattr->getxa_name);
+	if (status)
+		return status;
+
+	maxcount = svc_max_payload(argp->rqstp);
+	maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
+
+	getxattr->getxa_buf = svcxdr_tmpalloc(argp, maxcount);
+	if (!getxattr->getxa_buf)
+		status = nfserr_jukebox;
+	getxattr->getxa_len = maxcount;
+
+	return status;
+}
+
+static __be32
+nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
+		      struct nfsd4_setxattr *setxattr)
+{
+	DECODE_HEAD;
+	u32 flags, maxcount, size;
+	struct kvec head;
+	struct page **pagelist;
+
+	READ_BUF(4);
+	flags = be32_to_cpup(p++);
+
+	if (flags > SETXATTR4_REPLACE)
+		return nfserr_inval;
+	setxattr->setxa_flags = flags;
+
+	status = nfsd4_decode_xattr_name(argp, &setxattr->setxa_name);
+	if (status)
+		return status;
+
+	maxcount = svc_max_payload(argp->rqstp);
+	maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
+
+	READ_BUF(4);
+	size = be32_to_cpup(p++);
+	if (size > maxcount)
+		return nfserr_xattr2big;
+
+	setxattr->setxa_len = size;
+	if (size > 0) {
+		status = svcxdr_construct_vector(argp, &head, &pagelist, size);
+		if (status)
+			return status;
+
+		status = nfsd4_vbuf_from_stream(argp, &head, pagelist,
+		    &setxattr->setxa_buf, size);
+	}
+
+	DECODE_TAIL;
+}
+
+static __be32
+nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
+			struct nfsd4_listxattrs *listxattrs)
+{
+	DECODE_HEAD;
+	u32 maxcount;
+
+	READ_BUF(12);
+	p = xdr_decode_hyper(p, &listxattrs->lsxa_cookie);
+
+	/*
+	 * If the cookie  is too large to have even one user.x attribute
+	 * plus trailing '\0' left in a maximum size buffer, it's invalid.
+	 */
+	if (listxattrs->lsxa_cookie >=
+	    (XATTR_LIST_MAX / (XATTR_USER_PREFIX_LEN + 2)))
+		return nfserr_badcookie;
+
+	maxcount = be32_to_cpup(p++);
+	if (maxcount < 8)
+		/* Always need at least 2 words (length and one character) */
+		return nfserr_inval;
+
+	maxcount = min(maxcount, svc_max_payload(argp->rqstp));
+	listxattrs->lsxa_maxcount = maxcount;
+
+	/*
+	 * Unfortunately, there is no interface to only list xattrs for
+	 * one prefix. So there is no good way to convert maxcount to
+	 * a maximum value to pass to vfs_listxattr, as we don't know
+	 * how many of the returned attributes will be user attributes.
+	 *
+	 * So, always ask vfs_listxattr for the maximum size, and encode
+	 * as many as possible.
+	 */
+	listxattrs->lsxa_buf = svcxdr_tmpalloc(argp, XATTR_LIST_MAX);
+	if (!listxattrs->lsxa_buf)
+		status = nfserr_jukebox;
+
+	DECODE_TAIL;
+}
+
+static __be32
+nfsd4_decode_removexattr(struct nfsd4_compoundargs *argp,
+			 struct nfsd4_removexattr *removexattr)
+{
+	return nfsd4_decode_xattr_name(argp, &removexattr->rmxa_name);
+}
+
 static __be32
 nfsd4_decode_noop(struct nfsd4_compoundargs *argp, void *p)
 {
@@ -1975,6 +2193,11 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_SEEK]		= (nfsd4_dec)nfsd4_decode_seek,
 	[OP_WRITE_SAME]		= (nfsd4_dec)nfsd4_decode_notsupp,
 	[OP_CLONE]		= (nfsd4_dec)nfsd4_decode_clone,
+	/* RFC 8276 extended atributes operations */
+	[OP_GETXATTR]		= (nfsd4_dec)nfsd4_decode_getxattr,
+	[OP_SETXATTR]		= (nfsd4_dec)nfsd4_decode_setxattr,
+	[OP_LISTXATTRS]		= (nfsd4_dec)nfsd4_decode_listxattrs,
+	[OP_REMOVEXATTR]	= (nfsd4_dec)nfsd4_decode_removexattr,
 };
 
 static inline bool
@@ -4458,6 +4681,225 @@ nfsd4_encode_noop(struct nfsd4_compoundres *resp, __be32 nfserr, void *p)
 	return nfserr;
 }
 
+/*
+ * Encode kmalloc-ed buffer in to XDR stream.
+ */
+static int
+nfsd4_vbuf_to_stream(struct xdr_stream *xdr, char *buf, u32 buflen)
+{
+	u32 cplen;
+	__be32 *p;
+
+	cplen = min_t(unsigned long, buflen,
+		      ((void *)xdr->end - (void *)xdr->p));
+	p = xdr_reserve_space(xdr, cplen);
+	if (!p)
+		return nfserr_resource;
+
+	memcpy(p, buf, cplen);
+	buf += cplen;
+	buflen -= cplen;
+
+	while (buflen) {
+		cplen = min_t(u32, buflen, PAGE_SIZE);
+		p = xdr_reserve_space(xdr, cplen);
+		if (!p)
+			return nfserr_resource;
+
+		memcpy(p, buf, cplen);
+
+		if (cplen < PAGE_SIZE) {
+			/*
+			 * We're done, with a length that wasn't page
+			 * aligned, so possibly not word aligned. Pad
+			 * any trailing bytes with 0.
+			 */
+			xdr_encode_opaque_fixed(p, NULL, cplen);
+			break;
+		}
+
+		buflen -= PAGE_SIZE;
+		buf += PAGE_SIZE;
+	}
+
+	return 0;
+}
+
+static __be32
+nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
+		      struct nfsd4_getxattr *getxattr)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 4);
+	if (!p)
+		return nfserr_resource;
+
+	*p = cpu_to_be32(getxattr->getxa_len);
+
+	if (getxattr->getxa_len == 0)
+		return 0;
+
+	return nfsd4_vbuf_to_stream(xdr, getxattr->getxa_buf,
+				    getxattr->getxa_len);
+}
+
+static __be32
+nfsd4_encode_setxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
+		      struct nfsd4_setxattr *setxattr)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 20);
+	if (!p)
+		return nfserr_resource;
+
+	encode_cinfo(p, &setxattr->setxa_cinfo);
+
+	return 0;
+}
+
+/*
+ * See if there are cookie values that can be rejected outright.
+ */
+static int
+nfsd4_listxattr_validate_cookie(struct nfsd4_listxattrs *listxattrs,
+				u32 *offsetp)
+{
+	u64 cookie = listxattrs->lsxa_cookie;
+
+	/*
+	 * If the cookie is larger than the maximum number we can fit
+	 * in either the buffer we just got back from vfs_listxattr, or,
+	 * XDR-encoded, in the return buffer, it's invalid.
+	 */
+	if (cookie > (listxattrs->lsxa_len) / (XATTR_USER_PREFIX_LEN + 2))
+		return nfserr_badcookie;
+
+	if (cookie > (listxattrs->lsxa_maxcount /
+		      (XDR_QUADLEN(XATTR_USER_PREFIX_LEN + 2) + 4)))
+		return nfserr_badcookie;
+
+	*offsetp = (u32)cookie;
+	return 0;
+}
+
+static __be32
+nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
+			struct nfsd4_listxattrs *listxattrs)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	u32 cookie_offset, count_offset, eof;
+	u32 left, xdrleft, slen, count;
+	u32 xdrlen, offset;
+	u64 cookie;
+	char *sp;
+	int status;
+	__be32 *p;
+	u32 nuser;
+
+	eof = 1;
+
+	status = nfsd4_listxattr_validate_cookie(listxattrs, &offset);
+	if (status)
+		return status;
+
+	/*
+	 * Reserve space for the cookie and the name array count. Record
+	 * the offsets to save them later.
+	 */
+	cookie_offset = xdr->buf->len;
+	count_offset = cookie_offset + 8;
+	p = xdr_reserve_space(xdr, 12);
+	if (!p)
+		return nfserr_resource;
+
+	count = 0;
+	left = listxattrs->lsxa_len;
+	sp = listxattrs->lsxa_buf;
+	nuser = 0;
+
+	xdrleft = listxattrs->lsxa_maxcount;
+
+	while (left > 0 && xdrleft > 0) {
+		slen = strlen(sp);
+
+		/*
+		 * Check if this a user. attribute, skip it if not.
+		 */
+		if (strncmp(sp, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+			goto contloop;
+
+		slen -= XATTR_USER_PREFIX_LEN;
+		xdrlen = 4 + ((slen + 3) & ~3);
+		if (xdrlen > xdrleft) {
+			if (count == 0) {
+				/*
+				 * Can't even fit the first attribute name.
+				 */
+				return nfserr_toosmall;
+			}
+			eof = 0;
+			goto wreof;
+		}
+
+		left -= XATTR_USER_PREFIX_LEN;
+		sp += XATTR_USER_PREFIX_LEN;
+		if (nuser++ < offset)
+			goto contloop;
+
+
+		p = xdr_reserve_space(xdr, xdrlen);
+		if (!p)
+			return nfserr_resource;
+
+		p = xdr_encode_opaque(p, sp, slen);
+
+		xdrleft -= xdrlen;
+		count++;
+contloop:
+		sp += slen + 1;
+		left -= slen + 1;
+	}
+
+	/*
+	 * If there were user attributes to copy, but we didn't copy
+	 * any, the offset was too large (e.g. the cookie was invalid).
+	 */
+	if (nuser > 0 && count == 0)
+		return nfserr_badcookie;
+
+wreof:
+	p = xdr_reserve_space(xdr, 4);
+	if (!p)
+		return nfserr_resource;
+	*p = cpu_to_be32(eof);
+
+	cookie = offset + count;
+
+	write_bytes_to_xdr_buf(xdr->buf, cookie_offset, &cookie, 8);
+	count = htonl(count);
+	write_bytes_to_xdr_buf(xdr->buf, count_offset, &count, 4);
+	return 0;
+}
+
+static __be32
+nfsd4_encode_removexattr(struct nfsd4_compoundres *resp, __be32 nfserr,
+			 struct nfsd4_removexattr *removexattr)
+{
+	struct xdr_stream *xdr = &resp->xdr;
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 20);
+	if (!p)
+		return nfserr_resource;
+
+	p = encode_cinfo(p, &removexattr->rmxa_cinfo);
+	return 0;
+}
+
 typedef __be32(* nfsd4_enc)(struct nfsd4_compoundres *, __be32, void *);
 
 /*
@@ -4547,6 +4989,12 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
 	[OP_SEEK]		= (nfsd4_enc)nfsd4_encode_seek,
 	[OP_WRITE_SAME]		= (nfsd4_enc)nfsd4_encode_noop,
 	[OP_CLONE]		= (nfsd4_enc)nfsd4_encode_noop,
+
+	/* RFC 8276 extended atributes operations */
+	[OP_GETXATTR]		= (nfsd4_enc)nfsd4_encode_getxattr,
+	[OP_SETXATTR]		= (nfsd4_enc)nfsd4_encode_setxattr,
+	[OP_LISTXATTRS]		= (nfsd4_enc)nfsd4_encode_listxattrs,
+	[OP_REMOVEXATTR]	= (nfsd4_enc)nfsd4_encode_removexattr,
 };
 
 /*
-- 
2.16.6

