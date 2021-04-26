Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD3A36B7FA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Apr 2021 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbhDZRUv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Apr 2021 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbhDZRUk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Apr 2021 13:20:40 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF23C06138C
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:53 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id p15so11500219iln.3
        for <linux-nfs@vger.kernel.org>; Mon, 26 Apr 2021 10:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gf/HTiMOF7lEE7p7o4BD7uDS+joARQgZSioVyNny/f4=;
        b=g4kLWKC7MuOmJ40y5LRQbWL8lbJEhYprWTjsmMpe6gqP3TeGlp3wtfwGviNWDSjGK5
         XpO3IEaS+wu58mKIUd5jXkty8NXfBZVHgJmF4Y3+/4uBnvNH3MMjj3mhQPKsBPo/j24F
         zsOtyuEfmxlKOASkRNcVJwNHkQnvVhriURINH1BLmPCePtAMssg815unwPyw371e1SCe
         HzQTY8MdfCjWm3i9eDWmdsfw7TkLm5zVAGuG3GrVCDwkbl4TyP80nOnMvYhKFEQQLbZb
         HVQCExuFCX0DAqbcRY6WE52UsFSvn98GtomjdOfoqMbjdvLyjNeAst+qUaiqaKwYatXy
         r7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gf/HTiMOF7lEE7p7o4BD7uDS+joARQgZSioVyNny/f4=;
        b=DbyKYfvyoQdn8ygqSFZZRvT1CFwftul3yjIA7X8pZ2yJjjyt1/UlnqislXUTUcQUhk
         ONyPbCX7AzqUH2/LkZcDDYX9NqQ8ilX63LPpOaAynYu5rN/nJLFZtK5bmFcckB5UsiB4
         ThkAY6WCOqC/5WuZ5lLrp2m3tOGvVoHNLDnYmZ9Yw2Dyq22d8LoapaWxniNDoT42J9fy
         47YybquqvG6hMLYyTyrbiS6oo++FYXaS8/SvsKohJiUiy4j1wO/emj9E1GcchL/nd2/7
         78kYGZApsQQl+NEmE8BWmctaXhkWbzXd6DL2QnyMYfy0YvyAS4SFi6KyLSmpMYdRu44M
         PKkw==
X-Gm-Message-State: AOAM532r69v5bK+zmQyh+iSQYu5jBY6noIFHBllcjxQjUe7i9M0htGay
        ycclFfIbCMgNZQDTgwvLoWY=
X-Google-Smtp-Source: ABdhPJw3zqt8qsx1g8EaCBwm2X4X/iHfDrU7PABQ8vrDst9OmEPrKpkWiWcnShZ5nITB1qJFN5SRZg==
X-Received: by 2002:a92:d688:: with SMTP id p8mr14620171iln.268.1619457591132;
        Mon, 26 Apr 2021 10:19:51 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id x13sm207297ilq.85.2021.04.26.10.19.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:19:50 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 01/13] sunrpc: Create a sunrpc directory under /sys/kernel/
Date:   Mon, 26 Apr 2021 13:19:35 -0400
Message-Id: <20210426171947.99233-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
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

