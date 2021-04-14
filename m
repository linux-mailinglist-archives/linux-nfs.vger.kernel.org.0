Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F12E35F534
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351563AbhDNNoh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351599AbhDNNoV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E7A7611B0
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407840;
        bh=4ZfclsLNuZRrWn1g9V2Ry7g8wqo+pwCWaRNsFa+00vk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KNc4vxJ1fT2j6PYg5AHxpm89swNSVzMLgFcKO4aF92SnEctcww7UQUaOuWQhHTVN2
         AT+lNreVKupagpb0coUh47V6bqR+k2H+1CeCh5LXJI39rawymmLbncGHy2zxVJGIVF
         uITkv8WeraT1kYMSanSCfxLcou2VYenrhW60Jh3mJ9OrpxvW3FsPE0EUMphiu/AZQU
         wzlyJK/8CtOLlorJXrZaWk7tuPKfBeYM1uhy7zvJzV+RK/9JgJ7us00mF/ESK0qGW4
         Q/XxE57qZAr6Vzzvatu3Lb7uezyDcxjFOfMONJL4BZpu2KTL236VUxTAmvp8iXzFF+
         9DafdITDFxYlg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 12/26] NFSv4: Fix nfs4_bitmap_copy_adjust()
Date:   Wed, 14 Apr 2021 09:43:39 -0400
Message-Id: <20210414134353.11860-13-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-12-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
 <20210414134353.11860-9-trondmy@kernel.org>
 <20210414134353.11860-10-trondmy@kernel.org>
 <20210414134353.11860-11-trondmy@kernel.org>
 <20210414134353.11860-12-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Don't remove flags from the set retrieved from the cache_validity.
We do want to retrieve all attributes that are listed as being
invalid, whether or not there is a delegation set.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a490f1373765..8dc595ce40ca 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -284,7 +284,7 @@ const u32 nfs4_fs_locations_bitmap[3] = {
 };
 
 static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
-		struct inode *inode)
+				    struct inode *inode, unsigned long flags)
 {
 	unsigned long cache_validity;
 
@@ -292,22 +292,19 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	if (!inode || !nfs4_have_delegation(inode, FMODE_READ))
 		return;
 
-	cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
-	if (!(cache_validity & NFS_INO_REVAL_FORCED))
-		cache_validity &= ~(NFS_INO_INVALID_CHANGE
-				| NFS_INO_INVALID_SIZE);
+	cache_validity = READ_ONCE(NFS_I(inode)->cache_validity) | flags;
 
+	/* Remove the attributes over which we have full control */
+	dst[1] &= ~FATTR4_WORD1_RAWDEV;
 	if (!(cache_validity & NFS_INO_INVALID_SIZE))
 		dst[0] &= ~FATTR4_WORD0_SIZE;
 
 	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
 		dst[0] &= ~FATTR4_WORD0_CHANGE;
-}
 
-static void nfs4_bitmap_copy_adjust_setattr(__u32 *dst,
-		const __u32 *src, struct inode *inode)
-{
-	nfs4_bitmap_copy_adjust(dst, src, inode);
+	if (!(cache_validity & NFS_INO_INVALID_OTHER))
+		dst[1] &= ~(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER |
+			    FATTR4_WORD1_OWNER_GROUP);
 }
 
 static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dentry,
@@ -3344,12 +3341,15 @@ static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 		.inode = inode,
 		.stateid = &arg.stateid,
 	};
+	unsigned long adjust_flags = NFS_INO_INVALID_CHANGE;
 	int err;
 
+	if (sattr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID))
+		adjust_flags |= NFS_INO_INVALID_OTHER;
+
 	do {
-		nfs4_bitmap_copy_adjust_setattr(bitmask,
-				nfs4_bitmask(server, olabel),
-				inode);
+		nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, olabel),
+					inode, adjust_flags);
 
 		err = _nfs4_do_setattr(inode, &arg, &res, cred, ctx);
 		switch (err) {
@@ -4157,8 +4157,7 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	if (inode && (server->flags & NFS_MOUNT_SOFTREVAL))
 		task_flags |= RPC_TASK_TIMEOUT;
 
-	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, label), inode);
-
+	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, label), inode, 0);
 	nfs_fattr_init(fattr);
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
 	return nfs4_do_call_sync(server->client, server, &msg,
@@ -4764,8 +4763,8 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 	}
 
 	nfs4_inode_make_writeable(inode);
-	nfs4_bitmap_copy_adjust_setattr(bitmask, nfs4_bitmask(server, res.label), inode);
-
+	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, res.label), inode,
+				NFS_INO_INVALID_CHANGE);
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	if (!status) {
 		nfs4_update_changeattr(dir, &res.cinfo, res.fattr->time_start,
-- 
2.30.2

