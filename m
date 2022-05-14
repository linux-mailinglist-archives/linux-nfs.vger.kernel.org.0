Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8552721F
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiENOnw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiENOnu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B31BB87E
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 263A360F5D
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4442AC34116;
        Sat, 14 May 2022 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652539427;
        bh=+d/EH0WhnfByJ17IuOzDDsu1SYCO3+xPy3Ja28ri/JU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOZt7hYd1+QT3ba7RDDTe+LC7JyAvVjsPrEeQ23VmJywQFQqVR0pi4XJir/X3kUcd
         exgaKPp9YMSSWj8X2uUDdT4lV07W1lngnibkM2vPTzLU01CsatVClJn39gE1n59+wI
         hm0m7TE0Mc8E48ZJINTghE6WpH0ltakchEQ/8ITWkJJheInF+XYKmWrFxMwtejbr+Y
         H31nYsG4Qj348Gbe+ERub1V8YIpdT7wFJToH1xyugeWUfwklRZAC7yaw/1NtmsUuYs
         Yfcfm141g7Vkg6Li7D+8DM/urOmtCBItDKlgtQKK7CLP5GxWAvY5P2UNsr903Sde5N
         1Ydqw/D9lZ9qg==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSv4: Specify the type of ACL to cache
Date:   Sat, 14 May 2022 10:36:58 -0400
Message-Id: <20220514143700.4263-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514143700.4263-1-trondmy@kernel.org>
References: <20220514143700.4263-1-trondmy@kernel.org>
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

When caching a NFSv4 ACL, we want to specify whether we are caching an
NFSv4.0 type acl, the NFSv4.1 dacl or the NFSv4.1 sacl.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c       | 59 ++++++++++++++++++++++++++++-------------
 include/linux/nfs4.h    |  2 ++
 include/linux/nfs_xdr.h |  7 +++++
 3 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bf3ba541b9fb..e6c830d4db0b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5772,9 +5772,17 @@ static int nfs4_proc_renew(struct nfs_client *clp, const struct cred *cred)
 	return 0;
 }
 
-static inline int nfs4_server_supports_acls(struct nfs_server *server)
+static bool nfs4_server_supports_acls(const struct nfs_server *server,
+				      enum nfs4_acl_type type)
 {
-	return server->caps & NFS_CAP_ACLS;
+	switch (type) {
+	default:
+		return server->attr_bitmask[0] & FATTR4_WORD0_ACL;
+	case NFS4ACL_DACL:
+		return server->attr_bitmask[1] & FATTR4_WORD1_DACL;
+	case NFS4ACL_SACL:
+		return server->attr_bitmask[1] & FATTR4_WORD1_SACL;
+	}
 }
 
 /* Assuming that XATTR_SIZE_MAX is a multiple of PAGE_SIZE, and that
@@ -5813,6 +5821,7 @@ int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
 }
 
 struct nfs4_cached_acl {
+	enum nfs4_acl_type type;
 	int cached;
 	size_t len;
 	char data[];
@@ -5833,7 +5842,8 @@ static void nfs4_zap_acl_attr(struct inode *inode)
 	nfs4_set_cached_acl(inode, NULL);
 }
 
-static inline ssize_t nfs4_read_cached_acl(struct inode *inode, char *buf, size_t buflen)
+static ssize_t nfs4_read_cached_acl(struct inode *inode, char *buf,
+				    size_t buflen, enum nfs4_acl_type type)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs4_cached_acl *acl;
@@ -5843,6 +5853,8 @@ static inline ssize_t nfs4_read_cached_acl(struct inode *inode, char *buf, size_
 	acl = nfsi->nfs4_acl;
 	if (acl == NULL)
 		goto out;
+	if (acl->type != type)
+		goto out;
 	if (buf == NULL) /* user is just asking for length */
 		goto out_len;
 	if (acl->cached == 0)
@@ -5858,7 +5870,9 @@ static inline ssize_t nfs4_read_cached_acl(struct inode *inode, char *buf, size_
 	return ret;
 }
 
