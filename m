Return-Path: <linux-nfs+bounces-4552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B5924394
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4E71F244F4
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784C1BD4F4;
	Tue,  2 Jul 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKmeWbIe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37FA1BD4E0
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937732; cv=none; b=AMRyk7ZAn3NTSUS9CNdjeRvfK/uVYWQRicFkk1z47cGf6cqfzEjnI5pPgOOZUjRVBHsa1jCtNRbQjLgrcZ/dlBtkglePcjfDlbB3+DOwc3uE9NttLnNFo7eaD6ItuOEpbD+oVnTBtlQIAdXTNsxUBvQ3bZCNGD3XQNM4Av28F5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937732; c=relaxed/simple;
	bh=pgQ6DawDyPNymHjwpcQQHFxYuEKWTOGymf71gARV8Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxHg9fX7cuQkdTQlzAZultGa9SWdT1LYLc/z/VTQ6vn3sk/dLWT/BkLrLbIpXZiv3o7sU0v+GuUd1CejHfkaVfJ/uO+7JE6TEoeWtZpAoRSXxTuqEB2GTxnctRayzLv4ruMpW5v/JfeXLCzQTavnXmas0auWPr1ethJmCEgPJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKmeWbIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA22C116B1;
	Tue,  2 Jul 2024 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719937732;
	bh=pgQ6DawDyPNymHjwpcQQHFxYuEKWTOGymf71gARV8Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKmeWbIeZrecsqAnuwtoN3OWAFdw+8qDNv8AKcUxb654igxrsPnf2SSetJkbxPNlk
	 +y6hHCkmSaO9frBE1p9p+6x/P7tCt5SJqimGEkb7PL+ps/3WCSlSrlfX7gIch52PJY
	 V6DBeFAr9oK/a7iNdcbRzufLbW/stWc2/mrrFTxEWNqiPv72kKe4aE5JcJ7RFVQV1t
	 GbOm4D4Ab7/6EdDKhbWkuI25RIs5I13SgMl1Y9ivzcZu+JA9kc+XjiZyon/TltzoWT
	 wdV4/orfPqmy6XExhkDiImnv+7ghDGhBP+j3zcm5rAs7rE0aoz+iQE7E6H1ltkOEPr
	 usTI/B9bV8RYQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v11 15/20] nfs: enable localio for non-pNFS I/O
Date: Tue,  2 Jul 2024 12:28:26 -0400
Message-ID: <20240702162831.91604-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240702162831.91604-1-snitzer@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
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
index 7b7dbbefee03..031027983c16 100644
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


