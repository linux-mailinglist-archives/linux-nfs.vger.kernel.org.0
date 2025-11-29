Return-Path: <linux-nfs+bounces-16785-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F6EC937CC
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 05:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AF4C34A6AD
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 04:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AECB21423C;
	Sat, 29 Nov 2025 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfydgK0X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F73C17
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764389194; cv=none; b=jING+8KbMvsdpeHsu/wWdFBtiloW9bZX0ftCtwKpILYsZuIBq0zWCdJORliwazbY298WC5L9PQ9IeOKFg3dmUVbv5rG0G0czqh36OZw3+p9NWpkvYvU0J/ZSyMR5tJFEMgDiVZRdBPUEM6bs3LJs2KBuKjXSqTYonzVAh8s1bVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764389194; c=relaxed/simple;
	bh=Z67r9BBJD71v/e7pBmq+09B1mKT8uJmqnzNAp4dz98A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kB5hLRv8QmRBD0ahpy2XKLUa1FVGxcYmY/Qd+1ex5u3C1zutcK1rQ2nTKsxSPfIq2GoQInoj/Zvy6S4YQgAFVzLGeLR6rQ6oErjJ7/Bt2iA2SGJQKH3Jrua5/0UKWdy6fBLfS2msUVffHX7JzZHnTxPpo/CAYjABYaQb94VwIBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfydgK0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBF6C4CEFB;
	Sat, 29 Nov 2025 04:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764389194;
	bh=Z67r9BBJD71v/e7pBmq+09B1mKT8uJmqnzNAp4dz98A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfydgK0XJb6VIseyRrpD5OenKWVzdSgI1umt1G9Ge5SnP7ecsy7E0pG6BNxD73g5a
	 cks9nGcEG4CmcP54sJn0mQn1pKZjXReJ9CauH8vGkgzRWM+lKMbK2BJin3SB1OLTDf
	 CzDNmlbulI/dNbdtPH1F+Bxzg4h8RHhOhlAEFANx1+uecpwmIISPhP2SPVzj5/DGE5
	 dNCMAP+msxFR/dMSGAXZ0g5acgDlSaBLNz0p37MhC3o7Jrc5ROOndPFlY6o0CqXPB9
	 hex2NRH3Dxd59GstkG5spFPTVOO4A7rmH5AAEB6NfX7oKa/9g1gQcfj6oByZaWwRUk
	 7c3lyEd7Tcltg==
From: Trond Myklebust <trondmy@kernel.org>
To: Alkis Georgopoulos <alkisg@gmail.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/6] Revert "nfs: ignore SB_RDONLY when remounting nfs"
Date: Fri, 28 Nov 2025 23:06:27 -0500
Message-ID: <d5c503cdb7d4f773d0037367a45a52faeba0dfaf.1764388528.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764388528.git.trond.myklebust@hammerspace.com>
References: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com> <cover.1764388528.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This reverts commit 80c4de6ab44c14e910117a02f2f8241ffc6ec54a.

Silently ignoring the "ro" and "rw" mount options causes user confusion,
and is a regression.

Reported-by: Alkis Georgopoulos<alkisg@gmail.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>
Fixes: 80c4de6ab44c ("nfs: ignore SB_RDONLY when remounting nfs")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/super.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 72dee6f3050e..527000f5d150 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1051,16 +1051,6 @@ int nfs_reconfigure(struct fs_context *fc)
 
 	sync_filesystem(sb);
 
-	/*
-	 * The SB_RDONLY flag has been removed from the superblock during
-	 * mounts to prevent interference between different filesystems.
-	 * Similarly, it is also necessary to ignore the SB_RDONLY flag
-	 * during reconfiguration; otherwise, it may also result in the
-	 * creation of redundant superblocks when mounting a directory with
-	 * different rw and ro flags multiple times.
-	 */
-	fc->sb_flags_mask &= ~SB_RDONLY;
-
 	/*
 	 * Userspace mount programs that send binary options generally send
 	 * them populated with default values. We have no way to know which
-- 
2.52.0


