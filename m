Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA963F2E6E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Aug 2021 16:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbhHTOyj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Aug 2021 10:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240879AbhHTOyi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Aug 2021 10:54:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B56A961102
        for <linux-nfs@vger.kernel.org>; Fri, 20 Aug 2021 14:54:00 +0000 (UTC)
Subject: [PATCH v3 2/4] SUNRPC: Move client-side disconnect injection
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Aug 2021 10:54:00 -0400
Message-ID: <162947124002.3311.9633502522004431134.stgit@klimt.1015granger.net>
In-Reply-To: <162947112222.3311.9483898011770198455.stgit@klimt.1015granger.net>
References: <162947112222.3311.9483898011770198455.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Disconnect injection stress-tests the ability for both client and
server implementations to behave resiliently in the face of network
instability.

Convert the existing client-side disconnect injection infrastructure
to use the kernel's generic error injection facility. The generic
facility has a richer set of injection criteria.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xprt.h |   18 ----------
 net/sunrpc/debugfs.c        |   78 ++++++++-----------------------------------
 net/sunrpc/fail.h           |    2 +
 net/sunrpc/xprt.c           |   14 ++++++++
 4 files changed, 30 insertions(+), 82 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index c8c39f22d3b1..b15c1f07162d 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -288,7 +288,6 @@ struct rpc_xprt {
 	const char		*address_strings[RPC_DISPLAY_MAX];
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	struct dentry		*debugfs;		/* debugfs directory */
-	atomic_t		inject_disconnect;
 #endif
 	struct rcu_head		rcu;
 	const struct xprt_class	*xprt_class;
@@ -502,21 +501,4 @@ static inline int xprt_test_and_set_binding(struct rpc_xprt *xprt)
 	return test_and_set_bit(XPRT_BINDING, &xprt->state);
 }
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-extern unsigned int rpc_inject_disconnect;
-static inline void xprt_inject_disconnect(struct rpc_xprt *xprt)
-{
-	if (!rpc_inject_disconnect)
-		return;
-	if (atomic_dec_return(&xprt->inject_disconnect))
-		return;
-	atomic_set(&xprt->inject_disconnect, rpc_inject_disconnect);
-	xprt->ops->inject_disconnect(xprt);
-}
-#else
-static inline void xprt_inject_disconnect(struct rpc_xprt *xprt)
-{
-}
-#endif
-
 #endif /* _LINUX_SUNRPC_XPRT_H */
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index eaeb51f83abd..04e453ad3508 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -16,8 +16,6 @@ static struct dentry *topdir;
 static struct dentry *rpc_clnt_dir;
 static struct dentry *rpc_xprt_dir;
 
-unsigned int rpc_inject_disconnect;
-
 static int
 tasks_show(struct seq_file *f, void *v)
 {
@@ -237,8 +235,6 @@ rpc_xprt_debugfs_register(struct rpc_xprt *xprt)
 	/* make tasks file */
 	debugfs_create_file("info", S_IFREG | 0400, xprt->debugfs, xprt,
 			    &xprt_info_fops);
-
-	atomic_set(&xprt->inject_disconnect, rpc_inject_disconnect);
 }
 
 void
@@ -248,62 +244,26 @@ rpc_xprt_debugfs_unregister(struct rpc_xprt *xprt)
 	xprt->debugfs = NULL;
 }
 
-static int
-fault_open(struct inode *inode, struct file *filp)
-{
-	filp->private_data = kmalloc(128, GFP_KERNEL);
-	if (!filp->private_data)
-		return -ENOMEM;
-	return 0;
-}
+#if IS_ENABLED(CONFIG_FAIL_SUNRPC)
+struct fail_sunrpc_attr fail_sunrpc = {
+	.attr			= FAULT_ATTR_INITIALIZER,
+};
+EXPORT_SYMBOL_GPL(fail_sunrpc);
 
-static int
-fault_release(struct inode *inode, struct file *filp)
+static void fail_sunrpc_init(void)
 {
-	kfree(filp->private_data);
-	return 0;
-}
+	struct dentry *dir;
 
