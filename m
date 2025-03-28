Return-Path: <linux-nfs+bounces-10945-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B02A74F9E
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 18:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF0516A259
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460C61DD0E1;
	Fri, 28 Mar 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAL9Ws6g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097414A0BC
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183647; cv=none; b=QjS0wD0gOe8QBqz4+IDx6YsGgI48THuBS33ofgou8AiqOR7QyxzbD880/ZvRF6Vp9VxPkpHhpiR6hunh6y2/D5UctsxA08nudBsLcUd6DyFbj2ZoqohPW+GOcPuC/TY95VXfzkeEOpvq/a6XRSkr2S7/zQpGmuhomhJEYodO2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183647; c=relaxed/simple;
	bh=4c2rOecK9oRM6oomxtn/firHHgPLaQtrey6KIPyxRF0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xfv34ETHeXlkTHilXyk2QDmYX1ZI3zH8sU1T6ltwlG4nAmnVgM2cLZX16FdTHWCd0BhktTngJry+gD2xODUjgopaAbD9p79x1ppqQDPZJ1nsl+yuX6/t2+b7/IrnL6276KvC2zNpC5sjYpDdqMaI6klXvfU326IXtvXu686g7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAL9Ws6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C986BC4CEEA
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743183647;
	bh=4c2rOecK9oRM6oomxtn/firHHgPLaQtrey6KIPyxRF0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tAL9Ws6gIBJ4Qq3rSyt4GSwnEQg8WMDche7CSv4Z2UYtereIaftOV1vhwPgj9/xn7
	 8dNswM02b6mO8MHBH/JUgLzOPtpoP6xhzB2FJt3fQlaUUI57552DuSPGOrU5YnJvix
	 SfBPaxzh+hpNMjvGJrqnjB65U+vq7Sm4+Lo1D30WLDWJUpea6x3fRRlA4IzwaG0PuA
	 xNPM7MCD8hQziFuAUI7Wnli82Sd6BFOtxul8Ru1eJXFf63ZUX7JvyXfDrbqgDECUeL
	 JI0HeexgMuuSH7Iqat33kD55F9kAN3IYUbx/nly/aY7uJ3BcRKBK+vQPd4x19BUKBA
	 ZXGwMqWENd91w==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Don't allow waiting for exiting tasks
Date: Fri, 28 Mar 2025 13:40:45 -0400
Message-ID: <f12bc922d95858ffea1649d64767f342e1a190fd.1743183579.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <f301a88d04e1929a313c458bd8ce1218903b648a.1743183579.git.trond.myklebust@hammerspace.com>
References: <f301a88d04e1929a313c458bd8ce1218903b648a.1743183579.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Once a task calls exit_signals() it can no longer be signalled. So do
not allow it to do killable waits.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c    | 2 ++
 fs/nfs/internal.h | 5 +++++
 fs/nfs/nfs3proc.c | 2 +-
 fs/nfs/nfs4proc.c | 9 +++++++--
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 1aa67fca69b2..119e447758b9 100644
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
index fae2c7ae4acc..2133b3c20bad 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -912,6 +912,11 @@ static inline u32 nfs_stateid_hash(nfs4_stateid *stateid)
 }
 #endif
 
+static inline bool nfs_current_task_exiting(void)
+{
+	return (current->flags & PF_EXITING) != 0;
+}
+
 static inline bool nfs_error_is_fatal(int err)
 {
 	switch (err) {
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 0c3bc98cd999..c1736dbb92b6 100644
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
index 50be54e0f578..da97f87ecaa9 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -446,6 +446,8 @@ static int nfs4_delay_killable(long *timeout)
 {
 	might_sleep();
 
+	if (unlikely(nfs_current_task_exiting()))
+		return -EINTR;
 	__set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 	schedule_timeout(nfs4_update_delay(timeout));
 	if (!__fatal_signal_pending(current))
@@ -457,6 +459,8 @@ static int nfs4_delay_interruptible(long *timeout)
 {
 	might_sleep();
 
+	if (unlikely(nfs_current_task_exiting()))
+		return -EINTR;
 	__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE_UNSAFE);
 	schedule_timeout(nfs4_update_delay(timeout));
 	if (!signal_pending(current))
@@ -1777,7 +1781,8 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 		rcu_read_unlock();
 		trace_nfs4_open_stateid_update_wait(state->inode, stateid, 0);
 
-		if (!fatal_signal_pending(current)) {
+		if (!fatal_signal_pending(current) &&
+		    !nfs_current_task_exiting()) {
 			if (schedule_timeout(5*HZ) == 0)
 				status = -EAGAIN;
 			else
@@ -3581,7 +3586,7 @@ static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
 		write_sequnlock(&state->seqlock);
 		trace_nfs4_close_stateid_update_wait(state->inode, dst, 0);
 
-		if (fatal_signal_pending(current))
+		if (fatal_signal_pending(current) || nfs_current_task_exiting())
 			status = -EINTR;
 		else
 			if (schedule_timeout(5*HZ) != 0)
-- 
2.49.0


