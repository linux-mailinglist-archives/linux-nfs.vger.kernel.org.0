Return-Path: <linux-nfs+bounces-5769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77795F494
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF131C21D24
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9718C910;
	Mon, 26 Aug 2024 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3V483mE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FCB13B286;
	Mon, 26 Aug 2024 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684876; cv=none; b=LQ3OFdkGG5wmYfOB3+vxKB917d3DUj5BiY/Iv1NXOJBLDWHxuNKvWfb4lHCpziQvPmuYCdHfj+MfVwLrDj9VbrFlKXoBEecO6DfmbDUZeSvQTq3674nnpvEDPbgbwKnaKBijtm+NLfs9R5J2LYbZEZsESRj0EO/1OTCkiiKMHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684876; c=relaxed/simple;
	bh=8UbVXFzGVjQE6pUMUlT0vADNlfUMBdxSVuclNT6eH/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r93sqWPTIsJxsZ8yGyOGTm9So3nhQSuEuexV2qwffxKKE/j6cNA8MfRB6eob1t2yYDjkmCUMmMFFDoBb8JWaD5QhR4pY1YywQlR3NCJoLXqB9Qf4P7zuN2y8eVZovmVUb3ewoYPVcWCZAjpL8aNpiNzAl6OEbX4eZ+mCiYabOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3V483mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F22C4FF57;
	Mon, 26 Aug 2024 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724684875;
	bh=8UbVXFzGVjQE6pUMUlT0vADNlfUMBdxSVuclNT6eH/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3V483mEtS+I30NLLft+zselEwz8ak+EBjTmxOnfjo7mvEKC6CdSgwD7pvhwjXzhi
	 6+wOIpADE3uCnThZ6Zamj1o3zd3CQMp7MvBlIEDhoItuVYNO7acRU2quK8fIQWZnYc
	 R3GjW2ZXgZ2PfyRJuagO5Ltm97imXtmgZvjBMadjGH7zjk2LAosWQqD3vY78/MiLha
	 2JmifyAN1S6c+ImumrstsrD0OgYlN0yTZdiGIGJ++3wbRmOr9FyLGo+InMdBegHX5a
	 YJwqwfzgPwUh50Ns+y/aybaCNE4sdJxdeNIHizySQzAgn1zsbh/3t6WXVlnlylWpMA
	 o5rWOi28X583Q==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	lilingfeng3@huawei.com,
	Jeff Layton <jlayton@kernel.org>,
	Zhi Li <yieli@redhat.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH 6.1.y 5/7] nfsd: drop the nfsd_put helper
Date: Mon, 26 Aug 2024 11:07:01 -0400
Message-ID: <20240826150703.13987-6-cel@kernel.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 64e6304169f1e1f078e7f0798033f80a7fb0ea46 ]

It's not safe to call nfsd_put once nfsd_last_thread has been called, as
that function will zero out the nn->nfsd_serv pointer.

Drop the nfsd_put helper altogether and open-code the svc_put in its
callers instead. That allows us to not be reliant on the value of that
pointer when handling an error.

Fixes: 2a501f55cd64 ("nfsd: call nfsd_last_thread() before final nfsd_put()")
Reported-by: Zhi Li <yieli@redhat.com>
Cc: NeilBrown <neilb@suse.de>
Signed-off-by: Jeffrey Layton <jlayton@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c | 31 +++++++++++++++++--------------
 fs/nfsd/nfsd.h   |  7 -------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index a906d0257e3a..2feaa49fb9fe 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -709,6 +709,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	char *mesg = buf;
 	int fd, err;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	err = get_int(&mesg, &fd);
 	if (err != 0 || fd < 0)
@@ -718,15 +719,15 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	if (err != 0)
 		return err;
 
-	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
+	serv = nn->nfsd_serv;
+	err = svc_addsock(serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
-	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+	if (err < 0 && !serv->sv_nrthreads && !nn->keep_active)
 		nfsd_last_thread(net);
-	else if (err >= 0 &&
-		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
+	else if (err >= 0 && !serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+		svc_get(serv);
 
-	nfsd_put(net);
+	svc_put(serv);
 	return err;
 }
 
@@ -740,6 +741,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	struct svc_xprt *xprt;
 	int port, err;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	if (sscanf(buf, "%15s %5u", transport, &port) != 2)
 		return -EINVAL;
@@ -751,32 +753,33 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	if (err != 0)
 		return err;
 
-	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+	serv = nn->nfsd_serv;
+	err = svc_xprt_create(serv, transport, net,
 			      PF_INET, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0)
 		goto out_err;
 
-	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+	err = svc_xprt_create(serv, transport, net,
 			      PF_INET6, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0 && err != -EAFNOSUPPORT)
 		goto out_close;
 
-	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
+	if (!serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+		svc_get(serv);
 
-	nfsd_put(net);
+	svc_put(serv);
 	return 0;
 out_close:
-	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
+	xprt = svc_find_xprt(serv, transport, net, PF_INET, port);
 	if (xprt != NULL) {
 		svc_xprt_close(xprt);
 		svc_xprt_put(xprt);
 	}
 out_err:
-	if (!nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+	if (!serv->sv_nrthreads && !nn->keep_active)
 		nfsd_last_thread(net);
 
-	nfsd_put(net);
+	svc_put(serv);
 	return err;
 }
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 781781b88cca..996f3f62335b 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -97,13 +97,6 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
-static inline void nfsd_put(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	svc_put(nn->nfsd_serv);
-}
-
 bool		i_am_nfsd(void);
 
 struct nfsdfs_client {
-- 
2.45.1


