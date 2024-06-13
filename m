Return-Path: <linux-nfs+bounces-3716-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA3906302
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 048ABB22BF7
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDD2132811;
	Thu, 13 Jun 2024 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llnf1qWy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE24132114
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252268; cv=none; b=H3+yIXtlHMygbwfX++eLwoYR2h/fzg/FOXHRt3e6cWRmvb/0RCX8onvASn5x+eTMXm1oLSAtQFT5oq5z3jlWxzD4aeGcEJtJzKJeptmMT4cYNW0R8hVF+Ex4hkefBPn342pqg3sx3Q7Z8cAnFg3nEr+MMU4SaTC5ZWa3xgzV80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252268; c=relaxed/simple;
	bh=MyXJxOFduuOO7vIKV0xhXCDCHNuAU7aiT3TY9cIZI4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7OMw8TjKMQIFTHHk6PXY1dmiNgFHdKhCphaTISCpGUgv8NHlocWwA1jxfmcATvisxtFXeGt0y6mCNTi1xFKAqym2V3VGURCI4pxReUaZmB6z41ujtpR+U8D5CBj9qkGhI9bVI+jgYDj5msvxzneE+4JlhxX3glhG87vQERC9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llnf1qWy; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7955f3d4516so155065285a.1
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252265; x=1718857065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byFZqyYW/bRGDY2x6J39wtPoZv35HJsyt7GNtw2tAYk=;
        b=llnf1qWy5D3rImlqhTGgr0uz5lbG0H55S797tqfkxJ7t7PbsUVRJt7QZvYla0qbKxY
         i8z7vNxfddZsLD7xacYSduPCKKt8eiI3AW0rUn6fg7SxiA7XBlHlsqJBTqmjJWKEqBQ/
         uDaVNlehQ6T4jLwZBgMlBCE9lQKE+K/XB9FI5yogcbNllPHAslXz1ejfy+X6s9UE0HUJ
         aF1vu12vFKExv8eUin9nIJvCOJXVyc7VCIFtc5a7aSAGYj4kUGpxGe92eP2lJ+mmTXiZ
         ACwJgZYgtiC4gKDrW1KbEZL8T0B2+d28ajFZHVIO5KFaKoKKXwbsRW+RTGrpnlnAEbfR
         FUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252265; x=1718857065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byFZqyYW/bRGDY2x6J39wtPoZv35HJsyt7GNtw2tAYk=;
        b=ZjRD61W6ec7aD4rSQqjnI98XBrUtU4bb3mTKG7kST0UkfhSDe07fFp8SIv2dERxi26
         LbT7vd7CKNrm0lIqwnOAKXEXZiSv71mGSB378jNKL9zxbngM4UIb3uzDWYZtwrneWC8k
         Y5isJ+ro/wHeAmOAMbKeE1lET3Q3XQH5aNXStFADSm7iSs9xA1L5WM5tkDBMkt/iouHq
         kxv231BVg+evEX/ExVfX/n407y8UwseJu9QXMa/DLdZHJk6SBpfgugJ/nhcIyt/LUAnR
         5j9x4AfepalyZT6LWNX1aZTA6RJ84PFG7BCZ3uyectObwRmkpX78ZUttUnde72Zzslkt
         HMaA==
X-Gm-Message-State: AOJu0YxPsVafaqusZnYJ9KEMlui9fgg9BdDpe6el0U+wektFuLMt9y5n
	/j5Tp6APoQnKTMXW/ZCqA98+Zml2kSjDPJfdxiLsC012h1TkXXZAWA9C
X-Google-Smtp-Source: AGHT+IFdpctwMr7K0SXsKYL5Y+QpBkIXB55yGN4lb8XwmtTRKjnhVQ/CrW9kbcEgbY4ADQSOT6QgTA==
X-Received: by 2002:a05:6214:f6a:b0:6ab:9214:ffd3 with SMTP id 6a1803df08f44-6b2a343ccf8mr29238406d6.25.1718252265248;
        Wed, 12 Jun 2024 21:17:45 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:44 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 07/19] NFSv4: Add support for delegated atime and mtime attributes
