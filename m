Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB42BB2DC
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 19:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgKTS0l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 13:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgKTS0l (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 20 Nov 2020 13:26:41 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE3724137;
        Fri, 20 Nov 2020 18:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896800;
        bh=LZueLPJ+3ObSrv0fVnvb4Tj7nxHz4UZd36lHn7FoZys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wAI3v0GMrcJb3dWvQX/23tEGib+xjtZqG5TRS+g0yAGPV76Kv+0VGkS/16kuB/jcT
         V8i6coGqHxTUTnn9k67j2YUALk9bRb5sctN+FTaA1qbMBWAaFLOj6NcvfPXCVkAZgx
         oLvLk3JFJ3PjJJIOE6oKfgSnEtCHh4QMhCnnSCW8=
Date:   Fri, 20 Nov 2020 12:26:46 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 017/141] nfs: Fix fall-through warnings for Clang
Message-ID: <078232d75c5a02b41ad54a48eb68c461da564f76.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly add multiple break/goto/return/fallthrough
statements instead of just letting the code fall through to the next
case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/nfs/nfs3acl.c    | 1 +
 fs/nfs/nfs4client.c | 1 +
 fs/nfs/nfs4proc.c   | 2 ++
 fs/nfs/nfs4state.c  | 1 +
 fs/nfs/pnfs.c       | 2 ++
 5 files changed, 7 insertions(+)

diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index c6c863382f37..68e206cf4c4e 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -111,6 +111,7 @@ struct posix_acl *nfs3_get_acl(struct inode *inode, int type)
 			fallthrough;
 		case -ENOTSUPP:
 			status = -EOPNOTSUPP;
+			goto getout;
 		default:
 			goto getout;
 	}
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index be7915c861ce..4bdd256b725a 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -609,6 +609,7 @@ int nfs40_walk_client_list(struct nfs_client *new,
 			 * changed. Schedule recovery!
 			 */
 			nfs4_schedule_path_down_recovery(pos);
+			goto out;
 		default:
 			goto out;
 		}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..98c9f3197647 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2229,6 +2229,7 @@ static int nfs4_handle_delegation_recall_error(struct nfs_server *server, struct
 		default:
 			printk(KERN_ERR "NFS: %s: unhandled error "
 					"%d.\n", __func__, err);
+			fallthrough;
 		case 0:
 		case -ENOENT:
 		case -EAGAIN:
@@ -9698,6 +9699,7 @@ nfs4_layoutcommit_done(struct rpc_task *task, void *calldata)
 	case -NFS4ERR_BADLAYOUT:     /* no layout */
 	case -NFS4ERR_GRACE:	    /* loca_recalim always false */
 		task->tk_status = 0;
+		break;
 	case 0:
 		break;
 	default:
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 4bf10792cb5b..3a51351bdc6a 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1125,6 +1125,7 @@ static void nfs_increment_seqid(int status, struct nfs_seqid *seqid)
 					" sequence-id error on an"
 					" unconfirmed sequence %p!\n",
 					seqid->sequence);
+			return;
 		case -NFS4ERR_STALE_CLIENTID:
 		case -NFS4ERR_STALE_STATEID:
 		case -NFS4ERR_BAD_STATEID:
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 0e50b9d45c32..7f71f4f8347f 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2824,6 +2824,7 @@ pnfs_do_write(struct nfs_pageio_descriptor *desc,
 	switch (trypnfs) {
 	case PNFS_NOT_ATTEMPTED:
 		pnfs_write_through_mds(desc, hdr);
+		break;
 	case PNFS_ATTEMPTED:
 		break;
 	case PNFS_TRY_AGAIN:
@@ -2968,6 +2969,7 @@ pnfs_do_read(struct nfs_pageio_descriptor *desc, struct nfs_pgio_header *hdr)
 	switch (trypnfs) {
 	case PNFS_NOT_ATTEMPTED:
 		pnfs_read_through_mds(desc, hdr);
+		break;
 	case PNFS_ATTEMPTED:
 		break;
 	case PNFS_TRY_AGAIN:
-- 
2.27.0

