Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD97A30CA51
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 19:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbhBBSo6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 13:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbhBBSn3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 13:43:29 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA541C061788
        for <linux-nfs@vger.kernel.org>; Tue,  2 Feb 2021 10:42:48 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id r20so12132670qtm.3
        for <linux-nfs@vger.kernel.org>; Tue, 02 Feb 2021 10:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQawKngObyoorCuyVqhiiQ0rHFSjPC2r0xk/zqMkP9U=;
        b=XZbs40kqCynL+FUvW4arogKxhjUU9ML/It0ttCXGHqr9i/6cfG3Aug/c7yO2FGkxQB
         yoH5PLjm8BibZKNxETVaElp5b84qPVlsgirUSdfGJCY3Lymao5s0efdY+UKcZD284DlH
         3a+QPon+W4iSqmcBbeM6BYaDU+IfBlgBBbqTlcxi1JaZwKUrX+nON9q5bvD3jJZ1E72S
         Q/xBJyAudp6CfORFYOwRusr3Gum7AEfCuMP7TWsrCvm3c1Mh/vnbJbm/oqv6J06COFKq
         JVHFjvV2kVFfgAuWhjO3YlnCJtVim1zWtcfPVO/T3PsHOkOwBarD6iC+q7iX81OLYkpg
         YBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oQawKngObyoorCuyVqhiiQ0rHFSjPC2r0xk/zqMkP9U=;
        b=q9cwDbkwfBCvtpFu/6wIqW0Mv49LTfgUsu3gln6XQ08QnzSlBl0M5Tqi6VKeAu4Bxh
         7Ol86uTTpvEhe35RaXPufVRQ6QVmTHO6EB3EiJqoHaFLDbfCu4ddfVo+PuqpZ3zucau+
         tq2YyP8IhjH2LyGN5LaujDFiPs23sc9pdoVl3cG/5BjhNm1j7d8PKIGkJUxjhWRCMsE7
         e0olM6DOHOwwvQTyYpJoKuWJNK1uIgkIA4MIwy56NQiqs8jKn26VFsPxzuWCW0Sxs+Bp
         xNxEE0jdoEc8Wf6z7GE03pYgMdMXlPP+VrZrRVx3FkqAqzPQa/ZqJbkGWPSJOdDHedDT
         x6sA==
X-Gm-Message-State: AOAM533CnX0wcwKslpnWLohuOMZik3rhdu36eYEwNuXocn3q9a/b4lIO
        x6ibOiQh7CpZikLHEg9In3wkxQ+/s7V39g==
X-Google-Smtp-Source: ABdhPJyF7iLCR57e5wPDuyTuDo4KNTU+qC23zRVfR5Hae8ItNM5MeUNCWRTQJsss6Z4N3JAc2RGJsw==
X-Received: by 2002:aed:3484:: with SMTP id x4mr20166047qtd.283.1612291367801;
        Tue, 02 Feb 2021 10:42:47 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id k4sm7415906qtq.13.2021.02.02.10.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:42:47 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 1/5] sunrpc: Create a sunrpc directory under /sys/kernel/
Date:   Tue,  2 Feb 2021 13:42:40 -0500
Message-Id: <20210202184244.288898-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This is where we'll put per-rpc_client related files

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v2: Move directory from /sys/net/sunrpc/ to /sys/kernel/sunrpc/
---
 net/sunrpc/Makefile      |  2 +-
 net/sunrpc/sunrpc_syms.c |  8 ++++++++
 net/sunrpc/sysfs.c       | 20 ++++++++++++++++++++
 net/sunrpc/sysfs.h       | 13 +++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 net/sunrpc/sysfs.c
 create mode 100644 net/sunrpc/sysfs.h

diff --git a/net/sunrpc/Makefile b/net/sunrpc/Makefile
index 9488600451e8..1c8de397d6ad 100644
--- a/net/sunrpc/Makefile
+++ b/net/sunrpc/Makefile
@@ -12,7 +12,7 @@ sunrpc-y := clnt.o xprt.o socklib.o xprtsock.o sched.o \
 	    auth.o auth_null.o auth_unix.o \
 	    svc.o svcsock.o svcauth.o svcauth_unix.o \
 	    addr.o rpcb_clnt.o timer.o xdr.o \
-	    sunrpc_syms.o cache.o rpc_pipe.o \
+	    sunrpc_syms.o cache.o rpc_pipe.o sysfs.o \
 	    svc_xprt.o \
 	    xprtmultipath.o
 sunrpc-$(CONFIG_SUNRPC_DEBUG) += debugfs.o
diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
index 236fadc4a439..3b57efc692ec 100644
--- a/net/sunrpc/sunrpc_syms.c
+++ b/net/sunrpc/sunrpc_syms.c
@@ -24,6 +24,7 @@
 #include <linux/sunrpc/xprtsock.h>
 
 #include "sunrpc.h"
+#include "sysfs.h"
 #include "netns.h"
 
 unsigned int sunrpc_net_id;
@@ -103,6 +104,10 @@ init_sunrpc(void)
 	if (err)
 		goto out4;
 
+	err = rpc_sysfs_init();
+	if (err)
+		goto out5;
+
 	sunrpc_debugfs_init();
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	rpc_register_sysctl();
@@ -111,6 +116,8 @@ init_sunrpc(void)
 	init_socket_xprt();	/* clnt sock transport */
 	return 0;
 
+out5:
+	unregister_rpc_pipefs();
 out4:
 	unregister_pernet_subsys(&sunrpc_net_ops);
 out3:
@@ -124,6 +131,7 @@ init_sunrpc(void)
 static void __exit
 cleanup_sunrpc(void)
 {
+	rpc_sysfs_exit();
 	rpc_cleanup_clids();
 	rpcauth_remove_module();
 	cleanup_socket_xprt();
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
new file mode 100644
index 000000000000..fbb8db50eb29
--- /dev/null
+++ b/net/sunrpc/sysfs.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Anna Schumaker <Anna.Schumaker@Netapp.com>
+ */
+#include <linux/kobject.h>
+
+static struct kset *rpc_client_kset;
+
+int rpc_sysfs_init(void)
+{
+	rpc_client_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
+	if (!rpc_client_kset)
+		return -ENOMEM;
+	return 0;
+}
+
+void rpc_sysfs_exit(void)
+{
+	kset_unregister(rpc_client_kset);
+}
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
new file mode 100644
index 000000000000..93c3cd220506
--- /dev/null
+++ b/net/sunrpc/sysfs.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Anna Schumaker <Anna.Schumaker@Netapp.com>
+ */
+#ifndef __SUNRPC_SYSFS_H
+#define __SUNRPC_SYSFS_H
+
+extern struct kobject *rpc_client_kobj;
+
+extern int rpc_sysfs_init(void);
+extern void rpc_sysfs_exit(void);
+
+#endif
-- 
2.29.2

