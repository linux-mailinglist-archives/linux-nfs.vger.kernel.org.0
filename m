Return-Path: <linux-nfs+bounces-6279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A4096E2D9
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B148D2872ED
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0AE18C910;
	Thu,  5 Sep 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbW1RqOw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B218CBF6
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563440; cv=none; b=Z29VvcIg2Grq0ZpsUwFYD9Tmdezos5/PaB8u08XeeFrcECeWbZ5YlcUDmlbvST0Pi82ev1rJF6A1cQ7TJds/tNJT3TKBa54Y5XwTJ3GEYR5v3OtlEJl4Hc6bjPstEBpDSt6hBAQ7b14+Buv/QHrsz0uXf3+uKmePCsrf9fn/Dq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563440; c=relaxed/simple;
	bh=wRLL5zAAjgNbgyEVuucqf3bjas4HxWtQE4gmmikf0aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw6xonUKUkHkEu69MJGCQL2kcjHi0/rBMzTvHbbilQji9BgkYLRKO5OAnUnQlTsl/CTOBrePmZQQ9tzEsKm068HIaJ6Z61L5OhFfo2mHdQtkOHUC6+Ozp8NBi/pVe630DftjdCkca/AKV3E71sCqAv19nOW7Vy6VqeMyMnZq3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbW1RqOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15DDC4CEC7;
	Thu,  5 Sep 2024 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563440;
	bh=wRLL5zAAjgNbgyEVuucqf3bjas4HxWtQE4gmmikf0aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbW1RqOwc8QN/kbpg78jjzFuSbQUuWyFXn0bajJDWwLENQck2G4PKFRA64i6iYOnA
	 wfAvOC7wXiBWrz/gCL3GTWcnbfAMgGY+9sOWA06UIfN2iGuwRUk0Jt2A0O9bgVH3K3
	 9NFOvMw23LelLkR67k013V3xHIMjw26n6hUN1RQet7Kcmh908suX0dHS1tOBSok4Hh
	 5irUYRxwVbhD0fcv+5EqOQrKHRSepiiN09VsDG2QUDowhVlxbu/cTKgeTrkzE4Qmre
	 RwnTdGPUTt+o+9KBIblIwGb9DypyCbWxhFdtUazDu+/lfTimAScuw1NHbv4bOi43Yg
	 V4mcX7mEir24w==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 20/26] nfs: enable localio for non-pNFS IO
Date: Thu,  5 Sep 2024 15:09:54 -0400
Message-ID: <20240905191011.41650-21-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240905191011.41650-1-snitzer@kernel.org>
References: <20240905191011.41650-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Try a local open of the file being written to, and if it succeeds,
then use localio to issue IO.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/pagelist.c | 8 +++++++-
 fs/nfs/write.c    | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 97d5524c379a..e27c07bd8929 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -958,6 +958,12 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	nfs_pgheader_init(desc, hdr, nfs_pgio_header_free);
 	ret = nfs_generic_pgio(desc, hdr);
 	if (ret == 0) {
+		struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
+
+		struct nfsd_file *localio =
+			nfs_local_open_fh(clp, hdr->cred,
+					  hdr->args.fh, hdr->args.context->mode);
+
 		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
 			task_flags = RPC_TASK_MOVEABLE;
 		ret = nfs_initiate_pgio(NFS_CLIENT(hdr->inode),
@@ -967,7 +973,7 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 					desc->pg_rpc_callops,
 					desc->pg_ioflags,
 					RPC_TASK_CRED_NOREF | task_flags,
-					NULL);
+					localio);
 	}
 	return ret;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 404cc5281e6a..de3cf5f971f4 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1795,6 +1795,7 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		struct nfs_commit_info *cinfo)
 {
 	struct nfs_commit_data	*data;
+	struct nfsd_file *localio;
 	unsigned short task_flags = 0;
 
 	/* another commit raced with us */
@@ -1811,9 +1812,12 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	nfs_init_commit(data, head, NULL, cinfo);
 	if (NFS_SERVER(inode)->nfs_client->cl_minorversion)
 		task_flags = RPC_TASK_MOVEABLE;
+
+	localio = nfs_local_open_fh(NFS_SERVER(inode)->nfs_client, data->cred,
+				    data->args.fh, data->context->mode);
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
-				   RPC_TASK_CRED_NOREF | task_flags, NULL);
+				   RPC_TASK_CRED_NOREF | task_flags, localio);
 }
 
 /*
-- 
2.44.0


