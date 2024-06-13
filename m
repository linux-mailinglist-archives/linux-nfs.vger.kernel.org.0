Return-Path: <linux-nfs+bounces-3720-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E773906305
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D27A1C2234A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D06134414;
	Thu, 13 Jun 2024 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHOncNjS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A35E1339A4
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252271; cv=none; b=cpK41/vB49R1a9UBrqrC18a82p+qoAuGyGSK0YnGJsJXZ8eWfdyoNelnEgP8o5Bvv7yzZUfos6O0XZ+eFeQhsZwPT2J0ch71BCPEXumN8qXiCVqISS+lrJIeBCuwwNDbjG05b37ZJnLx0u1YB5c7ymHsnEMI4ip6OJIap+Xt3yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252271; c=relaxed/simple;
	bh=xX1I07808zeQLJDKalOIwpnPcqOJ7GBLddGiJO+Bhp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3zMufONTUEaTv/vHZ+sLaRYsvEGvlhfnL7BiZ7XuAgkddrCKvbOEAdGYR8FFI8q4wcEQsH+HidpMzXrbTbarucw1IcZ5+7Slx6smH4mOUU5S0rjvSaGlhAdQmFm7WNCtHPoTGeqdqsaLkOQlnKBfnQmVhkFlVM0KKpEzTRhN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHOncNjS; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b065d12e81so3150506d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252269; x=1718857069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XiA5qEzlqnxVRasj1LKRioRSNf661cBYZKDDv6Cs9o=;
        b=XHOncNjSbVTunyHAHlyaTqJOFcnKD3R4Ffj5zgt0yn/Gl58fITTC5phzDNYGhpur8F
         2vtjYMzLk5R3o5xzbjijh3Dx3Q3i93Qbl4fDwS4hXXed6Xg4MXkFS62qHimP2pXwazVx
         uDztXqtIMMm8E6KdGsTVpZmK61dIo3nuD55uCuotN2trFlx0bMWsAJP4wr+jCa6D0+Ep
         6US9rjEjTrKwFpeA9WNVO0+zuEqZR2HiUOROmuZoJppYFowChWlbDkfMF4ZwIAmNht2A
         sr795/HYXBWaDqJp1T3T/dk7YYoR/tPZCaCakGNU7eEWLHwdnWZKpkVnlaLpzbhnJbvw
         VuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252269; x=1718857069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XiA5qEzlqnxVRasj1LKRioRSNf661cBYZKDDv6Cs9o=;
        b=Q6OPq68Vdv0lO5fo7oCIbJWlUlWFZVqYObjoTPr/VnkM3KhZQwl3EX4wp/a/wROINP
         gahYeK3qmb/YaMzlTIL0WgVP//UfxOfSya8WzLqIeAJYDY6spHylrYC1aB+HYfR8L53p
         YHuBymIuZXIjYD9C8S7HQIO1UmnPleWMw6TDjHXf4fL9PcqQpUEOsZJgC6Nm/svD5mQS
         6uzg2Nn1qiA2qA9FfCR9JUY67p5MBEhgwZr/hXKncLRIXqTBfr4Ns2/Ku+TfaZuoklQy
         sO++dMnIweWKe0ZaQ83dxo2+w9gStvksoi5ScZl1vJVpAqgFEyUb7qAUwgyiPkRrH8+8
         ihfA==
X-Gm-Message-State: AOJu0YzeG7LlFs5dKQEh5+SNbQhXTww31KhtN88Ng9TF95L08ylSbDn7
	Lh0jK9vgiMtOQ9c/30C++fM2Auo75uHBAH9oci1KYH7Izz53MaXV6AYE
X-Google-Smtp-Source: AGHT+IGvt5Fv/+p32/j8GfB6rbUmAUGksJVcvLQU2zLGpjYVEBxGHI/dJT5dJzrxUpxI8ZrOLXmUwA==
X-Received: by 2002:a05:6214:419d:b0:6b0:6f20:fed5 with SMTP id 6a1803df08f44-6b1a79dc1a7mr39812106d6.49.1718252268520;
        Wed, 12 Jun 2024 21:17:48 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:48 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 11/19] NFSv4: Delegreturn must set m/atime when they are delegated
Date: Thu, 13 Jun 2024 00:11:28 -0400
Message-ID: <20240613041136.506908-12-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-11-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
 <20240613041136.506908-9-trond.myklebust@hammerspace.com>
 <20240613041136.506908-10-trond.myklebust@hammerspace.com>
 <20240613041136.506908-11-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
---
 fs/nfs/delegation.c |  9 +++++----
 fs/nfs/delegation.h |  4 +++-
 fs/nfs/nfs4proc.c   | 27 ++++++++++++++++++++++++---
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index e72eead06c08..d8f4a1cdbc8e 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -258,7 +258,9 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 	}
 }
 
-static int nfs_do_return_delegation(struct inode *inode, struct nfs_delegation *delegation, int issync)
+static int nfs_do_return_delegation(struct inode *inode,
+				    struct nfs_delegation *delegation,
+				    int issync)
 {
 	const struct cred *cred;
 	int res = 0;
@@ -267,9 +269,8 @@ static int nfs_do_return_delegation(struct inode *inode, struct nfs_delegation *
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
index 2e9ad83acf2c..da910e2e98a4 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -72,7 +72,9 @@ void nfs_test_expired_all_delegations(struct nfs_client *clp);
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
index 140ff1d75320..b0c1564a7bc7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6718,7 +6718,10 @@ static const struct rpc_call_ops nfs4_delegreturn_ops = {
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
@@ -6770,12 +6773,27 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
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
@@ -6793,13 +6811,16 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
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


