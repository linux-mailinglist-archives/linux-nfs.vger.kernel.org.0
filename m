Return-Path: <linux-nfs+bounces-11469-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9469AAB3CA
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 06:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97493B2B24
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 04:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE8233CC63;
	Tue,  6 May 2025 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdV7JHiI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559C288C11;
	Mon,  5 May 2025 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486399; cv=none; b=QPT8yV4Vk9Bgv76lDBH7sM9Nz0NSWQZJsJ2p/cj+Pa17SXwYFqkAHlbjV+KexBhr3nLpGKUe0DGKUHvro0ZNmSfKy2cLSmwJSUXB1bPskFJwr+dc9eI4bV1Vtn85GysSxI0opGx58dXkBDeI0OrK4SJwcsIqKm5ZHMm0AuPQdwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486399; c=relaxed/simple;
	bh=SavV+VmMD1SjWmoWMM4EyJ+IPgOkTYI57dkpii0g+7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJkEFMPdvmqQ+6oyTiQfURwfzAUtCd94oLwHOCZwC0r41kwi4e7zYOc7xWcd0IoqYLUBhGf8KJ+w0phuQwgoxcArj7xcwpjmkHJW2kRCqQM44TffOUIsRLaIg7Ti47g46aQeqXgUkuSjYb7hSXSwYqFAdIQTePtC5GdbrMlERmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdV7JHiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784C3C4CEE4;
	Mon,  5 May 2025 23:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486398;
	bh=SavV+VmMD1SjWmoWMM4EyJ+IPgOkTYI57dkpii0g+7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tdV7JHiI7gJxP/LHlm0BxAUXanHQbBLx+qVK6ZCg4UVFwITooJAkfpsnWsVUnQWPn
	 8KoB/LzS06b9Z3LHDmeQEsCdJqricgXroXx7CVIlPycP/zIW0BwnpH5V+z+IZcT89W
	 lNkrKKdjRAmCPPJ29aoWA52staGaeB4ZWmBMj9ZFGbsJlyCqYo8ZIBhrqfX2ZwvmZM
	 /z/zBMlUp+O15VTyrB5Izm+Blafj6KJxVmNXOjQDxZbkEDYQpFsNgKpHkM3MLIAc3X
	 JMFi5BPCFNG5rR+RYKJTHgqlenbJNnBdSbKDpcuy9mcYVYehjfSRxA/aE/gy+SZ+qT
	 4Wd4WVEtRVJDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 008/212] NFS: Don't allow waiting for exiting tasks
Date: Mon,  5 May 2025 19:03:00 -0400
Message-Id: <20250505230624.2692522-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 8d3ca331026a7f9700d3747eed59a67b8f828cdc ]

Once a task calls exit_signals() it can no longer be signalled. So do
not allow it to do killable waits.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/inode.c    | 2 ++
 fs/nfs/internal.h | 5 +++++
 fs/nfs/nfs3proc.c | 2 +-
 fs/nfs/nfs4proc.c | 9 +++++++--
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 964df0725f4c2..f2e66b946f4b4 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -74,6 +74,8 @@ nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
 
 int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
+	if (unlikely(nfs_current_task_exiting()))
+		return -EINTR;
 	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index ece517ebcca0b..84361674bffc7 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -832,6 +832,11 @@ static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
 				NFS4_STATEID_OTHER_SIZE);
 }
 
+static inline bool nfs_current_task_exiting(void)
+{
+	return (current->flags & PF_EXITING) != 0;
+}
+
 static inline bool nfs_error_is_fatal(int err)
 {
 	switch (err) {
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 2e7579626cf01..f036d30f7515c 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -39,7 +39,7 @@ nfs3_rpc_wrapper(struct rpc_clnt *clnt, struct rpc_message *msg, int flags)
 		__set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 		schedule_timeout(NFS_JUKEBOX_RETRY_TIME);
 		res = -ERESTARTSYS;
-	} while (!fatal_signal_pending(current));
+	} while (!fatal_signal_pending(current) && !nfs_current_task_exiting());
 	return res;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5b06b8d4e0147..57c19a7d9c3e1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -422,6 +422,8 @@ static int nfs4_delay_killable(long *timeout)
 {
 	might_sleep();
 
+	if (unlikely(nfs_current_task_exiting()))
+		return -EINTR;
 	__set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 	schedule_timeout(nfs4_update_delay(timeout));
 	if (!__fatal_signal_pending(current))
@@ -433,6 +435,8 @@ static int nfs4_delay_interruptible(long *timeout)
 {
 	might_sleep();
 
+	if (unlikely(nfs_current_task_exiting()))
+		return -EINTR;
 	__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE_UNSAFE);
 	schedule_timeout(nfs4_update_delay(timeout));
 	if (!signal_pending(current))
@@ -1712,7 +1716,8 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 		rcu_read_unlock();
 		trace_nfs4_open_stateid_update_wait(state->inode, stateid, 0);
 
-		if (!fatal_signal_pending(current)) {
+		if (!fatal_signal_pending(current) &&
+		    !nfs_current_task_exiting()) {
 			if (schedule_timeout(5*HZ) == 0)
 				status = -EAGAIN;
 			else
@@ -3500,7 +3505,7 @@ static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
 		write_sequnlock(&state->seqlock);
 		trace_nfs4_close_stateid_update_wait(state->inode, dst, 0);
 
-		if (fatal_signal_pending(current))
+		if (fatal_signal_pending(current) || nfs_current_task_exiting())
 			status = -EINTR;
 		else
 			if (schedule_timeout(5*HZ) != 0)
-- 
2.39.5


