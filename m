Return-Path: <linux-nfs+bounces-4333-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911BB918E54
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C094E1C21F9C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5C019066C;
	Wed, 26 Jun 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qfe211Yd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B519047F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426290; cv=none; b=PRGdCfHHlGd+RDnYmI7o024EPUqLlk0mdXuDwbJayosfORyou+kqpuUj0xe0yjKNjzqspDQV07KGPeY/oKCOw0qWl6Auh34+OUT26hjIGABlj1mFkuOxQJchosDlDUmBhk1AB8zylSOcOn8xrC5WARTWzj+pNNyE+kZTWN2vLHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426290; c=relaxed/simple;
	bh=uZqFsSXWVEwh8GyIFNHxTUKg0H0aaeW1O8pBP6anquE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEdH/n+KS5EwAQY5hQgxNGJmgtBVb5bQcRWE9blVFkpkhZcNSbzY0e9xHoYHnBDgSsUuybUVQuVKaNNykICFxVCX/SseR+rtq42wG9e/PQBEmYLWUOcluBhSyLMZ24bpQWinTao49zgS9kq27oBUshNWvr/Lq1rpEMzejb8JSuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qfe211Yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A76C32789;
	Wed, 26 Jun 2024 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426290;
	bh=uZqFsSXWVEwh8GyIFNHxTUKg0H0aaeW1O8pBP6anquE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qfe211Ydf5zkjnSL9bFS+idQnedHUAt2zytO188q0tR0/6JcVA75Isgzs98b+u02d
	 vesFNM7PcQghVh7DmXrMAfgWYL1ERLA3WhoJBAJAB4tZxD6+v+kumCF9ObPpn6zFdF
	 duWUpGEKk4NFEOqMWUEyJiQFnaTzUufVh2AQDtdazHNh1ceXqdQ5xJOdrxKiDfEfLP
	 HqP58kOl2HyTsHntIlfa9zw9wqpgXqxkDhHQQXROzwUf/yINsrdgTGZAY2ARog5iyF
	 gqJjyGNdnt6U97L6N2eZk25W/mhKAXWJ4k2EYUbL9z5vDwOvqUtFKqtc0cjs8M+edv
	 Rxd+RuowHcXoQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v8 08/18] nfsd/localio: manage netns reference in nfsd_open_local_fh
Date: Wed, 26 Jun 2024 14:24:28 -0400
Message-ID: <20240626182438.69539-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240626182438.69539-1-snitzer@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
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
index ba9187735947..48118db801b5 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -101,18 +101,11 @@ nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
 
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
@@ -122,13 +115,13 @@ nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
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
@@ -190,28 +183,44 @@ int nfsd_open_local_fh(struct net *net,
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
@@ -227,17 +236,15 @@ int nfsd_open_local_fh(struct net *net,
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


