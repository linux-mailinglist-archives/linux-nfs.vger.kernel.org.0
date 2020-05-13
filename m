Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230601D2226
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2020 00:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgEMWim (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 May 2020 18:38:42 -0400
Received: from fieldses.org ([173.255.197.46]:57794 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgEMWim (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 May 2020 18:38:42 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id AAFF91508; Wed, 13 May 2020 18:38:41 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH] SUNRPC: 'Directory with parent 'rpc_clnt' already present!'
Date:   Wed, 13 May 2020 18:38:40 -0400
Message-Id: <1589409520-1344-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Each rpc_client has a cl_clid which is allocated from a global ida, and
a debugfs directory which is named after cl_clid.

We're releasing the cl_clid before we free the debugfs directory named
after it.  As soon as the cl_clid is released, that value is available
for another newly created client.

That leaves a window where another client may attempt to create a new
debugfs directory with the same name as the not-yet-deleted debugfs
directory from the dying client.  Symptoms are log messages like

	Directory 4 with parent 'rpc_clnt' already present!

Fixes: 7c4310ff5642 "SUNRPC: defer slow parts of rpc_free_client() to a workqueue."
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 net/sunrpc/clnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 8350d3a2e9a7..4a7efc00fd83 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -889,6 +889,7 @@ static void rpc_free_client_work(struct work_struct *work)
 	 * here.
 	 */
 	rpc_clnt_debugfs_unregister(clnt);
+	rpc_free_clid(clnt);
 	rpc_clnt_remove_pipedir(clnt);
 
 	kfree(clnt);
@@ -910,7 +911,6 @@ rpc_free_client(struct rpc_clnt *clnt)
 	xprt_put(rcu_dereference_raw(clnt->cl_xprt));
 	xprt_iter_destroy(&clnt->cl_xpi);
 	put_cred(clnt->cl_cred);
-	rpc_free_clid(clnt);
 
 	INIT_WORK(&clnt->cl_work, rpc_free_client_work);
 	schedule_work(&clnt->cl_work);
-- 
2.26.2

