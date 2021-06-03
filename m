Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF8439ADDF
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFCWWn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhFCWWm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:22:42 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33793C06174A
        for <linux-nfs@vger.kernel.org>; Thu,  3 Jun 2021 15:20:44 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a7so4017593qvf.11
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gf/HTiMOF7lEE7p7o4BD7uDS+joARQgZSioVyNny/f4=;
        b=COjRuPPXhdYUnSm2RayYkjGQzw1ziNvJDco9wfAUFCZFfxOJkNsqqtunxaOJjfmVtt
         3vHLNIIC7VQ2YivZWX4iV3MAQ1Rw1C3HZtYQW2baICi06gMRN2EqyV3COR/CHdKgV94J
         ftaMmoMl20VYKYvBRthrRrYu30ueUQv18ckRd6rb0QPf0S72sjbkfxia/eyK3h3PXqJj
         A6MnkfQ/BWtTSVmOXp6AEmCYvkrytRs/kSGEhRdrcvquCjUDQ6VhqLksYqq2tLOTbnVK
         r20MiA9lcpqQkmy6PdzFnjCwd78O7o1Fu+JbmSvVFFu4XR7YUiyB1y2kCzak4VeI63QW
         ODjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gf/HTiMOF7lEE7p7o4BD7uDS+joARQgZSioVyNny/f4=;
        b=TnRLzYrSJQIS9YkV4d2IXcTqDG671lt9E/PssGrQiooHvUnuoO3pvHLksQo0XcCWoL
         96RJrwFRLlhSqhyVch2Al9Bf56dieRi+zRTAcvrIUCfBMVvN8Vgagn/XTEEhFrrEva9x
         v/kQyt36YsJZb6WUlSINdf3yGtBhvFFFXQBKSF/TqR1yBfK87kWwGTnjiUDahMmxtAuO
         8gni//achdYxK3f4vVb2JrFMz+dLVuLxlWsjaD5K3kWgIylQcfC+4gXiB3k/cqCMjH5r
         ZxojUUJ2EwJNd8IssnB9Xrc604yG2DlF/8B9Ft28hcM8hBEkF4mIuYzNM+/dKPKK6we4
         1oKw==
X-Gm-Message-State: AOAM5313ynnO1BIrtvNTCu2qjNqnzHw0iVXZ/R2AWFFmG7MU+9z+aEdM
        pUQySLXn4VS0fvMLHWpo4N07yGeRoMM=
X-Google-Smtp-Source: ABdhPJzTkFXK0N9emTrrDL80UrCNczga5rU5dzLMNNVPoV40W+kv5E/fYJBha0qwIWhgMPv1RKcyJA==
X-Received: by 2002:ad4:4783:: with SMTP id z3mr1551061qvy.43.1622758843297;
        Thu, 03 Jun 2021 15:20:43 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:42 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 01/13] sunrpc: Create a sunrpc directory under /sys/kernel/
Date:   Thu,  3 Jun 2021 18:20:27 -0400
Message-Id: <20210603222039.19182-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This is where we'll put per-rpc_client related files

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 net/sunrpc/Makefile      |  2 +-
 net/sunrpc/sunrpc_syms.c |  8 ++++++++
 net/sunrpc/sysfs.c       | 20 ++++++++++++++++++++
 net/sunrpc/sysfs.h       | 11 +++++++++++
 4 files changed, 40 insertions(+), 1 deletion(-)
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
index 000000000000..27eda180ac5e
--- /dev/null
+++ b/net/sunrpc/sysfs.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Anna Schumaker <Anna.Schumaker@Netapp.com>
+ */
+#include <linux/kobject.h>
+
+static struct kset *rpc_sunrpc_kset;
+
+int rpc_sysfs_init(void)
+{
+	rpc_sunrpc_kset = kset_create_and_add("sunrpc", NULL, kernel_kobj);
+	if (!rpc_sunrpc_kset)
+		return -ENOMEM;
+	return 0;
+}
+
+void rpc_sysfs_exit(void)
+{
+	kset_unregister(rpc_sunrpc_kset);
+}
diff --git a/net/sunrpc/sysfs.h b/net/sunrpc/sysfs.h
new file mode 100644
index 000000000000..f181c650aab8
--- /dev/null
+++ b/net/sunrpc/sysfs.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Anna Schumaker <Anna.Schumaker@Netapp.com>
+ */
+#ifndef __SUNRPC_SYSFS_H
+#define __SUNRPC_SYSFS_H
+
+int rpc_sysfs_init(void);
+void rpc_sysfs_exit(void);
+
+#endif
-- 
2.27.0