Date: Thu, 13 Jun 2024 00:11:24 -0400
Message-ID: <20240613041136.506908-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-7-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Ensure that we update the mtime and atime correctly when we read
or write data to the file and when we truncate. Let the server manage
ctime on other attribute updates.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 24 +++++++++++++++-----
 fs/nfs/delegation.h | 25 +++++++++++++++++++--
 fs/nfs/inode.c      | 54 +++++++++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs4proc.c   | 21 ++++++++++--------
 fs/nfs/read.c       |  3 +++
 fs/nfs/write.c      |  9 ++++++++
 6 files changed, 116 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6fdffd25cb2b..e72eead06c08 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -115,6 +115,9 @@ static int nfs4_do_check_delegation(struct inode *inode, fmode_t type,
 		if (mark)
 			nfs_mark_delegation_referenced(delegation);
 		ret = 1;
+		if ((flags & NFS_DELEGATION_FLAG_TIME) &&
+		    !test_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags))
+			ret = 0;
 	}
 	rcu_read_unlock();
 	return ret;
@@ -221,11 +224,12 @@ static int nfs_delegation_claim_opens(struct inode *inode,
  * @type: delegation type
  * @stateid: delegation stateid
  * @pagemod_limit: write delegation "space_limit"
+ * @deleg_type: raw delegation type
  *
  */
 void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 				  fmode_t type, const nfs4_stateid *stateid,
-				  unsigned long pagemod_limit)
+				  unsigned long pagemod_limit, u32 deleg_type)
 {
 	struct nfs_delegation *delegation;
 	const struct cred *oldcred = NULL;
@@ -250,7 +254,7 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 	} else {
 		rcu_read_unlock();
 		nfs_inode_set_delegation(inode, cred, type, stateid,
-					 pagemod_limit);
+					 pagemod_limit, deleg_type);
 	}
 }
 
@@ -418,13 +422,13 @@ nfs_update_inplace_delegation(struct nfs_delegation *delegation,
  * @type: delegation type
  * @stateid: delegation stateid
  * @pagemod_limit: write delegation "space_limit"
+ * @deleg_type: raw delegation type
  *
  * Returns zero on success, or a negative errno value.
  */
 int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
-				  fmode_t type,
-				  const nfs4_stateid *stateid,
-				  unsigned long pagemod_limit)
+			     fmode_t type, const nfs4_stateid *stateid,
+			     unsigned long pagemod_limit, u32 deleg_type)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs_client *clp = server->nfs_client;
@@ -444,6 +448,11 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	delegation->cred = get_cred(cred);
 	delegation->inode = inode;
 	delegation->flags = 1<<NFS_DELEGATION_REFERENCED;
+	switch (deleg_type) {
+	case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
+	case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
+		delegation->flags |= BIT(NFS_DELEGATION_DELEGTIME);
+	}
 	delegation->test_gen = 0;
 	spin_lock_init(&delegation->lock);
 
@@ -508,6 +517,11 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 	atomic_long_inc(&nfs_active_delegations);
 
 	trace_nfs4_set_delegation(inode, type);
+
+	/* If we hold writebacks and have delegated mtime then update */
+	if (deleg_type == NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG &&
+	    nfs_have_writebacks(inode))
+		nfs_update_delegated_mtime(inode);
 out:
 	spin_unlock(&clp->cl_lock);
 	if (delegation != NULL)
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 257b3d726043..2e9ad83acf2c 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -38,12 +38,17 @@ enum {
 	NFS_DELEGATION_TEST_EXPIRED,
 	NFS_DELEGATION_INODE_FREEING,
 	NFS_DELEGATION_RETURN_DELAYED,
+	NFS_DELEGATION_DELEGTIME,
 };
 
+#define NFS_DELEGATION_FLAG_TIME	BIT(1)
+
 int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
-		fmode_t type, const nfs4_stateid *stateid, unsigned long pagemod_limit);
+			     fmode_t type, const nfs4_stateid *stateid,
+			     unsigned long pagemod_limit, u32 deleg_type);
 void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
-		fmode_t type, const nfs4_stateid *stateid, unsigned long pagemod_limit);
+				  fmode_t type, const nfs4_stateid *stateid,
+				  unsigned long pagemod_limit, u32 deleg_type);
 int nfs4_inode_return_delegation(struct inode *inode);
 void nfs4_inode_return_delegation_on_close(struct inode *inode);
 int nfs_async_inode_return_delegation(struct inode *inode, const nfs4_stateid *stateid);
@@ -84,6 +89,10 @@ int nfs4_inode_make_writeable(struct inode *inode);
 
 #endif
 
