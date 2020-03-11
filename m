Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90281822F8
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 20:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbgCKT75 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:59:57 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:23579 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbgCKT75 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956798; x=1615492798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ROXlFFlPjSQ2iimx+oHHLVf9NqixAlMXraRw9w77D0M=;
  b=RuMm6k6WV8fLw/bETae/Waa/pDPfQhM5t7DsYgiq+20sSQiwQOfmMG4G
   gK/plQfJamUhGMVMVrmYW71jdwKrTydT+r3GnAQR5EwzYLqgKF81DCwBt
   DN+bJq60AywiXOQ2XiAcu4vXTSkKvvjuhA8w0qzVEeJRL7mZwZX5E9yHO
   g=;
IronPort-SDR: bTK9H2J8809YLJe23dWenz/LR0kMQFWB5D8gl6xuZSJH6knl65AMwlj8HXqd74wSMtaHv3BzHt
 HwJMs3LagS5g==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="20656068"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 11 Mar 2020 19:59:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id D176AC1B2C;
        Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:55 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:54 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:54 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 09136DEC12; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 02/14] xattr: modify vfs_{set,remove}xattr for NFS server use
Date:   Wed, 11 Mar 2020 19:59:42 +0000
Message-ID: <20200311195954.27117-3-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To be called from the upcoming NFS server xattr code, the vfs_removexattr
and vfs_setxattr need some modifications.

First, they need to grow a _locked variant, since the NFS server code
will call this with i_rwsem held. It needs to do that in fh_lock to be
able to atomically provide the before and after change attributes.

Second, RFC 8276 (NFSv4 extended attribute support) specifies that
delegations should be recalled (8.4.2.4, 8.4.4.4) when a SETXATTR
or REMOVEXATTR operation is performed. So, like with other fs
operations, try to break the delegation. The _locked version of
these operations will not wait for the delegation to be successfully
broken, instead returning an error if it wasn't, so that the NFS
server code can return NFS4ERR_DELAY to the client (similar to
what e.g. vfs_link does).

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/xattr.c            | 63 +++++++++++++++++++++++++++++++++++++++++++++------
 include/linux/xattr.h |  2 ++
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 90dd78f0eb27..58013bcbc333 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -204,10 +204,10 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	return error;
 }
 
-
 int
-vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
-		size_t size, int flags)
+__vfs_setxattr_locked(struct dentry *dentry, const char *name,
+		const void *value, size_t size, int flags,
+		struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -216,15 +216,40 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 	if (error)
 		return error;
 
-	inode_lock(inode);
 	error = security_inode_setxattr(dentry, name, value, size, flags);
 	if (error)
 		goto out;
 
+	error = try_break_deleg(inode, delegated_inode);
+	if (error)
+		goto out;
+
 	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
 
 out:
+	return error;
+}
+EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
+
+int
+vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
+		size_t size, int flags)
+{
+	struct inode *inode = dentry->d_inode;
+	struct inode *delegated_inode = NULL;
+	int error;
+
+retry_deleg:
+	inode_lock(inode);
+	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
+	    &delegated_inode);
 	inode_unlock(inode);
+
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_setxattr);
@@ -379,7 +404,8 @@ __vfs_removexattr(struct dentry *dentry, const char *name)
 EXPORT_SYMBOL(__vfs_removexattr);
 
 int
-vfs_removexattr(struct dentry *dentry, const char *name)
+__vfs_removexattr_locked(struct dentry *dentry, const char *name,
+		struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -388,11 +414,14 @@ vfs_removexattr(struct dentry *dentry, const char *name)
 	if (error)
 		return error;
 
-	inode_lock(inode);
 	error = security_inode_removexattr(dentry, name);
 	if (error)
 		goto out;
 
+	error = try_break_deleg(inode, delegated_inode);
+	if (error)
+		goto out;
+
 	error = __vfs_removexattr(dentry, name);
 
 	if (!error) {
@@ -401,12 +430,32 @@ vfs_removexattr(struct dentry *dentry, const char *name)
 	}
 
 out:
+	return error;
+}
+EXPORT_SYMBOL_GPL(__vfs_removexattr_locked);
+
+int
+vfs_removexattr(struct dentry *dentry, const char *name)
+{
+	struct inode *inode = dentry->d_inode;
+	struct inode *delegated_inode = NULL;
+	int error;
+
+retry_deleg:
+	inode_lock(inode);
+	error = __vfs_removexattr_locked(dentry, name, &delegated_inode);
 	inode_unlock(inode);
+
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_removexattr);
 
-
 /*
  * Extended attribute SET operations
  */
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 6dad031be3c2..3a71ad716da5 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -51,8 +51,10 @@ ssize_t vfs_getxattr(struct dentry *, const char *, void *, size_t);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
 int __vfs_setxattr(struct dentry *, struct inode *, const char *, const void *, size_t, int);
 int __vfs_setxattr_noperm(struct dentry *, const char *, const void *, size_t, int);
+int __vfs_setxattr_locked(struct dentry *, const char *, const void *, size_t, int, struct inode **);
 int vfs_setxattr(struct dentry *, const char *, const void *, size_t, int);
 int __vfs_removexattr(struct dentry *, const char *);
+int __vfs_removexattr_locked(struct dentry *, const char *, struct inode **);
 int vfs_removexattr(struct dentry *, const char *);
 
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
-- 
2.16.6

