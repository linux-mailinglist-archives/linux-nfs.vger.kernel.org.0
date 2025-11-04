Return-Path: <linux-nfs+bounces-16006-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46661C31C2D
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 16:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B343AF4EE
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF8523EABA;
	Tue,  4 Nov 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukIqrdyv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42022D7A1
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268808; cv=none; b=FvrjHss1XqfFbNq9eV3Ft6r6JzPu29usoD3vtxRtL/farKx+BHQ4k3odM1+uuhYRvdwuYB2cRle1tYx315wTBrRbEBV4HD0SljBurTXvtUW/pVRzz0fwB8kpX6KWoFWci90GemE+JDiXV6hmLwdYy37fbuOGNR64fdcgOZrRd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268808; c=relaxed/simple;
	bh=lJ/AVCXPjoMzTtYgiU30MnVGNvChdOFA9BpNFK27slg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI2+QkeStb49VYTYTMg14AFOFFEanEPXZswTqNLmF6gGVCgN/KTCd7Fpr12hJ1A1Gj+SJhOsMP5vgsGyZdsmzBCpSQbJzxBy3df4UTjbRxYjam2aGT9qkmD5fUgPRrFUJmH10kQfRpYyLt6VTPl+TM2q3SJws1KbSRX9KRIPGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukIqrdyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E354EC19422;
	Tue,  4 Nov 2025 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762268808;
	bh=lJ/AVCXPjoMzTtYgiU30MnVGNvChdOFA9BpNFK27slg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ukIqrdyvUm6xkFG68os9KdxtWQpVRB+l6CgRPmlCXrC8Ad5lQPi48DJb9iKeH1h0z
	 k/7CM2ZBrWuilKtXM48opIbmBi24irI95eeSZeOg0DRlcVydeYJAkTWBOCAxr8vAqD
	 HbN2B+Rvf+V1MTb57NShKCM8lB5Z+SxjmP2LGseR1Q/LGmeQnMvdN9tBkP7tIUah+A
	 dWdkW8Xf0L7LItuzTTwj9gWgQhjKa9e48jG6M7gDIrerU1PEMKJiIJtMA+lvSZK21C
	 VoKW0cQhS6NkbPEe142pO8dHxFUNuK/nr1Spg3m8SLvAHgZUtNEtHNbcramBR6aHnc
	 fw3o7RLvHAhkA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 3/5] NFS: Request a directory delegation during RENAME
Date: Tue,  4 Nov 2025 10:06:43 -0500
Message-ID: <20251104150645.719865-4-anna@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104150645.719865-1-anna@kernel.org>
References: <20251104150645.719865-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

If we notice that we're renaming a file within a directory then we take
that as a sign that the user is working with the current directory and
may want a delegation to avoid extra revalidations when possible.

The nfs_request_directory_delegation() function exists within the NFS v4
module, so I add an extra flag to rename_setup() to indicate if a dentry
is being renamed within the same parent directory.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs3proc.c       | 3 ++-
 fs/nfs/nfs4proc.c       | 5 ++++-
 fs/nfs/proc.c           | 3 ++-
 fs/nfs/unlink.c         | 3 ++-
 include/linux/nfs_xdr.h | 3 ++-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index a4cb67573aa7..1181f9cc6dbd 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -483,7 +483,8 @@ nfs3_proc_unlink_done(struct rpc_task *task, struct inode *dir)
 static void
 nfs3_proc_rename_setup(struct rpc_message *msg,
 		struct dentry *old_dentry,
-		struct dentry *new_dentry)
+		struct dentry *new_dentry,
+		struct inode *same_parent)
 {
 	msg->rpc_proc = &nfs3_procedures[NFS3PROC_RENAME];
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bd718a270e72..fa176db362c7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5047,7 +5047,8 @@ static int nfs4_proc_unlink_done(struct rpc_task *task, struct inode *dir)
 
 static void nfs4_proc_rename_setup(struct rpc_message *msg,
 		struct dentry *old_dentry,
-		struct dentry *new_dentry)
+		struct dentry *new_dentry,
+		struct inode *same_parent)
 {
 	struct nfs_renameargs *arg = msg->rpc_argp;
 	struct nfs_renameres *res = msg->rpc_resp;
@@ -5058,6 +5059,8 @@ static void nfs4_proc_rename_setup(struct rpc_message *msg,
 		nfs4_inode_make_writeable(old_inode);
 	if (new_inode)
 		nfs4_inode_return_delegation(new_inode);
+	if (same_parent)
+		nfs_request_directory_delegation(same_parent);
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_RENAME];
 	res->server = NFS_SB(old_dentry->d_sb);
 	nfs4_init_sequence(&arg->seq_args, &res->seq_res, 1, 0);
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 63e71310b9f6..39df80e4ae6f 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -353,7 +353,8 @@ static int nfs_proc_unlink_done(struct rpc_task *task, struct inode *dir)
 static void
 nfs_proc_rename_setup(struct rpc_message *msg,
 		struct dentry *old_dentry,
-		struct dentry *new_dentry)
+		struct dentry *new_dentry,
+		struct inode *same_parent)
 {
 	msg->rpc_proc = &nfs_procedures[NFSPROC_RENAME];
 }
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index b55467911648..4db818c0f9dd 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -390,7 +390,8 @@ nfs_async_rename(struct inode *old_dir, struct inode *new_dir,
 
 	nfs_sb_active(old_dir->i_sb);
 
-	NFS_PROTO(data->old_dir)->rename_setup(&msg, old_dentry, new_dentry);
+	NFS_PROTO(data->old_dir)->rename_setup(&msg, old_dentry, new_dentry,
+					old_dir == new_dir ? old_dir : NULL);
 
 	return rpc_run_task(&task_setup_data);
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 8bf6cba96c46..79fe2dfb470f 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1808,7 +1808,8 @@ struct nfs_rpc_ops {
 	int	(*unlink_done) (struct rpc_task *, struct inode *);
 	void	(*rename_setup)  (struct rpc_message *msg,
 			struct dentry *old_dentry,
-			struct dentry *new_dentry);
+			struct dentry *new_dentry,
+			struct inode *same_parent);
 	void	(*rename_rpc_prepare)(struct rpc_task *task, struct nfs_renamedata *);
 	int	(*rename_done) (struct rpc_task *task, struct inode *old_dir, struct inode *new_dir);
 	int	(*link)    (struct inode *, struct inode *, const struct qstr *);
-- 
2.51.2


