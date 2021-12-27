Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9722480457
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 20:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhL0TLh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 14:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhL0TLf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Dec 2021 14:11:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A39FC06173E
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 11:11:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A7FAB80D8E
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 19:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628E0C36AEE;
        Mon, 27 Dec 2021 19:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640632292;
        bh=mBY94kq1kn6ti5GvmuAWBYXtg2MZhtDx/DpPCKTfwSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgdFByFe277TifQttNwPQzp/djSAdaw8IM8brGzXupzQzY6IooKnptoIVppfjMGfi
         lHocREticArrUIrHSqh1GAxM43J4LG7LzAOkU+IljvXIVWSgWIkEtdGrBFKkReXwnt
         RusGJrJtQKFY/uEyDB65r6CuGZIMqqlwZGdKJNdAc2RxEQiuLBLqQJo0MqGYy21YVB
         yItukppbdZTnXQgkkVtmSRRDNK87ZCv35BL+idu14ZB/O0wcPEctAFlnhvfeK9lmVa
         ucPSyEPnhzXLgeQX6wJluGuzZaEGb/H7THGLSxQ4B/0Q6tnrb1aVCQeynE2ocAOZ9h
         HB1/5vmXPlolg==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/8] nfs: Add 'archive', 'hidden' and 'system' fields to nfs inode
Date:   Mon, 27 Dec 2021 14:05:00 -0500
Message-Id: <20211227190504.309612-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211227190504.309612-4-trondmy@kernel.org>
References: <20211227190504.309612-1-trondmy@kernel.org>
 <20211227190504.309612-2-trondmy@kernel.org>
 <20211227190504.309612-3-trondmy@kernel.org>
 <20211227190504.309612-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anne Marie Merritt <annemarie.merritt@primarydata.com>

Add tracking of the Windows 'archive', 'hidden' and 'system' attributes,
along with corresponding bitfields, request, and decode xdr routines.

Signed-off-by: Anne Marie Merritt <annemarie.merritt@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c          |  42 +++++++++++++++--
 fs/nfs/nfs4proc.c       |  26 ++++++++++-
 fs/nfs/nfs4trace.h      |   5 +-
 fs/nfs/nfs4xdr.c        | 100 +++++++++++++++++++++++++++++++++++++---
 fs/nfs/nfstrace.h       |   3 +-
 include/linux/nfs_fs.h  |   5 ++
 include/linux/nfs_xdr.h |  12 +++++
 7 files changed, 179 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 94268cab7613..9f138dc1880d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -202,6 +202,7 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 			flags &= ~(NFS_INO_INVALID_MODE |
 				   NFS_INO_INVALID_OTHER |
 				   NFS_INO_INVALID_BTIME |
+				   NFS_INO_INVALID_WINATTR |
 				   NFS_INO_INVALID_XATTR);
 		flags &= ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
 	} else if (flags & NFS_INO_REVAL_PAGECACHE)
@@ -523,6 +524,9 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		memset(&inode->i_mtime, 0, sizeof(inode->i_mtime));
 		memset(&inode->i_ctime, 0, sizeof(inode->i_ctime));
 		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
+		nfsi->archive = 0;
+		nfsi->hidden = 0;
+		nfsi->system = 0;
 		inode_set_iversion_raw(inode, 0);
 		inode->i_size = 0;
 		clear_nlink(inode);
@@ -550,6 +554,18 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			nfsi->btime = fattr->btime;
 		else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BTIME);
+		if (fattr->valid & NFS_ATTR_FATTR_ARCHIVE)
+			nfsi->archive = (fattr->hsa_flags & NFS_HSA_ARCHIVE) ? 1 : 0;
+		else if (fattr_supported & NFS_ATTR_FATTR_ARCHIVE)
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_WINATTR);
+		if (fattr->valid & NFS_ATTR_FATTR_HIDDEN)
+			nfsi->hidden = (fattr->hsa_flags & NFS_HSA_HIDDEN) ? 1 : 0;
+		else if (fattr_supported & NFS_ATTR_FATTR_HIDDEN)
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_WINATTR);
+		if (fattr->valid & NFS_ATTR_FATTR_SYSTEM)
+			nfsi->system = (fattr->hsa_flags & NFS_HSA_SYSTEM) ? 1 : 0;
+		else if (fattr_supported & NFS_ATTR_FATTR_SYSTEM)
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_WINATTR);
 		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
 			inode_set_iversion_raw(inode, fattr->change_attr);
 		else
