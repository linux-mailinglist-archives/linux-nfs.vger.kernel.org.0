Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093D6206757
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgFWWoO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:14 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14756 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387818AbgFWWoM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952250; x=1624488250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4fQMbm87XLuMjdyzcxRNhmh3Na51+kqOMqbV9Hrddvo=;
  b=A2HFuyB0O/jltii3gtNHQ+xWOxJWNx4ksVdOthgypOZ7rywWglUOpCK4
   yUniEYJryKrf3azJqRvUACzm0hCu/QlKccqN91oSPv4gZYnI+bBocMeIg
   o0BYnLXfUSkJYeTGGDHOWKsYDLil8DtErUIFF1G+prcdLz7uI6blbvMsd
   k=;
IronPort-SDR: wP4vrp4FmWuMtQtcGpZlLSMmyrCYX6s4Ww92p4kMA6O82LJScXsHcATK4Kp6aIpJqgDYuO3pRs
 CmbHWITnzHyQ==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="53337265"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Jun 2020 22:39:33 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 1F917A17EC;
        Tue, 23 Jun 2020 22:39:30 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:30 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:30 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:28 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 2301FC378B; Tue, 23 Jun 2020 22:39:28 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 09/10] nfsd: implement the xattr functions and en/decode logic
Date:   Tue, 23 Jun 2020 22:39:26 +0000
Message-ID: <20200623223927.31795-10-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Implement the main entry points for the *XATTR operations.

Add functions to calculate the reply size for the user extended attribute
operations, and implement the XDR encode / decode logic for these
operations.

Add the user extended attributes operations to nfsd4_ops.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4proc.c   | 120 ++++++++++++
 fs/nfsd/nfs4xdr.c    | 450 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/nfs4.h |   2 +-
 3 files changed, 571 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 841aad772798..a527da3d8052 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2097,6 +2097,68 @@ nfsd4_layoutreturn(struct svc_rqst *rqstp,
 }
 #endif /* CONFIG_NFSD_PNFS */
 
+static __be32
+nfsd4_getxattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	       union nfsd4_op_u *u)
+{
+	struct nfsd4_getxattr *getxattr = &u->getxattr;
+
+	return nfsd_getxattr(rqstp, &cstate->current_fh,
+			     getxattr->getxa_name, &getxattr->getxa_buf,
+			     &getxattr->getxa_len);
+}
+
+static __be32
+nfsd4_setxattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   union nfsd4_op_u *u)
+{
+	struct nfsd4_setxattr *setxattr = &u->setxattr;
+	__be32 ret;
+
+	if (opens_in_grace(SVC_NET(rqstp)))
+		return nfserr_grace;
+
+	ret = nfsd_setxattr(rqstp, &cstate->current_fh, setxattr->setxa_name,
+			    setxattr->setxa_buf, setxattr->setxa_len,
+			    setxattr->setxa_flags);
+
+	if (!ret)
+		set_change_info(&setxattr->setxa_cinfo, &cstate->current_fh);
+
+	return ret;
+}
+
+static __be32
+nfsd4_listxattrs(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   union nfsd4_op_u *u)
+{
+	/*
+	 * Get the entire list, then copy out only the user attributes
+	 * in the encode function.
+	 */
+	return nfsd_listxattr(rqstp, &cstate->current_fh,
+			     &u->listxattrs.lsxa_buf, &u->listxattrs.lsxa_len);
+}
+
+static __be32
+nfsd4_removexattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	   union nfsd4_op_u *u)
+{
+	struct nfsd4_removexattr *removexattr = &u->removexattr;
+	__be32 ret;
+
+	if (opens_in_grace(SVC_NET(rqstp)))
+		return nfserr_grace;
+
+	ret = nfsd_removexattr(rqstp, &cstate->current_fh,
+	    removexattr->rmxa_name);
+
+	if (!ret)
+		set_change_info(&removexattr->rmxa_cinfo, &cstate->current_fh);
+
+	return ret;
+}
+
 /*
  * NULL call.
  */
