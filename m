Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03B53768A7
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 18:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbhEGQ0X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 12:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbhEGQ0V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 12:26:21 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8A8C061761
        for <linux-nfs@vger.kernel.org>; Fri,  7 May 2021 09:25:21 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id b10so8450157iot.4
        for <linux-nfs@vger.kernel.org>; Fri, 07 May 2021 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gf/HTiMOF7lEE7p7o4BD7uDS+joARQgZSioVyNny/f4=;
        b=MHdIiu88lcIwWsjkF0plmkPVU7HCpCOghXtlpCzVzd+ItoPRC816DibOWn4shKNImd
         zW0rhCHj1h8UBqrv/mcSwKxu3rz06CR3x7TA88B4rQ5ye7m4euTYWqBXXq77hgLKAwkn
         zlSUVN4gB3G5O1XrGs4cTXFCMQdSKMH+Qy1OHBdVQBdrxmOITo91tttOlNSgJFoZDrp8
         pPE60Nh4utz3gplQXJoR1RXfmvz2bBaBOHASXdB1TYurpkXCgDqQIAywRUKJTAv00tGV
         2NzXowV2Q//tKLyb7HNvWZc0WVJ0hkt/3zNMhBEhaN9bosraqjAVU3+f+XB0oeHvpIr9
         8urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gf/HTiMOF7lEE7p7o4BD7uDS+joARQgZSioVyNny/f4=;
        b=DX+C3ACpiCC1NnMVi8yW8wezpdmmdtUo9mnRQCmukBkpsdXQRE6rPh+U2aJL+XrVNc
         pWC1ythTQQUnopNtnF7Svaskztnqbg0RRop8xA7TnWu+ZATCZQKCzQHTlcU8x8GYmqVZ
         LM9BLW5ovyFkRpiZHTPF6EnpIfvd32V5qsCaz/8heJ2Xurv5fJEVVn8wLActMm7xfZaZ
         D8IV0Op789w8OBHOOtGyxQmzynXjgqiXOvwFnAyk035VBPaU7Jp4hHC9+JQKBS2w8Hxf
         +2v1MDhVs9TYeR5BpZtY7bWMQm0ka+aCkjv4NRvh3lk7urCjzfP6YXCiOAmBHNRHpZkc
         gxAQ==
X-Gm-Message-State: AOAM5339VlV80Y1V/yvzr4NALPTNV4K7JR5cMUYz+TvopOHPBpTmZFH6
        /ZIt0HvPJdcutmHuUUFHato4MVoQ0P4Ggw==
X-Google-Smtp-Source: ABdhPJyYdaTrGzpL0SJ1ddGADgI1E0W3RWq+HgtYxVHJUXeP5UXW50xsUSJDWyh6GBnQ7RpfwFBgOw==
X-Received: by 2002:a05:6638:2157:: with SMTP id z23mr9563462jaj.35.1620404721144;
        Fri, 07 May 2021 09:25:21 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v2sm2451000ioe.22.2021.05.07.09.25.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 09:25:20 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 01/12] sunrpc: Create a sunrpc directory under /sys/kernel/
Date:   Fri,  7 May 2021 12:25:07 -0400
Message-Id: <20210507162518.51520-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
References: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
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

