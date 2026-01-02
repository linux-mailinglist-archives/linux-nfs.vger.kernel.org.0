Return-Path: <linux-nfs+bounces-17402-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D6CEF78D
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 00:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45F363010982
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jan 2026 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26951A08BC;
	Fri,  2 Jan 2026 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZJH9KJQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B00279358
	for <linux-nfs@vger.kernel.org>; Fri,  2 Jan 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767396635; cv=none; b=WZGexzspZ38pPL9Nc6EhEy9nRQ4yJhnaYYxP1u+cLt70l+52gNmwJKCGo6w9ww7KywoVBx3lRG0G71c4X1RXN18cXyX2wIvNI3IbukDMUhqAKNvNqGQXynvO9RSHYkqrtZzPZALXU6HIfv07BbVDKEtDTYZnFqvrVPrKf0O2/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767396635; c=relaxed/simple;
	bh=Wiu5BBgWRUVOKhxtFS2/4yrKD8Z1DN39gecLW7cGEso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiUMq+5SfVtU0tYS4T/fFQr9+GEkF7uZ/8MX7UJSvf1IslkZapS0WH6Kw+jHIfZ8+J510nn756jPwq2DY9PQ+ckNxbQC4kuVl4hAqcTVAFMH5BRYpxzcRE3s2LntKT/wH0hmSK+838XnGakPKWnUfXB/alEp8i3u9iOeBfutQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZJH9KJQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0d5c365ceso165724475ad.3
        for <linux-nfs@vger.kernel.org>; Fri, 02 Jan 2026 15:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767396634; x=1768001434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rchuhALNmPqQKjGXCirCs+iFGn89fglZcFpKBuxrnpI=;
        b=EZJH9KJQ9EquRLShaBHUMGy3X3WVs5QVE1G8uqQM2xabV7YcLvPEE6qb4rL1J9mFat
         F+r58XpE1ABukFIJOetorU95YQGHHwvJ9sClxpzoE9PLpI1jJkMUOvUvF4m4ccKS1HBc
         0eok/ywWudyEoGiQpw3W5dSXZDU/UhTtxUvHrxgj919WruCEHccuVJsxeHNpGRCULhcV
         +SuS3N8UgPsnO3V69yv0owmjGfsnPzQhgxc95eQcH1dtaXdPgYmFxeM1jAX6+hjzHx4l
         Ecs1GfRA+fAxJsrvXtnDgwTs75gJ/ILetYOlFQk+cT9DKIo/NqUY/i3sbzBZga7StaG+
         td4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767396634; x=1768001434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rchuhALNmPqQKjGXCirCs+iFGn89fglZcFpKBuxrnpI=;
        b=MrIkIcI5Sn3PJRmH5qjEV9VdPFXZ+Tf/KNBqZyyJsv7i2DNybIvdPw7G4yVbz3ZP0V
         5ytlPxvqr40Yiu8eO+c5aI5PUvuE6xXIwLeMHkNkT1ldLw9WDjQcqnAD4FvvAMhNMBI1
         rsHTVrIGxcxrI3OelXWtRLADmcPgCA0K27udS6C4vPor8r1Aw7pfSEunUDIfRJZ4ALDS
         hIPLw+qPSqWpVag6DsywJwByyJEeis0ey/nYyyPODQ2ivantXapSl2IvoGMBA9ROmeNC
         D+hUU4haQLrzx7GNwPCuA/U1H/rRdy7lg7o00kuahVDkBomYqYnlM+u/cd6xx9674dSl
         eq4w==
X-Gm-Message-State: AOJu0Ywh/Up8iPcgxxK9Xso7DyK6n8L6c5V1jKGyDRk0awrIiUTYXeeF
	qVXQSC1FOgOjLr1f3Z/ieFp4JKUyhoYpJK5iLqQWoOVNeB2LBrI2qOiV9BBYTxo=
X-Gm-Gg: AY/fxX4hWit7+fOkHBJjlsjt5H0un/17RJFzsGYVUsgFbv5TKp6dEdEr06mOvaTD1Qf
	fHgvlTTlLhQYdtg39JU0pq1SyGBBRJsAojx/lZBuOOdb4NUuJu0vRTRtiw9yQouKbY4Y+2wk8uU
	wyw7bST9QfkaoW0FpfYl/O+hDKjkSVuL1BDofzAnTFIiHatxQh+8L2koLLmV6KfdYzc5AQ1+Ywv
	MT62MLzG4l0eoVZIFkO+BS0qsX1K99m0l8kNGeAYgzI1vOM+iJNz135xJyXQCqc4Qjqa/PgLdOv
	0yS4PLz++au7u1Iv80F1E2KQ1c25u4RxensCnQdVIht+4ZlImvBWLnetMA7oPuueideNUPALmhi
	6jGyOiT5cvSmUbBGJkzZsiFWqpZHQ39AcPMHiuNXZUn9MjD9wHQd4iw9keLP4vvCaMUgisA9U1w
	EQ0HpymsKngZRtfWArM7/cMmg8TitLZAdSi5oDVtP2PiUj6GlD2kVhpowS
