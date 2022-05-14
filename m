Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD2527220
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiENOnx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiENOnu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083E6EA7
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 982D260F68
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECCFC34115;
        Sat, 14 May 2022 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652539428;
        bh=YJyoSC7xWIgZJueVSpVWyZLGxWYXwF4WBsUXrnXBnEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAAqh7nLqfon7hLPChYXFmjgSkphYB6w3tWezz6bnGYW7Gn+mlIH/b8MSfrNrGTUu
         guM9Ggo0CVRBuyZdt4mSEgq8wGAqS731GYl8tJPag0j1owMOV/LyflEUfgs+XNfri2
         pcS4DP9B9U5lAFVeSFFJMBrLW8+VSf7DuYWNoTrxeqsDlyRpncLIlh/V3u/+FOMkms
         RIMZ6xKTjRpOKNDqAUNbQCki506AJejlx3GHQPYkEJMpZMOrMHgZ/WFf835UCTZxmL
         cm6D1F4WVnYuFjDvu6sU6ZyhXNX/scJzTJEW9tobjdCYu5hR82vlWKAXakSHrgHZiE
         LquXNvT4Irepw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSv4: Add encoders/decoders for the NFSv4.1 dacl and sacl attributes
Date:   Sat, 14 May 2022 10:36:59 -0400
Message-Id: <20220514143700.4263-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514143700.4263-2-trondmy@kernel.org>
References: <20220514143700.4263-1-trondmy@kernel.org>
 <20220514143700.4263-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add the ability to set or retrieve the acl using the NFSv4.1 'dacl' and
