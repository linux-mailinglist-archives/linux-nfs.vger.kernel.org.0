Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8946B48046E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 20:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhL0TrW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 14:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhL0TrV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Dec 2021 14:47:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1D7C061401
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 11:47:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA908B81144
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 19:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58448C36AEB;
        Mon, 27 Dec 2021 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640634438;
        bh=3bCHbqqwvgIF/fYEkHPvAEzi84mmhLtO6P8W8CQzifE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dd/K27skFKYHAwkySOq9hQSiTSxZMnNi9VzbSxirw0hLo0JqxAeq8VnF7TXlqV6k/
         pzAJBJkqhFmgB53JqMFtjPPJyZxnU3aj0yXPeeY+FzPi1mHIzV+q4Bi2ob1hhuhKvv
         v7Yg/yeO8GLuwwu7cnMy2659Jzk//v7SOseSvNlW9xuGy8ilpLInWLJA8UKPhgf+I5
         pKez19xrBjQ4Z5O1++4lxRZypuUYaMa7KpRiy5kYB2gsgjUY8HcRFSpqnhgIF3XpVN
         99Lh0vsJPxgTWfaL1t5xkxf26tBw2hUCDl4eyeGYrjcl2lcsVxeeAgk2RmHk4ifXrW
         wjfQukCvyy1Qg==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv42: Fallocate and clone should also request 'blocks used'
Date:   Mon, 27 Dec 2021 14:40:52 -0500
Message-Id: <20211227194052.309898-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211227194052.309898-1-trondmy@kernel.org>
References: <20211227194052.309898-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Both fallocate and clone can end up updating the blocks used attribute.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42proc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 8b21ff1be717..32129446beca 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -46,7 +46,7 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 {
 	struct inode *inode = file_inode(filep);
 	struct nfs_server *server = NFS_SERVER(inode);
-	u32 bitmask[3];
+	u32 bitmask[NFS_BITMASK_SZ];
 	struct nfs42_falloc_args args = {
 		.falloc_fh	= NFS_FH(inode),
 		.falloc_offset	= offset,
@@ -69,9 +69,8 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 		return status;
 	}
 
-	memcpy(bitmask, server->cache_consistency_bitmask, sizeof(bitmask));
-	if (server->attr_bitmask[1] & FATTR4_WORD1_SPACE_USED)
-		bitmask[1] |= FATTR4_WORD1_SPACE_USED;
+	nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask, inode,
+			 NFS_INO_INVALID_BLOCKS);
 
 	res.falloc_fattr = nfs_alloc_fattr();
 	if (!res.falloc_fattr)
@@ -1044,13 +1043,14 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 	struct inode *src_inode = file_inode(src_f);
 	struct inode *dst_inode = file_inode(dst_f);
 	struct nfs_server *server = NFS_SERVER(dst_inode);
+	__u32 dst_bitmask[NFS_BITMASK_SZ];
 	struct nfs42_clone_args args = {
 		.src_fh = NFS_FH(src_inode),
 		.dst_fh = NFS_FH(dst_inode),
 		.src_offset = src_offset,
 		.dst_offset = dst_offset,
 		.count = count,
-		.dst_bitmask = server->cache_consistency_bitmask,
+		.dst_bitmask = dst_bitmask,
 	};
 	struct nfs42_clone_res res = {
 		.server	= server,
@@ -1079,6 +1079,9 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 	if (!res.dst_fattr)
 		return -ENOMEM;
 
+	nfs4_bitmask_set(dst_bitmask, server->cache_consistency_bitmask,
+			 dst_inode, NFS_INO_INVALID_BLOCKS);
+
 	status = nfs4_call_sync(server->client, server, msg,
 				&args.seq_args, &res.seq_res, 0);
 	trace_nfs4_clone(src_inode, dst_inode, &args, status);
-- 
2.33.1

