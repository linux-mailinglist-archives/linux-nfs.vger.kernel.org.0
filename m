Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5044795D4
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 21:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhLQUzG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 15:55:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40092 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbhLQUzF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 15:55:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A208623C1
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 20:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BC1C36AE2;
        Fri, 17 Dec 2021 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639774504;
        bh=QXcmJ6avdu7VQ4fQjHidyKHbQGwREnHDiKYaQSDj74k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXpG0gLEdI0IfyZB3HypP0319sVdjCb99GeP/GozF2CHhsfnFdjGI1zz7WRsqrEoF
         ngSvTltXo3DnoOWOfbcXwEzOZL7F4qkt/TFhFoWR2PGJK1eKrzRIIXjzMAaRO9hAPZ
         vf6/M2pIQ6qLHSv9uZfH2i+U5enQnKM/zNdGCav6oqTtSIailqxgNULPg2i6L3w0IN
         iR8ZBL9tgbWBlK+n2WiqJ9F4pIunyJzXe9RFahIiFs9bulK0QebSzaXNshqf2NFpTu
         FHV7+Cawbdfvg4WnDp6Ze78AAL468SMuYNr/epuMRt4zUnWuyTN/Ny7srdkJePyYYj
         hCMoBwT0SR3TQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 8/8] NFSv4: Add an ioctl to allow retrieval of the NFS raw ACCESS mask
Date:   Fri, 17 Dec 2021 15:48:54 -0500
Message-Id: <20211217204854.439578-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217204854.439578-8-trondmy@kernel.org>
References: <20211217204854.439578-1-trondmy@kernel.org>
 <20211217204854.439578-2-trondmy@kernel.org>
 <20211217204854.439578-3-trondmy@kernel.org>
 <20211217204854.439578-4-trondmy@kernel.org>
 <20211217204854.439578-5-trondmy@kernel.org>
 <20211217204854.439578-6-trondmy@kernel.org>
 <20211217204854.439578-7-trondmy@kernel.org>
 <20211217204854.439578-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c             | 47 +++++++++++++++++++++++++---------------
 fs/nfs/internal.h        |  2 ++
 fs/nfs/nfs4file.c        | 39 +++++++++++++++++++++++++++++++++
 include/uapi/linux/nfs.h | 11 ++++++++++
 4 files changed, 81 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f6fc60822153..2cbff76d36de 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2863,37 +2863,33 @@ void nfs_access_set_mask(struct nfs_access_entry *entry, u32 access_result)
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
 
 	trace_nfs_access_enter(inode);
 
-	status = nfs_access_get_cached(inode, cred, &cache, may_block);
+	status = nfs_access_get_cached(inode, cred, cache, may_block);
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
-	cache.cred = cred;
-	status = NFS_PROTO(inode)->access(inode, &cache);
+		cache->mask |= NFS_ACCESS_EXECUTE;
+	cache->cred = cred;
+	status = NFS_PROTO(inode)->access(inode, cache);
 	if (status != 0) {
 		if (status == -ESTALE) {
 			if (!S_ISDIR(inode->i_mode))
@@ -2901,10 +2897,25 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 			else
 				nfs_zap_caches(inode);
 		}
-		goto out;
+		return status;
 	}
-	nfs_access_add_cache(inode, &cache);
-out_cached:
+	nfs_access_add_cache(inode, cache);
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

