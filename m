Return-Path: <linux-nfs+bounces-10880-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A7A70CFB
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 23:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D77188DE63
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 22:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809BB1E1E05;
	Tue, 25 Mar 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3CRcmhH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1A26A095
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942128; cv=none; b=MP9q3OSvXFUy1ThBFdwaRgEV5lKh0n4LWnPIaBU80NbLa0sxzAAj6+oYgcGGvG1ejgKcOG6152mHEgkFeBRlXab/7caiKbOqqlMj0/2aDC0AhHXPCSldFEw0ZfalUtss/sTGnP8MScWrZ95lEiRm9rAk3XSZlsHVuJ0klJVBmR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942128; c=relaxed/simple;
	bh=DX73LX1hqBy54JZ3tEvbOwWEd5r7ert7pfxGxayirro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXc2VGrVFeR1Z6rHj3p/Le3Z0iAIDE4Iok4w97e0MmLPobxnAMvR7/L29U6OnQjWES+gafffAYVfCdz56QtpBvMBF+sEUAX5QCPF3PGMNf/WVOaPsyQ+Dko5po8yAIqcTllTETVkphe6bXavuAuRWxeoffONlT6SwdzfG90v7jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3CRcmhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9053FC4CEE4;
	Tue, 25 Mar 2025 22:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742942127;
	bh=DX73LX1hqBy54JZ3tEvbOwWEd5r7ert7pfxGxayirro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3CRcmhH58TQmvK+ZspoUFArwfBj4feTzb7+Gik5MOWTR6Ok6H9CVEIxFSRe79fYC
	 GIT4CsetwK8exaG2LhbKtaBqX7MrsTXAnBVvDvdfUlQA+5XLY6Fk2VYCvaith0OHno
	 s/GxZ4XvJBYZ65mn5mvHwG6HuOfRuca7aaPdLkx5Dr1nAAz/aH92F09XHr8YmJ9RoT
	 juNbfs8iEXQpyNqkdu/9FsyywW0WKAn5jW0AGkyOnimPRCWpEO/y93T4mbgGzFIg95
	 MlgobMmBi2ox7U/9A9LXXYdB8XsBhEIYjJxQI/mVo/RnIUFLfwM793ZQNI8tTl0Ttw
	 lNZ86xRxOzljg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v3 5/6] NFSv4: clp->cl_cons_state < 0 signifies an invalid nfs_client
Date: Tue, 25 Mar 2025 18:35:22 -0400
Message-ID: <7059cac07b2bc3c6a249b66326a86a5858f74214.1742941932.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742941932.git.trond.myklebust@hammerspace.com>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If someone calls nfs_mark_client_ready(clp, status) with a negative
value for status, then that should signal that the nfs_client is no
longer valid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f1f7eaa97973..272d2ebdae0f 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1403,7 +1403,7 @@ int nfs4_schedule_stateid_recovery(const struct nfs_server *server, struct nfs4_
 	dprintk("%s: scheduling stateid recovery for server %s\n", __func__,
 			clp->cl_hostname);
 	nfs4_schedule_state_manager(clp);
-	return 0;
+	return clp->cl_cons_state < 0 ? clp->cl_cons_state : 0;
 }
 EXPORT_SYMBOL_GPL(nfs4_schedule_stateid_recovery);
 
-- 
2.49.0


