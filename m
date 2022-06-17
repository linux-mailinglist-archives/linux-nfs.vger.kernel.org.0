Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A126754FE42
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jun 2022 22:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347199AbiFQUXm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jun 2022 16:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiFQUXl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jun 2022 16:23:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F81850059
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jun 2022 13:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5770FB82B8C
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jun 2022 20:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C530CC3411B;
        Fri, 17 Jun 2022 20:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655497418;
        bh=EkXMMrnwGszBPFHho2BEnhFcAczct4y2BPNL8xyYLJc=;
        h=From:To:Cc:Subject:Date:From;
        b=Ebl9AzJKD1/oFWj4QIux+NFbDyZn5CPt78ACmIpClqS2ZReznHBXtQ9CU+sOVvHU1
         7vNUl3k02wt2R4HBju+ZyZKLsV2zZPlZd8jEIO0wp5BaEMRWA2IjlWlIP8ydlzF1RQ
         uZUovzKBelNq2ko62wQG7AHA/sEwXvJHBb5j8IZKNITpZ/b9nN1IZ+A631ORRluAP+
         cLqKPO0FSfqUREO5ukvNyonTpp5njQqiVSMua3p0EhVDkc4Zlz+8slK6zGWOdTM5gE
         wMg0+PjjfRrxSSVh2Xajjl/rFeV3NVGsqCkTuAeepcS6O6/5q3m2Q3AAAgw36/5VBU
         w6YYkuAgpijfg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH] NFS: Allow setting rsize / wsize to a multiple of PAGE_SIZE
Date:   Fri, 17 Jun 2022 16:23:36 -0400
Message-Id: <20220617202336.1099702-1-anna@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Previously, we required this to value to be a power of 2 for UDP related
reasons. This patch keeps the power of 2 rule for UDP but allows more
flexibility for TCP and RDMA.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/client.c                           | 13 +++++++------
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |  6 ++++--
 fs/nfs/internal.h                         | 18 ++++++++++++++++++
 fs/nfs/nfs4client.c                       |  4 ++--
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index e828504cc396..da8da5cdbbc1 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -708,9 +708,9 @@ static int nfs_init_server(struct nfs_server *server,
 	}
 
 	if (ctx->rsize)
-		server->rsize = nfs_block_size(ctx->rsize, NULL);
+		server->rsize = nfs_io_size(ctx->rsize, clp->cl_proto);
 	if (ctx->wsize)
-		server->wsize = nfs_block_size(ctx->wsize, NULL);
+		server->wsize = nfs_io_size(ctx->wsize, clp->cl_proto);
 
 	server->acregmin = ctx->acregmin * HZ;
 	server->acregmax = ctx->acregmax * HZ;
@@ -755,18 +755,19 @@ static int nfs_init_server(struct nfs_server *server,
 static void nfs_server_set_fsinfo(struct nfs_server *server,
 				  struct nfs_fsinfo *fsinfo)
 {
+	struct nfs_client *clp = server->nfs_client;
 	unsigned long max_rpc_payload, raw_max_rpc_payload;
 
 	/* Work out a lot of parameters */
 	if (server->rsize == 0)
-		server->rsize = nfs_block_size(fsinfo->rtpref, NULL);
+		server->rsize = nfs_io_size(fsinfo->rtpref, clp->cl_proto);
 	if (server->wsize == 0)
-		server->wsize = nfs_block_size(fsinfo->wtpref, NULL);
+		server->wsize = nfs_io_size(fsinfo->wtpref, clp->cl_proto);
 
 	if (fsinfo->rtmax >= 512 && server->rsize > fsinfo->rtmax)
-		server->rsize = nfs_block_size(fsinfo->rtmax, NULL);
+		server->rsize = nfs_io_size(fsinfo->rtmax, clp->cl_proto);
 	if (fsinfo->wtmax >= 512 && server->wsize > fsinfo->wtmax)
-		server->wsize = nfs_block_size(fsinfo->wtmax, NULL);
+		server->wsize = nfs_io_size(fsinfo->wtmax, clp->cl_proto);
 
 	raw_max_rpc_payload = rpc_max_payload(server->client);
 	max_rpc_payload = nfs_block_size(raw_max_rpc_payload, NULL);
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index bfa7202ca7be..e028f5a0ef5f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -113,8 +113,10 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 			goto out_err_drain_dsaddrs;
 		ds_versions[i].version = be32_to_cpup(p++);
 		ds_versions[i].minor_version = be32_to_cpup(p++);
-		ds_versions[i].rsize = nfs_block_size(be32_to_cpup(p++), NULL);
-		ds_versions[i].wsize = nfs_block_size(be32_to_cpup(p++), NULL);
+		ds_versions[i].rsize = nfs_io_size(be32_to_cpup(p++),
+						   server->nfs_client->cl_proto);
+		ds_versions[i].wsize = nfs_io_size(be32_to_cpup(p++),
+						   server->nfs_client->cl_proto);
 		ds_versions[i].tightly_coupled = be32_to_cpup(p);
 
 		if (ds_versions[i].rsize > NFS_MAX_FILE_IO_SIZE)
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 8f8cd6e2d4db..af6d261241ff 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -704,6 +704,24 @@ unsigned long nfs_block_size(unsigned long bsize, unsigned char *nrbitsp)
 	return nfs_block_bits(bsize, nrbitsp);
 }
 
+/*
+ * Compute and set NFS server rsize / wsize
+ */
+static inline
+unsigned long nfs_io_size(unsigned long iosize, enum xprt_transports proto)
+{
+	if (iosize < NFS_MIN_FILE_IO_SIZE)
+		iosize = NFS_DEF_FILE_IO_SIZE;
+	else if (iosize >= NFS_MAX_FILE_IO_SIZE)
+		iosize = NFS_MAX_FILE_IO_SIZE;
+	else
+		iosize = iosize & PAGE_MASK;
+
+	if (proto == XPRT_TRANSPORT_UDP)
+		return nfs_block_bits(iosize, NULL);
+	return iosize;
+}
+
 /*
  * Determine the maximum file size for a superblock
  */
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 47a6cf892c95..3c5678aec006 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1161,9 +1161,9 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 		return error;
 
 	if (ctx->rsize)
-		server->rsize = nfs_block_size(ctx->rsize, NULL);
+		server->rsize = nfs_io_size(ctx->rsize, server->nfs_client->cl_proto);
 	if (ctx->wsize)
-		server->wsize = nfs_block_size(ctx->wsize, NULL);
+		server->wsize = nfs_io_size(ctx->wsize, server->nfs_client->cl_proto);
 
 	server->acregmin = ctx->acregmin * HZ;
 	server->acregmax = ctx->acregmax * HZ;
-- 
2.36.1

