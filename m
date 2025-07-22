Return-Path: <linux-nfs+bounces-13181-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC71B0DC68
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 16:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72D7164887
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12842989AD;
	Tue, 22 Jul 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwGBS+Bs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA028C2C4
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192718; cv=none; b=ZGoLMJW0DYZrIKhQZh86VlA/+5aqEbhmA6Kdz6ok2X+E6gGviNooTP+cUvS3mkGjwOkLFSs1NqMLM29nlZ+xJgut7U3dG8bT0PfyHactMGtHLMfV3+bTrgk2XXAClPtm+AL4ws/aAhBLfeVDD8AerPzKBFgdVRrpvSXGOtKLG/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192718; c=relaxed/simple;
	bh=M5fw73OVgTnBjJjdlaF/aMrPRgfbt1sOeFNdoflTC5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKG0NT0Fr4Cy3x9JrhZ3xtgXfWuI4+QzgiU/WdJOyM6opqQIR6p/hXhjYkKQb+OT4d96y08XhddkjCay2zYRqIAulHuzT0DA3D97o3TtjYqqp1Ez4L3i03RJ9EWXxfrrlfk6t7ewlSn1HiFc3jCvE3PMP3/Bj5nC7ka7IHIUHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwGBS+Bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F5FC4CEF1;
	Tue, 22 Jul 2025 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753192718;
	bh=M5fw73OVgTnBjJjdlaF/aMrPRgfbt1sOeFNdoflTC5I=;
	h=From:To:Cc:Subject:Date:From;
	b=mwGBS+BsEWq6WC9nPuf5Qrk4JB3VgAsXpuVrAAhnccU3i1cZbe73+/Cc5ny6zniL+
	 DSwsPmqQUT487MeR8A/+UcVwnAING9XDwXAPoDx4jsTp8qFH/rx8fgdAeYtD2JI5ew
	 i44h9ay9d8meLkcu/JcHAVMVf69n6eQ3XIko5n2ZwcgX72GQ7Ulunnf8r9PAkiiFIA
	 JDSnvbxe/mnm52Vq0wOvBjI2GFEYohLwXjrsVTM5EyiG05elZx/GdsSitdLIjt3QhK
	 Z2C5W/NZn5j/0NNShszoNFWd9uy6BQXM9O8M7DnrU7Yl2PM0MU3EUzND6exIjN1ael
	 I+YYkgFrMq50Q==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: zhangjian <zhangjian496@huawei.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] NFS: Fix filehandle bounds checking in nfs_fh_to_dentry()
Date: Tue, 22 Jul 2025 09:58:36 -0400
Message-ID: <ef93a685e01a281b5e2a25ce4e3428cf9371a205.1753192530.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The function needs to check the minimal filehandle length before it can
access the embedded filehandle.

Reported-by: zhangjian <zhangjian496@huawei.com>
Fixes: 20fa19027286 ("nfs: add export operations")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/export.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index e9c233b6fd20..a10dd5f9d078 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -66,14 +66,21 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 {
 	struct nfs_fattr *fattr = NULL;
 	struct nfs_fh *server_fh = nfs_exp_embedfh(fid->raw);
-	size_t fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
+	size_t fh_size = offsetof(struct nfs_fh, data);
 	const struct nfs_rpc_ops *rpc_ops;
 	struct dentry *dentry;
 	struct inode *inode;
-	int len = EMBED_FH_OFF + XDR_QUADLEN(fh_size);
+	int len = EMBED_FH_OFF;
 	u32 *p = fid->raw;
 	int ret;
 
+	/* Initial check of bounds */
+	if (fh_len < len + XDR_QUADLEN(fh_size) ||
+	    fh_len > XDR_QUADLEN(NFS_MAXFHSIZE))
+		return NULL;
+	/* Calculate embedded filehandle size */
+	fh_size += server_fh->size;
+	len += XDR_QUADLEN(fh_size);
 	/* NULL translates to ESTALE */
 	if (fh_len < len || fh_type != len)
 		return NULL;
-- 
2.50.1