@@ -1818,7 +1834,8 @@ static int nfs_inode_finish_partial_attr_update(const struct nfs_fattr *fattr,
 		NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
 		NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
 		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
-		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
+		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME |
+		NFS_INO_INVALID_WINATTR;
 	unsigned long cache_validity = NFS_I(inode)->cache_validity;
 	enum nfs4_change_attr_type ctype = NFS_SERVER(inode)->change_attr_type;
 
@@ -2075,7 +2092,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		  NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
 		  NFS_INO_INVALID_OTHER | NFS_INO_INVALID_BLOCKS |
 		  NFS_INO_INVALID_NLINK | NFS_INO_INVALID_MODE |
-		  NFS_INO_INVALID_BTIME);
+		  NFS_INO_INVALID_BTIME | NFS_INO_INVALID_WINATTR);
 
 	/* Do atomic weak cache consistency updates */
 	nfs_wcc_update_inode(inode, fattr);
@@ -2106,7 +2123,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 					| NFS_INO_INVALID_NLINK
 					| NFS_INO_INVALID_MODE
 					| NFS_INO_INVALID_OTHER
-					| NFS_INO_INVALID_BTIME;
+					| NFS_INO_INVALID_BTIME
+					| NFS_INO_INVALID_WINATTR;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
 				attr_changed = true;
@@ -2143,6 +2161,24 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_BTIME;
 
+	if (fattr->valid & NFS_ATTR_FATTR_ARCHIVE)
+		nfsi->archive = (fattr->hsa_flags & NFS_HSA_ARCHIVE) ? 1 : 0;
+	else if (fattr_supported & NFS_ATTR_FATTR_ARCHIVE)
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_WINATTR;
+
+	if (fattr->valid & NFS_ATTR_FATTR_HIDDEN)
+		nfsi->hidden = (fattr->hsa_flags & NFS_HSA_HIDDEN) ? 1 : 0;
+	else if (fattr_supported & NFS_ATTR_FATTR_HIDDEN)
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_WINATTR;
+
+	if (fattr->valid & NFS_ATTR_FATTR_SYSTEM)
+		nfsi->system = (fattr->hsa_flags & NFS_HSA_SYSTEM) ? 1 : 0;
+	else if (fattr_supported & NFS_ATTR_FATTR_SYSTEM)
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_WINATTR;
+
 	/* Check if our cached file size is stale */
 	if (fattr->valid & NFS_ATTR_FATTR_SIZE) {
 		new_isize = nfs_size_to_loff_t(fattr->size);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index be8eeb22b35f..99c7cf5944f8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -200,13 +200,16 @@ const u32 nfs4_fattr_bitmap[3] = {
 	| FATTR4_WORD0_CHANGE
 	| FATTR4_WORD0_SIZE
 	| FATTR4_WORD0_FSID
-	| FATTR4_WORD0_FILEID,
+	| FATTR4_WORD0_ARCHIVE
+	| FATTR4_WORD0_FILEID
+	| FATTR4_WORD0_HIDDEN,
 	FATTR4_WORD1_MODE
 	| FATTR4_WORD1_NUMLINKS
 	| FATTR4_WORD1_OWNER
 	| FATTR4_WORD1_OWNER_GROUP
 	| FATTR4_WORD1_RAWDEV
 	| FATTR4_WORD1_SPACE_USED
+	| FATTR4_WORD1_SYSTEM
 	| FATTR4_WORD1_TIME_ACCESS
 	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_TIME_METADATA
@@ -222,13 +225,16 @@ static const u32 nfs4_pnfs_open_bitmap[3] = {
 	| FATTR4_WORD0_CHANGE
 	| FATTR4_WORD0_SIZE
 	| FATTR4_WORD0_FSID
-	| FATTR4_WORD0_FILEID,
+	| FATTR4_WORD0_ARCHIVE
+	| FATTR4_WORD0_FILEID
+	| FATTR4_WORD0_HIDDEN,
 	FATTR4_WORD1_MODE
 	| FATTR4_WORD1_NUMLINKS
 	| FATTR4_WORD1_OWNER
 	| FATTR4_WORD1_OWNER_GROUP
 	| FATTR4_WORD1_RAWDEV
 	| FATTR4_WORD1_SPACE_USED
+	| FATTR4_WORD1_SYSTEM
 	| FATTR4_WORD1_TIME_ACCESS
 	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_TIME_METADATA
@@ -313,6 +319,11 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 
 	if (!(cache_validity & NFS_INO_INVALID_BTIME))
 		dst[1] &= ~FATTR4_WORD1_TIME_CREATE;
+
+	if (!(cache_validity & NFS_INO_INVALID_WINATTR)) {
+		dst[0] &= ~(FATTR4_WORD0_ARCHIVE | FATTR4_WORD0_HIDDEN);
+		dst[1] &= ~FATTR4_WORD1_SYSTEM;
+	}
 }
 
 static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dentry,
@@ -1239,6 +1250,7 @@ nfs4_update_changeattr_locked(struct inode *inode,
 				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
 				NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_NLINK |
 				NFS_INO_INVALID_MODE | NFS_INO_INVALID_BTIME |
+				NFS_INO_INVALID_WINATTR |
 				NFS_INO_INVALID_XATTR | NFS_INO_REVAL_PAGECACHE;
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 	}
@@ -3878,8 +3890,12 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		if (res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL)
 			server->caps |= NFS_CAP_SECURITY_LABEL;
 #endif
+		if (!(res.attr_bitmask[0] & FATTR4_WORD0_ARCHIVE))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_ARCHIVE;
 		if (!(res.attr_bitmask[0] & FATTR4_WORD0_FILEID))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_FILEID;
+		if (!(res.attr_bitmask[0] & FATTR4_WORD0_HIDDEN))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_HIDDEN;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_MODE))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_MODE;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_NUMLINKS))
@@ -3902,6 +3918,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			server->fattr_valid &= ~NFS_ATTR_FATTR_MTIME;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_CREATE))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_BTIME;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_SYSTEM))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_SYSTEM;
 		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
 				sizeof(server->attr_bitmask));
 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
