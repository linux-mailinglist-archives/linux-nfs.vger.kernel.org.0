Return-Path: <linux-nfs+bounces-18057-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AFFD388F6
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 613543020248
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F6330BB88;
	Fri, 16 Jan 2026 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7qCShUN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA392FD69D
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600300; cv=none; b=euvOSYubKiYhGDx8CFcwtNHZNq1U8DjYFkG/AZkySz8mn3kFG0oBxipblwOlS/o98MdazGb4s/0vT/fmMVMKGHafjPesKCz9ycEWYK/6iHbe78xkuGBfWibiExqMpa0G75L3hir2qglw95va2YHP0SYQGGpeJw8AGY6rBxbye90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600300; c=relaxed/simple;
	bh=gFUlx0IwSfj3hIPTZ6awsfM6q5N3bsSHJYkf49n+de8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJytZI7Tla6u4jmbpv8IIM7kaRAyal8pUnIzXxZxue6TE9qazBGKdNi8tmpKVawHPUV1WLPAufWXEDzAse+m13YyRvg4+qv+oPTOxIAzqs3gplDdF+c38WOXJx1aypLQxDWq8K/ECqcvRZBKmIkZfM0czNCGb7nI0B3+DP3eNKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7qCShUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235C5C19422;
	Fri, 16 Jan 2026 21:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600300;
	bh=gFUlx0IwSfj3hIPTZ6awsfM6q5N3bsSHJYkf49n+de8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7qCShUNmcnmSIVXXubDMqmDrxTfXPfvneRbsed75W1Kj3UoE9xA+u2+rQ8zMFJ0I
	 /gmWtFeglGicxIYVWtaq3Urs/Ex2tdkY8fxuYY2HZhIOy2AfBUj3vpyctFAFmfBumA
	 yFs940Khm8qRVUs4ZWhGtDPDFkZxlDu1g5j+/mdTS9EBMAknQW437DX4XTm9tMXWag
	 f0uT8R6jRAWtARWDWKF8aPS1MAQeJouh+SRh6pU8emExh07UAQUn+EEryHpY3fPser
	 5bN0Z34oUhhWw9NK/a2vFHOETJyON3DekTkgrxONLG+Fs/kkXgZJccqduIzD8AUYO0
	 0niAX5wnoVDxw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 07/14] NFS: Make the various NFS v4.0 operations static again
Date: Fri, 16 Jan 2026 16:51:28 -0500
Message-ID: <20260116215135.846062-8-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116215135.846062-1-anna@kernel.org>
References: <20260116215135.846062-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

They don't need to be visible outside of nfs40proc.c anymore now that
the minor version ops have been moved over.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs40.h     |  5 -----
 fs/nfs/nfs40proc.c | 10 +++++-----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
index 05ba9f1afe7c..272e1ffdb161 100644
--- a/fs/nfs/nfs40.h
+++ b/fs/nfs/nfs40.h
@@ -4,11 +4,6 @@
 
 
 /* nfs40proc.c */
-extern const struct rpc_call_ops nfs40_call_sync_ops;
-extern const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops;
-extern const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops;
-extern const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops;
-extern const struct nfs4_mig_recovery_ops nfs40_mig_recovery_ops;
 extern const struct nfs4_minor_version_ops nfs_v4_0_minor_ops;
 
 /* nfs40state.c */
diff --git a/fs/nfs/nfs40proc.c b/fs/nfs/nfs40proc.c
index 36802f9b94b5..5968a3318d14 100644
--- a/fs/nfs/nfs40proc.c
+++ b/fs/nfs/nfs40proc.c
@@ -309,12 +309,12 @@ nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
 	rpc_call_async(server->client, &msg, 0, &nfs4_release_lockowner_ops, data);
 }
 
-const struct rpc_call_ops nfs40_call_sync_ops = {
+static const struct rpc_call_ops nfs40_call_sync_ops = {
 	.rpc_call_prepare = nfs40_call_sync_prepare,
 	.rpc_call_done = nfs40_call_sync_done,
 };
 
-const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops = {
+static const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops = {
 	.owner_flag_bit = NFS_OWNER_RECLAIM_REBOOT,
 	.state_flag_bit	= NFS_STATE_RECLAIM_REBOOT,
 	.recover_open	= nfs4_open_reclaim,
@@ -323,7 +323,7 @@ const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops = {
 	.detect_trunking = nfs40_discover_server_trunking,
 };
 
-const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops = {
+static const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops = {
 	.owner_flag_bit = NFS_OWNER_RECLAIM_NOGRACE,
 	.state_flag_bit	= NFS_STATE_RECLAIM_NOGRACE,
 	.recover_open	= nfs40_open_expired,
@@ -331,13 +331,13 @@ const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops = {
 	.establish_clid = nfs4_init_clientid,
 };
 
-const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops = {
+static const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops = {
 	.sched_state_renewal = nfs4_proc_async_renew,
 	.get_state_renewal_cred = nfs4_get_renew_cred,
 	.renew_lease = nfs4_proc_renew,
 };
 
-const struct nfs4_mig_recovery_ops nfs40_mig_recovery_ops = {
+static const struct nfs4_mig_recovery_ops nfs40_mig_recovery_ops = {
 	.get_locations = _nfs40_proc_get_locations,
 	.fsid_present = _nfs40_proc_fsid_present,
 };
-- 
2.52.0


