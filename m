Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE1934DCB3
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhC3AAp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhC3AAe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:00:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5588F61924
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617062433;
        bh=5XKWHBDzd26btc+yr2YhTpbi5lIcie23fo7eZOLrVdA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uX/N93IT5ECoGJ+MoyPsC6CfbW+Y2NBjGWuOwjM0/fxyZxOTXhXv0mrb05iD9vbLT
         yw3O8lGI+I2Sw/oE5/3mJQZGLLEBLGSFeBfPbfJnSxATJXyxynlwCbMOHtNZfJE4MN
         3GOu4bZLPNuC2sBNh+qX4RliSnqDd9OnRvYJDvgsfDmaJtUR04xpA1EXgciwHjlcfh
         q4Qfpb1dQ5vYevB8NSlfbduSGZQQi1kelsxxxMzq3i+Sgv/5+nOmcO7WpSG6AuIKGn
         mlvwsolkea7vnVEa1GY0fVPh3EFEMhpcs9dIoOLZiglnZ6rkXhNhHJLhboPzLgWNAZ
         ppZaYEe5ymQUg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Fix attribute bitmask in _nfs42_proc_fallocate()
Date:   Mon, 29 Mar 2021 20:00:29 -0400
Message-Id: <20210330000029.41426-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330000029.41426-1-trondmy@kernel.org>
References: <20210330000029.41426-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We can't use nfs4_fattr_bitmap as a bitmask, because it hasn't been
filtered to represent the attributes supported by the server. Instead,
let's revert to using server->cache_consistency_bitmask after adding in
the missing SPACE_USED attribute.

Fixes: 913eca1aea87 ("NFS: Fallocate should use the nfs4_fattr_bitmap")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42proc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 094024b0aca1..597005bc8a05 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -46,11 +46,12 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 {
 	struct inode *inode = file_inode(filep);
 	struct nfs_server *server = NFS_SERVER(inode);
+	u32 bitmask[3];
 	struct nfs42_falloc_args args = {
 		.falloc_fh	= NFS_FH(inode),
 		.falloc_offset	= offset,
 		.falloc_length	= len,
-		.falloc_bitmask	= nfs4_fattr_bitmap,
+		.falloc_bitmask	= bitmask,
 	};
 	struct nfs42_falloc_res res = {
 		.falloc_server	= server,
@@ -68,6 +69,10 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 		return status;
 	}
 
+	memcpy(bitmask, server->cache_consistency_bitmask, sizeof(bitmask));
+	if (server->attr_bitmask[1] & FATTR4_WORD1_SPACE_USED)
+		bitmask[1] |= FATTR4_WORD1_SPACE_USED;
+
 	res.falloc_fattr = nfs_alloc_fattr();
 	if (!res.falloc_fattr)
 		return -ENOMEM;
@@ -75,7 +80,8 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 	status = nfs4_call_sync(server->client, server, msg,
 				&args.seq_args, &res.seq_res, 0);
 	if (status == 0)
-		status = nfs_post_op_update_inode(inode, res.falloc_fattr);
+		status = nfs_post_op_update_inode_force_wcc(inode,
+							    res.falloc_fattr);
 
 	kfree(res.falloc_fattr);
 	return status;
-- 
2.30.2