+void nfs_update_delegated_atime(struct inode *inode);
+void nfs_update_delegated_mtime(struct inode *inode);
+void nfs_update_delegated_mtime_locked(struct inode *inode);
+
 static inline int nfs_have_read_or_write_delegation(struct inode *inode)
 {
 	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0);
@@ -99,4 +108,16 @@ static inline int nfs_have_delegated_attributes(struct inode *inode)
 	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0);
 }
 
+static inline int nfs_have_delegated_atime(struct inode *inode)
+{
+	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ,
+						 NFS_DELEGATION_FLAG_TIME);
+}
+
+static inline int nfs_have_delegated_mtime(struct inode *inode)
+{
+	return NFS_PROTO(inode)->have_delegation(inode, FMODE_WRITE,
+						 NFS_DELEGATION_FLAG_TIME);
+}
+
 #endif
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 89722919b463..91c0aeaf6c1e 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -275,6 +275,8 @@ EXPORT_SYMBOL_GPL(nfs_zap_acl_cache);
 
 void nfs_invalidate_atime(struct inode *inode)
 {
+	if (nfs_have_delegated_atime(inode))
+		return;
 	spin_lock(&inode->i_lock);
 	nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATIME);
 	spin_unlock(&inode->i_lock);
@@ -603,6 +605,33 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 }
 EXPORT_SYMBOL_GPL(nfs_fhget);
 
+void nfs_update_delegated_atime(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	if (nfs_have_delegated_atime(inode)) {
+		inode_update_timestamps(inode, S_ATIME);
+		NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_ATIME;
+	}
+	spin_unlock(&inode->i_lock);
+}
+
+void nfs_update_delegated_mtime_locked(struct inode *inode)
+{
+	if (nfs_have_delegated_mtime(inode)) {
+		inode_update_timestamps(inode, S_CTIME | S_MTIME);
+		NFS_I(inode)->cache_validity &= ~(NFS_INO_INVALID_CTIME |
+						  NFS_INO_INVALID_MTIME);
+	}
+}
+
+void nfs_update_delegated_mtime(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	nfs_update_delegated_mtime_locked(inode);
+	spin_unlock(&inode->i_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_update_delegated_mtime);
+
 #define NFS_VALID_ATTRS (ATTR_MODE|ATTR_UID|ATTR_GID|ATTR_SIZE|ATTR_ATIME|ATTR_ATIME_SET|ATTR_MTIME|ATTR_MTIME_SET|ATTR_FILE|ATTR_OPEN)
 
 int
@@ -630,6 +659,17 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			attr->ia_valid &= ~ATTR_SIZE;
 	}
 
+	if (nfs_have_delegated_mtime(inode)) {
+		if (attr->ia_valid & ATTR_MTIME) {
+			nfs_update_delegated_mtime(inode);
+			attr->ia_valid &= ~ATTR_MTIME;
+		}
+		if (attr->ia_valid & ATTR_ATIME) {
+			nfs_update_delegated_atime(inode);
+			attr->ia_valid &= ~ATTR_ATIME;
+		}
+	}
+
 	/* Optimization: if the end result is no change, don't RPC */
 	if (((attr->ia_valid & NFS_VALID_ATTRS) & ~(ATTR_FILE|ATTR_OPEN)) == 0)
 		return 0;
@@ -685,6 +725,7 @@ static int nfs_vmtruncate(struct inode * inode, loff_t offset)
 
 	spin_unlock(&inode->i_lock);
 	truncate_pagecache(inode, offset);
+	nfs_update_delegated_mtime_locked(inode);
 	spin_lock(&inode->i_lock);
 out:
 	return err;
@@ -708,8 +749,9 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 	spin_lock(&inode->i_lock);
 	NFS_I(inode)->attr_gencount = fattr->gencount;
 	if ((attr->ia_valid & ATTR_SIZE) != 0) {
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME |
-						     NFS_INO_INVALID_BLOCKS);
+		if (!nfs_have_delegated_mtime(inode))
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
 		nfs_inc_stats(inode, NFSIOS_SETATTRTRUNC);
 		nfs_vmtruncate(inode, attr->ia_size);
 	}
