Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5000A3E84EC
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 23:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhHJVGY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 17:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232739AbhHJVGY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Aug 2021 17:06:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AF1260E09
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 21:06:01 +0000 (UTC)
Subject: [PATCH v2 1/4] SUNRPC: Add a /sys/kernel/debug/fail_sunrpc/ directory
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 10 Aug 2021 17:06:01 -0400
Message-ID: <162862956133.263874.4169713012198608705.stgit@klimt.1015granger.net>
In-Reply-To: <162862940914.263874.10843184118571471892.stgit@klimt.1015granger.net>
References: <162862940914.263874.10843184118571471892.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This directory will contain a set of administrative controls for
enabling error injection for kernel RPC consumers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/debugfs.c |   23 +++++++++++++++++++++++
 net/sunrpc/fail.h    |   21 +++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 net/sunrpc/fail.h

diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 56029e3af6ff..dd9cf4cbda75 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -8,7 +8,9 @@
 #include <linux/debugfs.h>
 #include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/clnt.h>
+
 #include "netns.h"
+#include "fail.h"
 
 static struct dentry *topdir;
 static struct dentry *rpc_clnt_dir;
@@ -297,6 +299,25 @@ static const struct file_operations fault_disconnect_fops = {
 	.release	= fault_release,
 };
 
+
+#if IS_ENABLED(CONFIG_FAULT_INJECTION)
+struct fail_sunrpc_attr fail_sunrpc = {
+	.attr			= FAULT_ATTR_INITIALIZER,
+};
+
+#if IS_ENABLED(CONFIG_FAULT_INJECTION_DEBUG_FS)
+static void fail_sunrpc_init(void)
+{
+	fault_create_debugfs_attr("fail_sunrpc", NULL,
+				  &fail_sunrpc.attr);
+}
+#else
+static inline void fail_sunrpc_init(void)
+{
+}
+#endif
+#endif
+
 void __exit
 sunrpc_debugfs_exit(void)
 {
@@ -321,4 +342,6 @@ sunrpc_debugfs_init(void)
 
 	debugfs_create_file("disconnect", S_IFREG | 0400, rpc_fault_dir, NULL,
 			    &fault_disconnect_fops);
+
+	fail_sunrpc_init();
 }
diff --git a/net/sunrpc/fail.h b/net/sunrpc/fail.h
new file mode 100644
index 000000000000..1d402b0d3453
--- /dev/null
+++ b/net/sunrpc/fail.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021, Oracle. All rights reserved.
+ */
+
+#ifndef _NET_SUNRPC_FAIL_H_
+#define _NET_SUNRPC_FAIL_H_
+
+#include <linux/fault-inject.h>
+
+#if IS_ENABLED(CONFIG_FAULT_INJECTION)
+
+struct fail_sunrpc_attr {
+	struct fault_attr	attr;
+};
+
+extern struct fail_sunrpc_attr fail_sunrpc;
+
+#endif /* CONFIG_FAULT_INJECTION */
+
+#endif /* _NET_SUNRPC_FAIL_H_ */