'sacl' attributes to the NFSv4 xdr encoders/decoders.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c       |  9 ++--
 fs/nfs/nfs4xdr.c        | 95 +++++++++++++++++++++++++++--------------
 include/linux/nfs_xdr.h |  3 ++
 3 files changed, 71 insertions(+), 36 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e6c830d4db0b..b2ddbaf32a95 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5911,9 +5911,11 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf,
 	struct page **pages;
 	struct nfs_getaclargs args = {
 		.fh = NFS_FH(inode),
+		.acl_type = type,
 		.acl_len = buflen,
 	};
 	struct nfs_getaclres res = {
+		.acl_type = type,
 		.acl_len = buflen,
 	};
 	struct rpc_message msg = {
@@ -6028,9 +6030,10 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf,
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct page *pages[NFS4ACL_MAXPAGES];
 	struct nfs_setaclargs arg = {
-		.fh		= NFS_FH(inode),
-		.acl_pages	= pages,
-		.acl_len	= buflen,
+		.fh = NFS_FH(inode),
+		.acl_type = type,
+		.acl_len = buflen,
+		.acl_pages = pages,
 	};
 	struct nfs_setaclres res;
 	struct rpc_message msg = {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 86a5f6516928..0b41e00e754f 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1680,19 +1680,35 @@ encode_restorefh(struct xdr_stream *xdr, struct compound_hdr *hdr)
 	encode_op_hdr(xdr, OP_RESTOREFH, decode_restorefh_maxsz, hdr);
 }
 
-static void
-encode_setacl(struct xdr_stream *xdr, const struct nfs_setaclargs *arg,
-		struct compound_hdr *hdr)
+static void nfs4_acltype_to_bitmap(enum nfs4_acl_type type, __u32 bitmap[2])
 {
-	__be32 *p;
+	switch (type) {
+	default:
+		bitmap[0] = FATTR4_WORD0_ACL;
+		bitmap[1] = 0;
+		break;
+	case NFS4ACL_DACL:
+		bitmap[0] = 0;
+		bitmap[1] = FATTR4_WORD1_DACL;
+		break;
+	case NFS4ACL_SACL:
+		bitmap[0] = 0;
+		bitmap[1] = FATTR4_WORD1_SACL;
+	}
+}
+
+static void encode_setacl(struct xdr_stream *xdr,
+			  const struct nfs_setaclargs *arg,
+			  struct compound_hdr *hdr)
+{
+	__u32 bitmap[2];
+
+	nfs4_acltype_to_bitmap(arg->acl_type, bitmap);
 
 	encode_op_hdr(xdr, OP_SETATTR, decode_setacl_maxsz, hdr);
 	encode_nfs4_stateid(xdr, &zero_stateid);
-	p = reserve_space(xdr, 2*4);
-	*p++ = cpu_to_be32(1);
-	*p = cpu_to_be32(FATTR4_WORD0_ACL);
-	p = reserve_space(xdr, 4);
-	*p = cpu_to_be32(arg->acl_len);
+	xdr_encode_bitmap4(xdr, bitmap, ARRAY_SIZE(bitmap));
+	encode_uint32(xdr, arg->acl_len);
 	xdr_write_pages(xdr, arg->acl_pages, 0, arg->acl_len);
 }
 
@@ -2587,11 +2603,11 @@ static void nfs4_xdr_enc_getacl(struct rpc_rqst *req, struct xdr_stream *xdr,
 	struct compound_hdr hdr = {
 		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
 	};
-	const __u32 nfs4_acl_bitmap[1] = {
-		[0] = FATTR4_WORD0_ACL,
-	};
+	__u32 nfs4_acl_bitmap[2];
 	uint32_t replen;
 
+	nfs4_acltype_to_bitmap(args->acl_type, nfs4_acl_bitmap);
+
 	encode_compound_hdr(xdr, req, &hdr);
 	encode_sequence(xdr, &args->seq_args, &hdr);
 	encode_putfh(xdr, args->fh, &hdr);
@@ -5386,7 +5402,7 @@ decode_restorefh(struct xdr_stream *xdr)
 }
 
 static int decode_getacl(struct xdr_stream *xdr, struct rpc_rqst *req,
-			 struct nfs_getaclres *res)
+			 struct nfs_getaclres *res, enum nfs4_acl_type type)
 {
 	unsigned int savep;
 	uint32_t attrlen,
@@ -5404,26 +5420,39 @@ static int decode_getacl(struct xdr_stream *xdr, struct rpc_rqst *req,
 	if ((status = decode_attr_length(xdr, &attrlen, &savep)) != 0)
 		goto out;
 
-	if (unlikely(bitmap[0] & (FATTR4_WORD0_ACL - 1U)))
-		return -EIO;
-	if (likely(bitmap[0] & FATTR4_WORD0_ACL)) {
-
-		/* The bitmap (xdr len + bitmaps) and the attr xdr len words
-		 * are stored with the acl data to handle the problem of
-		 * variable length bitmaps.*/
-		res->acl_data_offset = xdr_page_pos(xdr);
-		res->acl_len = attrlen;
-
-		/* Check for receive buffer overflow */
-		if (res->acl_len > xdr_stream_remaining(xdr) ||
-		    res->acl_len + res->acl_data_offset > xdr->buf->page_len) {
-			res->acl_flags |= NFS4_ACL_TRUNC;
-			dprintk("NFS: acl reply: attrlen %u > page_len %zu\n",
-				attrlen, xdr_stream_remaining(xdr));
-		}
-	} else
-		status = -EOPNOTSUPP;
+	switch (type) {
+	default:
+		if (unlikely(bitmap[0] & (FATTR4_WORD0_ACL - 1U)))
+			return -EIO;
+		if (!(bitmap[0] & FATTR4_WORD0_ACL))
+			return -EOPNOTSUPP;
+		break;
+	case NFS4ACL_DACL:
+		if (unlikely(bitmap[0] || bitmap[1] & (FATTR4_WORD1_DACL - 1U)))
+			return -EIO;
+		if (!(bitmap[1] & FATTR4_WORD1_DACL))
+			return -EOPNOTSUPP;
+		break;
+	case NFS4ACL_SACL:
+		if (unlikely(bitmap[0] || bitmap[1] & (FATTR4_WORD1_SACL - 1U)))
+			return -EIO;
+		if (!(bitmap[1] & FATTR4_WORD1_SACL))
+			return -EOPNOTSUPP;
+	}
 
+	/* The bitmap (xdr len + bitmaps) and the attr xdr len words
+	 * are stored with the acl data to handle the problem of
+	 * variable length bitmaps.*/
+	res->acl_data_offset = xdr_page_pos(xdr);
+	res->acl_len = attrlen;
+
+	/* Check for receive buffer overflow */
+	if (res->acl_len > xdr_stream_remaining(xdr) ||
+	    res->acl_len + res->acl_data_offset > xdr->buf->page_len) {
+		res->acl_flags |= NFS4_ACL_TRUNC;
+		dprintk("NFS: acl reply: attrlen %u > page_len %zu\n",
+			attrlen, xdr_stream_remaining(xdr));
+	}
 out:
 	return status;
 }
@@ -6486,7 +6515,7 @@ nfs4_xdr_dec_getacl(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	status = decode_putfh(xdr);
 	if (status)
 		goto out;
-	status = decode_getacl(xdr, rqstp, res);
+	status = decode_getacl(xdr, rqstp, res, res->acl_type);
 
 out:
 	return status;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 13d068c57d8d..4a8ba84f848e 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -810,6 +810,7 @@ enum nfs4_acl_type {
 struct nfs_setaclargs {
 	struct nfs4_sequence_args	seq_args;
 	struct nfs_fh *			fh;
+	enum nfs4_acl_type		acl_type;
 	size_t				acl_len;
 	struct page **			acl_pages;
 };
@@ -821,6 +822,7 @@ struct nfs_setaclres {
 struct nfs_getaclargs {
 	struct nfs4_sequence_args 	seq_args;
 	struct nfs_fh *			fh;
+	enum nfs4_acl_type		acl_type;
 	size_t				acl_len;
 	struct page **			acl_pages;
 };
@@ -829,6 +831,7 @@ struct nfs_getaclargs {
 #define NFS4_ACL_TRUNC		0x0001	/* ACL was truncated */
 struct nfs_getaclres {
 	struct nfs4_sequence_res	seq_res;
+	enum nfs4_acl_type		acl_type;
 	size_t				acl_len;
 	size_t				acl_data_offset;
 	int				acl_flags;
-- 
2.36.1

