Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D385A20675D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbgFWWoR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:17 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:57642 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387926AbgFWWoO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952253; x=1624488253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=j5p0qSUuAcztmqwkbbCE1LaEmMCppQPANjme0LQKnTI=;
  b=Oowb4npUdhJtOPXL3KtCGQ1kYFdtJza4hqT9isdRWewsqZcO0eV9WhhY
   DTqx2zmW5BX8LwCBCcQ7mDRGEmUe3XeYsGeKc6efBstQM87jQtIixGG97
   CBWDbNSBPJkkUFmXFJHVY0S2b7wIHXGXdI4IBPv3yf/2rDz6Zk4ZmeC/t
   M=;
IronPort-SDR: y2Jv8IJohgdarPKKY/VOvl0EcvsazOaOJhjIWrKchv0UfauLL95+yzwOfjZMBviRVfaKL5P2eR
 UEp6BEq26Oxg==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="46390757"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 23 Jun 2020 22:39:06 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id F3865A28D3;
        Tue, 23 Jun 2020 22:39:05 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:04 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:04 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id C11A2CD35F; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 05/13] NFSv4.2: add client side XDR handling for extended attributes
Date:   Tue, 23 Jun 2020 22:38:56 +0000
Message-ID: <20200623223904.31643-6-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Define the argument and response structures that will be used for
RFC 8276 extended attribute RPC calls, and implement the necessary
functions to encode/decode the extended attribute operations.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs42xdr.c       | 368 +++++++++++++++++++++++++++++++++++++++-
 fs/nfs/nfs4xdr.c        |   6 +
 include/linux/nfs_xdr.h |  59 ++++++-
 3 files changed, 430 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 6712daa9d85b..cc50085e151c 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -169,7 +169,6 @@
 					 decode_clone_maxsz + \
 					 decode_getattr_maxsz)
 
-#ifdef CONFIG_NFS_V4_2
 /* Not limited by NFS itself, limited by the generic xattr code */
 #define nfs4_xattr_name_maxsz   XDR_QUADLEN(XATTR_NAME_MAX)
 
@@ -241,7 +240,6 @@ const u32 nfs42_maxlistxattrs_overhead = ((RPC_MAX_HEADER_WITH_AUTH +
 					compound_decode_hdr_maxsz +
 					decode_sequence_maxsz +
 					decode_putfh_maxsz + 3) * XDR_UNIT);
-#endif
 
 static void encode_fallocate(struct xdr_stream *xdr,
 			     const struct nfs42_falloc_args *args)
@@ -407,6 +405,210 @@ static void encode_layouterror(struct xdr_stream *xdr,
 	encode_device_error(xdr, &args->errors[0]);
 }
 
