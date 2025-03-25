Return-Path: <linux-nfs+bounces-10879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CB5A70CFA
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 23:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A911E3BB389
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 22:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F8E26A092;
	Tue, 25 Mar 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwocNj84"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22251E1E05
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942128; cv=none; b=oX6k3pozeOrGubq26o5coz7qsY8ICqPfZgD4nrkQTB2kunMAYN8LKQ5fyGxuI9O7kRbpRgmUgx80mVGEuKHSyZJWGXbv1Yj2W5yK/IJC6G2U1/mg4D1k782lgw5NeMLNZPTTuyxHxGJ0SALsve9CeWiucIyYYDAFJjpEK//ZnFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942128; c=relaxed/simple;
	bh=DcyQHC8NeXigx8LMQEI0+AqnIAX0ogTR8+S7SIXGt3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocON7nlBqBnpkFMHMPfeF+C9jU0X0VTo759zYp75etBD61Qj4OMfolyP0Em5lgfxrMfjpaVnrJPLd8gEOoh4nZw2XkuuesSmlXGpTCv7cmlVf9ysPkzuh9SyfwcCJ40ghWEWw/s520zqAIGBRjxnUjdfmFGB5oxAjT/g56nrIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwocNj84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3A6C4CEE9;
	Tue, 25 Mar 2025 22:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742942127;
	bh=DcyQHC8NeXigx8LMQEI0+AqnIAX0ogTR8+S7SIXGt3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwocNj84U0h7tp7kxY1yTSR60t5qO5BH/A7HxA//1GCi+Ik8hnDPWl1+SY2Gnhhk2
	 jD76bogWbm+n8OePm1dgljJ9mr8Fpw358CXimAuRkOnEp2aqf7Q6fdQ9yI6uzvgBF4
	 JJpxNDo0pKpw8mMma/As7Z9u5BgBy09Sye5IcVq3sAK4DZ2a+wNWFovY8wtVQvbIcJ
	 I36spt6nP1x6CQ26SUq4irn2OaqzKJTuR6c7UV690LeU5M9kCNahJsEFYhRJHKlH10
	 MOgeTwkwDgQ1joA5CmeUT1Aw360qh8k2kvjzGneb3yeZGtDi4KWxpQjFBCjS6bLZ6n
	 XNIAqz4Sr+0DQ==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v3 4/6] NFSv4: Further cleanups to shutdown loops
Date: Tue, 25 Mar 2025 18:35:21 -0400
Message-ID: <668e25098cb97187d084d5fa2916ddd4d2a68e00.1742941932.git.trond.myklebust@hammerspace.com>
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

Replace the tests for the RPC client being shut down with tests for
whether the nfs_client is in an error state.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c  | 2 +-
 fs/nfs/nfs4state.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 889511650ceb..50be54e0f578 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9580,7 +9580,7 @@ static void nfs41_sequence_call_done(struct rpc_task *task, void *data)
 		return;
 
 	trace_nfs4_sequence(clp, task->tk_status);
-	if (task->tk_status < 0 && !task->tk_client->cl_shutdown) {
+	if (task->tk_status < 0 && clp->cl_cons_state >= 0) {
 		dprintk("%s ERROR %d\n", __func__, task->tk_status);
 		if (refcount_read(&clp->cl_count) == 1)
 			return;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 542cdf71229f..f1f7eaa97973 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1198,7 +1198,7 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 	struct rpc_clnt *clnt = clp->cl_rpcclient;
 	bool swapon = false;
 
-	if (clnt->cl_shutdown)
+	if (clp->cl_cons_state < 0)
 		return;
 
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
-- 
2.49.0


