Return-Path: <linux-nfs+bounces-4336-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFA6918E57
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B511F275B7
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD3F19048B;
	Wed, 26 Jun 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx03lzmr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51219047F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426294; cv=none; b=MZykMAyAk/CgVeGkuUjyj6KkG7h0JcunNqq2O6obmUYTtl/tHwvGfGQVLl3PD5i5PM5IUbNsfPPlSF35ArQUUX+piBGnVQw1ngO1wp5qwVSeG+5eg4W5PHP6AvoZGkdsTvJLoyC+FuyiQDPCfLk6n6cgWoBxxM8TGfGa0MX35II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426294; c=relaxed/simple;
	bh=X3eeEYlS9YLp7iD3PjCjsrl81HV+UMdSCrHhb+Bvz6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OghF7407uWIo1jDwqhFCVShXgH7z7L5dB4PkS78pHA0oWgksPKyDmSyvaXgbVrtLaQnAewAWjeG8uoNy/YSCTTZ0x0ki9HzW5b+ehzR1aOfvvvqlgTaZ1gnWCgMclkECHchihGB0WK1abtjgOiyHMvMNHIVPiyOShoFsdCwyfHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx03lzmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4C7C116B1;
	Wed, 26 Jun 2024 18:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426294;
	bh=X3eeEYlS9YLp7iD3PjCjsrl81HV+UMdSCrHhb+Bvz6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cx03lzmrYHR3YpHCU0oxDtnkuguUV4CQhst3IFDNGyvxmLKLEpVETW68GB2r8fHLd
	 WsF3pawLS4YBIcxp8DpYMH6Ii+oiDwdV8BRyqC2JXRtDs1YicP3GPSuV4FmbygRcqm
	 J8tuSqy833aCUsRi17OnI4bYkNS1LhvSvHBhQsm0kn0Oj5CKfcd1uDgQb0Gdhyx9YO
	 6/yKn/D47y4HmX/QbObXUPvquB5qycK4jJA1JuDbu49vkk+RJawnfrQLqLK/dKFYlM
	 81gMSWg3+fwgKoSwUdgPSK60Jlwr66RmaRmtwZm8bF9nOBXA6XeI2RoVwT5dTs4IHF
	 nCAfdWxQfbC7A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v8 11/18] NFS: Enable localio for non-pNFS I/O
Date: Wed, 26 Jun 2024 14:24:31 -0400
Message-ID: <20240626182438.69539-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240626182438.69539-1-snitzer@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
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


