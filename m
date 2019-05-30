Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550F72E9C8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 02:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfE3Anf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 20:43:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:46454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3Anf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 20:43:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8B06AC66;
        Thu, 30 May 2019 00:43:34 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 30 May 2019 10:41:28 +1000
Subject: [PATCH 5/9] SUNRPC: add links for all client xprts to debugfs
Cc:     linux-nfs@vger.kernel.org
Message-ID: <155917688872.3988.1542351454603489228.stgit@noble.brown>
In-Reply-To: <155917564898.3988.6096672032831115016.stgit@noble.brown>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that a client can have multiple xprts, we need to add
them all to debugs.
The first one is still "xprt"
Subsequent xprts are "xprt1", "xprt2", etc.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 net/sunrpc/debugfs.c |   46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 95ebd76b132d..228bc7e8bca0 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -118,12 +118,38 @@ static const struct file_operations tasks_fops = {
 	.release	= tasks_release,
 };
 
+static int do_xprt_debugfs(struct rpc_clnt *clnt, struct rpc_xprt *xprt, void *numv)
+{
+	int len;
+	char name[24]; /* enough for "../../rpc_xprt/ + 8 hex digits + NULL */
+	char link[9]; /* enough for 8 hex digits + NULL */
+	int *nump = numv;
+
+	if (IS_ERR_OR_NULL(xprt->debugfs))
+		return 0;
+	len = snprintf(name, sizeof(name), "../../rpc_xprt/%s",
+		       xprt->debugfs->d_name.name);
+	if (len > sizeof(name))
+		return -1;
+	if (*nump == 0)
+		strcpy(link, "xprt");
+	else {
+		len = snprintf(link, sizeof(link), "xprt%d", *nump);
+		if (len > sizeof(link))
+			return -1;
+	}
+	if (!debugfs_create_symlink(link, clnt->cl_debugfs, name))
+		return -1;
+	(*nump)++;
+	return 0;
+}
+
 void
 rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
 {
 	int len;
-	char name[24]; /* enough for "../../rpc_xprt/ + 8 hex digits + NULL */
-	struct rpc_xprt *xprt;
+	char name[9]; /* enough for 8 hex digits + NULL */
+	int xprtnum = 0;
 
 	/* Already registered? */
 	if (clnt->cl_debugfs || !rpc_clnt_dir)
@@ -143,21 +169,7 @@ rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
 				 clnt, &tasks_fops))
 		goto out_err;
 
-	rcu_read_lock();
-	xprt = rcu_dereference(clnt->cl_xprt);
-	/* no "debugfs" dentry? Don't bother with the symlink. */
-	if (IS_ERR_OR_NULL(xprt->debugfs)) {
-		rcu_read_unlock();
-		return;
-	}
-	len = snprintf(name, sizeof(name), "../../rpc_xprt/%s",
-			xprt->debugfs->d_name.name);
-	rcu_read_unlock();
-
-	if (len >= sizeof(name))
-		goto out_err;
-
-	if (!debugfs_create_symlink("xprt", clnt->cl_debugfs, name))
+	if (rpc_clnt_iterate_for_each_xprt(clnt, do_xprt_debugfs, &xprtnum) < 0)
 		goto out_err;
 
 	return;


