Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91FB1FA50
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2019 21:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfEOTIG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 May 2019 15:08:06 -0400
Received: from fieldses.org ([173.255.197.46]:32830 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfEOTIG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 May 2019 15:08:06 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A3D851D39; Wed, 15 May 2019 15:08:05 -0400 (EDT)
Date:   Wed, 15 May 2019 15:08:05 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] rpc: replace rpc_filelist by tree_descr
Message-ID: <20190515190805.GC11614@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Use a common structure instead of defining our own here.

The only difference is using an int instead of umode_t for the mode
field; I haven't tried to figure out why tree_descr uses int.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 net/sunrpc/rpc_pipe.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

Seems like trivial but reasonable cleanup.  I'm curious whether there
might be more chances to share code between rpc_pipe and libfs, but
haven't investigated any further yet.

--b.

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 69663681bf9d..9af9f4c8fa1e 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -460,15 +460,6 @@ static const struct file_operations rpc_info_operations = {
 };
 
 
-/*
- * Description of fs contents.
- */
-struct rpc_filelist {
-	const char *name;
-	const struct file_operations *i_fop;
-	umode_t mode;
-};
-
 static struct inode *
 rpc_get_inode(struct super_block *sb, umode_t mode)
 {
@@ -648,7 +639,7 @@ static struct dentry *__rpc_lookup_create_exclusive(struct dentry *parent,
  * FIXME: This probably has races.
  */
 static void __rpc_depopulate(struct dentry *parent,
-			     const struct rpc_filelist *files,
+			     const struct tree_descr *files,
 			     int start, int eof)
 {
 	struct inode *dir = d_inode(parent);
@@ -680,7 +671,7 @@ static void __rpc_depopulate(struct dentry *parent,
 }
 
 static void rpc_depopulate(struct dentry *parent,
-			   const struct rpc_filelist *files,
+			   const struct tree_descr *files,
 			   int start, int eof)
 {
 	struct inode *dir = d_inode(parent);
@@ -691,7 +682,7 @@ static void rpc_depopulate(struct dentry *parent,
 }
 
 static int rpc_populate(struct dentry *parent,
-			const struct rpc_filelist *files,
+			const struct tree_descr *files,
 			int start, int eof,
 			void *private)
 {
@@ -711,7 +702,7 @@ static int rpc_populate(struct dentry *parent,
 			case S_IFREG:
 				err = __rpc_create(dir, dentry,
 						files[i].mode,
-						files[i].i_fop,
+						files[i].ops,
 						private);
 				break;
 			case S_IFDIR:
@@ -1015,10 +1006,10 @@ enum {
 	RPCAUTH_EOF
 };
 
-static const struct rpc_filelist authfiles[] = {
+static const struct tree_descr authfiles[] = {
 	[RPCAUTH_info] = {
 		.name = "info",
-		.i_fop = &rpc_info_operations,
+		.ops = &rpc_info_operations,
 		.mode = S_IFREG | 0400,
 	},
 };
@@ -1076,20 +1067,20 @@ int rpc_remove_client_dir(struct rpc_clnt *rpc_client)
 	return rpc_rmdir_depopulate(dentry, rpc_clntdir_depopulate);
 }
 
-static const struct rpc_filelist cache_pipefs_files[3] = {
+static const struct tree_descr cache_pipefs_files[3] = {
 	[0] = {
 		.name = "channel",
-		.i_fop = &cache_file_operations_pipefs,
+		.ops = &cache_file_operations_pipefs,
 		.mode = S_IFREG | 0600,
 	},
 	[1] = {
 		.name = "content",
-		.i_fop = &content_file_operations_pipefs,
+		.ops = &content_file_operations_pipefs,
 		.mode = S_IFREG | 0400,
 	},
 	[2] = {
 		.name = "flush",
-		.i_fop = &cache_flush_operations_pipefs,
+		.ops = &cache_flush_operations_pipefs,
 		.mode = S_IFREG | 0600,
 	},
 };
@@ -1145,7 +1136,7 @@ enum {
 	RPCAUTH_RootEOF
 };
 
-static const struct rpc_filelist files[] = {
+static const struct tree_descr files[] = {
 	[RPCAUTH_lockd] = {
 		.name = "lockd",
 		.mode = S_IFDIR | 0555,
@@ -1242,7 +1233,7 @@ void rpc_put_sb_net(const struct net *net)
 }
 EXPORT_SYMBOL_GPL(rpc_put_sb_net);
 
-static const struct rpc_filelist gssd_dummy_clnt_dir[] = {
+static const struct tree_descr gssd_dummy_clnt_dir[] = {
 	[0] = {
 		.name = "clntXX",
 		.mode = S_IFDIR | 0555,
@@ -1277,10 +1268,10 @@ rpc_dummy_info_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(rpc_dummy_info);
 
-static const struct rpc_filelist gssd_dummy_info_file[] = {
+static const struct tree_descr gssd_dummy_info_file[] = {
 	[0] = {
 		.name = "info",
-		.i_fop = &rpc_dummy_info_fops,
+		.ops = &rpc_dummy_info_fops,
 		.mode = S_IFREG | 0400,
 	},
 };
-- 
2.21.0

