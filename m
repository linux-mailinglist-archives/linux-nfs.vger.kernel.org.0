Return-Path: <linux-nfs+bounces-3715-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAC9906300
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637D91C2236A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1D84084E;
	Thu, 13 Jun 2024 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG8pXTRQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D76132811
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252268; cv=none; b=YIXofSIVE5upZ6xt/9YbnPcic/H7q9H9GQTN313y1c5vAQ6EZ8g8IR7EAGqollloSNJrFZOvaGzRazCwMbZTzQT5sw8Bc8tjDYfcnHIXFlUrmfeMHAZ0wGV5NPoC8t8yJGtIOKMpWm9/mVWAUB/1MCMpSk57SijBJuxvF9NJI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252268; c=relaxed/simple;
	bh=yhdNvFn9uVnhwgZy+rADuQU1YlBZItMBetAWtInX/H0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzAWby7/BZqOeQdXz+Ky6urMs1jmMryVgyVC6HGExDWyxpho+zzcX4vrkUSjW1/88UVNBsf67N2bpt9D/bzXMrzPHs1ZQvnWb5DhfrrNA4PsnGEJ7rtfrVg+msEN/QFGtfg7iRG1eQ6NbE2UOtiSeZ7rWf1PXO5GY2rb7nAgzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG8pXTRQ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6301aa3a89eso6600017b3.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252265; x=1718857065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=352dKP4GAqpQzxwich6A8f9MPwb5Kt/tjt5E2AhScgU=;
        b=kG8pXTRQAYds/ufitJ6flKPCesBpzZQbVWitu5o4O/Wt4GSlxPMoqyQfBEJx7z+orY
         hNE7eLmDe6w6HFBRONbNgQsIfSDRLagbmiuVpL4EgxtmKqnyv02Ah/q0zVrvb04y9zl6
         lRURCYCVYkuXojbSxOCte5UUp/Zl4r+4ZlD4BokrLb5BsTWPhywnSA+ujkCnMLCIv/d7
         BkYVZjpWoTKYLNgvCCfIYc2iih+w3sUQ0NP1ML4GAjohYH0iN5kJ9Bety+fHaWFkzK6Q
         jn8Sxib2ekzMzlg41wygLHrZvKSMLLFTMpnd/Bo0O8PZNSPZVyz2wlSCFSdROaSTbJaX
         bgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252265; x=1718857065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=352dKP4GAqpQzxwich6A8f9MPwb5Kt/tjt5E2AhScgU=;
        b=hPKIvPbaZHMxJejK0Yc82P9bYr60AZ9FTCjwjHbfYLN5CJo4FUtFusd4eseIR2BkeY
         +RuaXMewLmT30EzjMy0I3E72A2k+BkeZs+ytrsHAw4LJU7ehiLTwbxg81sw5aF95x7hv
         pPSk4Utxgn1H8qdohtz8iiXbzTMGywkma4X0wg2C+QHyMSYjEyy6jQ3IJ1c+Ney3u/aX
         kPNuOpsDWDh5XcxvobW9UnotYwMMao2Ngo4nzeVIxDOUYGPF6RXZYTyWSiBTiwVQxmo0
         AuJS4LQTScoJzGQEUcGLlhQckmvSYjZLH4Jj3UWLcQin9AkjnvAqWjmeUR4baPsnC34s
         zfHA==
X-Gm-Message-State: AOJu0YwgKlORPztK0oRV+oqqWUIK1GQ3IaotNzxUeD1C+5FLJF3STHg8
	tgJ6RgBCsdWAxmfk5od/nEn385PxneQMOX93lrIWp1GlFMYkxbLZmBzR
X-Google-Smtp-Source: AGHT+IH/LYkb46Dd/qjWcc2Asg0yycR86irGdmXCFRb6WNrYgDv16ssptfA20T0ZIR3L86kQPtEdFw==
X-Received: by 2002:a81:6908:0:b0:627:dfbd:89e with SMTP id 00721157ae682-62fbb7f5e56mr39431377b3.11.1718252264587;
        Wed, 12 Jun 2024 21:17:44 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:44 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 06/19] NFSv4: Add a flags argument to the 'have_delegation' callback
