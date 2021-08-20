Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B95D3F2E6D
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Aug 2021 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbhHTOyd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Aug 2021 10:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240879AbhHTOyc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Aug 2021 10:54:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCF086112E
        for <linux-nfs@vger.kernel.org>; Fri, 20 Aug 2021 14:53:54 +0000 (UTC)
Subject: [PATCH v3 1/4] SUNRPC: Add a /sys/kernel/debug/fail_sunrpc/ directory
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Aug 2021 10:53:54 -0400
Message-ID: <162947123406.3311.1077573575613457304.stgit@klimt.1015granger.net>
In-Reply-To: <162947112222.3311.9483898011770198455.stgit@klimt.1015granger.net>
References: <162947112222.3311.9483898011770198455.stgit@klimt.1015granger.net>
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
 lib/Kconfig.debug    |    7 +++++++
 net/sunrpc/debugfs.c |   14 ++++++++++++++
 net/sunrpc/fail.h    |   21 +++++++++++++++++++++
 3 files changed, 42 insertions(+)
 create mode 100644 net/sunrpc/fail.h

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ddd575159fb..cd78bb0a7dd9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1971,6 +1971,13 @@ config FAIL_MMC_REQUEST
 	  and to test how the mmc host driver handles retries from
 	  the block device.
 
+config FAIL_SUNRPC
+	bool "Fault-injection capability for SunRPC"
+	depends on FAULT_INJECTION_DEBUG_FS && SUNRPC_DEBUG
+	help
+	  Provide fault-injection capability for SunRPC and
+	  its consumers.
+
 config FAULT_INJECTION_STACKTRACE_FILTER
 	bool "stacktrace filter for fault-injection capabilities"
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 56029e3af6ff..eaeb51f83abd 100644
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
@@ -297,6 +299,13 @@ static const struct file_operations fault_disconnect_fops = {
 	.release	= fault_release,
 };
 
+#if IS_ENABLED(CONFIG_FAIL_SUNRPC)
+struct fail_sunrpc_attr fail_sunrpc = {
+	.attr			= FAULT_ATTR_INITIALIZER,
+};
+EXPORT_SYMBOL_GPL(fail_sunrpc);
+#endif
+
 void __exit
 sunrpc_debugfs_exit(void)
 {
@@ -321,4 +330,9 @@ sunrpc_debugfs_init(void)
 
 	debugfs_create_file("disconnect", S_IFREG | 0400, rpc_fault_dir, NULL,
 			    &fault_disconnect_fops);
+
+#if IS_ENABLED(CONFIG_FAIL_SUNRPC)
+	fault_create_debugfs_attr("fail_sunrpc", NULL,
+				  &fail_sunrpc.attr);
+#endif
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


