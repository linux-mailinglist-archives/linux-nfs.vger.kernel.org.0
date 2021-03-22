Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004E1343888
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 06:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhCVF3g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 01:29:36 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:39132 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhCVF3e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Mar 2021 01:29:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0USrrR4H_1616390972;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0USrrR4H_1616390972)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Mar 2021 13:29:32 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     linux-nfs@vger.kernel.org
Cc:     Eryu Guan <eguan@linux.alibaba.com>
Subject: [PATCH 1/2] nfs: hornor timeo and retrans option when mounting NFSv3
Date:   Mon, 22 Mar 2021 13:29:03 +0800
Message-Id: <20210322052904.83508-1-eguan@linux.alibaba.com>
X-Mailer: git-send-email 2.26.1.107.gefe3874
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Mounting NFSv3 uses default timeout parameters specified by underlying
sunrpc transport, and mount options like 'timeo' and 'retrans', unlike
NFSv4, are not honored.

But sometimes we want to set non-default timeout value when mounting
NFSv3, so pass 'timeo' and 'retrans' to nfs_mount() and fill the
'timeout' field of struct rpc_create_args before creating RPC
connection. This is also consistent with NFSv4 behavior.

Note that this only sets the timeout value of rpc connection to mountd,
but the timeout of rpcbind connection should be set as well. A later
patch will fix the rpcbind part.

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
 fs/nfs/internal.h   |  2 +-
 fs/nfs/mount_clnt.c | 12 +++++++-----
 fs/nfs/super.c      |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 7b644d6c09e4..cf0d7db24d44 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -180,7 +180,7 @@ struct nfs_mount_request {
 	struct net		*net;
 };
 
-extern int nfs_mount(struct nfs_mount_request *info);
+extern int nfs_mount(struct nfs_mount_request *info, int timeo, int retrans);
 extern void nfs_umount(const struct nfs_mount_request *info);
 
 /* client.c */
diff --git a/fs/nfs/mount_clnt.c b/fs/nfs/mount_clnt.c
index dda5c3e65d8d..248319254672 100644
--- a/fs/nfs/mount_clnt.c
+++ b/fs/nfs/mount_clnt.c
@@ -137,13 +137,13 @@ struct mnt_fhstatus {
  * nfs_mount - Obtain an NFS file handle for the given host and path
  * @info: pointer to mount request arguments
  *
- * Uses default timeout parameters specified by underlying transport. On
- * successful return, the auth_flavs list and auth_flav_len will be populated
- * with the list from the server or a faked-up list if the server didn't
- * provide one.
+ * Uses timeout parameters specified by caller. On successful return, the
+ * auth_flavs list and auth_flav_len will be populated with the list from the
+ * server or a faked-up list if the server didn't provide one.
  */
-int nfs_mount(struct nfs_mount_request *info)
+int nfs_mount(struct nfs_mount_request *info, int timeo, int retrans)
 {
+	static struct rpc_timeout mnt_timeout;
 	struct mountres	result = {
 		.fh		= info->fh,
 		.auth_count	= info->auth_flav_len,
@@ -158,6 +158,7 @@ int nfs_mount(struct nfs_mount_request *info)
 		.protocol	= info->protocol,
 		.address	= info->sap,
 		.addrsize	= info->salen,
+		.timeout	= &mnt_timeout,
 		.servername	= info->hostname,
 		.program	= &mnt_program,
 		.version	= info->version,
@@ -177,6 +178,7 @@ int nfs_mount(struct nfs_mount_request *info)
 	if (info->noresvport)
 		args.flags |= RPC_CLNT_CREATE_NONPRIVPORT;
 
+	nfs_init_timeout_values(&mnt_timeout, info->protocol, timeo, retrans);
 	mnt_clnt = rpc_create(&args);
 	if (IS_ERR(mnt_clnt))
 		goto out_clnt_err;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 94885c6f8f54..13a650750f04 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -867,7 +867,7 @@ static int nfs_request_mount(struct fs_context *fc,
 	 * Now ask the mount server to map our export path
 	 * to a file handle.
 	 */
-	status = nfs_mount(&request);
+	status = nfs_mount(&request, ctx->timeo, ctx->retrans);
 	if (status != 0) {
 		dfprintk(MOUNT, "NFS: unable to mount server %s, error %d\n",
 				request.hostname, status);
-- 
2.26.1.107.gefe3874

