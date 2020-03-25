Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D63B19343F
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 00:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCYXLG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 19:11:06 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:40828 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgCYXLG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 19:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585177865; x=1616713865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=eZeWbPDIFuYOcQFds2CBKE2Ml+c1Xl1+OMbta7BvFLA=;
  b=ZdT0J4AfBe6LaNX9pW0QhES90G0eLnSuf5icW46NLWGDhCOgzIIp9/2s
   HhA+J0AuDhy0ER3KZ52SDsFS0tcMtj30zW5Gly5SnGWeU3G9sZT8hBxjt
   LgJ4UyfGRXZbBYBFbRKLOgLIWDxCyD8VEBKR1v1OB2M+8JMqKNxiPTUXR
   4=;
IronPort-SDR: v/vLSkByqoFJ8d9YJ9f/uzXsVo+nnG8Oti+/T7I8KE1tQjbBNRGTlNqVOhqtBo0WDta2kPlR+w
 tbBGgzcJ9tMw==
X-IronPort-AV: E=Sophos;i="5.72,306,1580774400"; 
   d="scan'208";a="22761095"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 25 Mar 2020 23:10:53 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id B450AA27C5;
        Wed, 25 Mar 2020 23:10:52 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 23:10:52 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 23:10:51 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 25 Mar 2020 23:10:51 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 70DB7D92CA; Wed, 25 Mar 2020 23:10:51 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 12/13] NFSv4.2: hook in the user extended attribute handlers
Date:   Wed, 25 Mar 2020 23:10:50 +0000
Message-ID: <20200325231051.31652-13-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200325231051.31652-1-fllinden@amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that all the lower level code is there to make the RPC calls, hook
it in to the xattr handlers and the listxattr entry point, to make them
available.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs4proc.c | 123 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c1193766cfe5..33bbd4c90416 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -66,6 +66,7 @@
 #include "nfs4idmap.h"
 #include "nfs4session.h"
 #include "fscache.h"
+#include "nfs42.h"
 
 #include "nfs4trace.h"
 
@@ -7442,6 +7443,103 @@ nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
 
 #endif
 
+#ifdef CONFIG_NFS_V4_2
+static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
+				    struct dentry *unused, struct inode *inode,
+				    const char *key, const void *buf,
+				    size_t buflen, int flags)
+{
+	struct nfs_access_entry cache;
+
+	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
+		return -EOPNOTSUPP;
+
+	/*
+	 * There is no mapping from the MAY_* flags to the NFS_ACCESS_XA*
+	 * flags right now. Handling of xattr operations use the normal
+	 * file read/write permissions.
+	 *
+	 * Just in case the server has other ideas (which RFC 8276 allows),
+	 * do a cached access check for the XA* flags to possibly avoid
+	 * doing an RPC and getting EACCES back.
+	 */
+	if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
+		if (!(cache.mask & NFS_ACCESS_XAWRITE))
+			return -EACCES;
+	}
+
+	if (buf == NULL)
+		return nfs42_proc_removexattr(inode, key);
+	else
+		return nfs42_proc_setxattr(inode, key, buf, buflen, flags);
+}
+
+static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
+				    struct dentry *unused, struct inode *inode,
+				    const char *key, void *buf, size_t buflen)
+{
+	struct nfs_access_entry cache;
+
+	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
+		return -EOPNOTSUPP;
+
+	if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
+		if (!(cache.mask & NFS_ACCESS_XAREAD))
+			return -EACCES;
+	}
+
+	return nfs42_proc_getxattr(inode, key, buf, buflen);
+}
+
+static ssize_t
+nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
+{
+	u64 cookie;
+	bool eof;
+	int ret, size;
+	char *buf;
+	size_t buflen;
+	struct nfs_access_entry cache;
+
+	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
+		return 0;
+
+	if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
+		if (!(cache.mask & NFS_ACCESS_XALIST))
+			return 0;
+	}
+
+	cookie = 0;
+	eof = false;
+	buflen = list_len ? list_len : XATTR_LIST_MAX;
+	buf = list_len ? list : NULL;
+	size = 0;
+
+	while (!eof) {
+		ret = nfs42_proc_listxattrs(inode, buf, buflen,
+		    &cookie, &eof);
+		if (ret < 0)
+			return ret;
+
+		if (list_len) {
+			buf += ret;
+			buflen -= ret;
+		}
+		size += ret;
+	}
+
+	return size;
+}
+
+#else
+
+static ssize_t
+nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
+{
+	return 0;
+}
+#endif /* CONFIG_NFS_V4_2 */
+
 /*
  * nfs_fhget will use either the mounted_on_fileid or the fileid
  */
@@ -10039,7 +10137,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
-	ssize_t error, error2;
+	ssize_t error, error2, error3;
 
 	error = generic_listxattr(dentry, list, size);
 	if (error < 0)
@@ -10052,7 +10150,17 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 	error2 = nfs4_listxattr_nfs4_label(d_inode(dentry), list, size);
 	if (error2 < 0)
 		return error2;
-	return error + error2;
+
+	if (list) {
+		list += error2;
+		size -= error2;
+	}
+
+	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, size);
+	if (error3 < 0)
+		return error3;
+
+	return error + error2 + error3;
 }
 
 static const struct inode_operations nfs4_dir_inode_operations = {
@@ -10140,10 +10248,21 @@ static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
 	.set	= nfs4_xattr_set_nfs4_acl,
 };
 
+#ifdef CONFIG_NFS_V4_2
+static const struct xattr_handler nfs4_xattr_nfs4_user_handler = {
+	.prefix	= XATTR_USER_PREFIX,
+	.get	= nfs4_xattr_get_nfs4_user,
+	.set	= nfs4_xattr_set_nfs4_user,
+};
+#endif
+
 const struct xattr_handler *nfs4_xattr_handlers[] = {
 	&nfs4_xattr_nfs4_acl_handler,
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	&nfs4_xattr_nfs4_label_handler,
+#endif
+#ifdef CONFIG_NFS_V4_2
+	&nfs4_xattr_nfs4_user_handler,
 #endif
 	NULL
 };
-- 
2.17.2