@@ -5461,6 +5479,10 @@ static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
 		bitmask[1] |= FATTR4_WORD1_SPACE_USED;
 	if (cache_validity & NFS_INO_INVALID_BTIME)
 		bitmask[1] |= FATTR4_WORD1_TIME_CREATE;
+	if (cache_validity & NFS_INO_INVALID_WINATTR) {
+		bitmask[0] |= FATTR4_WORD0_ARCHIVE | FATTR4_WORD0_HIDDEN;
+		bitmask[1] |= FATTR4_WORD1_SYSTEM;
+	}
 
 	if (cache_validity & NFS_INO_INVALID_SIZE)
 		bitmask[0] |= FATTR4_WORD0_SIZE;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 186b851be5ba..babcd3207e8f 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -31,7 +31,10 @@
 		{ NFS_ATTR_FATTR_CHANGE, "CHANGE" }, \
 		{ NFS_ATTR_FATTR_OWNER_NAME, "OWNER_NAME" }, \
 		{ NFS_ATTR_FATTR_GROUP_NAME, "GROUP_NAME" }, \
-		{ NFS_ATTR_FATTR_BTIME, "BTIME" })
+		{ NFS_ATTR_FATTR_BTIME, "BTIME" }, \
+		{ NFS_ATTR_FATTR_HIDDEN, "HIDDEN" }, \
+		{ NFS_ATTR_FATTR_SYSTEM, "SYSTEM" }, \
+		{ NFS_ATTR_FATTR_ARCHIVE, "ARCHIVE" })
 
 DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		TP_PROTO(
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 33ab1377f443..2131754e64f0 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1611,13 +1611,17 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 	unsigned int i;
 
 	if (readdir->plus) {
-		attrs[0] |= FATTR4_WORD0_TYPE|FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE|
-			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
-		attrs[1] |= FATTR4_WORD1_MODE|FATTR4_WORD1_NUMLINKS|FATTR4_WORD1_OWNER|
-			FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|
-			FATTR4_WORD1_SPACE_USED|FATTR4_WORD1_TIME_ACCESS|
-			FATTR4_WORD1_TIME_CREATE |
-			FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
+		attrs[0] |= FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
+			    FATTR4_WORD0_SIZE| FATTR4_WORD0_FSID |
+			    FATTR4_WORD0_ARCHIVE | FATTR4_WORD0_FILEHANDLE |
+			    FATTR4_WORD0_FILEID | FATTR4_WORD0_HIDDEN;
+		attrs[1] |= FATTR4_WORD1_MODE | FATTR4_WORD1_NUMLINKS |
+			    FATTR4_WORD1_OWNER| FATTR4_WORD1_OWNER_GROUP |
+			    FATTR4_WORD1_RAWDEV | FATTR4_WORD1_SPACE_USED |
+			    FATTR4_WORD1_SYSTEM | FATTR4_WORD1_TIME_ACCESS |
+			    FATTR4_WORD1_TIME_CREATE |
+			    FATTR4_WORD1_TIME_METADATA |
+			    FATTR4_WORD1_TIME_MODIFY;
 		attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
 		dircount >>= 1;
 	}
@@ -3534,6 +3538,28 @@ static int decode_attr_aclsupport(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	return 0;
 }
 
+static int decode_attr_archive(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
+{
+	int status = 0;
+	__be32 *p;
+
+	if (unlikely(bitmap[0] & (FATTR4_WORD0_ARCHIVE - 1U)))
+		return -EIO;
+	if (likely(bitmap[0] & FATTR4_WORD0_ARCHIVE)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		if (be32_to_cpup(p))
+			*res |= NFS_HSA_ARCHIVE;
+		else
+			*res &= ~NFS_HSA_ARCHIVE;
+		bitmap[0] &= ~FATTR4_WORD0_ARCHIVE;
+		status = NFS_ATTR_FATTR_ARCHIVE;
+	}
+	dprintk("%s: archive file: =%s\n", __func__, (*res & NFS_HSA_ARCHIVE) == 0 ? "false" : "true");
+	return status;
+}
+
 static int decode_attr_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *fileid)
 {
 	__be32 *p;
@@ -3751,6 +3777,28 @@ static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, st
 	goto out;
 }
 
+static int decode_attr_hidden(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
+{
+	int status = 0;
+	__be32 *p;
+
+	if (unlikely(bitmap[0] & (FATTR4_WORD0_HIDDEN - 1U)))
+		return -EIO;
+	if (likely(bitmap[0] & FATTR4_WORD0_HIDDEN)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		if (be32_to_cpup(p))
+			*res |= NFS_HSA_HIDDEN;
+		else
+			*res &= ~NFS_HSA_HIDDEN;
+		bitmap[0] &= ~FATTR4_WORD0_HIDDEN;
+		status = NFS_ATTR_FATTR_HIDDEN;
+	}
+	dprintk("%s: hidden file: =%s\n", __func__, (*res & NFS_HSA_HIDDEN) == 0 ? "false" : "true");
+	return status;
+}
+
 static int decode_attr_maxfilesize(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *res)
 {
 	__be32 *p;
@@ -4082,6 +4130,28 @@ static int decode_attr_space_used(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	return ret;
 }
 
+static int decode_attr_system(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
+{
+	int status = 0;
+	__be32 *p;
+
+	if (unlikely(bitmap[1] & (FATTR4_WORD1_SYSTEM - 1U)))
+		return -EIO;
+	if (likely(bitmap[1] & FATTR4_WORD1_SYSTEM)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		if (be32_to_cpup(p))
+			*res |= NFS_HSA_SYSTEM;
+		else
+			*res &= ~NFS_HSA_SYSTEM;
+		bitmap[1] &= ~FATTR4_WORD1_SYSTEM;
+		status = NFS_ATTR_FATTR_SYSTEM;
+	}
+	dprintk("%s: system file: =%s\n", __func__, (*res & NFS_HSA_HIDDEN) == 0 ? "false" : "true");
+	return status;
+}
+
 static __be32 *
 xdr_decode_nfstime4(__be32 *p, struct timespec64 *t)
 {
@@ -4641,6 +4711,12 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 	if (status < 0)
 		goto xdr_error;
 
+	fattr->hsa_flags = 0;
+	status = decode_attr_archive(xdr, bitmap, &fattr->hsa_flags);
+	if (status < 0)
+		goto xdr_error;
+	fattr->valid |= status;
+
 	status = decode_attr_filehandle(xdr, bitmap, fh);
 	if (status < 0)
 		goto xdr_error;
@@ -4655,6 +4731,11 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 		goto xdr_error;
 	fattr->valid |= status;
 
+	status = decode_attr_hidden(xdr, bitmap, &fattr->hsa_flags);
+	if (status < 0)
+		goto xdr_error;
+	fattr->valid |= status;
+
 	status = -EIO;
 	if (unlikely(bitmap[0]))
 		goto xdr_error;
@@ -4692,6 +4773,11 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 		goto xdr_error;
 	fattr->valid |= status;
 
+	status = decode_attr_system(xdr, bitmap, &fattr->hsa_flags);
+	if (status < 0)
+		goto xdr_error;
+	fattr->valid |= status;
+
 	status = decode_attr_time_access(xdr, bitmap, &fattr->atime);
 	if (status < 0)
 		goto xdr_error;
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index cba86d167c38..2ef7cff8a4ba 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -34,7 +34,8 @@
 			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" }, \
 			{ NFS_INO_INVALID_NLINK, "INVALID_NLINK" }, \
 			{ NFS_INO_INVALID_MODE, "INVALID_MODE" }, \
-			{ NFS_INO_INVALID_BTIME, "INVALID_BTIME" })
+			{ NFS_INO_INVALID_BTIME, "INVALID_BTIME" }, \
+			{ NFS_INO_INVALID_WINATTR, "INVALID_WINATTR" })
 
 #define nfs_show_nfsi_flags(v) \
 	__print_flags(v, "|", \
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 8d944d399b17..34288dcf8547 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -144,6 +144,10 @@ struct nfs_inode {
 
 	struct timespec64	btime;
 
+	unsigned char		archive : 1;
+	unsigned char		hidden : 1;
+	unsigned char		system : 1;
+
 	/*
 	 * read_cache_jiffies is when we started read-caching this inode.
 	 * attrtimeo is for how long the cached information is assumed
@@ -267,6 +271,7 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALID_NLINK	BIT(16)		/* cached nlinks is invalid */
 #define NFS_INO_INVALID_MODE	BIT(17)		/* cached mode is invalid */
 #define NFS_INO_INVALID_BTIME	BIT(18)		/* cached btime is invalid */
+#define NFS_INO_INVALID_WINATTR	BIT(19)		/* cached windows attr is invalid */
 
 #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
 		| NFS_INO_INVALID_CTIME \
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 8e8ff5def523..308324d197f4 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -17,6 +17,11 @@
 
 #define NFS_BITMASK_SZ		3
 
+/* HIDDEN, SYSTEM bitfields in hsa_flags in nfs_fattr */
+#define NFS_HSA_HIDDEN		BIT(0)
+#define NFS_HSA_SYSTEM		BIT(1)
+#define NFS_HSA_ARCHIVE		BIT(2)
+
 struct nfs4_string {
 	unsigned int len;
 	char *data;
@@ -68,6 +73,7 @@ struct nfs_fattr {
 	struct timespec64	mtime;
 	struct timespec64	ctime;
 	struct timespec64	btime;
+	__u32			hsa_flags;	/* hidden, system, archive flags bitfield */
 	__u64			change_attr;	/* NFSv4 change attribute */
 	__u64			pre_change_attr;/* pre-op NFSv4 change attribute */
 	__u64			pre_size;	/* pre_op_attr.size	  */
@@ -108,6 +114,9 @@ struct nfs_fattr {
 #define NFS_ATTR_FATTR_GROUP_NAME	BIT_ULL(24)
 #define NFS_ATTR_FATTR_V4_SECURITY_LABEL BIT_ULL(25)
 #define NFS_ATTR_FATTR_BTIME		BIT_ULL(26)
+#define NFS_ATTR_FATTR_HIDDEN           BIT_ULL(27)
+#define NFS_ATTR_FATTR_SYSTEM           BIT_ULL(28)
+#define NFS_ATTR_FATTR_ARCHIVE          BIT_ULL(29)
 
 #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
 		| NFS_ATTR_FATTR_MODE \
@@ -129,6 +138,9 @@ struct nfs_fattr {
 #define NFS_ATTR_FATTR_V4 (NFS_ATTR_FATTR \
 		| NFS_ATTR_FATTR_SPACE_USED \
 		| NFS_ATTR_FATTR_BTIME \
+		| NFS_ATTR_FATTR_HIDDEN \
+		| NFS_ATTR_FATTR_SYSTEM \
+		| NFS_ATTR_FATTR_ARCHIVE \
 		| NFS_ATTR_FATTR_V4_SECURITY_LABEL)
 
 /*
-- 
2.33.1