-static ssize_t
-fault_disconnect_read(struct file *filp, char __user *user_buf,
-		      size_t len, loff_t *offset)
-{
-	char *buffer = (char *)filp->private_data;
-	size_t size;
+	dir = fault_create_debugfs_attr("fail_sunrpc", NULL,
+					&fail_sunrpc.attr);
 
-	size = sprintf(buffer, "%u\n", rpc_inject_disconnect);
-	return simple_read_from_buffer(user_buf, len, offset, buffer, size);
+	debugfs_create_bool("ignore-client-disconnect", S_IFREG | 0600, dir,
+			    &fail_sunrpc.ignore_client_disconnect);
 }
-
-static ssize_t
-fault_disconnect_write(struct file *filp, const char __user *user_buf,
-		       size_t len, loff_t *offset)
+#else
+static void fail_sunrpc_init(void)
 {
-	char buffer[16];
-
-	if (len >= sizeof(buffer))
-		len = sizeof(buffer) - 1;
-	if (copy_from_user(buffer, user_buf, len))
-		return -EFAULT;
-	buffer[len] = '\0';
-	if (kstrtouint(buffer, 10, &rpc_inject_disconnect))
-		return -EINVAL;
-	return len;
 }
-
-static const struct file_operations fault_disconnect_fops = {
-	.owner		= THIS_MODULE,
-	.open		= fault_open,
-	.read		= fault_disconnect_read,
-	.write		= fault_disconnect_write,
-	.release	= fault_release,
-};
-
-#if IS_ENABLED(CONFIG_FAIL_SUNRPC)
-struct fail_sunrpc_attr fail_sunrpc = {
-	.attr			= FAULT_ATTR_INITIALIZER,
-};
-EXPORT_SYMBOL_GPL(fail_sunrpc);
 #endif
 
 void __exit
@@ -318,21 +278,11 @@ sunrpc_debugfs_exit(void)
 void __init
 sunrpc_debugfs_init(void)
 {
-	struct dentry *rpc_fault_dir;
-
 	topdir = debugfs_create_dir("sunrpc", NULL);
 
 	rpc_clnt_dir = debugfs_create_dir("rpc_clnt", topdir);
 
 	rpc_xprt_dir = debugfs_create_dir("rpc_xprt", topdir);
 
-	rpc_fault_dir = debugfs_create_dir("inject_fault", topdir);
-
-	debugfs_create_file("disconnect", S_IFREG | 0400, rpc_fault_dir, NULL,
-			    &fault_disconnect_fops);
-
-#if IS_ENABLED(CONFIG_FAIL_SUNRPC)
-	fault_create_debugfs_attr("fail_sunrpc", NULL,
-				  &fail_sunrpc.attr);
-#endif
+	fail_sunrpc_init();
 }
diff --git a/net/sunrpc/fail.h b/net/sunrpc/fail.h
index 1d402b0d3453..62c1b9fd59e2 100644
--- a/net/sunrpc/fail.h
+++ b/net/sunrpc/fail.h
@@ -12,6 +12,8 @@
 
 struct fail_sunrpc_attr {
 	struct fault_attr	attr;
+
+	bool			ignore_client_disconnect;
 };
 
 extern struct fail_sunrpc_attr fail_sunrpc;
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index fb6db09725c7..05abe344a269 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -56,6 +56,7 @@
 
 #include "sunrpc.h"
 #include "sysfs.h"
+#include "fail.h"
 
 /*
  * Local variables
@@ -855,6 +856,19 @@ xprt_init_autodisconnect(struct timer_list *t)
 	queue_work(xprtiod_workqueue, &xprt->task_cleanup);
 }
 
+#if IS_ENABLED(CONFIG_FAIL_SUNRPC)
+static void xprt_inject_disconnect(struct rpc_xprt *xprt)
+{
+	if (!fail_sunrpc.ignore_client_disconnect &&
+	    should_fail(&fail_sunrpc.attr, 1))
+		xprt->ops->inject_disconnect(xprt);
+}
+#else
+static inline void xprt_inject_disconnect(struct rpc_xprt *xprt)
+{
+}
+#endif
+
 bool xprt_lock_connect(struct rpc_xprt *xprt,
 		struct rpc_task *task,
 		void *cookie)