Date: Thu, 13 Jun 2024 00:11:23 -0400
Message-ID: <20240613041136.506908-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-6-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c     | 26 +++++++++++++-------------
 fs/nfs/delegation.h     | 16 +++++++++++++---
 fs/nfs/dir.c            |  2 +-
 fs/nfs/file.c           |  4 ++--
 fs/nfs/inode.c          |  7 +++----
 fs/nfs/nfs3proc.c       |  2 +-
 fs/nfs/nfs4proc.c       | 14 +++++++-------
 fs/nfs/proc.c           |  2 +-
 fs/nfs/write.c          |  2 +-
 include/linux/nfs_xdr.h |  2 +-
 10 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6bace5fece04..6fdffd25cb2b 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -82,11 +82,10 @@ static void nfs_mark_return_delegation(struct nfs_server *server,
 	set_bit(NFS4CLNT_DELEGRETURN, &server->nfs_client->cl_state);
 }
 
-static bool
-nfs4_is_valid_delegation(const struct nfs_delegation *delegation,
-		fmode_t flags)
+static bool nfs4_is_valid_delegation(const struct nfs_delegation *delegation,
+				     fmode_t type)
 {
-	if (delegation != NULL && (delegation->type & flags) == flags &&
+	if (delegation != NULL && (delegation->type & type) == type &&
 	    !test_bit(NFS_DELEGATION_REVOKED, &delegation->flags) &&
 	    !test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
 		return true;
@@ -103,16 +102,16 @@ struct nfs_delegation *nfs4_get_valid_delegation(const struct inode *inode)
 	return NULL;
 }
 
-static int
-nfs4_do_check_delegation(struct inode *inode, fmode_t flags, bool mark)
+static int nfs4_do_check_delegation(struct inode *inode, fmode_t type,
+				    int flags, bool mark)
 {
 	struct nfs_delegation *delegation;
 	int ret = 0;
 
-	flags &= FMODE_READ|FMODE_WRITE;
+	type &= FMODE_READ|FMODE_WRITE;
 	rcu_read_lock();
 	delegation = rcu_dereference(NFS_I(inode)->delegation);
-	if (nfs4_is_valid_delegation(delegation, flags)) {
+	if (nfs4_is_valid_delegation(delegation, type)) {
 		if (mark)
 			nfs_mark_delegation_referenced(delegation);
 		ret = 1;
@@ -124,22 +123,23 @@ nfs4_do_check_delegation(struct inode *inode, fmode_t flags, bool mark)
  * nfs4_have_delegation - check if inode has a delegation, mark it
  * NFS_DELEGATION_REFERENCED if there is one.
  * @inode: inode to check
- * @flags: delegation types to check for
+ * @type: delegation types to check for
+ * @flags: various modifiers
  *
  * Returns one if inode has the indicated delegation, otherwise zero.
  */
-int nfs4_have_delegation(struct inode *inode, fmode_t flags)
+int nfs4_have_delegation(struct inode *inode, fmode_t type, int flags)
 {
-	return nfs4_do_check_delegation(inode, flags, true);
+	return nfs4_do_check_delegation(inode, type, flags, true);
 }
 
 /*
  * nfs4_check_delegation - check if inode has a delegation, do not mark
  * NFS_DELEGATION_REFERENCED if it has one.
  */
-int nfs4_check_delegation(struct inode *inode, fmode_t flags)
+int nfs4_check_delegation(struct inode *inode, fmode_t type)
 {
-	return nfs4_do_check_delegation(inode, flags, false);
+	return nfs4_do_check_delegation(inode, type, 0, false);
 }
 
 static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_stateid *stateid)
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index a6f495d012cf..257b3d726043 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -75,8 +75,8 @@ bool nfs4_refresh_delegation_stateid(nfs4_stateid *dst, struct inode *inode);
 
 struct nfs_delegation *nfs4_get_valid_delegation(const struct inode *inode);
 void nfs_mark_delegation_referenced(struct nfs_delegation *delegation);
-int nfs4_have_delegation(struct inode *inode, fmode_t flags);
-int nfs4_check_delegation(struct inode *inode, fmode_t flags);
+int nfs4_have_delegation(struct inode *inode, fmode_t type, int flags);
+int nfs4_check_delegation(struct inode *inode, fmode_t type);
 bool nfs4_delegation_flush_on_close(const struct inode *inode);
 void nfs_inode_find_delegation_state_and_recover(struct inode *inode,
 		const nfs4_stateid *stateid);
@@ -84,9 +84,19 @@ int nfs4_inode_make_writeable(struct inode *inode);
 
 #endif
 
+static inline int nfs_have_read_or_write_delegation(struct inode *inode)
+{
+	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0);
+}
+
+static inline int nfs_have_write_delegation(struct inode *inode)
+{
+	return NFS_PROTO(inode)->have_delegation(inode, FMODE_WRITE, 0);
+}
+
 static inline int nfs_have_delegated_attributes(struct inode *inode)
 {
-	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ);
+	return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0);
 }
 
 #endif
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 788077a4feb9..6b63d1ecd2c2 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1437,7 +1437,7 @@ static void nfs_set_verifier_locked(struct dentry *dentry, unsigned long verf)
 
 	if (!dir || !nfs_verify_change_attribute(dir, verf))
 		return;
-	if (inode && NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+	if (inode && NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0))
 		nfs_set_verifier_delegated(&verf);
 	dentry->d_time = verf;
 }
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 407c6e15afe2..8c13b9a41aaa 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -730,7 +730,7 @@ do_getlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 	}
 	fl->c.flc_type = saved_type;
 