@@ -855,8 +897,12 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	/* Flush out writes to the server in order to update c/mtime/version.  */
 	if ((request_mask & (STATX_CTIME | STATX_MTIME | STATX_CHANGE_COOKIE)) &&
-	    S_ISREG(inode->i_mode))
-		filemap_write_and_wait(inode->i_mapping);
+	    S_ISREG(inode->i_mode)) {
+		if (nfs_have_delegated_mtime(inode))
+			filemap_fdatawrite(inode->i_mapping);
+		else
+			filemap_write_and_wait(inode->i_mapping);
+	}
 
 	/*
 	 * We may force a getattr if the user cares about atime.
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 27fb40653f1d..83edbc7a3bcc 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1245,7 +1245,8 @@ nfs4_update_changeattr_locked(struct inode *inode,
 	struct nfs_inode *nfsi = NFS_I(inode);
 	u64 change_attr = inode_peek_iversion_raw(inode);
 
-	cache_validity |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
+	if (!nfs_have_delegated_mtime(inode))
+		cache_validity |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
 	if (S_ISDIR(inode->i_mode))
 		cache_validity |= NFS_INO_INVALID_DATA;
 
@@ -1961,6 +1962,8 @@ nfs4_process_delegation(struct inode *inode, const struct cred *cred,
 	switch (delegation->open_delegation_type) {
 	case NFS4_OPEN_DELEGATE_READ:
 	case NFS4_OPEN_DELEGATE_WRITE:
+	case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
+	case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
 		break;
 	default:
 		return;
@@ -1974,16 +1977,16 @@ nfs4_process_delegation(struct inode *inode, const struct cred *cred,
 				   NFS_SERVER(inode)->nfs_client->cl_hostname);
 		break;
 	case NFS4_OPEN_CLAIM_PREVIOUS:
-		nfs_inode_reclaim_delegation(inode, cred,
-				delegation->type,
-				&delegation->stateid,
-				delegation->pagemod_limit);
+		nfs_inode_reclaim_delegation(inode, cred, delegation->type,
+					     &delegation->stateid,
+					     delegation->pagemod_limit,
+					     delegation->open_delegation_type);
 		break;
 	default:
-		nfs_inode_set_delegation(inode, cred,
-				delegation->type,
-				&delegation->stateid,
-				delegation->pagemod_limit);
+		nfs_inode_set_delegation(inode, cred, delegation->type,
+					 &delegation->stateid,
+					 delegation->pagemod_limit,
+					 delegation->open_delegation_type);
 	}
 	if (delegation->do_recall)
 		nfs_async_inode_return_delegation(inode, &delegation->stateid);
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index a142287d86f6..1b0e06c11983 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -28,6 +28,7 @@
 #include "fscache.h"
 #include "pnfs.h"
 #include "nfstrace.h"
+#include "delegation.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
@@ -372,6 +373,7 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 		goto out_put;
 
 	nfs_pageio_complete_read(&pgio);
+	nfs_update_delegated_atime(inode);
 	ret = pgio.pg_error < 0 ? pgio.pg_error : 0;
 	if (!ret) {
 		ret = folio_wait_locked_killable(folio);
@@ -428,6 +430,7 @@ void nfs_readahead(struct readahead_control *ractl)
 	}
 
 	nfs_pageio_complete_read(&pgio);
+	nfs_update_delegated_atime(inode);
 
 	put_nfs_open_context(ctx);
 out:
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index a9186b113fe7..c0cd644b97ff 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -289,6 +289,8 @@ static void nfs_grow_file(struct folio *folio, unsigned int offset,
 	NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_SIZE;
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
 out:
+	/* Atomically update timestamps if they are delegated to us. */
+	nfs_update_delegated_mtime_locked(inode);
 	spin_unlock(&inode->i_lock);
 	nfs_fscache_invalidate(inode, 0);
 }
@@ -1514,6 +1516,13 @@ void nfs_writeback_update_inode(struct nfs_pgio_header *hdr)
 	struct nfs_fattr *fattr = &hdr->fattr;
 	struct inode *inode = hdr->inode;
 
+	if (nfs_have_delegated_mtime(inode)) {
+		spin_lock(&inode->i_lock);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
+		spin_unlock(&inode->i_lock);
+		return;
+	}
+
 	spin_lock(&inode->i_lock);
 	nfs_writeback_check_extend(hdr, fattr);
 	nfs_post_op_update_inode_force_wcc_locked(inode, fattr);
-- 
2.45.2


