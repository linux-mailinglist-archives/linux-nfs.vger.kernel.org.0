Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07384527235
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiENOvO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiENOvD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:51:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538423466D
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E36AD60F69
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F057CC34117;
        Sat, 14 May 2022 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652539843;
        bh=4H5VhiOzuNnAER7m+K0HBmbaoSkrPy7gUzvAMCNReZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eu9viniaghDuWVypbYsj+6tty4DGUlf4dR3SWs5qTpInQ0saUnFE0/8hWD26NJYaS
         +6h3dNTNPmL2917+ZB7cR6E0/Kh0YxzInrp7w2lyc0+1PYMkemVQYhBSH5OeYrV/xL
         CWBymxxlC588ANYAeODzOX/38yK36S9/ERU0/YJU5NsvudZA08rzGyAxc7PtorimCZ
         3B+QYb3TzVANqGBtDyMr5JwDxDhxEa3txevRsC96nHrxMUsjpPdUVBYm1GQN4YzC6a
         I7VhFNgZ7eq5DX/ltxEy5BJ0PDdP+2H+P+0V4+WgOy6eYpKCcy4eZ1Wkazcq7YzRbw
         nH+ZiHVlilPzg==
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>,
        "J.Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/6] libnfs4acl: Add helpers to set the dacl and sacl
Date:   Sat, 14 May 2022 10:44:31 -0400
Message-Id: <20220514144436.4298-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514144436.4298-1-trondmy@kernel.org>
References: <20220514144436.4298-1-trondmy@kernel.org>
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

Add helper functions to set the NFSv4.1 dacl and sacl attributes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/libacl_nfs4.h    |  9 +++++
 libnfs4acl/Makefile      |  2 +
 libnfs4acl/nfs4_getacl.c | 83 ++++++++++++++++++++++++++++++++++++++++
 libnfs4acl/nfs4_setacl.c | 49 ++++++++++++++++++++++++
 4 files changed, 143 insertions(+)
 create mode 100644 libnfs4acl/nfs4_getacl.c
 create mode 100644 libnfs4acl/nfs4_setacl.c

diff --git a/include/libacl_nfs4.h b/include/libacl_nfs4.h
index d3786c3fabdc..76bbe90af54d 100644
--- a/include/libacl_nfs4.h
+++ b/include/libacl_nfs4.h
@@ -123,6 +123,8 @@
 
 /* NFS4 acl xattr name */
 #define ACL_NFS4_XATTR "system.nfs4_acl"
+#define DACL_NFS4_XATTR "system.nfs4_dacl"
+#define SACL_NFS4_XATTR "system.nfs4_sacl"
 
 /* Macro for finding empty tailqs */
 #define TAILQ_IS_EMPTY(head) (head.tqh_first == NULL)
@@ -152,6 +154,13 @@ TAILQ_HEAD(ace_container_list_head, ace_container);
 
 /**** Public functions ****/
 
+extern struct nfs4_acl *	nfs4_getacl(const char *path);
+extern struct nfs4_acl *	nfs4_getdacl(const char *path);
+extern struct nfs4_acl *	nfs4_getsacl(const char *path);
+extern int			nfs4_setacl(const char *path, struct nfs4_acl *acl);
+extern int			nfs4_setdacl(const char *path, struct nfs4_acl *acl);
+extern int			nfs4_setsacl(const char *path, struct nfs4_acl *acl);
+
 /** Manipulation functions **/
 extern int			acl_nfs4_set_who(struct nfs4_ace*, int, char*);
 extern struct nfs4_acl *	acl_nfs4_copy_acl(struct nfs4_acl *);
diff --git a/libnfs4acl/Makefile b/libnfs4acl/Makefile
index a598d4ee141f..556b59535e26 100644
--- a/libnfs4acl/Makefile
+++ b/libnfs4acl/Makefile
@@ -92,6 +92,8 @@ LIBACL_NFS4_CFILES = \
 	nfs4_get_ace_access.c \
 	nfs4_get_ace_flags.c \
 	nfs4_get_ace_type.c \
+	nfs4_getacl.c \
+	nfs4_setacl.c \
 	nfs4_insert_file_aces.c \
 	nfs4_insert_string_aces.c \
 	nfs4_free_acl.c \
