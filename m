Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB3348046D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 20:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhL0TrV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 14:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhL0TrV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Dec 2021 14:47:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90DCC06173E
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 11:47:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56CA4B8113A
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 19:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D037BC36AEA;
        Mon, 27 Dec 2021 19:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640634438;
        bh=XN4Dz6hNttV1tZeFHFXjSdFmePMym08qe5huMilWSfI=;
        h=From:To:Cc:Subject:Date:From;
        b=HbQVFFnQ4v6rGDbqYzZAcuVCGdizicDKmynHaBSyh3Fma5+rOnabiIjGUHX+ces70
         OEtv0Ks12+gmRKyx7lE+cXsEGiz5bXrrysUYCBrfPgi6SpctWncNrQuvZ1e+U+ylpy
         qZ9UHPKoLji+XXTie2I4FsPdCxOfax+VxVcGVcVTjh2AFC2eakKaxbRvtI7x1tSF0Z
         anPG7AXNNEgyzsS2NJa7zdB/e3r7yNtp/LPI3odT5sQ6P0CmEh+xADXIP3NmoLuLHt
         HxcqJswvZ5CmHlGdwJ2XaIV+ls4/gl1L+gMLeWGk8D5YhdNEc4jtetj79P1Tv5BMjv
         Oat1iVYur78aA==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4: Allow writebacks to request 'blocks used'
Date:   Mon, 27 Dec 2021 14:40:51 -0500
Message-Id: <20211227194052.309898-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When doing a non-pNFS write, allow the writeback code to specify that it
also needs to update 'blocks used'.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4_fs.h  |  2 ++
 fs/nfs/nfs4proc.c | 21 +++++++--------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index ed5eaca6801e..89076dd32334 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -315,6 +315,8 @@ extern int nfs4_set_rw_stateid(nfs4_stateid *stateid,
 		const struct nfs_open_context *ctx,
 		const struct nfs_lock_context *l_ctx,
 		fmode_t fmode);
+extern void nfs4_bitmask_set(__u32 bitmask[], const __u32 src[],
+			     struct inode *inode, unsigned long cache_validity);
 extern int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 			     struct nfs_fattr *fattr, struct inode *inode);
 extern int update_open_stateid(struct nfs4_state *state,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 535436dbdc9a..ad6076ca7f1e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -108,10 +108,6 @@ static int nfs41_test_stateid(struct nfs_server *, nfs4_stateid *,
 static int nfs41_free_stateid(struct nfs_server *, const nfs4_stateid *,
 		const struct cred *, bool);
 #endif
-static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ],
-			     const __u32 *src, struct inode *inode,
-			     struct nfs_server *server,
-			     struct nfs4_label *label);
 
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 static inline struct nfs4_label *
@@ -3669,7 +3665,7 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
 		if (!nfs4_have_delegation(inode, FMODE_READ)) {
 			nfs4_bitmask_set(calldata->arg.bitmask_store,
 					 server->cache_consistency_bitmask,
-					 inode, server, NULL);
+					 inode, 0);
 			calldata->arg.bitmask = calldata->arg.bitmask_store;
 		} else
 			calldata->arg.bitmask = NULL;
@@ -5421,14 +5417,14 @@ bool nfs4_write_need_cache_consistency_data(struct nfs_pgio_header *hdr)
 	return nfs4_have_delegation(hdr->inode, FMODE_READ) == 0;
 }
 
-static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
-			     struct inode *inode, struct nfs_server *server,
-			     struct nfs4_label *label)
+void nfs4_bitmask_set(__u32 bitmask[], const __u32 src[],
+		      struct inode *inode, unsigned long cache_validity)
 {
-	unsigned long cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
+	struct nfs_server *server = NFS_SERVER(inode);
 	unsigned int i;
 
 	memcpy(bitmask, src, sizeof(*bitmask) * NFS4_BITMASK_SZ);
+	cache_validity |= READ_ONCE(NFS_I(inode)->cache_validity);
 
 	if (cache_validity & NFS_INO_INVALID_CHANGE)
 		bitmask[0] |= FATTR4_WORD0_CHANGE;
@@ -5440,8 +5436,6 @@ static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
 		bitmask[1] |= FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP;
 	if (cache_validity & NFS_INO_INVALID_NLINK)
 		bitmask[1] |= FATTR4_WORD1_NUMLINKS;
-	if (label && label->len && cache_validity & NFS_INO_INVALID_LABEL)
-		bitmask[2] |= FATTR4_WORD2_SECURITY_LABEL;
 	if (cache_validity & NFS_INO_INVALID_CTIME)
 		bitmask[1] |= FATTR4_WORD1_TIME_METADATA;
 	if (cache_validity & NFS_INO_INVALID_MTIME)
@@ -5468,7 +5462,7 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 	} else {
 		nfs4_bitmask_set(hdr->args.bitmask_store,
 				 server->cache_consistency_bitmask,
-				 hdr->inode, server, NULL);
+				 hdr->inode, NFS_INO_INVALID_BLOCKS);
 		hdr->args.bitmask = hdr->args.bitmask_store;
 	}
 
@@ -6506,8 +6500,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 	data->args.fhandle = &data->fh;
 	data->args.stateid = &data->stateid;
 	nfs4_bitmask_set(data->args.bitmask_store,
-			 server->cache_consistency_bitmask, inode, server,
-			 NULL);
+			 server->cache_consistency_bitmask, inode, 0);
 	data->args.bitmask = data->args.bitmask_store;
 	nfs_copy_fh(&data->fh, NFS_FH(inode));
 	nfs4_stateid_copy(&data->stateid, stateid);
-- 
2.33.1