+static void encode_setxattr(struct xdr_stream *xdr,
+			    const struct nfs42_setxattrargs *arg,
+			    struct compound_hdr *hdr)
+{
+	__be32 *p;
+
+	BUILD_BUG_ON(XATTR_CREATE != SETXATTR4_CREATE);
+	BUILD_BUG_ON(XATTR_REPLACE != SETXATTR4_REPLACE);
+
+	encode_op_hdr(xdr, OP_SETXATTR, decode_setxattr_maxsz, hdr);
+	p = reserve_space(xdr, 4);
+	*p = cpu_to_be32(arg->xattr_flags);
+	encode_string(xdr, strlen(arg->xattr_name), arg->xattr_name);
+	p = reserve_space(xdr, 4);
+	*p = cpu_to_be32(arg->xattr_len);
+	if (arg->xattr_len)
+		xdr_write_pages(xdr, arg->xattr_pages, 0, arg->xattr_len);
+}
+
+static int decode_setxattr(struct xdr_stream *xdr,
+			   struct nfs4_change_info *cinfo)
+{
+	int status;
+
+	status = decode_op_hdr(xdr, OP_SETXATTR);
+	if (status)
+		goto out;
+	status = decode_change_info(xdr, cinfo);
+out:
+	return status;
+}
+
+
+static void encode_getxattr(struct xdr_stream *xdr, const char *name,
+			    struct compound_hdr *hdr)
+{
+	encode_op_hdr(xdr, OP_GETXATTR, decode_getxattr_maxsz, hdr);
+	encode_string(xdr, strlen(name), name);
+}
+
+static int decode_getxattr(struct xdr_stream *xdr,
+			   struct nfs42_getxattrres *res,
+			   struct rpc_rqst *req)
+{
+	int status;
+	__be32 *p;
+	u32 len, rdlen;
+
+	status = decode_op_hdr(xdr, OP_GETXATTR);
+	if (status)
+		return status;
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	len = be32_to_cpup(p);
+	if (len > req->rq_rcv_buf.page_len)
+		return -ERANGE;
+
+	res->xattr_len = len;
+
+	if (len > 0) {
+		rdlen = xdr_read_pages(xdr, len);
+		if (rdlen < len)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static void encode_removexattr(struct xdr_stream *xdr, const char *name,
+			       struct compound_hdr *hdr)
+{
+	encode_op_hdr(xdr, OP_REMOVEXATTR, decode_removexattr_maxsz, hdr);
+	encode_string(xdr, strlen(name), name);
+}
+
+
+static int decode_removexattr(struct xdr_stream *xdr,
+			   struct nfs4_change_info *cinfo)
+{
+	int status;
+
+	status = decode_op_hdr(xdr, OP_REMOVEXATTR);
+	if (status)
+		goto out;
+
+	status = decode_change_info(xdr, cinfo);
+out:
+	return status;
+}
+
+static void encode_listxattrs(struct xdr_stream *xdr,
+			     const struct nfs42_listxattrsargs *arg,
+			     struct compound_hdr *hdr)
+{
+	__be32 *p;
+
+	encode_op_hdr(xdr, OP_LISTXATTRS, decode_listxattrs_maxsz + 1, hdr);
+
+	p = reserve_space(xdr, 12);
+	if (unlikely(!p))
+		return;
+
+	p = xdr_encode_hyper(p, arg->cookie);
+	/*
+	 * RFC 8276 says to specify the full max length of the LISTXATTRS
+	 * XDR reply. Count is set to the XDR length of the names array
+	 * plus the EOF marker. So, add the cookie and the names count.
+	 */
+	*p = cpu_to_be32(arg->count + 8 + 4);
+}
+
+static int decode_listxattrs(struct xdr_stream *xdr,
+			    struct nfs42_listxattrsres *res)
+{
+	int status;
+	__be32 *p;
+	u32 count, len, ulen;
+	size_t left, copied;
+	char *buf;
+
+	status = decode_op_hdr(xdr, OP_LISTXATTRS);
+	if (status) {
+		/*
+		 * Special case: for LISTXATTRS, NFS4ERR_TOOSMALL
+		 * should be translated to ERANGE.
+		 */
+		if (status == -ETOOSMALL)
+			status = -ERANGE;
+		goto out;
+	}
+
+	p = xdr_inline_decode(xdr, 8);
+	if (unlikely(!p))
+		return -EIO;
+
+	xdr_decode_hyper(p, &res->cookie);
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	left = res->xattr_len;
+	buf = res->xattr_buf;
+
+	count = be32_to_cpup(p);
+	copied = 0;
+
+	/*
+	 * We have asked for enough room to encode the maximum number
+	 * of possible attribute names, so everything should fit.
+	 *
+	 * But, don't rely on that assumption. Just decode entries
+	 * until they don't fit anymore, just in case the server did
+	 * something odd.
+	 */
+	while (count--) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+
+		len = be32_to_cpup(p);
+		if (len > (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN)) {
+			status = -ERANGE;
+			goto out;
+		}
+
+		p = xdr_inline_decode(xdr, len);
+		if (unlikely(!p))
+			return -EIO;
+
+		ulen = len + XATTR_USER_PREFIX_LEN + 1;
+		if (buf) {
+			if (ulen > left) {
+				status = -ERANGE;
+				goto out;
+			}
+
+			memcpy(buf, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
+			memcpy(buf + XATTR_USER_PREFIX_LEN, p, len);
+
+			buf[ulen - 1] = 0;
+			buf += ulen;
+			left -= ulen;
+		}
+		copied += ulen;
+	}
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	res->eof = be32_to_cpup(p);
+	res->copied = copied;
+
+out:
+	if (status == -ERANGE && res->xattr_len == XATTR_LIST_MAX)
+		status = -E2BIG;
+
+	return status;
+}
+
 /*
  * Encode ALLOCATE request
  */
@@ -1062,4 +1264,166 @@ static int nfs4_xdr_dec_layouterror(struct rpc_rqst *rqstp,
 	return status;
 }
 
+#ifdef CONFIG_NFS_V4_2
+static void nfs4_xdr_enc_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
+				  const void *data)
+{
+	const struct nfs42_setxattrargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_setxattr(xdr, args, &hdr);
+	encode_nops(&hdr);
+}
+
+static int nfs4_xdr_dec_setxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
+				 void *data)
+{
+	struct nfs42_setxattrres *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, req);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+
+	status = decode_setxattr(xdr, &res->cinfo);
+out:
+	return status;
+}
+
+static void nfs4_xdr_enc_getxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
+				  const void *data)
+{
+	const struct nfs42_getxattrargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+	size_t plen;
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_getxattr(xdr, args->xattr_name, &hdr);
+
+	plen = args->xattr_len ? args->xattr_len : XATTR_SIZE_MAX;
+
+	rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
+	    hdr.replen);
+	req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
+
+	encode_nops(&hdr);
+}
+
+static int nfs4_xdr_dec_getxattr(struct rpc_rqst *rqstp,
+				 struct xdr_stream *xdr, void *data)
+{
+	struct nfs42_getxattrres *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, rqstp);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_getxattr(xdr, res, rqstp);
+out:
+	return status;
+}
+
+static void nfs4_xdr_enc_listxattrs(struct rpc_rqst *req,
+				    struct xdr_stream *xdr, const void *data)
+{
+	const struct nfs42_listxattrsargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_listxattrs(xdr, args, &hdr);
+
+	rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
+	    hdr.replen);
+	req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
+
+	encode_nops(&hdr);
+}
+
+static int nfs4_xdr_dec_listxattrs(struct rpc_rqst *rqstp,
+				   struct xdr_stream *xdr, void *data)
+{
+	struct nfs42_listxattrsres *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	xdr_set_scratch_buffer(xdr, page_address(res->scratch), PAGE_SIZE);
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, rqstp);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+	status = decode_listxattrs(xdr, res);
+out:
+	return status;
+}
+
+static void nfs4_xdr_enc_removexattr(struct rpc_rqst *req,
+				     struct xdr_stream *xdr, const void *data)
+{
+	const struct nfs42_removexattrargs *args = data;
+	struct compound_hdr hdr = {
+		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
+	};
+
+	encode_compound_hdr(xdr, req, &hdr);
+	encode_sequence(xdr, &args->seq_args, &hdr);
+	encode_putfh(xdr, args->fh, &hdr);
+	encode_removexattr(xdr, args->xattr_name, &hdr);
+	encode_nops(&hdr);
+}
+
+static int nfs4_xdr_dec_removexattr(struct rpc_rqst *req,
+				    struct xdr_stream *xdr, void *data)
+{
+	struct nfs42_removexattrres *res = data;
+	struct compound_hdr hdr;
+	int status;
+
+	status = decode_compound_hdr(xdr, &hdr);
+	if (status)
+		goto out;
+	status = decode_sequence(xdr, &res->seq_res, req);
+	if (status)
+		goto out;
+	status = decode_putfh(xdr);
+	if (status)
+		goto out;
+
+	status = decode_removexattr(xdr, &res->cinfo);
+out:
+	return status;
+}
+#endif
 #endif /* __LINUX_FS_NFS_NFS4_2XDR_H */
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 9e1b07640e9a..388ac520b104 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7481,6 +7481,8 @@ static struct {
 	{ NFS4ERR_SYMLINK,	-ELOOP		},
 	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
 	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
+	{ NFS4ERR_NOXATTR,	-ENODATA	},
+	{ NFS4ERR_XATTR2BIG,	-E2BIG		},
 	{ -1,			-EIO		}
 };
 