-	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+	if (nfs_have_read_or_write_delegation(inode))
 		goto out_noconflict;
 
 	if (is_local)
@@ -813,7 +813,7 @@ do_setlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 	 * This makes locking act as a cache coherency point.
 	 */
 	nfs_sync_mapping(filp->f_mapping);
-	if (!NFS_PROTO(inode)->have_delegation(inode, FMODE_READ)) {
+	if (!nfs_have_read_or_write_delegation(inode)) {
 		nfs_zap_caches(inode);
 		if (mapping_mapped(filp->f_mapping))
 			nfs_revalidate_mapping(inode, filp->f_mapping);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index acef52ecb1bb..89722919b463 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -190,9 +190,8 @@ static bool nfs_has_xattr_cache(const struct nfs_inode *nfsi)
 void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
-	bool have_delegation = NFS_PROTO(inode)->have_delegation(inode, FMODE_READ);
 
-	if (have_delegation) {
+	if (nfs_have_delegated_attributes(inode)) {
 		if (!(flags & NFS_INO_REVAL_FORCED))
 			flags &= ~(NFS_INO_INVALID_MODE |
 				   NFS_INO_INVALID_OTHER |
@@ -1012,7 +1011,7 @@ void nfs_close_context(struct nfs_open_context *ctx, int is_sync)
 	if (!is_sync)
 		return;
 	inode = d_inode(ctx->dentry);
-	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+	if (nfs_have_read_or_write_delegation(inode))
 		return;
 	nfsi = NFS_I(inode);
 	if (inode->i_mapping->nrpages == 0)
@@ -1482,7 +1481,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	unsigned long invalid = 0;
 	struct timespec64 ts;
 
-	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+	if (nfs_have_delegated_attributes(inode))
 		return 0;
 
 	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 74bda639a7cf..cab6c73d25d6 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -979,7 +979,7 @@ nfs3_proc_lock(struct file *filp, int cmd, struct file_lock *fl)
 	return status;
 }
 
-static int nfs3_have_delegation(struct inode *inode, fmode_t flags)
+static int nfs3_have_delegation(struct inode *inode, fmode_t type, int flags)
 {
 	return 0;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 0ed734ab448e..27fb40653f1d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -293,7 +293,7 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	unsigned long cache_validity;
 
 	memcpy(dst, src, NFS4_BITMASK_SZ*sizeof(*dst));
-	if (!inode || !nfs4_have_delegation(inode, FMODE_READ))
+	if (!inode || !nfs_have_read_or_write_delegation(inode))
 		return;
 
 	cache_validity = READ_ONCE(NFS_I(inode)->cache_validity) | flags;
@@ -1264,7 +1264,7 @@ nfs4_update_changeattr_locked(struct inode *inode,
 		if (S_ISDIR(inode->i_mode))
 			nfs_force_lookup_revalidate(inode);
 
-		if (!NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
+		if (!nfs_have_delegated_attributes(inode))
 			cache_validity |=
 				NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
 				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
@@ -3700,7 +3700,7 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
 
 	if (calldata->arg.fmode == 0 || calldata->arg.fmode == FMODE_READ) {
 		/* Close-to-open cache consistency revalidation */
-		if (!nfs4_have_delegation(inode, FMODE_READ)) {
+		if (!nfs4_have_delegation(inode, FMODE_READ, 0)) {
 			nfs4_bitmask_set(calldata->arg.bitmask_store,
 					 server->cache_consistency_bitmask,
 					 inode, 0);
@@ -4617,7 +4617,7 @@ static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry
 	};
 	int status = 0;
 
-	if (!nfs4_have_delegation(inode, FMODE_READ)) {
+	if (!nfs4_have_delegation(inode, FMODE_READ, 0)) {
 		res.fattr = nfs_alloc_fattr();
 		if (res.fattr == NULL)
 			return -ENOMEM;
@@ -5586,7 +5586,7 @@ bool nfs4_write_need_cache_consistency_data(struct nfs_pgio_header *hdr)
 	/* Otherwise, request attributes if and only if we don't hold
 	 * a delegation
 	 */
-	return nfs4_have_delegation(hdr->inode, FMODE_READ) == 0;
+	return nfs4_have_delegation(hdr->inode, FMODE_READ, 0) == 0;
 }
 
 void nfs4_bitmask_set(__u32 bitmask[], const __u32 src[],
@@ -7633,10 +7633,10 @@ static int nfs4_add_lease(struct file *file, int arg, struct file_lease **lease,
 	int ret;
 
 	/* No delegation, no lease */
-	if (!nfs4_have_delegation(inode, type))
+	if (!nfs4_have_delegation(inode, type, 0))
 		return -EAGAIN;
 	ret = generic_setlease(file, arg, lease, priv);
-	if (ret || nfs4_have_delegation(inode, type))
+	if (ret || nfs4_have_delegation(inode, type, 0))
 		return ret;
 	/* We raced with a delegation return */
 	nfs4_delete_lease(file, priv);
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index d105e5b2659d..995cc42b0fa0 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -687,7 +687,7 @@ static int nfs_lock_check_bounds(const struct file_lock *fl)
 	return -EINVAL;
 }
 
-static int nfs_have_delegation(struct inode *inode, fmode_t flags)
+static int nfs_have_delegation(struct inode *inode, fmode_t type, int flags)
 {
 	return 0;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 5de85d725fb9..a9186b113fe7 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1320,7 +1320,7 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
 		return 0;
 	if (!nfs_folio_write_uptodate(folio, pagelen))
 		return 0;
-	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_WRITE))
+	if (nfs_have_write_delegation(inode))
 		return 1;
 	if (!flctx || (list_empty_careful(&flctx->flc_flock) &&
 		       list_empty_careful(&flctx->flc_posix)))
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index f40be64ce942..51611583af51 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1830,7 +1830,7 @@ struct nfs_rpc_ops {
 				int open_flags,
 				struct iattr *iattr,
 				int *);
-	int (*have_delegation)(struct inode *, fmode_t);
+	int (*have_delegation)(struct inode *, fmode_t, int);
 	struct nfs_client *(*alloc_client) (const struct nfs_client_initdata *);
 	struct nfs_client *(*init_client) (struct nfs_client *,
 				const struct nfs_client_initdata *);
-- 
2.45.2


