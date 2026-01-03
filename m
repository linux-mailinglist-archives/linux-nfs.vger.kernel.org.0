Return-Path: <linux-nfs+bounces-17428-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1937CF071D
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 00:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88F223009779
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 23:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911DD2690F9;
	Sat,  3 Jan 2026 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SScGvwx+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008E271440
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767483691; cv=none; b=O8Wk9H8zXY0NBii+QT8vVJHv5UchIvwq6V1tZRVMqONOkC0mjsF8oI03ZpbcoV+TDbMXYp01nCxzAso74XvwRDy9JUMiV1xlDEXDVuI2EPbYGo/vuyXu/Ya4uILwNEIUKYX9FxC1dXC91H/1aaDpCz4qp3ejr5O79YMJOSnqgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767483691; c=relaxed/simple;
	bh=Wiu5BBgWRUVOKhxtFS2/4yrKD8Z1DN39gecLW7cGEso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpFYyzBxIfQmotgTDwQD5YvnLDlcMc8fuYB0pk1ZtUdxxb7MsTodcGBG++OjVDoRxYRlo26clSrf3CJG//njg0UFGK/CYmlVsVpblHhFI9QwamvY6ys7taBjDeSn6ltsT7FWsKyPRadKvweJVfRv8QMWCBgLLqShmnUSsYg/+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SScGvwx+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c71f462d2so13742816a91.0
        for <linux-nfs@vger.kernel.org>; Sat, 03 Jan 2026 15:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767483689; x=1768088489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rchuhALNmPqQKjGXCirCs+iFGn89fglZcFpKBuxrnpI=;
        b=SScGvwx+exJiJ9NTC6Er2rFZa1vnjLx+28mqMY3N1sONWKnwHJKbjVKZw5SgBKH2Wf
         AfaiAExyx1hvRyqX7lKVBP2CR6izY6Axpx7YUwZ444KJDmXlhOoR+iVznCd2qXe+0r2K
         8XQ4tF0Q2ocgsMF8FfWV43jeuVH7aENjBit0BsPy8yKZEvCjJbwm9N0B24CTOqBw66Rz
         8gEowS8/SOjBI+27FFYVHGh0TRuNCNil+VWX62zREBblF1jKlGIJSzXLcTdCnneLumAg
         SNUuFRGPpIG9HbLoJ4J7NdCOdLDHQuTiz8RzmWRLEdg70IzsU36jgKSfCLvRfd/HdPK+
         xE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767483689; x=1768088489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rchuhALNmPqQKjGXCirCs+iFGn89fglZcFpKBuxrnpI=;
        b=w5XLdnsAU8WPzNGhwp/dJhbrqgpYPZ1IeI+Ns5Z39LNSkaeidon6ZepLgbD228N8QZ
         2S/LAx9hTZ2TJcpBb1kmUZf5+S96HH1NlhFK2/m820wB8NDXkl9w/gM+pvQz6sFA7w6i
         OvC4QmBCVkKW1rcwhKwsGqH7d2O9n4FI7krDPLmTRnihArqbb187rDrv4fA8EFOJ3grR
         EB5nGAvAZQ0OyFRs7FmmNC9GWKrbLiAKWYs501WRVdjBBrHtvkg+LLzSnJC6AXq7AF19
         Exv3aCLs/SZ49kXYANbj5TggN0wxjCLMoUq/EXRQvSxrfzNbzDIN66CeIfW1P7NIIvuK
         Y9yg==
X-Gm-Message-State: AOJu0YyLBVsSHOLmg/+zful+/UxGScbXOhaD4oLxTzP7Zrw+Dp9Sg9Wo
	Y87pIhfIZ9dH3TnR11kCiheRhX58PsPup6TPFRQD3eCjEKQiuabuwtQpyHQVWHQ=
X-Gm-Gg: AY/fxX5q09yhGtd+TrJqq+uc6oSRqHQSEQyFS0Bdr9v+r0/8P8+r1GYdvSTykhro8tP
	nZCY7BNQqoerDdl0rZK80pjS82CfNUJ8eurJxxqCqW++altNJWoALDD81Ss65Q+y8aIka6xBGB+
	PojuCNl2JTua0yep3jYG1OeyDJSL4M3Sf4cxsBMmpiMTGfKOmovnC6NeFIqfUA19S3AGnCwNjN/
	syWzYLzbt3vXOPc+Z7W//QWnFVI8vrnYKXAS2TIhpKPeGqMYuEbDX/BBVMZBw2uHbKAHf2mZCBz
	KDcNhG7QPj/rYfLWA+r/ovJtJEPogz1i0mFWkcu6Vndg3qLjAahu5Lu/Ma8mBITl24AytriIE4O
	lf9mk5j+hzl/GKx1jXR/nzD7xGAXkGDi+VaOnNUlbG/dLwJoy5gE0EnrSK7qDTDyvgdtQKnXd9f
	afLSDSRpfE2LfeQdp9TlXhbem+bewmXeIEaPg5dz/CBjeQU+dPOwooYG6HpAd09aVEo4I=
X-Google-Smtp-Source: AGHT+IF8+00Sye+33qUJ+hGDUYjOR73XbVrN3rrpoEW/TFxXo13nF004FtX7cGrNIprlirMnUuUMpQ==
X-Received: by 2002:a05:6a21:328e:b0:364:1361:a8a7 with SMTP id adf61e73a8af0-376a81dc171mr43284386637.10.1767483689142;
        Sat, 03 Jan 2026 15:41:29 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c5307c7sm38472577a12.28.2026.01.03.15.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 15:41:28 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 5/8] Make three functions global and move them to acl.c
Date: Sat,  3 Jan 2026 15:40:29 -0800
Message-ID: <20260103234033.1256-6-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260103234033.1256-1-rick.macklem@gmail.com>
References: <20260103234033.1256-1-rick.macklem@gmail.com>
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


