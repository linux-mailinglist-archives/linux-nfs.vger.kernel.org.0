Return-Path: <linux-nfs+bounces-4022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1D690DD36
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 22:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CF5284DC9
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 20:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA41741F4;
	Tue, 18 Jun 2024 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5Zn/KLs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A371741F2
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742008; cv=none; b=mKM0D2RUjGZhD2kbdJsx4vl/MH3MNALiBBdZiJBHTPRvhQWNXRmg1Oso1uS1Yt2YhXz8pO4fzIsD9YrooC0fF3WErVYSCJNyCsBNQVbsU4Sc0MxBhw7yio3XwWMmZi36atc2PLgopSCoydUPe/nL3zAu+azm1LnxkXSQUfFMclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742008; c=relaxed/simple;
	bh=+VhZPtOcWDWjNyUpwAsxKx4UiC1ph91VogY+peSTyBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYbQPCBqjMu/IAusjqPKd2IVcVPKAA6mZ6SzrFYThTLBlht6K9Lcb+o8ogMl5HzaRgT/fpP1Jg/tgdTYS0Jc5s0/+9HFX3yjFJUxY0WrNqbpyJDxYz18gCQxCKcWs3EBn3tqrMK+/DpQinUaLQG+nEDZfPFqO65o38A0MtJsovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5Zn/KLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623BBC3277B;
	Tue, 18 Jun 2024 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718742008;
	bh=+VhZPtOcWDWjNyUpwAsxKx4UiC1ph91VogY+peSTyBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5Zn/KLsIuoUbatzodQxjK0Emo8dwQzBv9JdJ52k9y4HUvSCLuFmfp8nMjc5L3yuz
	 bP0n77QNdz2XHhdJf4DqhneSeQ4U7+HwMXuNLUpxqmKAloQ97LnsoUDv2bJUV7pBaV
	 JptK+yf7qmMvKB32k/xzogEdIwft5Krl01mCBsEKyPt5nZY1OT7bW+UNds0f6XM6CD
	 okChJya/hVE8R6VtBJ2XteN/RSFxrQnVTkC95oP9jNV3EvetthGYpkE602KOt+kcKy
	 y7zvrw6p+G84qciS3nN4Kmo9Kp7my9RuQ6Dd2oR/ZxdUraTybqKQBGd6HB3x9N7Gz3
	 an0R83ZBSpeuA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v5 14/19] nfsd/localio: manage netns reference in nfsd_open_local_fh
Date: Tue, 18 Jun 2024 16:19:44 -0400
Message-ID: <20240618201949.81977-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618201949.81977-1-snitzer@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use maybe_get_net() and put_net() in nfsd_open_local_fh().
Also refactor nfsd_open_local_fh() slightly.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/localio.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 34678bfed579..cdf8e115b33e 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -104,18 +104,11 @@ nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
 
 static struct svc_rqst *
 nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
-			const struct cred *cred)
+			const struct cred *cred, struct svc_serv *serv)
 {
 	struct svc_rqst *rqstp;
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int status;
 
-	/* FIXME: not running in nfsd context, must get reference on nfsd_serv */
-	if (unlikely(!READ_ONCE(nn->nfsd_serv))) {
-		dprintk("%s: localio denied. Server not running\n", __func__);
-		return ERR_PTR(-ENXIO);
-	}
-
 	rqstp = kzalloc(sizeof(*rqstp), GFP_KERNEL);
 	if (!rqstp)
 		return ERR_PTR(-ENOMEM);
@@ -125,13 +118,13 @@ nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
 		status = -ENOMEM;
 		goto out_err;
 	}
-
 	rqstp->rq_xprt->xpt_net = net;
+
 	__set_bit(RQ_SECURE, &rqstp->rq_flags);
 	rqstp->rq_proc = 1;
 	rqstp->rq_vers = 3;
 	rqstp->rq_prot = IPPROTO_TCP;
-	rqstp->rq_server = nn->nfsd_serv;
+	rqstp->rq_server = serv;
 
 	/* Note: we're connecting to ourself, so source addr == peer addr */
 	rqstp->rq_addrlen = rpc_peeraddr(rpc_clnt,
@@ -193,28 +186,44 @@ int nfsd_open_local_fh(struct net *net,
 			 const fmode_t fmode,
 			 struct file **pfilp)
 {
+	struct nfsd_net *nn;
 	const struct cred *save_cred;
 	struct svc_rqst *rqstp;
 	struct svc_fh fh;
 	struct nfsd_file *nf;
 	int status = 0;
 	int mayflags = NFSD_MAY_LOCALIO;
+	struct svc_serv *serv;
 	__be32 beres;
 
+	if (nfs_fh->size > NFS4_FHSIZE)
+		return -EINVAL;
+
+	/* Not running in nfsd context, must safely get reference on nfsd_serv */
+	net = maybe_get_net(net);
+	if (!net) {
+		dprintk("%s: localio denied. Server netns not available\n", __func__);
+		return -ENXIO;
+	}
+	nn = net_generic(net, nfsd_net_id);
+
+	serv = READ_ONCE(nn->nfsd_serv);
+	if (unlikely(!serv)) {
+		dprintk("%s: localio denied. Server not running\n", __func__);
+		status = -ENXIO;
+		goto out_net;
+	}
+
 	/* Save creds before calling into nfsd */
 	save_cred = get_current_cred();
 
-	rqstp = nfsd_local_fakerqst_create(net, rpc_clnt, cred);
+	rqstp = nfsd_local_fakerqst_create(net, rpc_clnt, cred, serv);
 	if (IS_ERR(rqstp)) {
 		status = PTR_ERR(rqstp);
 		goto out_revertcred;
 	}
 
 	/* nfs_fh -> svc_fh */
-	if (nfs_fh->size > NFS4_FHSIZE) {
-		status = -EINVAL;
-		goto out;
-	}
 	fh_init(&fh, NFS4_FHSIZE);
 	fh.fh_handle.fh_size = nfs_fh->size;
 	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
@@ -230,17 +239,15 @@ int nfsd_open_local_fh(struct net *net,
 		dprintk("%s: fh_verify failed %d\n", __func__, status);
 		goto out_fh_put;
 	}
-
 	*pfilp = get_file(nf->nf_file);
-
 	nfsd_file_put(nf);
 out_fh_put:
 	fh_put(&fh);
-
-out:
 	nfsd_local_fakerqst_destroy(rqstp);
 out_revertcred:
 	revert_creds(save_cred);
+out_net:
+	put_net(net);
 	return status;
 }
 EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
-- 
2.44.0


