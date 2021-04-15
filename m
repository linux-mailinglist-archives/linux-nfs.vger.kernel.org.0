Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C175C35FFFD
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhDOC23 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDOC23 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A52C061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:07 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p8so1331083iol.11
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9ug9QkihPteu4k4ujdR3vfO9jchp59V55TcHSq8jHs=;
        b=PlDtObg52KAjmy8k0ddoefVBpw1ytrIo0h3hCATqCm9Qco05fuQO4BU/Ag4M8PrnIX
         ovsA6a1WrqXYGK/hxjxGaLUVIiH8scN33oSOIdzlZaEJO2Tj80QQPW7jgBBcqSkfN+hh
         ZUwpplXOGWlwdaVA/eR0EQVhIqCSLZu9WPn9oMQdujdL4DlYlQNkunqPkiJxFc7vjrba
         yoXyrY/XdtNyia7ZJmLBMgm1BEyYXGYtzXXjHLTgpFz6WuQFmTbGWmO8kSAFMBsZcj2q
         ZkciFz6tu1SZe35GWOOCH87QFdlzmZKMuZn+XdaOzmdB70ssEnN5PD6+S+VZM3H3ux4W
         JwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9ug9QkihPteu4k4ujdR3vfO9jchp59V55TcHSq8jHs=;
        b=HrtAbq1/zKkubEqryeKhq7OojRoclWIEBNTaG3wm9SHK7ilV1VJzJD1mfiD88/Ymos
         7edD8r3ymd3Fc7x6JLrQ4oYPEU0oLDJaktDpLfB2WhPgHnj7/yYVC7spN6RVmYX1HgHw
         0Bnkl9Wrg1jiEkFmWYIJZA1t1MraimDEYrJX3fmC/qjXtjSfV4d8HJKecQFZpr+KPyI8
         sIqTik+J7sT3dCgXEeEKjiX7e1VwbUCwX9UjyB50rQJRXlbV6F5kKOO/hu+wyibFArh1
         DcBHiE8tO7MsdSECJTk32AECM6g0j9d2Lk2n4jP2LFT9ZbgHQN9LBvX1rAEWMuJrQaBO
         urmg==
X-Gm-Message-State: AOAM532s/aFXX9e3t/JOLUSmC/SAlHC6WOoNdge0lSPcCTGASeOianDM
        r8a1vZ1mMZTkYP3/3nPyMp4=
X-Google-Smtp-Source: ABdhPJwo/T+yMlnDQfOUysqaSAbBiaybDuPFcgGD94VFZ+4clVX2Q9BidoGk/LX8LOQI9GFXQqlqUg==
X-Received: by 2002:a6b:d309:: with SMTP id s9mr843201iob.186.1618453686674;
        Wed, 14 Apr 2021 19:28:06 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:06 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/13] sunrpc: Create a sunrpc directory under /sys/kernel/
Date:   Wed, 14 Apr 2021 22:27:50 -0400
Message-Id: <20210415022802.31692-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
References: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

This is where we'll put per-rpc_client related files

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
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

