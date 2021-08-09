Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46C23E4BD9
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhHISJq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 14:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhHISJq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 9 Aug 2021 14:09:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80DFB60F02
        for <linux-nfs@vger.kernel.org>; Mon,  9 Aug 2021 18:09:25 +0000 (UTC)
Subject: [PATCH v1 1/4] SUNRPC: Add a /sys/kernel/debug/fail_sunrpc/ directory
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 09 Aug 2021 14:09:24 -0400
Message-ID: <162853256480.4752.1219884794743002339.stgit@klimt.1015granger.net>
In-Reply-To: <162853242223.4752.16344468003771993974.stgit@klimt.1015granger.net>
References: <162853242223.4752.16344468003771993974.stgit@klimt.1015granger.net>
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
 net/sunrpc/debugfs.c |   20 ++++++++++++++++++++
 net/sunrpc/fail.h    |   17 +++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 net/sunrpc/fail.h

diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 56029e3af6ff..7a9065b6a058 100644
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
@@ -297,6 +299,22 @@ static const struct file_operations fault_disconnect_fops = {
 	.release	= fault_release,
 };
 
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
+
 void __exit
 sunrpc_debugfs_exit(void)
 {
@@ -321,4 +339,6 @@ sunrpc_debugfs_init(void)
 
 	debugfs_create_file("disconnect", S_IFREG | 0400, rpc_fault_dir, NULL,
 			    &fault_disconnect_fops);
+
+	fail_sunrpc_init();
 }
diff --git a/net/sunrpc/fail.h b/net/sunrpc/fail.h
new file mode 100644
index 000000000000..96a46eff94e4
--- /dev/null
+++ b/net/sunrpc/fail.h
@@ -0,0 +1,17 @@
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
+struct fail_sunrpc_attr {
+	struct fault_attr	attr;
+};
+
+extern struct fail_sunrpc_attr fail_sunrpc;
+
+#endif /* _NET_SUNRPC_FAIL_H_ */


