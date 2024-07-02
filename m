Return-Path: <linux-nfs+bounces-4543-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6882D92438B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4808B25A95
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1248D1BD4F7;
	Tue,  2 Jul 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/Fu9VhU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA41BD4E4
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937721; cv=none; b=fTDEtZ03aaUl49CZE7qeAGULQGaP28ccyALYdCbbKCFobYQ7i7dSwyebk7L70sfIzjdUYdx88EveUiVuYONGzrg2LBRe3PN5CjWycFkUlwFzXBg/1nLx0U6tV8CtbQFJMr2E40P6kqboe8cMtGFdIynj8YZfj+6FMnD2d+he2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937721; c=relaxed/simple;
	bh=+bABhOiXZ0VuNJdYVsK1jlsjHSJKy41flP0IxMoIc2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APtegyLAQaNqskZPBgKg3NGw+8ujnhLAwkt0gzqtA51oOVN/ju8SledWr4ZMyB2DgtamINq+5FFL6HcHR2ML7LUhG4CSon2rWCQz1Nf/gBUqNm2oh550daeUWZfV1ya/1UyxpKWa1LSjg71pwtYu//Or8TAQWl5SR5ue6P7WGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/Fu9VhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7765FC4AF0C;
	Tue,  2 Jul 2024 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719937720;
	bh=+bABhOiXZ0VuNJdYVsK1jlsjHSJKy41flP0IxMoIc2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/Fu9VhUQ8R4x+rqgiGKFY80o6salAtxr73aQtPu5T8iWRqj9tl3cjhnCZT8+x1Sg
	 V1w/LSLHfB8EZt/PVinV2A244ZpXhYV/kPd2PdJOUti22iu9oEfylAThX3nGHxbm1z
	 mk8hFcQnGfIzxpj/BRNrCy5XtvHMhNLHAcxICyk7nAb9O6xednG+ex6rsXXixxE6++
	 WclaG+2COcD8HdMIs2Js1QuAfCB/f4gL1CK2AZfUd0Cpj5BFupTAE7GDWgZnacSMEY
	 mC84EeGkKwOwl5kUySgc4B7YA/aBjKaRzdL88PqP7T77wbLW9RBnMFbiyPkVHX4I0I
	 d6A5CRlZn0PQA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v11 06/20] nfsd: manage netns reference in nfsd_open_local_fh
Date: Tue,  2 Jul 2024 12:28:17 -0400
Message-ID: <20240702162831.91604-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240702162831.91604-1-snitzer@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
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
 fs/nfsd/localio.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 2eedeaeab533..0f81c340acc5 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -99,16 +99,11 @@ nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
 
 static struct svc_rqst *
 nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
-			const struct cred *cred)
+			const struct cred *cred, struct svc_serv *serv)
 {
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_rqst *rqstp;
 	int status;
 
-	/* FIXME: not running in nfsd context, must get reference on nfsd_serv */
-	if (unlikely(!READ_ONCE(nn->nfsd_serv)))
-		return ERR_PTR(-ENXIO);
-
 	rqstp = kzalloc(sizeof(*rqstp), GFP_KERNEL);
 	if (!rqstp)
 		return ERR_PTR(-ENOMEM);
@@ -118,10 +113,10 @@ nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
 		status = -ENOMEM;
 		goto out_err;
 	}
-
 	rqstp->rq_xprt->xpt_net = net;
+
 	__set_bit(RQ_SECURE, &rqstp->rq_flags);
-	rqstp->rq_server = nn->nfsd_serv;
+	rqstp->rq_server = serv;
 	/*
 	 * These constants aren't actively used in this fake svc_rqst,
 	 * which bypasses SUNRPC, but they must pass negative checks.
@@ -195,26 +190,39 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
 {
 	int mayflags = NFSD_MAY_LOCALIO;
 	int status = 0;
+	struct nfsd_net *nn;
 	const struct cred *save_cred;
 	struct svc_rqst *rqstp;
 	struct svc_fh fh;
 	struct nfsd_file *nf;
+	struct svc_serv *serv;
 	__be32 beres;
 
+	if (nfs_fh->size > NFS4_FHSIZE)
+		return -EINVAL;
+
+	/* Not running in nfsd context, must safely get reference on nfsd_serv */
+	cl_nfssvc_net = maybe_get_net(cl_nfssvc_net);
+	if (!cl_nfssvc_net)
+		return -ENXIO;
+	nn = net_generic(cl_nfssvc_net, nfsd_net_id);
+
+	serv = READ_ONCE(nn->nfsd_serv);
+	if (unlikely(!serv)) {
+		status = -ENXIO;
+		goto out_net;
+	}
+
 	/* Save creds before calling into nfsd */
 	save_cred = get_current_cred();
 
-	rqstp = nfsd_local_fakerqst_create(cl_nfssvc_net, rpc_clnt, cred);
+	rqstp = nfsd_local_fakerqst_create(cl_nfssvc_net, rpc_clnt, cred, serv);
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
@@ -229,17 +237,15 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
 		status = nfs_stat_to_errno(be32_to_cpu(beres));
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
+	put_net(cl_nfssvc_net);
 	return status;
 }
 EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
-- 
2.44.0


