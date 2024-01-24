Return-Path: <linux-nfs+bounces-1304-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0803683AAA0
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 14:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D651EB2DBB3
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 13:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AE87A724;
	Wed, 24 Jan 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tOBJVkRi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBD07A720;
	Wed, 24 Jan 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101262; cv=none; b=tm6Y1J68rZCy2iUCfP5ysAGKH3Fk9aH9M8PHYPbyixKiKs3iQEp34/IAac81ASajbpZHL4QIIGxlYd2JP5mFCcat2lFAdMYWMWogEfYzM+5IlFeVxJvb5QxRW5yx8YZ3nwN4zjff2m16Iy4GkAWWoSYaZPTYU9Rv76qBgmewHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101262; c=relaxed/simple;
	bh=dxeqS8nJn0cUal7MvYGwmBQGtwlyl43j8h6nUguSH/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIIkdXTqkFebLM9iPUwXWg8zpJ/1cHTjdbEvmf0oYdGuuayjLSH8wVZl6efh61PcYzgNkzVejK3+Te4GYDfARYYPHHYg8sPUSRILBgMpvxAJsgru6vgdnxS0/My+0POINlYnkLna18AvtT47nt+buxXEemD4mrr4Nyd1geTbmLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tOBJVkRi; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706101260; x=1737637260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=esdBGO6+s0GvM5L+apoZ0wMvnqC6EfNpK/oW2x91JKA=;
  b=tOBJVkRiIJPe+k3iEKO10Z3I2F6PXedINcDSwe9HF5EFGO4mS2Ieji5T
   jQPwszAxi2N391LVZ9DB0dpVzUp3ocSFhcPC4aMTO0q5yl/LmG9xkhJJ8
   MO5rzl3iW+KzFPGKVSxnBgv2qIo9HdC+IESDUkW/grgLLWFSeM3n8o9+P
   c=;
X-IronPort-AV: E=Sophos;i="6.05,216,1701129600"; 
   d="scan'208";a="633298651"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 13:00:56 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id 9A6ED80413;
	Wed, 24 Jan 2024 13:00:54 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:29479]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.58:2525] with esmtp (Farcaster)
 id c565c4aa-bf06-4350-9285-e1ece193a91d; Wed, 24 Jan 2024 13:00:53 +0000 (UTC)
X-Farcaster-Flow-ID: c565c4aa-bf06-4350-9285-e1ece193a91d
Received: from EX19EXOUWC002.ant.amazon.com (10.250.64.172) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 13:00:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19EXOUWC002.ant.amazon.com (10.250.64.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Jan 2024 13:00:47 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 13:00:46 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 6F6A22D62; Wed, 24 Jan 2024 14:00:46 +0100 (CET)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <viro@zeniv.linux.org.uk>, <xuyang2018.jy@fujitsu.com>,
	<stable@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<--suppress-cc=body@amazon.com>, "Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Mahmoud Adam <mngyadam@amazon.com>
Subject: [PATCH 1/2] fs: add mode_strip_sgid() helper
Date: Wed, 24 Jan 2024 14:00:25 +0100
Message-ID: <20240124130025.2292-2-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124130025.2292-1-mngyadam@amazon.com>
References: <20240124130025.2292-1-mngyadam@amazon.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Yang Xu <xuyang2018.jy@fujitsu.com>

commit 2b3416ceff5e6bd4922f6d1c61fb68113dd82302 upstream.

[remove userns argument of helper for 5.4.y backport]

Add a dedicated helper to handle the setgid bit when creating a new file
in a setgid directory. This is a preparatory patch for moving setgid
stripping into the vfs. The patch contains no functional changes.

Currently the setgid stripping logic is open-coded directly in
inode_init_owner() and the individual filesystems are responsible for
handling setgid inheritance. Since this has proven to be brittle as
evidenced by old issues we uncovered over the last months (see [1] to
[3] below) we will try to move this logic into the vfs.

Link: e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes") [1]
Link: 01ea173e103e ("xfs: fix up non-directory creation in SGID directories") [2]
Link: fd84bfdddd16 ("ceph: fix up non-directory creation in SGID directories") [3]
Link: https://lore.kernel.org/r/1657779088-2242-1-git-send-email-xuyang2018.jy@fujitsu.com
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-and-Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[commit 347750e1b69cef62966fbc5bd7dc579b4c00688a upstream
	backported from 5.10.y, resolved context conflicts]
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
 fs/inode.c         | 34 ++++++++++++++++++++++++++++++----
 include/linux/fs.h |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index f7c8c0fe11d4..2995130e0cdc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2100,10 +2100,8 @@ void inode_init_owner(struct inode *inode, const struct inode *dir,
 		/* Directories are special, and always inherit S_ISGID */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(inode->i_gid) &&
-			 !capable_wrt_inode_uidgid(dir, CAP_FSETID))
-			mode &= ~S_ISGID;
+		else
+			mode = mode_strip_sgid(dir, mode);
 	} else
 		inode->i_gid = current_fsgid();
 	inode->i_mode = mode;
@@ -2359,3 +2357,31 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
 	return 0;
 }
 EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
+
+/**
+ * mode_strip_sgid - handle the sgid bit for non-directories
+ * @dir: parent directory inode
+ * @mode: mode of the file to be created in @dir
+ *
+ * If the @mode of the new file has both the S_ISGID and S_IXGRP bit
+ * raised and @dir has the S_ISGID bit raised ensure that the caller is
+ * either in the group of the parent directory or they have CAP_FSETID
+ * in their user namespace and are privileged over the parent directory.
+ * In all other cases, strip the S_ISGID bit from @mode.
+ *
+ * Return: the new mode to use for the file
+ */
+umode_t mode_strip_sgid(const struct inode *dir, umode_t mode)
+{
+	if ((mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
+		return mode;
+	if (S_ISDIR(mode) || !dir || !(dir->i_mode & S_ISGID))
+		return mode;
+	if (in_group_p(dir->i_gid))
+		return mode;
+	if (capable_wrt_inode_uidgid(dir, CAP_FSETID))
+		return mode;
+
+	return mode & ~S_ISGID;
+}
+EXPORT_SYMBOL(mode_strip_sgid);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fbbd7ef7f653..d9b97ccd65e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1743,6 +1743,7 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 extern void inode_init_owner(struct inode *inode, const struct inode *dir,
 			umode_t mode);
 extern bool may_open_dev(const struct path *path);
+umode_t mode_strip_sgid(const struct inode *dir, umode_t mode);
 /*
  * VFS FS_IOC_FIEMAP helper definitions.
  */
-- 
2.40.1


