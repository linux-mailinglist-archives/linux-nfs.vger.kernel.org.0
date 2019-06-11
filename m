Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A2F3D541
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406913AbfFKSMC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 14:12:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34697 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406884AbfFKSMB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 14:12:01 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so10720831iot.1
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2019 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JXL+v9gwEGJ1PNf5Y/zoPLJPvp6gT/aSy8aczFGnbhU=;
        b=VVDLUPsoCawBKwMkcrAYyu+2upqZODAyZ0bWYSsoQRXUyLz/xxwRHOfh42EFtsqH1c
         H3gdOl5MO+QrGfoADrKY6P1mcK4tvtRRrxpT8OU9MJupDurN36eb4KiYp/SWRlIURaX/
         z/dpyOBWRTT2Ko49qhpQKOXLgQuCAMTfDOKGGAi7Z8sbFhImkB2Zn5xAFx1ACkdTVOGX
         SL0AqzwRb6ylE+6AYohiQWrrToKhNaCuOSFr2zacH3NCjfDC56o/b3QWenIz7Dstgd4u
         hf96BKR7cWQAId8UY8Z49zSdFmtehEOzf7KDbBcfC5JWtpopV/7Oj+7FvXPv76NG5OUV
         VLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXL+v9gwEGJ1PNf5Y/zoPLJPvp6gT/aSy8aczFGnbhU=;
        b=CFLuIKV+gG+7wxNwUk79RIK2k/+PRZV0Rnsh8b0DDn+u688AzFGOE4q12I9hMHOoMb
         8kJAoQ3M5sr0v26GSgkldVNQKHqIrfvgpMVZ+hWsv0BC1iHFC9OdEc8IKcAapjKPfBKP
         t/jR2ahdnLzdTYTisbUbaxFJxdIjMzCBJGGcXGfx6Jo8X9SHZd3MfZjl3krYNVtIuBgS
         xdihL/uyYsMnP91fJXMtq4o1xfA382Ykp4+IXHo6yPGjXdFdCNbjgZzncvUO1ifGNNGX
         UMZyuqKFPOl+hYeb0kh1On9edXdE+lSSHWyOr3FGI+vvb9a1tnOyUDfP0SWoBlUewzf3
         CoKA==
X-Gm-Message-State: APjAAAVrLqKH+XZxysD0aHtmpRTNMTVtfYub323wVZBCw8cNAnBYbuPV
        snq0BsfNTSJwD9NHZ+CeSI93OTQ=
X-Google-Smtp-Source: APXvYqwNDk/ik5tMrL92dxWyxmY92/i7795FTTEeLCQn6ZQj9iOydCk0He0UIKuAHC+SRu64whUbcg==
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr6151387ion.239.1560276720137;
        Tue, 11 Jun 2019 11:12:00 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id f4sm4900212iok.56.2019.06.11.11.11.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 11:11:59 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Create a root NFS directory in /sys/fs/nfs
Date:   Tue, 11 Jun 2019 14:08:30 -0400
Message-Id: <20190611180832.119488-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611180832.119488-1-trond.myklebust@hammerspace.com>
References: <20190611180832.119488-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/Makefile |  3 ++-
 fs/nfs/inode.c  |  8 ++++++
 fs/nfs/sysfs.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/sysfs.h  | 15 +++++++++++
 4 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 fs/nfs/sysfs.c
 create mode 100644 fs/nfs/sysfs.h

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index c587e3c4c6a6..34cdeaecccf6 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -8,7 +8,8 @@ obj-$(CONFIG_NFS_FS) += nfs.o
 CFLAGS_nfstrace.o += -I$(src)
 nfs-y 			:= client.o dir.o file.o getroot.o inode.o super.o \
 			   io.o direct.o pagelist.o read.o symlink.o unlink.o \
-			   write.o namespace.o mount_clnt.o nfstrace.o export.o
+			   write.o namespace.o mount_clnt.o nfstrace.o \
+			   export.o sysfs.o
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
 nfs-$(CONFIG_SYSCTL)	+= sysctl.o
 nfs-$(CONFIG_NFS_FSCACHE) += fscache.o fscache-index.o
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0b4a1a974411..60b9e14a0309 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -51,6 +51,7 @@
 #include "pnfs.h"
 #include "nfs.h"
 #include "netns.h"
+#include "sysfs.h"
 
 #include "nfstrace.h"
 
@@ -2181,6 +2182,10 @@ static int __init init_nfs_fs(void)
 {
 	int err;
 
+	err = nfs_sysfs_init();
+	if (err < 0)
+		goto out10;
+
 	err = register_pernet_subsys(&nfs_net_ops);
 	if (err < 0)
 		goto out9;
@@ -2244,6 +2249,8 @@ static int __init init_nfs_fs(void)
 out8:
 	unregister_pernet_subsys(&nfs_net_ops);
 out9:
+	nfs_sysfs_exit();
+out10:
 	return err;
 }
 
@@ -2260,6 +2267,7 @@ static void __exit exit_nfs_fs(void)
 	unregister_nfs_fs();
 	nfs_fs_proc_exit();
 	nfsiod_stop();
+	nfs_sysfs_exit();
 }
 
 /* Not quite true; I just maintain it */
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
new file mode 100644
index 000000000000..7070711ff6c5
--- /dev/null
+++ b/fs/nfs/sysfs.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Hammerspace Inc
+ */
+
+#include <linux/module.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/netdevice.h>
+
+#include "sysfs.h"
+
+struct kobject *nfs_client_kobj;
+static struct kset *nfs_client_kset;
+
+static void nfs_netns_object_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
+static const struct kobj_ns_type_operations *nfs_netns_object_child_ns_type(
+		struct kobject *kobj)
+{
+	return &net_ns_type_operations;
+}
+
+static struct kobj_type nfs_netns_object_type = {
+	.release = nfs_netns_object_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.child_ns_type = nfs_netns_object_child_ns_type,
+};
+
+static struct kobject *nfs_netns_object_alloc(const char *name,
+		struct kset *kset, struct kobject *parent)
+{
+	struct kobject *kobj;
+
+	kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
+	if (kobj) {
+		kobj->kset = kset;
+		if (kobject_init_and_add(kobj, &nfs_netns_object_type,
+					parent, "%s", name) == 0)
+			return kobj;
+		kobject_put(kobj);
+	}
+	return NULL;
+}
+
+int nfs_sysfs_init(void)
+{
+	nfs_client_kset = kset_create_and_add("nfs", NULL, fs_kobj);
+	if (!nfs_client_kset)
+		return -ENOMEM;
+	nfs_client_kobj = nfs_netns_object_alloc("net", nfs_client_kset, NULL);
+	if  (!nfs_client_kobj) {
+		kset_unregister(nfs_client_kset);
+		nfs_client_kset = NULL;
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+void nfs_sysfs_exit(void)
+{
+	kobject_put(nfs_client_kobj);
+	kset_unregister(nfs_client_kset);
+}
diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
new file mode 100644
index 000000000000..666f8db2ba92
--- /dev/null
+++ b/fs/nfs/sysfs.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Hammerspace Inc
+ */
+
+#ifndef __NFS_SYSFS_H
+#define __NFS_SYSFS_H
+
+
+extern struct kobject *nfs_client_kobj;
+
+extern int nfs_sysfs_init(void);
+extern void nfs_sysfs_exit(void);
+
+#endif
-- 
2.21.0

