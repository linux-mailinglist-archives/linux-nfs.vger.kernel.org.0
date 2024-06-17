Return-Path: <linux-nfs+bounces-3876-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B1590A1C3
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FC9281994
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B541BF31;
	Mon, 17 Jun 2024 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxJcBA7b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6031BDDC
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587517; cv=none; b=t0N3ApowPY1GCKrwvRzvdxAwQbMiAJWHyNIvCRtm4r7WYWUXqiClWynvPV9fybYHc/fHATQoyHpo4nhQF2MBMwQ7daQEjfCKf2g98cjRYuJEfLqvQX2QQHpHSHnbSVB7rreEi/BE7u2JSbfFHI68T3HqvTE/eqG1fT894szSgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587517; c=relaxed/simple;
	bh=KJP2iSMWQBuh+7wO42DkRYuG4KvCEOCWBOaqkHbAkZs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ak3hOo8TBuxPNuZDVR6vKrKXynZBOuzfv4kRqkDfdZ2UfA+CyKR+10bjjoeaV61F+2h6qmCFYoPivAe/ZkA63a5hTquNp4rQic58lJJUmkno+DgcW3spu0NANYuG+p3xj2s/U0YOFsFJTe9cBiwa5+uIASn5m2nlLVUQnIExipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxJcBA7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785B8C32786
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587516;
	bh=KJP2iSMWQBuh+7wO42DkRYuG4KvCEOCWBOaqkHbAkZs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GxJcBA7b5cs/8pcep2n85PmuyQysntqYvOyWoBkKiclrRTmsTs+pyheeyl+K60xGR
	 +h6MZbKA+EZ0MAiZbFmDlHHenymlJu6UHe3Mda8vDiyaCRZLlQgmj4sI4El4ivsmDK
	 sqgSxIQr3oSWfwD+hGm+1WER1e+XnJO0yBoJJCNJc+WqRlQbVeOmWp8um841PAOzjs
	 fjYzbR/xLoFscNt7Z32obAmqe3I9pZ5KD1rGU15I2Z6dYcmjj8HJuY29SW8XHKKFyT
	 nbgbun28LnszMEfr8eg1w8RhJEpLSeze4FaPbE8+nmsUx64RvFgZy7LEzedhRy+rYG
	 Ec5rXOA47tZYA==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 17/19] NFSv4: Ask for a delegation or an open stateid in OPEN
Date: Sun, 16 Jun 2024 21:21:35 -0400
Message-ID: <20240617012137.674046-18-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-17-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
 <20240617012137.674046-8-trondmy@kernel.org>
 <20240617012137.674046-9-trondmy@kernel.org>
 <20240617012137.674046-10-trondmy@kernel.org>
 <20240617012137.674046-11-trondmy@kernel.org>
 <20240617012137.674046-12-trondmy@kernel.org>
 <20240617012137.674046-13-trondmy@kernel.org>
 <20240617012137.674046-14-trondmy@kernel.org>
 <20240617012137.674046-15-trondmy@kernel.org>
 <20240617012137.674046-16-trondmy@kernel.org>
 <20240617012137.674046-17-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Turn on the optimisation to allow the client to request that the server
not return the open stateid when it returns a delegation.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5b18aac0b34a..b1376571f6ef 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1358,6 +1358,8 @@ nfs4_map_atomic_open_share(struct nfs_server *server,
 	/* res |= NFS4_SHARE_WANT_NO_PREFERENCE; */
 	if (server->caps & NFS_CAP_DELEGTIME)
 		res |= NFS4_SHARE_WANT_DELEG_TIMESTAMPS;
+	if (server->caps & NFS_CAP_OPEN_XOR)
+		res |= NFS4_SHARE_WANT_OPEN_XOR_DELEGATION;
 out:
 	return res;
 }
-- 
2.45.2


