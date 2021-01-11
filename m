Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105622F2200
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jan 2021 22:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbhAKVm2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jan 2021 16:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730855AbhAKVm2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jan 2021 16:42:28 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C118C061795
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:48 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id v3so762648ilo.5
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jan 2021 13:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lej7piHj5hXHvzk8ywmlnNvWesLKcT/8mF40IGDVQGw=;
        b=LluffieLEamzcLFTNlXgc8Kf9PyM6E4Vz6u2cr5eJpnLqFmb7TC90/U0b+GZS9KffI
         gdfcSaseymTHorfoJRvFJA13VgeBQlOTzu9+VR3zRVOaSSv70LxHQWh7ejeXnnnv/ass
         b4GVauedtOFiHkGpa5jbXf/h+3DeP9UW69c1UwFrCS6FsDVOb5Qf6Q+JeTdglXxEJ6aI
         nfWzKfNxWUq/XRJIIOTAXryCIjsETgbqkDjaSlca3nHIHT53BWFtP/BBpiAveU1fbH/c
         V16REblqP/IJKHZItYnlmlEp52sD2mu6eA6rPu/8BH4pgkRTslZwWQAPFWFHdm2fD0eZ
         v/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Lej7piHj5hXHvzk8ywmlnNvWesLKcT/8mF40IGDVQGw=;
        b=ggC3b+mZrND+u397mgQW2ss1oOcV3oygTJaEfmM4e/BI9fA9axInoNnNMTfT7WxmDT
         /qns0l7mCrFfOqt5rCNkwe5aCnO+0yxOQVSpZhFTCx2nqC+Mo5zFi7C67FqedDWcpUIU
         oZdhceZ1iUgtucJKOc+EKQVr9JrEPCoxRWuQw6D58Xe4QuHzPDFzEsaDwqHpllwHFDp5
         Sehry56dvUWm181xX7Lo1Wcvu+3b7elray8EHkWtTCud7CGfFpiU0TZnQORxmzCGUJGD
         E3atuEkSPHxIuU13pPZhmRjQkEqCBxJU8otnKX9L1qhYd/ye3YH0tqkH3ya11fA/EAtZ
         YakQ==
X-Gm-Message-State: AOAM531+Ae3AY160Btmh7BUvMgiV7+7tIZdgZ6CneCF0N27r1InnSQCa
        6qgLyp1cHB8y/E6Us1J4s9ZBlPnb1J8ydg==
X-Google-Smtp-Source: ABdhPJzYI0azdm6fCDyy4/LEh99U9tCTR/Mpl/CbIhXvJCBwlECogvhCDgVjTVTBgMaaiUkePnKg9Q==
X-Received: by 2002:a92:c692:: with SMTP id o18mr1069009ilg.215.1610401307194;
        Mon, 11 Jan 2021 13:41:47 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id 143sm681712ila.4.2021.01.11.13.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:41:46 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [RFC PATCH 2/7] sunrpc: Create a sunrpc directory under /sys/net/
Date:   Mon, 11 Jan 2021 16:41:38 -0500
Message-Id: <20210111214143.553479-3-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
References: <20210111214143.553479-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This is where we'll put per-rpc_client related files

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/Makefile      |  2 +-
 net/sunrpc/sunrpc_syms.c |  8 ++++++++
 net/sunrpc/sysfs.c       | 21 +++++++++++++++++++++
 net/sunrpc/sysfs.h       | 13 +++++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)
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
index 000000000000..efff6977095c
--- /dev/null
+++ b/net/sunrpc/sysfs.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Anna Schumaker <Anna.Schumaker@Netapp.com>
+ */
+#include <net/sock.h>
+
+//struct kobject *rpc_client_kobj;
+static struct kset *rpc_client_kset;
+
+int rpc_sysfs_init(void)
+{
+	rpc_client_kset = kset_create_and_add("sunrpc", NULL, net_kobj);
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