X-Google-Smtp-Source: AGHT+IGA1DVbjEWN7/mXcydjcXq0Wiv33L/HHdPqQFhliosaDMtSJo+w1mJsPwKuaOFTDB0hdHHA1w==
X-Received: by 2002:a17:902:e74c:b0:297:f09a:51cd with SMTP id d9443c01a7336-2a2f2214860mr458864405ad.14.1767396633487;
        Fri, 02 Jan 2026 15:30:33 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c71853sm391508805ad.19.2026.01.02.15.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 15:30:32 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 4/7] Make three functions global and move them to acl.c
Date: Fri,  2 Jan 2026 15:29:31 -0800
Message-ID: <20260102232934.1560-5-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260102232934.1560-1-rick.macklem@gmail.com>
References: <20260102232934.1560-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

The three functions:
nfs3_prepare_get_acl()
nfs3_complete_get_acl()
nfs3_abort_get_acl()
have been moved to a new file called nfs34acl.c and renamed nfs34_XXX(),
so that they can be called from the NFSv4.2 client code
implementing the POSIX draft ACL attributes.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfs/Makefile   |  2 +-
 fs/nfs/nfs.h      |  3 +++
 fs/nfs/nfs34acl.c | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs3acl.c  | 44 +++++++-------------------------------------
 4 files changed, 51 insertions(+), 38 deletions(-)
 create mode 100644 fs/nfs/nfs34acl.c

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 9fb2f2cac87e..afb84c44a019 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -9,7 +9,7 @@ CFLAGS_nfstrace.o += -I$(src)
 nfs-y 			:= client.o dir.o file.o getroot.o inode.o super.o \
 			   io.o direct.o pagelist.o read.o symlink.o unlink.o \
 			   write.o namespace.o mount_clnt.o nfstrace.o \
-			   export.o sysfs.o fs_context.o
+			   export.o sysfs.o fs_context.o nfs34acl.o
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
 nfs-$(CONFIG_SYSCTL)	+= sysctl.o
 nfs-$(CONFIG_NFS_FSCACHE) += fscache.o
diff --git a/fs/nfs/nfs.h b/fs/nfs/nfs.h
index 8a5f51be013a..b5d1cfb92ab1 100644
--- a/fs/nfs/nfs.h
+++ b/fs/nfs/nfs.h
@@ -26,5 +26,8 @@ int get_nfs_version(struct nfs_subversion *);
 void put_nfs_version(struct nfs_subversion *);
 void register_nfs_version(struct nfs_subversion *);
 void unregister_nfs_version(struct nfs_subversion *);
+void nfs34_prepare_get_acl(struct posix_acl **);
+void nfs34_complete_get_acl(struct posix_acl **, struct posix_acl *);
+void nfs34_abort_get_acl(struct posix_acl **);
 
 #endif /* __LINUX_INTERNAL_NFS_H */
diff --git a/fs/nfs/nfs34acl.c b/fs/nfs/nfs34acl.c
new file mode 100644
index 000000000000..e3322f222c53
--- /dev/null
+++ b/fs/nfs/nfs34acl.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fs.h>
+#include <linux/nfs_fs.h>
+#include <linux/posix_acl.h>
+
+#include "nfs.h"
+
+/*
+ * nfs34_prepare_get_acl, nfs34_complete_get_acl, nfs34_abort_get_acl: Helpers
+ * for caching get_acl results in a race-free way. See fs/posix_acl.c:get_acl()
+ * for explanations.
+ */
+void nfs34_prepare_get_acl(struct posix_acl **p)
+{
+	struct posix_acl *sentinel = uncached_acl_sentinel(current);
+
+	/* If the ACL isn't being read yet, set our sentinel. */
+	cmpxchg(p, ACL_NOT_CACHED, sentinel);
+}
+EXPORT_SYMBOL_GPL(nfs34_prepare_get_acl);
+
+void nfs34_complete_get_acl(struct posix_acl **p, struct posix_acl *acl)
+{
+	struct posix_acl *sentinel = uncached_acl_sentinel(current);
+
+	/* Only cache the ACL if our sentinel is still in place. */
+	posix_acl_dup(acl);
+	if (cmpxchg(p, sentinel, acl) != sentinel)
+		posix_acl_release(acl);
+}
+EXPORT_SYMBOL_GPL(nfs34_complete_get_acl);
+
+void nfs34_abort_get_acl(struct posix_acl **p)
+{
+	struct posix_acl *sentinel = uncached_acl_sentinel(current);
+
+	/* Remove our sentinel upon failure. */
+	cmpxchg(p, sentinel, ACL_NOT_CACHED);
+}
+EXPORT_SYMBOL_GPL(nfs34_abort_get_acl);
diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index a126eb31f62f..61aa56a632e3 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -8,41 +8,11 @@
 #include <linux/nfsacl.h>
 
 #include "internal.h"
