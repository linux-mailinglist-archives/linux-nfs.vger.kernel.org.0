Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2892C48045B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 20:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhL0TLj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 14:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhL0TLi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Dec 2021 14:11:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED893C061401
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 11:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6846BCE1087
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 19:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A35C36AEB;
        Mon, 27 Dec 2021 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640632294;
        bh=riGLkxdzmqOCC7x/23VqVAqyxw2YxqSLpFjUliqJAW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONjnvkqZIvLOb8cINTwztG+lcxeXyHtxjTf7Qdn/lEjUJ55PmbvYMxUR6xL+Q0tXn
         ls1Q6QyG6iy1zKXRErPMjUvmXoRz7t346EQWooNtC09gmwJBSHcv5iFF38V9J6Ybpd
         loz2rXQfBsZmw3OoQievamSpyJlhsxfjikeBdWs9rWb5h6882cMAeevYbma2n2lBuZ
         A7+K4LqJLx9K6Y+EK7yKjrXl1N3aPSPtD/rnjrK2X9bSzxaaadhluOQ3kVYiHxdOF6
         1GdIPCFhuZxGvxwRg6BwVsfrZ/FN07eMb7DuZSB2t8CuI4kdWHPp7vanyKc2+ZV6+F
         3lsdimFgbqQ1A==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 8/8] NFSv4: Add an ioctl to allow retrieval of the NFS raw ACCESS mask
Date:   Mon, 27 Dec 2021 14:05:04 -0500
Message-Id: <20211227190504.309612-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211227190504.309612-8-trondmy@kernel.org>
References: <20211227190504.309612-1-trondmy@kernel.org>
 <20211227190504.309612-2-trondmy@kernel.org>
 <20211227190504.309612-3-trondmy@kernel.org>
 <20211227190504.309612-4-trondmy@kernel.org>
 <20211227190504.309612-5-trondmy@kernel.org>
 <20211227190504.309612-6-trondmy@kernel.org>
 <20211227190504.309612-7-trondmy@kernel.org>
 <20211227190504.309612-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c             | 47 ++++++++++++++++++++++++----------------
 fs/nfs/internal.h        |  2 ++
 fs/nfs/nfs4file.c        | 39 +++++++++++++++++++++++++++++++++
 include/uapi/linux/nfs.h | 11 ++++++++++
 4 files changed, 80 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 10a6484c59d3..e8e6a2f7de1f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2907,36 +2907,30 @@ void nfs_access_set_mask(struct nfs_access_entry *entry, u32 access_result)
 }
 EXPORT_SYMBOL_GPL(nfs_access_set_mask);
 
