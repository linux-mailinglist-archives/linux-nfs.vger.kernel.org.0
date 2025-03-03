Return-Path: <linux-nfs+bounces-10431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CBDA4CA59
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EC916D052
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F55722B5AB;
	Mon,  3 Mar 2025 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcDes4po"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B85522CBE3
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023333; cv=none; b=olGIOs6pl8j7Fj6WD3C1hgkUlMhCcW/5+EN0m9m1tkEYn+1Tyvv8jEjvodiY/cfBwezSN8Nj2G1Ny3AgSBdreaCROXEacS4/9U7y2OtgAfebVEjgICKkda2uIk3whCulKD9TVFnAvCjZOu753f9leocFnhDMYpyi2mbuDnRefPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023333; c=relaxed/simple;
	bh=168Jj55IR5jfTLC3cOhyBBHZQ4MAGt9BkCU0cK/oy28=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyl0iVMCVNq8yoAN67sr/kKEZEL8n2wQv+ZT77sohHNKNOVzL/PvpLLkA5cnRjgQdTpZhTvZEKiFkgxZRmyg5R9vMdSYSW5Nxm05DT4P6/Y6Rev49FjfnysbTzJDvEwd2KckN5aDvZHcUTa3ICRJD+CRt9QPnF+UotWkLIxh6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcDes4po; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8847CC4CEF0
	for <linux-nfs@vger.kernel.org>; Mon,  3 Mar 2025 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741023332;
	bh=168Jj55IR5jfTLC3cOhyBBHZQ4MAGt9BkCU0cK/oy28=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LcDes4poi7GOc2yEmmKNlgz9HIAjxJ3AQtz7gyRYM7ShY6FRxmiJmnp3RFJjhUYQw
	 jhbAlB0pOW1YbF7jHvq6ShTkZBBaV6c51TxtradnHFVi7uvqXAiNBr6Ah5Yb1rg2FC
	 w5Jn8UTXuBVKM9vV2QBYRn4pbROP43Vkml6Nky7blQai0eRLYK7meNjfIDr7C3wvTu
	 EgVN58UtXLew9BSOCFf1BzTE8wUZudbUW9TLMOKAukkcfqKh7/F5zMR/sXLy8eHAZO
	 JYY3ORj8GH2c/K9QN9BdUu2UIq2VGuxWZesWGRtEFuWzWrMWr700ZaXfkDKc7/uxyF
	 LSwB6UdY0VAYA==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] NFSv4: Avoid unnecessary scans of filesystems for expired delegations
Date: Mon,  3 Mar 2025 12:35:28 -0500
Message-ID: <dc1b24cf5a44d2677b94b98e1ba66a70fed9ef49.1741023037.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741023037.git.trond.myklebust@hammerspace.com>
References: <cover.1741023037.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The amount of looping through the list of delegations is occasionally
leading to soft lockups.  If the state manager was asked to reap the
expired delegations, it should scan only those filesystems that hold
delegations that need to be reaped.

Fixes: 7f156ef0bf45 ("NFSv4: Clean up nfs_delegation_reap_expired()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c       | 7 +++++++
 include/linux/nfs_fs_sb.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index d1f5e497729c..abd952cc47e4 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -1284,6 +1284,7 @@ static void nfs_mark_test_expired_delegation(struct nfs_server *server,
 		return;
 	clear_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags);
 	set_bit(NFS_DELEGATION_TEST_EXPIRED, &delegation->flags);
+	set_bit(NFS4SERV_DELEGATION_EXPIRED, &server->delegation_flags);
 	set_bit(NFS4CLNT_DELEGATION_EXPIRED, &server->nfs_client->cl_state);
 }
 
@@ -1362,6 +1363,9 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 	nfs4_stateid stateid;
 	unsigned long gen = ++server->delegation_gen;
 
+	if (!test_and_clear_bit(NFS4SERV_DELEGATION_EXPIRED,
+				&server->delegation_flags))
+		return 0;
 restart:
 	rcu_read_lock();
 	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
@@ -1391,6 +1395,9 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 			goto restart;
 		}
 		nfs_inode_mark_test_expired_delegation(server,inode);
+		set_bit(NFS4SERV_DELEGATION_EXPIRED, &server->delegation_flags);
+		set_bit(NFS4CLNT_DELEGATION_EXPIRED,
+			&server->nfs_client->cl_state);
 		iput(inode);
 		return -EAGAIN;
 	}
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 4e9ad6f6e907..7d6f164036fa 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -252,6 +252,7 @@ struct nfs_server {
 
 	unsigned long		delegation_flags;
 #define NFS4SERV_DELEGRETURN		(1)
+#define NFS4SERV_DELEGATION_EXPIRED	(2)
 	unsigned long		delegation_gen;
 	unsigned long		mig_gen;
 	unsigned long		mig_status;
-- 
2.48.1


