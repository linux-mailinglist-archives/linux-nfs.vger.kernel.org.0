Return-Path: <linux-nfs+bounces-3965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B6890C108
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 03:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78548282833
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 01:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE5F1C6A3;
	Tue, 18 Jun 2024 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfb6jEi1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3A91C69D
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672977; cv=none; b=R8Fm9XRIIWpiaN2Uq3hAkQF6ppLzX35/YUO7kiXj1wyJfeux+WjwWJEwMLzAsYn/WNODuvod2MZzfzsKMtjKSIkirgOPUYPFuNnViXmdC8T5jPtydjL3YUjfeoAbkyicayAtQ9b4nARYE2jrS8yYLlvXdkrgCk2lrusxdL3a4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672977; c=relaxed/simple;
	bh=+VhZPtOcWDWjNyUpwAsxKx4UiC1ph91VogY+peSTyBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUJkIk87kJSQxnP/iBGtH8dETFV8yCoi0jB6hd28CmV8tc/tZqmC4qHQJwTHFwDzXcRk4W/y3kHhTUsQKfNkEvgnnEEusLCirEXLlNTJdhdl4NnaKVlCg8QOHw8XdrttL7R+ObFvUbHG2dYfV8IeSTWjyqtr+3qh0t5sMwXQWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfb6jEi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C36C2BD10;
	Tue, 18 Jun 2024 01:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718672976;
	bh=+VhZPtOcWDWjNyUpwAsxKx4UiC1ph91VogY+peSTyBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfb6jEi18u8DNfH+tJeIReQx2LCeJ7Wnz57nCfK0tvLclaaLOgSG/Ssh9m2LkQKPy
	 gagyZ3XpCd2XKaC7NVAjPOTySLGYZR2vZ1qbwvFl0vCWAzW/uiXY5S6tDMyWBMcwte
	 z3TxxXGsUzsaNChHIyHw/SGnKM9F/oyDGtrU86FMdl9cYjSLVnUl362RwmkLj3q228
	 HzF1K220d8NMFsYKjm0YRSzHG11sJGs2erPSc7sJsgXGPat40p51U8/AWmvxI+VLOo
	 mQfeoWZ7A9dzF3MbdYv0OP+GXUbYKghCPA0JTfzlN3AbDYZ70rmb8bLjthK3k1wGqy
	 aqDND9iCQZCQA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com,
	axboe@kernel.dk
Subject: [PATCH v4 14/18] nfsd/localio: manage netns reference in nfsd_open_local_fh
Date: Mon, 17 Jun 2024 21:09:13 -0400
Message-ID: <20240618010917.23385-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618010917.23385-1-snitzer@kernel.org>
References: <20240618010917.23385-1-snitzer@kernel.org>
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