diff --git a/libnfs4acl/nfs4_getacl.c b/libnfs4acl/nfs4_getacl.c
new file mode 100644
index 000000000000..753ba9167459
--- /dev/null
+++ b/libnfs4acl/nfs4_getacl.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (c) 2022, Trond Myklebust <trond.myklebust@hammerspace.com>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU LESSER GENERAL PUBLIC LICENSE
+ * version 2.1 as published by the Free Software Foundation.
+ *
+ * This code is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU LESSER GENERAL PUBLIC LICENSE for more details.
+ */
+
+#include <sys/types.h>
+#include <config.h>
+#ifdef HAVE_ATTR_XATTR_H
+# include <attr/xattr.h>
+#else
+# ifdef HAVE_SYS_XATTR_H
+#  include <sys/xattr.h>
+# endif
+#endif
+#include <sys/stat.h>
+#include "libacl_nfs4.h"
+
+/* returns a newly-allocated struct nfs4_acl or NULL on error. */
+static struct nfs4_acl *nfs4_getacl_byname(const char *path,
+					   const char *xattr_name)
+{
+	struct nfs4_acl *acl;
+	struct stat st;
+	void *buf;
+	ssize_t ret;
+	u32 iflags = NFS4_ACL_ISFILE;
+
+	if (path == NULL || *path == 0) {
+		errno = EFAULT;
+		return NULL;
+	}
+
+	/* find necessary buffer size */
+	ret = getxattr(path, xattr_name, NULL, 0);
+	if (ret == -1)
+		goto err;
+
+	buf = malloc(ret);
+	if (!buf)
+		goto err;
+
+	/* reconstruct the ACL */
+	ret = getxattr(path, xattr_name, buf, ret);
+	if (ret == -1)
+		goto err_free;
+
+	ret = stat(path, &st);
+	if (ret == -1)
+		goto err_free;
+
+	if (S_ISDIR(st.st_mode))
+		iflags = NFS4_ACL_ISDIR;
+
+	acl = acl_nfs4_xattr_load(buf, ret, iflags);
+
+	free(buf);
+	return acl;
+err_free:
+	free(buf);
+err:
+	return NULL;
+}
+
+struct nfs4_acl *nfs4_getacl(const char *path)
+{
+	return nfs4_getacl_byname(path, ACL_NFS4_XATTR);
+}
+struct nfs4_acl *nfs4_getdacl(const char *path)
+{
+	return nfs4_getacl_byname(path, DACL_NFS4_XATTR);
+}
+struct nfs4_acl *nfs4_getsacl(const char *path)
+{
+	return nfs4_getacl_byname(path, SACL_NFS4_XATTR);
+}
diff --git a/libnfs4acl/nfs4_setacl.c b/libnfs4acl/nfs4_setacl.c
new file mode 100644
index 000000000000..298365ec67c5
--- /dev/null
+++ b/libnfs4acl/nfs4_setacl.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2022, Trond Myklebust <trond.myklebust@hammerspace.com>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU LESSER GENERAL PUBLIC LICENSE
+ * version 2.1 as published by the Free Software Foundation.
+ *
+ * This code is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU LESSER GENERAL PUBLIC LICENSE for more details.
+ */
+
+#include <sys/types.h>
+#include <config.h>
+#ifdef HAVE_ATTR_XATTR_H
+# include <attr/xattr.h>
+#else
+# ifdef HAVE_SYS_XATTR_H
+#  include <sys/xattr.h>
+# endif
+#endif
+#include "libacl_nfs4.h"
+
+static int nfs4_setacl_byname(const char *path, const char *xattr_name,
+			      struct nfs4_acl *acl)
+{
+	char *xdrbuf = NULL;
+	int ret;
+
+	ret = acl_nfs4_xattr_pack(acl, &xdrbuf);
+	if (ret != -1)
+		ret = setxattr(path, xattr_name, xdrbuf, ret, XATTR_REPLACE);
+	free(xdrbuf);
+	return ret;
+}
+
+int nfs4_setacl(const char *path, struct nfs4_acl *acl)
+{
+	return nfs4_setacl_byname(path, ACL_NFS4_XATTR, acl);
+}
+int nfs4_setdacl(const char *path, struct nfs4_acl *acl)
+{
+	return nfs4_setacl_byname(path, DACL_NFS4_XATTR, acl);
+}
+int nfs4_setsacl(const char *path, struct nfs4_acl *acl)
+{
+	return nfs4_setacl_byname(path, SACL_NFS4_XATTR, acl);
+}
-- 
2.36.1