-static void nfs4_write_cached_acl(struct inode *inode, struct page **pages, size_t pgbase, size_t acl_len)
+static void nfs4_write_cached_acl(struct inode *inode, struct page **pages,
+				  size_t pgbase, size_t acl_len,
+				  enum nfs4_acl_type type)
 {
 	struct nfs4_cached_acl *acl;
 	size_t buflen = sizeof(*acl) + acl_len;
@@ -5875,6 +5889,7 @@ static void nfs4_write_cached_acl(struct inode *inode, struct page **pages, size
 			goto out;
 		acl->cached = 0;
 	}
+	acl->type = type;
 	acl->len = acl_len;
 out:
 	nfs4_set_cached_acl(inode, acl);
@@ -5890,7 +5905,8 @@ static void nfs4_write_cached_acl(struct inode *inode, struct page **pages, size
  * length. The next getxattr call will then produce another round trip to
  * the server, this time with the input buf of the required size.
  */
-static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t buflen)
+static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf,
+				       size_t buflen, enum nfs4_acl_type type)
 {
 	struct page **pages;
 	struct nfs_getaclargs args = {
@@ -5947,7 +5963,8 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t bu
 		ret = -ERANGE;
 		goto out_free;
 	}
-	nfs4_write_cached_acl(inode, pages, res.acl_data_offset, res.acl_len);
+	nfs4_write_cached_acl(inode, pages, res.acl_data_offset, res.acl_len,
+			      type);
 	if (buf) {
 		if (res.acl_len > buflen) {
 			ret = -ERANGE;
@@ -5967,14 +5984,15 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t bu
 	return ret;
 }
 
-static ssize_t nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t buflen)
+static ssize_t nfs4_get_acl_uncached(struct inode *inode, void *buf,
+				     size_t buflen, enum nfs4_acl_type type)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
 	ssize_t ret;
 	do {
-		ret = __nfs4_get_acl_uncached(inode, buf, buflen);
+		ret = __nfs4_get_acl_uncached(inode, buf, buflen, type);
 		trace_nfs4_get_acl(inode, ret);
 		if (ret >= 0)
 			break;
@@ -5983,27 +6001,29 @@ static ssize_t nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t bufl
 	return ret;
 }
 
-static ssize_t nfs4_proc_get_acl(struct inode *inode, void *buf, size_t buflen)
+static ssize_t nfs4_proc_get_acl(struct inode *inode, void *buf, size_t buflen,
+				 enum nfs4_acl_type type)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	int ret;
 
-	if (!nfs4_server_supports_acls(server))
+	if (!nfs4_server_supports_acls(server, type))
 		return -EOPNOTSUPP;
 	ret = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
 	if (ret < 0)
 		return ret;
 	if (NFS_I(inode)->cache_validity & NFS_INO_INVALID_ACL)
 		nfs_zap_acl_cache(inode);
-	ret = nfs4_read_cached_acl(inode, buf, buflen);
+	ret = nfs4_read_cached_acl(inode, buf, buflen, type);
 	if (ret != -ENOENT)
 		/* -ENOENT is returned if there is no ACL or if there is an ACL
 		 * but no cached acl data, just the acl length */
 		return ret;
-	return nfs4_get_acl_uncached(inode, buf, buflen);
+	return nfs4_get_acl_uncached(inode, buf, buflen, type);
 }
 
-static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t buflen)
+static int __nfs4_proc_set_acl(struct inode *inode, const void *buf,
+			       size_t buflen, enum nfs4_acl_type type)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct page *pages[NFS4ACL_MAXPAGES];
@@ -6024,7 +6044,7 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
 	/* You can't remove system.nfs4_acl: */
 	if (buflen == 0)
 		return -EINVAL;
-	if (!nfs4_server_supports_acls(server))
+	if (!nfs4_server_supports_acls(server, type))
 		return -EOPNOTSUPP;
 	if (npages > ARRAY_SIZE(pages))
 		return -ERANGE;
@@ -6055,12 +6075,13 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
 	return ret;
 }
 
-static int nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t buflen)
+static int nfs4_proc_set_acl(struct inode *inode, const void *buf,
+			     size_t buflen, enum nfs4_acl_type type)
 {
 	struct nfs4_exception exception = { };
 	int err;
 	do {
-		err = __nfs4_proc_set_acl(inode, buf, buflen);
+		err = __nfs4_proc_set_acl(inode, buf, buflen, type);
 		trace_nfs4_set_acl(inode, err);
 		if (err == -NFS4ERR_BADOWNER || err == -NFS4ERR_BADNAME) {
 			/*
@@ -7659,19 +7680,19 @@ static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
 				   const char *key, const void *buf,
 				   size_t buflen, int flags)
 {
-	return nfs4_proc_set_acl(inode, buf, buflen);
+	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_ACL);
 }
 
 static int nfs4_xattr_get_nfs4_acl(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
 				   const char *key, void *buf, size_t buflen)
 {
-	return nfs4_proc_get_acl(inode, buf, buflen);
+	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_ACL);
 }
 
 static bool nfs4_xattr_list_nfs4_acl(struct dentry *dentry)
 {
-	return nfs4_server_supports_acls(NFS_SERVER(d_inode(dentry)));
+	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_ACL);
 }
 
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 5662d8be04eb..8d04b6a5964c 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -451,6 +451,8 @@ enum lock_type4 {
 #define FATTR4_WORD1_TIME_MODIFY        (1UL << 21)
 #define FATTR4_WORD1_TIME_MODIFY_SET    (1UL << 22)
 #define FATTR4_WORD1_MOUNTED_ON_FILEID  (1UL << 23)
+#define FATTR4_WORD1_DACL               (1UL << 26)
+#define FATTR4_WORD1_SACL               (1UL << 27)
 #define FATTR4_WORD1_FS_LAYOUT_TYPES    (1UL << 30)
 #define FATTR4_WORD2_LAYOUT_TYPES       (1UL << 0)
 #define FATTR4_WORD2_LAYOUT_BLKSIZE     (1UL << 1)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 2863e5a69c6a..13d068c57d8d 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -800,6 +800,13 @@ struct nfs_setattrargs {
 	const struct nfs4_label		*label;
 };
 
+enum nfs4_acl_type {
+	NFS4ACL_NONE = 0,
+	NFS4ACL_ACL,
+	NFS4ACL_DACL,
+	NFS4ACL_SACL,
+};
+
 struct nfs_setaclargs {
 	struct nfs4_sequence_args	seq_args;
 	struct nfs_fh *			fh;
-- 
2.36.1

