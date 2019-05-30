Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC12E9C9
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 02:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfE3Anm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 20:43:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:46470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3Anm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 20:43:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77BABAC66;
        Thu, 30 May 2019 00:43:41 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 30 May 2019 10:41:28 +1000
Subject: [PATCH 6/9] NFS: Add a mount option to specify number of TCP
 connections to use
Cc:     linux-nfs@vger.kernel.org
Message-ID: <155917688876.3988.2056442739107972319.stgit@noble.brown>
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

From: Trond Myklebust <trond.myklebust@primarydata.com>

Allow the user to specify that the client should use multiple connections
to the server. For the moment, this functionality will be limited to
TCP and to NFSv4.x (x>0).

The value is not yet copied through from parsed data to the
nfs_client, later patches will do that.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/nfs/internal.h         |    1 +
 fs/nfs/super.c            |   12 ++++++++++++
 include/linux/nfs_fs_sb.h |    1 +
 3 files changed, 14 insertions(+)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 498fab72f70b..bba09dace5d6 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -123,6 +123,7 @@ struct nfs_parsed_mount_data {
 		char			*export_path;
 		int			port;
 		unsigned short		protocol;
+		unsigned short		nconnect;
 	} nfs_server;
 
 	void			*lsm_opts;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index f88ddac2dcdf..bd3ba1d323ea 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -77,6 +77,8 @@
 #define NFS_DEFAULT_VERSION 2
 #endif
 
+#define NFS_MAX_CONNECTIONS 16
+
 enum {
 	/* Mount options that take no arguments */
 	Opt_soft, Opt_softerr, Opt_hard,
@@ -108,6 +110,7 @@ enum {
 	Opt_nfsvers,
 	Opt_sec, Opt_proto, Opt_mountproto, Opt_mounthost,
 	Opt_addr, Opt_mountaddr, Opt_clientaddr,
+	Opt_nconnect,
 	Opt_lookupcache,
 	Opt_fscache_uniq,
 	Opt_local_lock,
@@ -181,6 +184,8 @@ static const match_table_t nfs_mount_option_tokens = {
 	{ Opt_mounthost, "mounthost=%s" },
 	{ Opt_mountaddr, "mountaddr=%s" },
 
+	{ Opt_nconnect, "nconnect=%s" },
+
 	{ Opt_lookupcache, "lookupcache=%s" },
 	{ Opt_fscache_uniq, "fsc=%s" },
 	{ Opt_local_lock, "local_lock=%s" },
@@ -673,6 +678,8 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	seq_printf(m, ",proto=%s",
 		   rpc_peeraddr2str(nfss->client, RPC_DISPLAY_NETID));
 	rcu_read_unlock();
+	if (clp->cl_nconnect > 0)
+		seq_printf(m, ",nconnect=%u", clp->cl_nconnect);
 	if (version == 4) {
 		if (nfss->port != NFS_PORT)
 			seq_printf(m, ",port=%u", nfss->port);
@@ -1549,6 +1556,11 @@ static int nfs_parse_mount_options(char *raw,
 			if (mnt->mount_server.addrlen == 0)
 				goto out_invalid_address;
 			break;
+		case Opt_nconnect:
+			if (nfs_get_option_ul_bound(args, &option, 1, NFS_MAX_CONNECTIONS))
+				goto out_invalid_value;
+			mnt->nfs_server.nconnect = option;
+			break;
 		case Opt_lookupcache:
 			string = match_strdup(args);
 			if (string == NULL)
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 1e78032a174b..a87fe854f008 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -58,6 +58,7 @@ struct nfs_client {
 	struct nfs_subversion *	cl_nfs_mod;	/* pointer to nfs version module */
 
 	u32			cl_minorversion;/* NFSv4 minorversion */
+	unsigned int		cl_nconnect;	/* Number of connections */
 	const char *		cl_principal;  /* used for machine cred */
 
 #if IS_ENABLED(CONFIG_NFS_V4)