+#include "nfs.h"
 #include "nfs3_fs.h"
 
 #define NFSDBG_FACILITY	NFSDBG_PROC
 
-/*
- * nfs3_prepare_get_acl, nfs3_complete_get_acl, nfs3_abort_get_acl: Helpers for
- * caching get_acl results in a race-free way.  See fs/posix_acl.c:get_acl()
- * for explanations.
- */
-static void nfs3_prepare_get_acl(struct posix_acl **p)
-{
-	struct posix_acl *sentinel = uncached_acl_sentinel(current);
-
-	/* If the ACL isn't being read yet, set our sentinel. */
-	cmpxchg(p, ACL_NOT_CACHED, sentinel);
-}
-
-static void nfs3_complete_get_acl(struct posix_acl **p, struct posix_acl *acl)
-{
-	struct posix_acl *sentinel = uncached_acl_sentinel(current);
-
-	/* Only cache the ACL if our sentinel is still in place. */
-	posix_acl_dup(acl);
-	if (cmpxchg(p, sentinel, acl) != sentinel)
-		posix_acl_release(acl);
-}
-
-static void nfs3_abort_get_acl(struct posix_acl **p)
-{
-	struct posix_acl *sentinel = uncached_acl_sentinel(current);
-
-	/* Remove our sentinel upon failure. */
-	cmpxchg(p, sentinel, ACL_NOT_CACHED);
-}
-
 struct posix_acl *nfs3_get_acl(struct inode *inode, int type, bool rcu)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
@@ -91,9 +61,9 @@ struct posix_acl *nfs3_get_acl(struct inode *inode, int type, bool rcu)
 		return ERR_PTR(-ENOMEM);
 
 	if (args.mask & NFS_ACL)
-		nfs3_prepare_get_acl(&inode->i_acl);
+		nfs34_prepare_get_acl(&inode->i_acl);
 	if (args.mask & NFS_DFACL)
-		nfs3_prepare_get_acl(&inode->i_default_acl);
+		nfs34_prepare_get_acl(&inode->i_default_acl);
 
 	status = rpc_call_sync(server->client_acl, &msg, 0);
 	dprintk("NFS reply getacl: %d\n", status);
@@ -131,12 +101,12 @@ struct posix_acl *nfs3_get_acl(struct inode *inode, int type, bool rcu)
 	}
 
 	if (res.mask & NFS_ACL)
-		nfs3_complete_get_acl(&inode->i_acl, res.acl_access);
+		nfs34_complete_get_acl(&inode->i_acl, res.acl_access);
 	else
 		forget_cached_acl(inode, ACL_TYPE_ACCESS);
 
 	if (res.mask & NFS_DFACL)
-		nfs3_complete_get_acl(&inode->i_default_acl, res.acl_default);
+		nfs34_complete_get_acl(&inode->i_default_acl, res.acl_default);
 	else
 		forget_cached_acl(inode, ACL_TYPE_DEFAULT);
 
@@ -150,8 +120,8 @@ struct posix_acl *nfs3_get_acl(struct inode *inode, int type, bool rcu)
 	}
 
 getout:
-	nfs3_abort_get_acl(&inode->i_acl);
-	nfs3_abort_get_acl(&inode->i_default_acl);
+	nfs34_abort_get_acl(&inode->i_acl);
+	nfs34_abort_get_acl(&inode->i_default_acl);
 	posix_acl_release(res.acl_access);
 	posix_acl_release(res.acl_default);
 	nfs_free_fattr(res.fattr);
-- 
2.49.0


