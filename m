Return-Path: <linux-nfs+bounces-3870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B17F990A1BC
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34ED91F21047
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B85134AC;
	Mon, 17 Jun 2024 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4BnAkp5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CF12B95
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587514; cv=none; b=hcoCeF19FiWwyUW/tgcIeqveoETsqqU33uNudJb+ONpWNFBNaY4RiMSUpY6xp/iAEypA8+b+xJBGM+fJWG+FzHaHzkZGpcipOeVa/snAYTVI8AboE1Wr/6Sy+l/ko6si+5BECvAn5jp0ekztKlMtRXGGq7chcE1rmLYHBAYikxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587514; c=relaxed/simple;
	bh=MMc8J6b6YoZc4TwATPCCUoltPjQ4HT6/s1fY8ZZ+Obg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSgvrySQFIFTzwzqFDWGUOKoQdU35TqLAwj0A/8QjwzbmAVp7xuDddvRPHnzq6NdznnsiCiUY49RvJ/L+YZsf+mCCUnN4Msn83T4oxk9Vy/7ccSEf7BQZvYLVLRyZ8kpVuerWtaR5OvvJY09tHHOZBD2S7OJ0IgqPUrV2HdJNAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4BnAkp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16761C4AF49
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587514;
	bh=MMc8J6b6YoZc4TwATPCCUoltPjQ4HT6/s1fY8ZZ+Obg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E4BnAkp596vFRdiMTO0a7p7dSszSfRqxFVeK2uYMFIWicIve00zZaXjDUVq7OhcsH
	 KUesy9HFMSfg5ae2aqwtfBVQfQVgSiK2zgy4GgA/4/xgtLBfRUQ7iSlfQgJPKgvyRp
	 Y1Pud3qAuCcSTAwObkx6/9My0nGdrb/7ZwgeqFrafDO7SCdmwaZXuzDlXcbgGqBAVC
	 htrO2nq+GdJ1pTHoj0zfLdac12cUuejTwkV32nNe92Q7RmJPDUBtZulCCT8oQ+YbB6
	 LKLhXhDbuQ/jlalAUUdCMFWpgvC1wRCStGtXJu2UJgao8VUU3q7/FXKR9AxiltzNLI
	 hdTTrryHIJY4A==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 11/19] NFSv4: Delegreturn must set m/atime when they are delegated
Date: Sun, 16 Jun 2024 21:21:29 -0400
Message-ID: <20240617012137.674046-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-11-trondmy@kernel.org>
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
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

If the atime or mtime attributes were delegated, then we need to
propagate their new values back to the server when returning the
delegation.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c |  9 +++++----
 fs/nfs/delegation.h |  4 +++-
 fs/nfs/nfs4proc.c   | 27 ++++++++++++++++++++++++---
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index d9117630e062..d5edb3b3eeef 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -266,7 +266,9 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 	}
 }
 
-static int nfs_do_return_delegation(struct inode *inode, struct nfs_delegation *delegation, int issync)
+static int nfs_do_return_delegation(struct inode *inode,
+				    struct nfs_delegation *delegation,
+				    int issync)
 {
 	const struct cred *cred;
 	int res = 0;
@@ -275,9 +277,8 @@ static int nfs_do_return_delegation(struct inode *inode, struct nfs_delegation *
 		spin_lock(&delegation->lock);
 		cred = get_cred(delegation->cred);
 		spin_unlock(&delegation->lock);
-		res = nfs4_proc_delegreturn(inode, cred,
-				&delegation->stateid,
-				issync);
+		res = nfs4_proc_delegreturn(inode, cred, &delegation->stateid,
+					    delegation, issync);
 		put_cred(cred);
 	}
 	return res;
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 001551e2ab60..71524d34ed20 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -70,7 +70,9 @@ void nfs_test_expired_all_delegations(struct nfs_client *clp);
 void nfs_reap_expired_delegations(struct nfs_client *clp);
 
 /* NFSv4 delegation-related procedures */
-int nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred, const nfs4_stateid *stateid, int issync);
+int nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
+			  const nfs4_stateid *stateid,
+			  struct nfs_delegation *delegation, int issync);
 int nfs4_open_delegation_recall(struct nfs_open_context *ctx, struct nfs4_state *state, const nfs4_stateid *stateid);
 int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state, const nfs4_stateid *stateid);
 bool nfs4_copy_delegation_stateid(struct inode *inode, fmode_t flags, nfs4_stateid *dst, const struct cred **cred);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1209ce22158e..88edeaf5b5d5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6739,7 +6739,10 @@ static const struct rpc_call_ops nfs4_delegreturn_ops = {
 	.rpc_release = nfs4_delegreturn_release,
 };
 
-static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred, const nfs4_stateid *stateid, int issync)
+static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
+				  const nfs4_stateid *stateid,
+				  struct nfs_delegation *delegation,
+				  int issync)
 {
 	struct nfs4_delegreturndata *data;
 	struct nfs_server *server = NFS_SERVER(inode);
@@ -6791,12 +6794,27 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 		}
 	}
 
+	if (delegation &&
+	    test_bit(NFS_DELEGATION_DELEGTIME, &delegation->flags)) {
+		if (delegation->type & FMODE_READ) {
+			data->sattr.atime = inode_get_atime(inode);
+			data->sattr.atime_set = true;
+		}
+		if (delegation->type & FMODE_WRITE) {
+			data->sattr.mtime = inode_get_mtime(inode);
+			data->sattr.mtime_set = true;
+		}
+		data->args.sattr_args = &data->sattr;
+		data->res.sattr_res = true;
+	}
+
 	if (!data->inode)
 		nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1,
 				   1);
 	else
 		nfs4_init_sequence(&data->args.seq_args, &data->res.seq_res, 1,
 				   0);
+
 	task_setup_data.callback_data = data;
 	msg.rpc_argp = &data->args;
 	msg.rpc_resp = &data->res;
@@ -6814,13 +6832,16 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 	return status;
 }
 
-int nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred, const nfs4_stateid *stateid, int issync)
+int nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
+			  const nfs4_stateid *stateid,
+			  struct nfs_delegation *delegation, int issync)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct nfs4_exception exception = { };
 	int err;
 	do {
-		err = _nfs4_proc_delegreturn(inode, cred, stateid, issync);
+		err = _nfs4_proc_delegreturn(inode, cred, stateid,
+					     delegation, issync);
 		trace_nfs4_delegreturn(inode, stateid, err);
 		switch (err) {
 			case -NFS4ERR_STALE_STATEID:
-- 
2.45.2


