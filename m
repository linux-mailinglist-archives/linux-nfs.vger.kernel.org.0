Return-Path: <linux-nfs+bounces-5540-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B75295A460
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 20:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171B42836A2
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF14199926;
	Wed, 21 Aug 2024 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxcFX87L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B81B2EE2
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263635; cv=none; b=L8Bso1YV3eRHmggrWqdKTWQ8XloMCb8MISkcxbYOxtMR58czXWbXumJxqwrfkBwr3xh1x0SnjkdmSMYePgTZSw2Ztn97Ue83+xOlBlwH9YgNSdqFE1mD8ldmc9l8RZljlyp7kwS129/yQL46Q7OSw3Hq0oWwH+fdTh7KvCykxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263635; c=relaxed/simple;
	bh=eHJj2SmhuEHcfVH/vtUFAR/Gy9AITO/Lp3HaONhdx64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTXmHO57hK/kg4cvE7aMgsHTxpmYlNQgfoh+pJE0TCV/50l1zN12Y3295OhXLHHvMT8TCIMLGBUdbXKIab/IZs/02RhG9uSQGiTq3mxXrw9Jh2Y16iX5CnGqyxVt6ZJNidCqYK+Emt/BRo5u+KqhUexjQxBcEtCwKFdpfR6zILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxcFX87L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C8AC32786;
	Wed, 21 Aug 2024 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724263634;
	bh=eHJj2SmhuEHcfVH/vtUFAR/Gy9AITO/Lp3HaONhdx64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MxcFX87Lnk0R/6R2/pejvXKUgdDPWLBcGA7nzr04WweZ1ZQC9VRVw8raNcLlokgRK
	 w63wZWXPbobDTgwN7HOzkNbB9ftEzaj4rhEvJBbPTZwqsrCnNbD+Fkp1Qua6+fgT+q
	 5seKPG0ervhveA+bQGBkhH7imiT0h/ei58o3iI9qcD5G6JEdklNl3563/ZSqHux3Fs
	 oPUwmvgnJXPo44Gp+DdQ+Uq6oU0SzVsgXTM4MtVhpF4/UHZ2wYtuM4J2HLr2FHHXBL
	 MyJMG89ABDcb1JTE8BG8Y2NPUhb3VQHEzHt2rdtZf7o6kKtMjljY4tfnxR5yoR/NAI
	 oxZrRaU1SWvhg==
From: trondmy@kernel.org
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Avoid unnecessary rescanning of the per-server delegation list
Date: Wed, 21 Aug 2024 14:05:02 -0400
Message-ID: <3fe20b13641fe569107f1474d17befd8caa0b076.1724263426.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ae213806d1188320ec55b730582705133b51dd22.1724263426.git.trond.myklebust@hammerspace.com>
References: <ae213806d1188320ec55b730582705133b51dd22.1724263426.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the call to nfs_delegation_grab_inode() fails, we will not have
dropped any locks that require us to rescan the list.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index d5edb3b3eeef..20cb2008f9e4 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -647,6 +647,9 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 				prev = delegation;
 			continue;
 		}
+		inode = nfs_delegation_grab_inode(delegation);
+		if (inode == NULL)
+			continue;
 
 		if (prev) {
 			struct inode *tmp = nfs_delegation_grab_inode(prev);
@@ -657,12 +660,6 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 			}
 		}
 
-		inode = nfs_delegation_grab_inode(delegation);
-		if (inode == NULL) {
-			rcu_read_unlock();
-			iput(to_put);
-			goto restart;
-		}
 		delegation = nfs_start_delegation_return_locked(NFS_I(inode));
 		rcu_read_unlock();
 
@@ -1184,7 +1181,6 @@ static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
 	struct inode *inode;
 restart:
 	rcu_read_lock();
-restart_locked:
 	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
 		if (test_bit(NFS_DELEGATION_INODE_FREEING,
 					&delegation->flags) ||
@@ -1195,7 +1191,7 @@ static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
 			continue;
 		inode = nfs_delegation_grab_inode(delegation);
 		if (inode == NULL)
-			goto restart_locked;
+			continue;
 		delegation = nfs_start_delegation_return_locked(NFS_I(inode));
 		rcu_read_unlock();
 		if (delegation != NULL) {
@@ -1318,7 +1314,6 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 
 restart:
 	rcu_read_lock();
-restart_locked:
 	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
 		if (test_bit(NFS_DELEGATION_INODE_FREEING,
 					&delegation->flags) ||
@@ -1330,7 +1325,7 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 			continue;
 		inode = nfs_delegation_grab_inode(delegation);
 		if (inode == NULL)
-			goto restart_locked;
+			continue;
 		spin_lock(&delegation->lock);
 		cred = get_cred_rcu(delegation->cred);
 		nfs4_stateid_copy(&stateid, &delegation->stateid);
-- 
2.46.0