@@ -7609,6 +7611,10 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC42(COPY_NOTIFY,	enc_copy_notify,	dec_copy_notify),
 	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp),
 	PROC42(LAYOUTERROR,	enc_layouterror,	dec_layouterror),
+	PROC42(GETXATTR,	enc_getxattr,		dec_getxattr),
+	PROC42(SETXATTR,	enc_setxattr,		dec_setxattr),
+	PROC42(LISTXATTRS,	enc_listxattrs,		dec_listxattrs),
+	PROC42(REMOVEXATTR,	enc_removexattr,	dec_removexattr),
 };
 
 static unsigned int nfs_version4_counts[ARRAY_SIZE(nfs4_procedures)];
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index dee9b1cfa972..9408f3252c8e 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1498,7 +1498,64 @@ struct nfs42_seek_res {
 	u32	sr_eof;
 	u64	sr_offset;
 };
-#endif
+
+struct nfs42_setxattrargs {
+	struct nfs4_sequence_args	seq_args;
+	struct nfs_fh			*fh;
+	const char			*xattr_name;
+	u32				xattr_flags;
+	size_t				xattr_len;
+	struct page			**xattr_pages;
+};
+
+struct nfs42_setxattrres {
+	struct nfs4_sequence_res	seq_res;
+	struct nfs4_change_info		cinfo;
+};
+
+struct nfs42_getxattrargs {
+	struct nfs4_sequence_args	seq_args;
+	struct nfs_fh			*fh;
+	const char			*xattr_name;
+	size_t				xattr_len;
+	struct page			**xattr_pages;
+};
+
+struct nfs42_getxattrres {
+	struct nfs4_sequence_res	seq_res;
+	size_t				xattr_len;
+};
+
+struct nfs42_listxattrsargs {
+	struct nfs4_sequence_args	seq_args;
+	struct nfs_fh			*fh;
+	u32				count;
+	u64				cookie;
+	struct page			**xattr_pages;
+};
+
+struct nfs42_listxattrsres {
+	struct nfs4_sequence_res	seq_res;
+	struct page			*scratch;
+	void				*xattr_buf;
+	size_t				xattr_len;
+	u64				cookie;
+	bool				eof;
+	size_t				copied;
+};
+
+struct nfs42_removexattrargs {
+	struct nfs4_sequence_args	seq_args;
+	struct nfs_fh			*fh;
+	const char			*xattr_name;
+};
+
+struct nfs42_removexattrres {
+	struct nfs4_sequence_res	seq_res;
+	struct nfs4_change_info		cinfo;
+};
+
+#endif /* CONFIG_NFS_V4_2 */
 
 struct nfs_page;
 
-- 
2.17.2

