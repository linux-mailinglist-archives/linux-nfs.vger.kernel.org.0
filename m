Return-Path: <linux-nfs+bounces-4391-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0AF91C7DB
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 23:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8181C2115D
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 21:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865F17EEF5;
	Fri, 28 Jun 2024 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv6O5PwW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622117E591
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609078; cv=none; b=cDxzkZ/YaGPzNtt5OMXPp9Uh0+46BhKt/CE+WlV9SYxVkZG+382v+27yFMIZGaPZ1R9SyJbDIyy2CeDW2WzNMzfDyX+wI0xWvOifk6Xmv2ChkPSjw1MRnwJdbZU6h70OYF6nB7TbwoIAz7aEWX/CBXooUyVU5yVH+tAioqzkjEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609078; c=relaxed/simple;
	bh=X3eeEYlS9YLp7iD3PjCjsrl81HV+UMdSCrHhb+Bvz6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAF5I/1uM3suWvjjXlbkKfNZcux+WkhanEqtzxXyDkRlhP8IKpXPsmc67MIiZF0MBtHc4dljt/Ap8KIOK+EpIJPitW0KSZDxi6uJlPNDxwhGQk5AivktVPJrf0e0po4uAdZVy7+DuSgel7kFV42S8QRPQRBXPnlcRnZ1eK/ohbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv6O5PwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA076C116B1;
	Fri, 28 Jun 2024 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719609077;
	bh=X3eeEYlS9YLp7iD3PjCjsrl81HV+UMdSCrHhb+Bvz6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sv6O5PwWJgzQpQlnOgmJvBVVSQrLUhaW0SaNcgXwIPdSqk/+lRYnaI8sKsdatigaX
	 C6eFGFNzzZ7uR6E/t97IzS/i+XV3IxmMWmFpOvcI6qnJsr4shzIKZ74bqIn9mC96eE
	 TgZNWXmTJtU6uWChPsdjGiWurdOze65nYDnheiMvDQ/PMpMUmVhTGtoTAUGpq8hb1L
	 54vSjTXilEwkmnPUvpwX5KXrH7x0FHvid8kICW8ew9OzQ9sl9L+DcT2GHjPZVBw1ER
	 qcBl5FiW/94A4JzxbUq0WXkVel5DnQLXwVemxX4zCJsPrvfDiqPB1pKXofOuEUf+Y0
	 cwoTR7erw7bbw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v9 08/19] nfs: enable localio for non-pNFS I/O
Date: Fri, 28 Jun 2024 17:10:54 -0400
Message-ID: <20240628211105.54736-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240628211105.54736-1-snitzer@kernel.org>
References: <20240628211105.54736-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Try a local open of the file we're writing to, and if it succeeds, then
do local I/O.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/pagelist.c | 19 ++++++++++---------
 fs/nfs/write.c    |  7 ++++++-
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index b08420b8e664..3ee78da5ebc4 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1063,6 +1063,7 @@ EXPORT_SYMBOL_GPL(nfs_generic_pgio);
 static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 {
 	struct nfs_pgio_header *hdr;
+	struct file *filp;
 	int ret;
 	unsigned short task_flags = 0;
 
@@ -1074,18 +1075,18 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	nfs_pgheader_init(desc, hdr, nfs_pgio_header_free);
 	ret = nfs_generic_pgio(desc, hdr);
 	if (ret == 0) {
+		struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
+
+		filp = nfs_local_file_open(clp, hdr->cred, hdr->args.fh,
+					   hdr->args.context);
+
 		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
 			task_flags = RPC_TASK_MOVEABLE;
-		ret = nfs_initiate_pgio(desc,
-					NFS_SERVER(hdr->inode)->nfs_client,
-					NFS_CLIENT(hdr->inode),
-					hdr,
-					hdr->cred,
-					NFS_PROTO(hdr->inode),
-					desc->pg_rpc_callops,
-					desc->pg_ioflags,
+		ret = nfs_initiate_pgio(desc, clp, NFS_CLIENT(hdr->inode),
+					hdr, hdr->cred, NFS_PROTO(hdr->inode),
+					desc->pg_rpc_callops, desc->pg_ioflags,
 					RPC_TASK_CRED_NOREF | task_flags,
-					NULL);
+					filp);
 	}
 	return ret;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index b29b0fd5431f..b2c06b8b88cd 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1802,6 +1802,8 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		struct nfs_commit_info *cinfo)
 {
 	struct nfs_commit_data	*data;
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+	struct file *filp;
 	unsigned short task_flags = 0;
 
 	/* another commit raced with us */
@@ -1818,9 +1820,12 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	nfs_init_commit(data, head, NULL, cinfo);
 	if (NFS_SERVER(inode)->nfs_client->cl_minorversion)
 		task_flags = RPC_TASK_MOVEABLE;
+
+	filp = nfs_local_file_open(clp, data->cred, data->args.fh,
+				   data->context);
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
-				   RPC_TASK_CRED_NOREF | task_flags, NULL);
+				   RPC_TASK_CRED_NOREF | task_flags, filp);
 }
 
 /*
-- 
2.44.0


