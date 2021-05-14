Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03686380B3D
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhENOOj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhENOOj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:14:39 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF339C061574
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id v13so25897100ilj.8
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gf/HTiMOF7lEE7p7o4BD7uDS+joARQgZSioVyNny/f4=;
        b=ODIe/E08mChICex+pBnkZtwBB9rHZnDABI3pl/SS+pbAzpIPevnv9oXuG97ATEOPMR
         RYhvyRyb4b3pA+kGSgHwU74ksltfYnS8azl4Zi3bFkTo7eg18HYXsUVJDApFFdmZ2jKt
         Ec99xPANxjLaNAl85L0mq1SrVi4D4d2G/0+UjaM4AR6afBSVVeeK7CF9AwtZ8yNo+02I
         x3O6ZqIFi8ctSY8Msu3SO4svA+vPPF/jYwcsZoxM9o5qnZvekp1qkm6o7QsXS3g6bA8Q
         slvRTQ3Ji3SFvMPTBYcxsHY+EgSmnZSDiweo/Kuf6CCDsT5pTFxRazy3q5YK5K0BkgPV
         AYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gf/HTiMOF7lEE7p7o4BD7uDS+joARQgZSioVyNny/f4=;
        b=hCvLwqWmstqnaWdNObSVXN6ulZ9f4M0OZA3JMVrTOmt9Cgb9vafPn2XmCq74DwYRIb
         yxecOnq4ruZfd4wkH1tJj8Wwuu4ZO2jXfqcqdClvoA1vhFzw0xCPZJsdRDEtM1yhqmDv
         IOyVkNfYihItb6KuNLijTscL8TfnX4SE6YCC+dsEUXywkHxNGX2YGFwquLaT/HRcD+Ke
         MDgb0Dp32cDJeRQz4tgLLSH4D4w8oNnPYYSZ/subxOgemm7ccskrOVvNAlDb2UrNxNdH
         ONbRtyQRjokhxy5gps3Ss8RUMzIG862VYW2gtc9cjf3lB/AGbv6qbWUR7wk5JYawqJZp
         aovg==
X-Gm-Message-State: AOAM531HmKcSPfswDClFXKnDA0rZ5MjZ4RW5/WZ+Ev6dz73n9RyRyzEq
        2o7rySpDgA/TtAPfe7k1Hy+tsY+Vw/GzPQ==
X-Google-Smtp-Source: ABdhPJzvf1YZ5F8aJkVOWLmmy1z2aPEyx4bp0pUKslVG7UPgUF/MFeWvClpwtltLF68a53VTtU2AIA==
X-Received: by 2002:a05:6e02:b2c:: with SMTP id e12mr24288484ilu.136.1621001607205;
        Fri, 14 May 2021 07:13:27 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a4f7:32c8:9c05:11a7])
        by smtp.gmail.com with ESMTPSA id b189sm2639263iof.48.2021.05.14.07.13.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 07:13:26 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 01/12] sunrpc: Create a sunrpc directory under /sys/kernel/
Date:   Fri, 14 May 2021 10:13:12 -0400
Message-Id: <20210514141323.67922-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
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