@@ -2706,6 +2768,42 @@ static inline u32 nfsd4_seek_rsize(struct svc_rqst *rqstp, struct nfsd4_op *op)
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
 static const struct nfsd4_operation nfsd4_ops[] = {
 	[OP_ACCESS] = {
 		.op_func = nfsd4_access,
@@ -3087,6 +3185,28 @@ static const struct nfsd4_operation nfsd4_ops[] = {
 		.op_name = "OP_COPY_NOTIFY",
 		.op_rsize_bop = nfsd4_copy_notify_rsize,
 	},
+	[OP_GETXATTR] = {
+		.op_func = nfsd4_getxattr,
+		.op_name = "OP_GETXATTR",
+		.op_rsize_bop = nfsd4_getxattr_rsize,
+	},
+	[OP_SETXATTR] = {
+		.op_func = nfsd4_setxattr,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
+		.op_name = "OP_SETXATTR",
+		.op_rsize_bop = nfsd4_setxattr_rsize,
+	},
+	[OP_LISTXATTRS] = {
+		.op_func = nfsd4_listxattrs,
+		.op_name = "OP_LISTXATTRS",
+		.op_rsize_bop = nfsd4_listxattrs_rsize,
+	},
+	[OP_REMOVEXATTR] = {
+		.op_func = nfsd4_removexattr,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
+		.op_name = "OP_REMOVEXATTR",
+		.op_rsize_bop = nfsd4_removexattr_rsize,
+	},
 };
 
 /**
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 48806b493eba..8bacc0ceae19 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -41,6 +41,8 @@
 #include <linux/pagemap.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/addr.h>
+#include <linux/xattr.h>
+#include <uapi/linux/xattr.h>
 
 #include "idmap.h"
 #include "acl.h"
@@ -1877,6 +1879,208 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
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
+ * Decode data into buffer. Uses head and pages constructed by
+ * svcxdr_construct_vector.
+ */
+static __be32
+nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct kvec *head,
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
+static __be32
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
+ * channel reply size. nfsd_getxattr will probe the length of the xattr,
+ * check it against getxa_len, and allocate + return the value.
+ */
+static __be32
+nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
+		      struct nfsd4_getxattr *getxattr)
+{
+	__be32 status;
+	u32 maxcount;
+
+	status = nfsd4_decode_xattr_name(argp, &getxattr->getxa_name);
+	if (status)
+		return status;
+
+	maxcount = svc_max_payload(argp->rqstp);
+	maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
+
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
+		status = nfsd4_vbuf_from_vector(argp, &head, pagelist,
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
@@ -1973,6 +2177,11 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
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
@@ -4458,6 +4667,241 @@ nfsd4_encode_noop(struct nfsd4_compoundres *resp, __be32 nfserr, void *p)
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
+	__be32 *p, err;
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
+	err = nfsd4_vbuf_to_stream(xdr, getxattr->getxa_buf,
+				    getxattr->getxa_len);
+
+	kvfree(getxattr->getxa_buf);
+
+	return err;
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
+static __be32
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
+	__be32 status;
+	__be32 *p;
+	u32 nuser;
+
+	eof = 1;
+
+	status = nfsd4_listxattr_validate_cookie(listxattrs, &offset);
+	if (status)
+		goto out;
+
+	/*
+	 * Reserve space for the cookie and the name array count. Record
+	 * the offsets to save them later.
+	 */
+	cookie_offset = xdr->buf->len;
+	count_offset = cookie_offset + 8;
+	p = xdr_reserve_space(xdr, 12);
+	if (!p) {
+		status = nfserr_resource;
+		goto out;
+	}
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
+				status = nfserr_toosmall;
+				goto out;
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
+		if (!p) {
+			status = nfserr_resource;
+			goto out;
+		}
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
+	if (nuser > 0 && count == 0) {
+		status = nfserr_badcookie;
+		goto out;
+	}
+
+wreof:
+	p = xdr_reserve_space(xdr, 4);
+	if (!p) {
+		status = nfserr_resource;
+		goto out;
+	}
+	*p = cpu_to_be32(eof);
+
+	cookie = offset + count;
+
+	write_bytes_to_xdr_buf(xdr->buf, cookie_offset, &cookie, 8);
+	count = htonl(count);
+	write_bytes_to_xdr_buf(xdr->buf, count_offset, &count, 4);
+out:
+	if (listxattrs->lsxa_len)
+		kvfree(listxattrs->lsxa_buf);
+	return status;
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
@@ -4547,6 +4991,12 @@ static const nfsd4_enc nfsd4_enc_ops[] = {
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
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index e6ca9d1d2e76..33ebe476428e 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -165,7 +165,7 @@ Needs to be updated if more operations are defined in future.*/
 #define FIRST_NFS4_OP	OP_ACCESS
 #define LAST_NFS40_OP	OP_RELEASE_LOCKOWNER
 #define LAST_NFS41_OP	OP_RECLAIM_COMPLETE
-#define LAST_NFS42_OP	OP_CLONE
+#define LAST_NFS42_OP	OP_REMOVEXATTR
 #define LAST_NFS4_OP	LAST_NFS42_OP
 
 enum nfsstat4 {
-- 
2.17.2

