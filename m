Return-Path: <linux-nfs+bounces-5771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77CF95F498
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 17:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7217C1F226E4
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 15:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AC813BACC;
	Mon, 26 Aug 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQfNrHAt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8141E892;
	Mon, 26 Aug 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684896; cv=none; b=oHyX+KEgPKNN3LFryXakcfRsj1ZwpbPKoapL6LNoPUfFt2W/d5jz+ktNQxaN9qse9D7WnoEvM7pb4GVxWUkzXCmK2AReLhFoVK9y6up1BOAstWK+DBIgDwKYk/69o0HAsIePVBQuSns+3p7MmPdF5gyDs4uEhiT8iUDun5PjoiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684896; c=relaxed/simple;
	bh=nESy1bZKUzMFIPhgaxtlTbG62TuQTsA4+4HBKa5jyA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHKBjKc+Ja2Yr/zSUAZaXobIOFsnghNwe6Hyue0lHORCLq0dcOf4w+v0u6SyMxohTZ7M0V1fcqDfEYPoM6dF8Cp0e8+jhFYOwPZjAbUDp8gd390MKi43MaOsW1v6HIDGqvuTOfwjnjRs7ptrzsGrbjNaJ+tKtLZDcjH/0QaQ6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQfNrHAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673D5C4FF63;
	Mon, 26 Aug 2024 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724684896;
	bh=nESy1bZKUzMFIPhgaxtlTbG62TuQTsA4+4HBKa5jyA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQfNrHAtk8AkOioqLHT8fd475CbfwChsR0W1XjZMdXo7sDfi4+y8Io7a5npIilvaK
	 5NIEkTAAZ+vJbwL4fbxvQGkk1XSM8RBaviqHZ6ygkgd/bSCcpYofQhRAFFLeSAktAM
	 +KHS9Jrblb0VSDRQBrtsUkjLzJ5mPxgwrTme9+2t6g2fVEyfmfa4Xis+xJBdQ424Iv
	 pzip65JJXG+oYdl/vjGvs5GcgjckFIpU/zgqwDAGte2VeMTlx104KgrVj24QQp5lRi
	 ap9U7KkrJWxJ2RduuT1MAj5YYfz9RgKSxGhWI8UAyGfEbnj8oFFPspC3msnA7NC8b2
	 aPsl4SLf/D69w==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	lilingfeng3@huawei.com,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH 6.1.y 7/7] nfsd: Fix a regression in nfsd_setattr()
Date: Mon, 26 Aug 2024 11:07:03 -0400
Message-ID: <20240826150703.13987-8-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240826150703.13987-1-cel@kernel.org>
References: <20240826150703.13987-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 6412e44c40aaf8f1d7320b2099c5bdd6cb9126ac ]

Commit bb4d53d66e4b ("NFSD: use (un)lock_inode instead of
fh_(un)lock for file operations") broke the NFSv3 pre/post op
attributes behaviour when doing a SETATTR rpc call by stripping out
the calls to fh_fill_pre_attrs() and fh_fill_post_attrs().

Fixes: bb4d53d66e4b ("NFSD: use (un)lock_inode instead of fh_(un)lock for file operations")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Message-ID: <20240216012451.22725-1-trondmy@kernel.org>
[ cel: adjusted to apply to v6.1.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 4 ++++
 fs/nfsd/vfs.c      | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7451cd34710d..df9dbd93663e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1106,6 +1106,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	};
 	struct inode *inode;
 	__be32 status = nfs_ok;
+	bool save_no_wcc;
 	int err;
 
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
@@ -1131,8 +1132,11 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
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
index 17e96e58e772..8f6d611d1380 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -475,7 +475,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int		accmode = NFSD_MAY_SATTR;
 	umode_t		ftype = 0;
 	__be32		err;
-	int		host_err;
+	int		host_err = 0;
 	bool		get_write_count;
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
 	int		retries;
@@ -533,6 +533,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	inode_lock(inode);
+	fh_fill_pre_attrs(fhp);
 	for (retries = 1;;) {
 		struct iattr attrs;
 
@@ -560,13 +561,14 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		attr->na_aclerr = set_posix_acl(&init_user_ns,
 						inode, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
+	fh_fill_post_attrs(fhp);
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
2.45.1


