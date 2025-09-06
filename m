Return-Path: <linux-nfs+bounces-14098-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A698AB474E2
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905571BC3E1F
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC00025782A;
	Sat,  6 Sep 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8UgJzsM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966FE2566D2
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176940; cv=none; b=HEmlh/6Tgjg2fkdlLmhRVLwOM0fm57Z2xMbgAspn3+IbsFyDxjbP+sYOGxhhxRrMF2eVnfc7MYJxPeMEECt9C+lC2BYQHQe3ehG9pEhSaoCVRO8eMXdMyQwbYVeaaCnbPH+EqMl3AUVaUpZiMN3dZIAyR1oDLwRUvTl9B9GvbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176940; c=relaxed/simple;
	bh=f/FMjYMiTxAwQhvfGge/JXU+GTgRIYeqDA0d4FKKzJM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3YyEI92XZMxjbnXrOA4De65llTZkYeIf70g9M7rEc/QJRsQXdDzf/uhD5qyAs7957+jwK+/uA5XGzjoddpAlHrb9mSxP83INbMin+ySEpMgNokXO85PswWaJLGPL2tge+ye+9ILDd9LCxVXVh8uoZaXCoJBX3WX+XWZowl93lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8UgJzsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45038C4CEFA
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757176940;
	bh=f/FMjYMiTxAwQhvfGge/JXU+GTgRIYeqDA0d4FKKzJM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=S8UgJzsMKdnF9xZ+J2CJhS06Wjk9ypSdMPNQvUftgxCPij5pL9cQRQ2vLXsY0Ur74
	 nWzEUgH6BeywLJKJjQajqaw+HoBqi2h1GKa44KhX8zd2PSccNIvjAJ226h6qyFaRlV
	 HRHsx4OnEyxod1JaqKAuuEsN2Zs/LRdh8C3hYfa94yHHyccoqWFML8ChAxiGoWEMwN
	 kk7/ELLnmbG7bzJB5Hnzs7HKaRW2HAimxFVoW50NdSgCTNNzJ2jGuLltbC5rmdAGw/
	 8M/DfKs2y0wSs8ZqFpnZgCy31h16mM+vDs58LtsH3kxsCuiHubIxnfm3BvvpLZJwl6
	 ZYm6qfgJ4npHQ==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/8] NFSv4.2: Serialise O_DIRECT i/o and fallocate()
Date: Sat,  6 Sep 2025 12:42:12 -0400
Message-ID: <9f6f5f460e6768992d61d91f1bd88fb9947a090f.1757176392.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757176392.git.trond.myklebust@hammerspace.com>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com> <cover.1757176392.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that all O_DIRECT reads and writes complete before calling
fallocate so that we don't race w.r.t. attribute updates.

Fixes: 99f237832243 ("NFSv4.2: Always flush out writes in nfs42_proc_fallocate()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index e2fea37c5348..1a169372ca16 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -114,6 +114,7 @@ static int nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 	exception.inode = inode;
 	exception.state = lock->open_context->state;
 
+	nfs_file_block_o_direct(NFS_I(inode));
 	err = nfs_sync_inode(inode);
 	if (err)
 		goto out;
-- 
2.51.0


