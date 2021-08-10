Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683443E84ED
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 23:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhHJVGa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 17:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232739AbhHJVGa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Aug 2021 17:06:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00CD060E97
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 21:06:07 +0000 (UTC)
Subject: [PATCH v2 2/4] SUNRPC: Server-side disconnect injection
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 10 Aug 2021 17:06:07 -0400
Message-ID: <162862956729.263874.11399561287903358774.stgit@klimt.1015granger.net>
In-Reply-To: <162862940914.263874.10843184118571471892.stgit@klimt.1015granger.net>
References: <162862940914.263874.10843184118571471892.stgit@klimt.1015granger.net>
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

A file called /sys/kernel/debug/fail_sunrpc/ignore-server-disconnect
enables administrators to turn off server-side disconnect injection
while allowing other types of sunrpc errors to be injected. So far
there are no others. The default setting is that server-side
disconnect injection is enabled (ignore=false).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/debugfs.c |    9 +++++++--
 net/sunrpc/fail.h    |    2 ++
 net/sunrpc/svc.c     |    8 ++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index dd9cf4cbda75..cdc6f0ded5ca 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -308,8 +308,13 @@ struct fail_sunrpc_attr fail_sunrpc = {
 #if IS_ENABLED(CONFIG_FAULT_INJECTION_DEBUG_FS)
 static void fail_sunrpc_init(void)
 {
-	fault_create_debugfs_attr("fail_sunrpc", NULL,
-				  &fail_sunrpc.attr);
+	struct dentry *dir;
+
+	dir = fault_create_debugfs_attr("fail_sunrpc", NULL,
+					&fail_sunrpc.attr);
+
+	debugfs_create_bool("ignore-server-disconnect", S_IFREG | 0600, dir,
+			    &fail_sunrpc.ignore_server_disconnect);
 }
 #else
 static inline void fail_sunrpc_init(void)
diff --git a/net/sunrpc/fail.h b/net/sunrpc/fail.h
index 1d402b0d3453..33ed557530ba 100644
--- a/net/sunrpc/fail.h
+++ b/net/sunrpc/fail.h
@@ -12,6 +12,8 @@
 
 struct fail_sunrpc_attr {
 	struct fault_attr	attr;
+
+	bool			ignore_server_disconnect;
 };
 
 extern struct fail_sunrpc_attr fail_sunrpc;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 35b549c147a2..c435f0061007 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -31,6 +31,8 @@
 
 #include <trace/events/sunrpc.h>
 
+#include "fail.h"
+
 #define RPCDBG_FACILITY	RPCDBG_SVCDSP
 
 static void svc_unregister(const struct svc_serv *serv, struct net *net);
@@ -1507,6 +1509,12 @@ svc_process(struct svc_rqst *rqstp)
 	struct svc_serv		*serv = rqstp->rq_server;
 	u32			dir;
 
+#if IS_ENABLED(CONFIG_FAULT_INJECTION)
+	if (!fail_sunrpc.ignore_server_disconnect &&
+	    should_fail(&fail_sunrpc.attr, 1))
+		svc_xprt_deferred_close(rqstp->rq_xprt);
+#endif
+
 	/*
 	 * Setup response xdr_buf.
 	 * Initially it has just one page


