Return-Path: <linux-nfs+bounces-1986-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75909857371
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 02:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D191F21359
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Feb 2024 01:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29302DDD5;
	Fri, 16 Feb 2024 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbrEylSx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614ADDCA
	for <linux-nfs@vger.kernel.org>; Fri, 16 Feb 2024 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047059; cv=none; b=urxm6s6HhJFq/qWmaYAG/H3PYmQS6O5u6eJb1bHo3oPXVkeiJzLTJ9VxtYKb97t5gbSlno+Z5RDljpYnpCFgQzjuNacfTkumssrieSKoZmrRKpzvr/Lc0JV3uKu+kzO5CSFuYm6RZ/pj/NL0U3NuVEwI39ilH0POEqUnfJWL0Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047059; c=relaxed/simple;
	bh=K2r88S6cZi6tCN9L7+wCpRGMETyM9mzs8iy+JwXd4aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJU/MUp92+mkc437jQnkewnMyLlpFPCdnIvRhsG5WlelTlpHBq7hpY7IuO0+qudVSS79OVEwuTsOt5aqEP9j6w+GynPDB8yDDck8NzxvGzmcpxhi+5af2Q8bi7RhM2N7/e5JtIZNHJn5htTWwhpVCLjBSchHUUovPZw3GDjzYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbrEylSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34366C433C7;
	Fri, 16 Feb 2024 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708047058;
	bh=K2r88S6cZi6tCN9L7+wCpRGMETyM9mzs8iy+JwXd4aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbrEylSxPHLryrJ7wiM/Tq2uHaEx8o2UWmU06RbzDw/VOtQFrsfJZJwVr4EfUti/2
	 5z5GRuhLr2lV3KI5gt3SeMgTLNp9ucfZMNKt4MkZLy8CrOlGxP2htTVhkz5t90bmMg
	 9dPbI/tuQODrHhRhWsANkeThbDs9twxrXoolJGBQzdAcczgrT+renz9BfaoEFz0L2E
	 cdFFu5LlcMJ9b3O7vX/C6vkhjGnx8FtIxSKKeW3Qw4FH5RUlu1i8pMJvG1qWEi3UiG
	 ChRGGFyP859MxFlVO9sWpRr4woPB96P1Vi6P95OvwWyxbqLkavgw1+LrbpXgZGXHuw
	 lvfVtklJ4W9BA==
From: trondmy@kernel.org
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
Date: Thu, 15 Feb 2024 20:24:50 -0500
Message-ID: <20240216012451.22725-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216012451.22725-1-trondmy@kernel.org>
References: <20240216012451.22725-1-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Commit bb4d53d66e4b broke the NFSv3 pre/post op attributes behaviour
when doing a SETATTR rpc call by stripping out the calls to
fh_fill_pre_attrs() and fh_fill_post_attrs().

Fixes: bb4d53d66e4b ("NFSD: use (un)lock_inode instead of fh_(un)lock for file operations")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4proc.c | 4 ++++
 fs/nfsd/vfs.c      | 9 +++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 14712fa08f76..e6d8624efc83 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1143,6 +1143,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	};
 	struct inode *inode;
 	__be32 status = nfs_ok;
+	bool save_no_wcc;
 	int err;
 
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
@@ -1168,8 +1169,11 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (status)
 		goto out;
+	save_no_wcc = cstate->current_fh.fh_no_wcc;
+	cstate->current_fh.fh_no_wcc = true;
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
 				0, (time64_t)0);
+	cstate->current_fh.fh_no_wcc = save_no_wcc;
 	if (!status)
 		status = nfserrno(attrs.na_labelerr);
 	if (!status)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6e7e37192461..58fab461bc00 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -497,7 +497,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int		accmode = NFSD_MAY_SATTR;
 	umode_t		ftype = 0;
 	__be32		err;
-	int		host_err;
+	int		host_err = 0;
 	bool		get_write_count;
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
 	int		retries;
@@ -555,6 +555,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	inode_lock(inode);
+	err = fh_fill_pre_attrs(fhp);
+	if (err)
+		goto out_unlock;
 	for (retries = 1;;) {
 		struct iattr attrs;
 
@@ -582,13 +585,15 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->na_aclerr = set_posix_acl(&nop_mnt_idmap,
 						dentry, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
+	fh_fill_post_attrs(fhp);
+out_unlock:
 	inode_unlock(inode);
 	if (size_change)
 		put_write_access(inode);
 out:
 	if (!host_err)
 		host_err = commit_metadata(fhp);
-	return nfserrno(host_err);
+	return err != 0 ? err : nfserrno(host_err);
 }
 
 #if defined(CONFIG_NFSD_V4)
-- 
2.43.1