-static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
+int nfs_get_access(struct inode *inode, const struct cred *cred,
+		   struct nfs_access_entry *cache, bool may_block)
 {
-	struct nfs_access_entry cache;
-	bool may_block = (mask & MAY_NOT_BLOCK) == 0;
-	int cache_mask = -1;
 	int status;
 
-	trace_nfs_access_enter(inode);
-
-	status = nfs_access_get_cached(inode, cred, &cache.mask, may_block);
+	status = nfs_access_get_cached(inode, cred, &cache->mask, may_block);
 	if (status == 0)
-		goto out_cached;
+		return 0;
 
-	status = -ECHILD;
 	if (!may_block)
-		goto out;
-
+		return -ECHILD;
 	/*
 	 * Determine which access bits we want to ask for...
 	 */
-	cache.mask = NFS_ACCESS_READ | NFS_ACCESS_MODIFY | NFS_ACCESS_EXTEND;
+	cache->mask = NFS_ACCESS_READ | NFS_ACCESS_MODIFY | NFS_ACCESS_EXTEND;
 	if (nfs_server_capable(inode, NFS_CAP_XATTR)) {
-		cache.mask |= NFS_ACCESS_XAREAD | NFS_ACCESS_XAWRITE |
+		cache->mask |= NFS_ACCESS_XAREAD | NFS_ACCESS_XAWRITE |
 		    NFS_ACCESS_XALIST;
 	}
 	if (S_ISDIR(inode->i_mode))
-		cache.mask |= NFS_ACCESS_DELETE | NFS_ACCESS_LOOKUP;
+		cache->mask |= NFS_ACCESS_DELETE | NFS_ACCESS_LOOKUP;
 	else
-		cache.mask |= NFS_ACCESS_EXECUTE;
-	status = NFS_PROTO(inode)->access(inode, &cache, cred);
+		cache->mask |= NFS_ACCESS_EXECUTE;
+	status = NFS_PROTO(inode)->access(inode, cache, cred);
 	if (status != 0) {
 		if (status == -ESTALE) {
 			if (!S_ISDIR(inode->i_mode))
@@ -2944,10 +2938,25 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 			else
 				nfs_zap_caches(inode);
 		}
-		goto out;
+		return status;
 	}
-	nfs_access_add_cache(inode, &cache, cred);
-out_cached:
+	nfs_access_add_cache(inode, cache, cred);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nfs_get_access);
+
+static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
+{
+	struct nfs_access_entry cache;
+	bool may_block = (mask & MAY_NOT_BLOCK) == 0;
+	int cache_mask = -1;
+	int status;
+
+	trace_nfs_access_enter(inode);
+
+	status = nfs_get_access(inode, cred, &cache, may_block);
+	if (status < 0)
+		goto out;
 	cache_mask = nfs_access_calc_mask(cache.mask, inode->i_mode);
 	if ((mask & ~cache_mask & (MAY_READ | MAY_WRITE | MAY_EXEC)) != 0)
 		status = -EACCES;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9602a886f0f0..9b8fd2247533 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -392,6 +392,8 @@ int nfs_mknod(struct user_namespace *, struct inode *, struct dentry *, umode_t,
 	      dev_t);
 int nfs_rename(struct user_namespace *, struct inode *, struct dentry *,
 	       struct inode *, struct dentry *, unsigned int);
+int nfs_get_access(struct inode *inode, const struct cred *cred,
+		   struct nfs_access_entry *cache, bool may_block);
 
 /* file.c */
 int nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 494ebc7cd1c0..ccf70d26c5c4 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -611,6 +611,42 @@ static long nfs4_ioctl_file_statx_set(struct file *dst_file,
 	return ret;
 }
 
+static long
+nfs4_ioctl_file_access_get(struct file *file,
+			   struct nfs_ioctl_nfs4_access __user *uarg)
+{
+	struct inode *inode = file_inode(file);
+	struct nfs_access_entry cache;
+	__u64 ac_flags;
+	const struct cred *old_cred;
+	struct cred *override_cred;
+	long ret;
+
+	if (!NFS_PROTO(inode)->access)
+		return -ENOTSUPP;
+
+	if (get_user(ac_flags, &uarg->ac_flags))
+		return -EFAULT;
+
+	override_cred = prepare_creds();
+	if (!override_cred)
+		return -ENOMEM;
+
+	if (!(ac_flags & NFS_AC_FLAG_EACCESS)) {
+		override_cred->fsuid = override_cred->uid;
+		override_cred->fsgid = override_cred->gid;
+	}
+	old_cred = override_creds(override_cred);
+
+	ret = nfs_get_access(inode, override_cred, &cache, true);
+	if (!ret && unlikely(put_user(cache.mask, &uarg->ac_mask) != 0))
+		ret = -EFAULT;
+
+	revert_creds(old_cred);
+	put_cred(override_cred);
+	return ret;
+}
+
 static long nfs4_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -623,6 +659,9 @@ static long nfs4_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case NFS_IOC_FILE_STATX_SET:
 		ret = nfs4_ioctl_file_statx_set(file, argp);
 		break;
+	case NFS_IOC_FILE_ACCESS_GET:
+		ret = nfs4_ioctl_file_access_get(file, argp);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
index df87da39bc43..b1e50f14db18 100644
--- a/include/uapi/linux/nfs.h
+++ b/include/uapi/linux/nfs.h
@@ -41,6 +41,8 @@
 #define NFS_IOC_FILE_STATX_GET	_IOR('N', 2, struct nfs_ioctl_nfs4_statx)
 #define NFS_IOC_FILE_STATX_SET	_IOW('N', 3, struct nfs_ioctl_nfs4_statx)
 
+#define NFS_IOC_FILE_ACCESS_GET	_IOR('N', 4, struct nfs_ioctl_nfs4_access)
+
 /* Options for struct nfs_ioctl_nfs4_statx */
 #define NFS_FA_OPTIONS_SYNC_AS_STAT			0x0000
 #define NFS_FA_OPTIONS_FORCE_SYNC			0x2000 /* See statx */
@@ -125,6 +127,15 @@ struct nfs_ioctl_nfs4_statx {
 	__u64 		fa_padding[4];
 };
 
+struct nfs_ioctl_nfs4_access {
+	/* input */
+	__u64		ac_flags;		/* operation flags */
+	/* output */
+	__u64		ac_mask;		/* NFS raw ACCESS reply mask */
+};
+
+#define NFS_AC_FLAG_EACCESS (1UL << 0)
+
 /*
  * NFS stats. The good thing with these values is that NFSv3 errors are
  * a superset of NFSv2 errors (with the exception of NFSERR_WFLUSH which
-- 
2.33.1

