Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3363398FC
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 22:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhCLVSx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 16:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbhCLVSa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 16:18:30 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65612C061761
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:30 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id s7so25842742qkg.4
        for <linux-nfs@vger.kernel.org>; Fri, 12 Mar 2021 13:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHEMWnG1httaOebjxzUSCMi4EC2eLwY/EEbXQn1DhtE=;
        b=VaLTxi4hY8L7b+nSzaLY3VWgQl5sp7Cgp73MASVuf0kC1YMXOVBVlA/IWphS3Xuj1E
         SzNAmBpIGQO4KBrlEXELH5MogSjhnMPSuCnOFceZDqStWwlmz6AsEGSePX9ULU4edZ+l
         v/VIX2s2BMGHG6ExMuThYgg4oHvT6BHrablQSOMvkRfpEQ1Jx3v6m7zoKvMmKmr7VPSE
         vLPI9rdHa1y0/bGvyrvYzTyODYUCU1+ONW1OjTVFZN3rphKO5+aC1mGGc7iqmT0fIeRj
         GRh+RDzm/XhVpJQbR76d4zmXI2xgFEuICtl+KOlqJ9x8QZLFW3SjSeX+53f+L1ZvuPbz
         PoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LHEMWnG1httaOebjxzUSCMi4EC2eLwY/EEbXQn1DhtE=;
        b=H6LPUSNJUCpqU4/Y+fryg/sh0OTwG6cmir/ocapMC0wgolAeVkt59qkJrsLm4YCKkq
         aIMQAmtNKUUmigRxt23ewHdZ46VnRjjhcR3usHyltke7Phvl4MeRO/yTkLuttUWBIq21
         HprT/YwKbbJSWdGFT3o6DHasfDsBZWZsBU8OGpgT2dWHKi3JF9sx4yuqYR/8TAO45PiM
         W734vNmITscEXBGFflN8YAzfFjzdlk12a+Rokrcc8W7dznrDEZP2ZR5RY0t5NEwoHvqy
         6R8Ro+FcrOhzWqBzlqG/YM9OM/Hgm2vj7KiZ3KgauLBqvD3VcIo5zlfkL3vL0K8dTs0T
         5d0A==
X-Gm-Message-State: AOAM531MPSbirSFGFxSnHuQsdUTJpLaRET/iACgnTTKYhsjj4odZnWDX
        9oNoS09L83QXBBUI7qnPqU34UZlWGBlvBQ==
X-Google-Smtp-Source: ABdhPJxZKpXAYHg+OdrMnyW8F/TN97edYCATUGCQu47aC4Go5pP8tye2t2Kpdz3qnEpv37UEp59/eA==
X-Received: by 2002:a05:620a:49a:: with SMTP id 26mr14536830qkr.436.1615583909408;
        Fri, 12 Mar 2021 13:18:29 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id d24sm5177490qko.54.2021.03.12.13.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:18:29 -0800 (PST)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v3 1/5] sunrpc: Create a sunrpc directory under /sys/kernel/
Date:   Fri, 12 Mar 2021 16:18:22 -0500
Message-Id: <20210312211826.360959-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
References: <20210312211826.360959-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This is where we'll put per-rpc_client related files

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v3: Rename kset object to rpc_sunrpc_kset
v2: Move directory from /sys/net/sunrpc/ to /sys/kernel/sunrpc/
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
index 000000000000..c9d9918e87ee
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
+extern int rpc_sysfs_init(void);
+extern void rpc_sysfs_exit(void);
+
+#endif
-- 
2.29.2

