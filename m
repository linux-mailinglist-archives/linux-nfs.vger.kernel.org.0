Return-Path: <linux-nfs+bounces-4096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FF090F79F
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24831C22019
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D0E15958E;
	Wed, 19 Jun 2024 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llTT5V/r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C631591F3
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829643; cv=none; b=ktkT/HMYSUonzVEutoS5hiX48t6TaMSvThgSk2Kv45uq6MZzyxEXqQk1TR5kOtCYhg4wLGgRUDvmuuIX6xVC9FoCmNqyH9BUrokAofuA4/CHWp0RVampvJUFcC2p/4tfZL2KfKzRYlxknU6qATPqIIkNe9iop8cOxtFXyUN0NGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829643; c=relaxed/simple;
	bh=T55cTPW5qP6dqOWHwB8vLj8iL18KbzL5QZhNnku5foo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlWcgDBtzFJeW2fQxEXW5+k/82tKBRMcDJEXWCjurgczkXs4hJG+89k8bw/uBlH/her5wDIPiOSveqSh9j7dDv40fMxr27wC1r0bx2IETmIHUadbQ7gRGN7wrzwn1GeI3hWZD4r21xH+7EZWZjXnhFbAQlWa60Xh1xzI6g6jFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llTT5V/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64142C4AF08;
	Wed, 19 Jun 2024 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829643;
	bh=T55cTPW5qP6dqOWHwB8vLj8iL18KbzL5QZhNnku5foo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llTT5V/r4JCEoqrm7bNWAzPGMShEGYehi/M+e7GjpGnu6ulzH2hd3GVR+dsQE22S0
	 EfJsXC0dhrC3t9l+gCG2Ud9maalmPq5lFjjKKb/x8+LtMDoeloFaOiGe8sdqSfRu35
	 xFoK0bWMXpIrKp4IqE/lXeFRYRNtE0UHiVMN1DdZUatQMOSNDbd8JtiIO0ety6Efb0
	 ByrWhKIwNAWG8KYXwYbYjcj/lnGpTxVaaOrVWq5huX8UE15OrNwdinpnaUf0ZKX2Ii
	 GnOtS0RuIXpyTi2d0Nqk9ck5iysIeWq4L0N6WpKjO4RxW6fW5xq+wfFIbmMAPoGp9w
	 OOQNUKLPNBFHQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v6 07/18] nfsd/localio: manage netns reference in nfsd_open_local_fh
Date: Wed, 19 Jun 2024 16:40:21 -0400
Message-ID: <20240619204032.93740-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619204032.93740-1-snitzer@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
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
index e9aa0997f898..f6df66b1d523 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -99,18 +99,11 @@ nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
 
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
@@ -120,13 +113,13 @@ nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
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
@@ -188,28 +181,44 @@ int nfsd_open_local_fh(struct net *net,
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
@@ -225,17 +234,15 @@ int nfsd_open_local_fh(struct net *net,
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


