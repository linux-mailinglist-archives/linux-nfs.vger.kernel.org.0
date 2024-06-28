Return-Path: <linux-nfs+bounces-4397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FB191C7E1
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 23:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A63F1C20DD5
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2849B80024;
	Fri, 28 Jun 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYDBWWrT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E1480023
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609087; cv=none; b=EcZlWA+oDyrKuVYs0aI/tkIEYnDURXoneqVVBypBRYLRbELDuhaaealwxB2NOx728HPYu2u7IWryv86A0ACmUJF6pXp2qWbGGawW7woA9VHmmPzqAANBSq1QFNFQnYNoAkLuNBgUBDp1RhFSx8kdmnQ13rnFkeKwLVITRjoxLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609087; c=relaxed/simple;
	bh=EQ4E1cn5nh5BYeiC1MRbmbwetlghjSzawRU06tXNzz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkbVX93XIOXr9rxtDxyIy/iK64LUOee0keNFOkI44Nv3AXKaT41TLGNXzSmfH0Ete57+3Pec7ATStbbaJo/VxA1HCaKqDjLAFccXHARK0nr69/zxkN34Yza07ASvvDWC+Xa/wlPTOjls3z9WqlI5YuP9BlqL1ZrfmGzzF2+kUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYDBWWrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1C2C116B1;
	Fri, 28 Jun 2024 21:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719609086;
	bh=EQ4E1cn5nh5BYeiC1MRbmbwetlghjSzawRU06tXNzz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYDBWWrTb+el+FsKQlNGq8aiAc9C5aMRO4DOOJFePfV2ISeCRMJhd53qt2UYd07Io
	 KnX4SQb0p1SlEEAiSYs08UhpitbEcp4gBjSORvLUC8CrYmNOT+qno874Ax020CB09r
	 MFBjbTh6NtoMc9nun45RtVpYnn5QUfPJU88TLp5+/2hJwwOe+DqLp43LA/QaGfj5J1
	 10zNa13K47AnLasC4lP8da517eaQmNDeatfshXXc42eDxdEy2WMM00ogUknhtg29A1
	 2u9uqns4Xilyc4zYiull13gOrV26hSEUYlcHsN4oSWbRlfJYAbQDddRIiuRivGMjFq
	 SGVkKOw9Oz+4Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v9 14/19] nfsd/localio: manage netns reference in nfsd_open_local_fh
Date: Fri, 28 Jun 2024 17:11:00 -0400
Message-ID: <20240628211105.54736-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240628211105.54736-1-snitzer@kernel.org>
References: <20240628211105.54736-1-snitzer@kernel.org>
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
index 759a5cb79652..8799ad3ac536 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -101,16 +101,11 @@ nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
 
 static struct svc_rqst *
 nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
-			const struct cred *cred)
+			const struct cred *cred, struct svc_serv *serv)
 {
 	struct svc_rqst *rqstp;
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int status;
 
-	/* FIXME: not running in nfsd context, must get reference on nfsd_serv */
-	if (unlikely(!READ_ONCE(nn->nfsd_serv)))
-		return ERR_PTR(-ENXIO);
-
 	rqstp = kzalloc(sizeof(*rqstp), GFP_KERNEL);
 	if (!rqstp)
 		return ERR_PTR(-ENOMEM);
@@ -120,13 +115,13 @@ nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
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
@@ -184,28 +179,41 @@ int nfsd_open_local_fh(struct net *net,
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
+	if (!net)
+		return -ENXIO;
+	nn = net_generic(net, nfsd_net_id);
+
+	serv = READ_ONCE(nn->nfsd_serv);
+	if (unlikely(!serv)) {
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
@@ -220,17 +228,15 @@ int nfsd_open_local_fh(struct net *net,
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
+	put_net(net);
 	return status;
 }
 EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
-- 
2.44.0


