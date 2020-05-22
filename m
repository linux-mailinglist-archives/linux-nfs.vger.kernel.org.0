Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255E81DDD00
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2020 04:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgEVCDh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 22:03:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:47098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgEVCDh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 21 May 2020 22:03:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EB8BCAD09;
        Fri, 22 May 2020 02:03:37 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, kircherlike@outlook.com,
        Stephen Hemminger <stephen@networkplumber.org>
Date:   Fri, 22 May 2020 12:01:32 +1000
Subject: [PATCH 1/3] sunrpc: check that domain table is empty at module
 unload.
Cc:     linux-nfs@vger.kernel.org
Message-ID: <159011289291.29107.750750426822869150.stgit@noble>
In-Reply-To: <159011265914.29107.13764997801950546826.stgit@noble>
References: <159011265914.29107.13764997801950546826.stgit@noble>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The domain table should be empty at module unload.  If it isn't there is
a bug somewhere.  So check and report.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206651
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/sunrpc.h      |    1 +
 net/sunrpc/sunrpc_syms.c |    2 ++
 net/sunrpc/svcauth.c     |   25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/net/sunrpc/sunrpc.h b/net/sunrpc/sunrpc.h
index 47a756503d11..f6fe2e6cd65a 100644
--- a/net/sunrpc/sunrpc.h
+++ b/net/sunrpc/sunrpc.h
@@ -52,4 +52,5 @@ static inline int sock_is_loopback(struct sock *sk)
 
 int rpc_clients_notifier_register(void);
 void rpc_clients_notifier_unregister(void);
+void auth_domain_cleanup(void);
 #endif /* _NET_SUNRPC_SUNRPC_H */
diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
index f9edaa9174a4..236fadc4a439 100644
--- a/net/sunrpc/sunrpc_syms.c
+++ b/net/sunrpc/sunrpc_syms.c
@@ -23,6 +23,7 @@
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/sunrpc/xprtsock.h>
 
+#include "sunrpc.h"
 #include "netns.h"
 
 unsigned int sunrpc_net_id;
@@ -131,6 +132,7 @@ cleanup_sunrpc(void)
 	unregister_rpc_pipefs();
 	rpc_destroy_mempool();
 	unregister_pernet_subsys(&sunrpc_net_ops);
+	auth_domain_cleanup();
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	rpc_unregister_sysctl();
 #endif
diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
index 552617e3467b..998b196b6176 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -21,6 +21,8 @@
 
 #include <trace/events/sunrpc.h>
 
+#include "sunrpc.h"
+
 #define RPCDBG_FACILITY	RPCDBG_AUTH
 
 
@@ -205,3 +207,26 @@ struct auth_domain *auth_domain_find(char *name)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(auth_domain_find);
+
+/**
+ * auth_domain_cleanup - check that the auth_domain table is empty
+ *
+ * On module unload the auth_domain_table must be empty.  To make it
+ * easier to catch bugs which don't clean up domains properly, we
+ * warn if anything remains in the table at cleanup time.
+ *
+ * Note that we cannot proactively remove the domains at this stage.
+ * The ->release() function might be in a module that has already been
+ * unloaded.
+ */
+
+void auth_domain_cleanup(void)
+{
+	int h;
+	struct auth_domain *hp;
+
+	for (h = 0; h < DN_HASHMAX; h++)
+		hlist_for_each_entry(hp, &auth_domain_table[h], hash)
+			pr_warn("svc: domain %s still present at module unload.\n",
+				hp->name);
+}


