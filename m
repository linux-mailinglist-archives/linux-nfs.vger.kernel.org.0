Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE991822FE
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgCKUAA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 16:00:00 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:21948 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387469AbgCKT77 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956799; x=1615492799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ECKRP8QI91xkBXqgzzaaw62R8Y/U8A7xJx56JpnoJJo=;
  b=qh+b2jw8J0tbl35+Df7Y5o3nUEJSx8wYBRr7oF/YCVPY274a2r+XTQ2H
   4J6hX64AmnsafN/G30jsahX6kgOVP6praGXXsUwsWKAoWU9ecHGyT2hFl
   HKDqSbdATcHyxmgqNFNbClxQ4mX4Z8qkEPGsEyfbb3ij2VK6ZHc0FOIO8
   4=;
IronPort-SDR: GOm82r+IBTyGLdcIazep9R1/FlGOf+sRxTENBirVliN2R7hUttMc5Dy3n7NeclDpppdy90hHl5
 2kyev8GHgzwA==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="30664618"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 11 Mar 2020 19:59:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 3E420A33FB;
        Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:55 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 2687EDEF4B; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 13/14] xattr: add a function to check if a namespace is supported
Date:   Wed, 11 Mar 2020 19:59:53 +0000
Message-ID: <20200311195954.27117-14-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a function that checks is an extended attribute namespace is
supported for an inode.

To be used by the nfs server code when being queried for extended
attributes support.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/xattr.c            | 27 +++++++++++++++++++++++++++
 include/linux/xattr.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 58013bcbc333..7d0ebab1df30 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -134,6 +134,33 @@ xattr_permission(struct inode *inode, const char *name, int mask)
 	return inode_permission(inode, mask);
 }
 
+/*
+ * Look for any handler that deals with the specified namespace.
+ */
+int
+xattr_supported_namespace(struct inode *inode, const char *prefix)
+{
+	const struct xattr_handler **handlers = inode->i_sb->s_xattr;
+	const struct xattr_handler *handler;
+	size_t preflen;
+
+	if (!(inode->i_opflags & IOP_XATTR)) {
+		if (unlikely(is_bad_inode(inode)))
+			return -EIO;
+		return -EOPNOTSUPP;
+	}
+
+	preflen = strlen(prefix);
+
+	for_each_xattr_handler(handlers, handler) {
+		if (!strncmp(xattr_prefix(handler), prefix, preflen))
+			return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(xattr_supported_namespace);
+
 int
 __vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
 	       const void *value, size_t size, int flags)
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 3a71ad716da5..32e377602068 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -61,6 +61,8 @@ ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_siz
 ssize_t vfs_getxattr_alloc(struct dentry *dentry, const char *name,
 			   char **xattr_value, size_t size, gfp_t flags);
 
+int xattr_supported_namespace(struct inode *inode, const char *prefix);
+
 static inline const char *xattr_prefix(const struct xattr_handler *handler)
 {
 	return handler->prefix ?: handler->name;
-- 
2.16.6

