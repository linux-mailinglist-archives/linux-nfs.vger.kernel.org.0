Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1351DC58D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 05:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgEUDXB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 23:23:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:58966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgEUDXA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 20 May 2020 23:23:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E641CB13E;
        Thu, 21 May 2020 03:23:01 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, kircherlike@outlook.com,
        Stephen Hemminger <stephen@networkplumber.org>
Date:   Thu, 21 May 2020 13:21:41 +1000
Subject: [PATCH 1/3] sunrpc: check that domain table is empty at module
 unload.
Cc:     linux-nfs@vger.kernel.org
Message-ID: <159003130168.24897.13206733830315341548.stgit@noble>
In-Reply-To: <159003086409.24897.4659128962844846611.stgit@noble>
References: <159003086409.24897.4659128962844846611.stgit@noble>
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
Cc: stable@vger.kernel.org
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/sunrpc.h      |    1 +
 net/sunrpc/sunrpc_syms.c |    2 ++
 net/sunrpc/svcauth.c     |   18 ++++++++++++++++++
 3 files changed, 21 insertions(+)

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
index 552617e3467b..477890e8b9d8 100644
--- a/net/sunrpc/svcauth.c
+++ b/net/sunrpc/svcauth.c
@@ -205,3 +205,21 @@ struct auth_domain *auth_domain_find(char *name)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(auth_domain_find);
+
+void auth_domain_cleanup(void)
+{
+	/* There should be no auth_domains left at module unload */
+	int h;
+	bool found = false;
+
+	for (h = 0; h < DN_HASHMAX; h++) {
+		struct auth_domain *hp;
+
+		hlist_for_each_entry(hp, auth_domain_table+h, hash) {
+			found = true;
+			printk(KERN_WARNING "sunrpc: domain %s still present at module unload.\n",
+			       hp->name);
+		}
+	}
+	WARN(found, "sunrpc: auth_domain_table not clean -> memory leak\n");
+}


