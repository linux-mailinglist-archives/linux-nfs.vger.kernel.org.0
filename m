Return-Path: <linux-nfs+bounces-5768-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A5995F493
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 17:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130AEB211AA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3490118BC24;
	Mon, 26 Aug 2024 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA5vfwbt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25613B286;
	Mon, 26 Aug 2024 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684866; cv=none; b=V3uPVrJZFjm7sDKHLUXoS7pi/NLw0aNYg1HKKfpRQksdfijB9KLAKZtL6SfPnCPduijFO4rBDYCI4ArPiKYUS4chuDFuDlhejwq/oQSuEAojrlc0Vqb+TXqdqBqEsZIPMAu5lc+CCuELuaDDwvff1ZjJU2YeJyxGsJkDQC47m28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684866; c=relaxed/simple;
	bh=jjpYYlwaKLLkLBwEPkZHnlZc0qbcUfMFW2ounVGmNoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kS0rzxHwuxC2KIWuavIYPLSDYHCsE0gzu5wUAH3fOlsM/iAo6R8XDeMdQx2FO2FCNH5LAx8HEy+u5h3vLWmJ9qbKWGKwCebtRdIecIirs3myQuOPzOcUWzWCCqAqLToBJFWiANqMd5NLkq/oqHVXUuvm5jOmCJDlGg2pn5K8gvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA5vfwbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264B5C4FF53;
	Mon, 26 Aug 2024 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724684865;
	bh=jjpYYlwaKLLkLBwEPkZHnlZc0qbcUfMFW2ounVGmNoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NA5vfwbtd1UMMlEJauZfYMk1R8oFqYaMLiclBzrLTfkqrN8NtAGM3X/6ZS8cdGHGN
	 vwbfPG6ILSaDkNPsyiUv6DK8EUYKxaJYZdGf3AAZm5koX/FeFJKt5IAngIsPW0tqmz
	 BeC33IdGISSlKm4mZjNC1OMrxbC+egXhjpkVNTjFhElPCwhIeYe5D4o7Qn6ns5dsRe
	 /sw5e+nRS36ObFNcvhBf750nvLEfA4F1KvRgduuedcgEj8TkIdLwdpTCEx7xKJouBM
	 x6jgRiDtJOxBzHe/fHObOcLakd9Ge7jVyq+KU03fp+mNXOmA1PWNZBKvupMTNBjR/w
	 oVWcRYFtRtqZw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	lilingfeng3@huawei.com,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 4/7] nfsd: call nfsd_last_thread() before final nfsd_put()
Date: Mon, 26 Aug 2024 11:07:00 -0400
Message-ID: <20240826150703.13987-5-cel@kernel.org>
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

From: NeilBrown <neilb@suse.de>

[ Upstream commit 2a501f55cd641eb4d3c16a2eab0d678693fac663 ]

If write_ports_addfd or write_ports_addxprt fail, they call nfsd_put()
without calling nfsd_last_thread().  This leaves nn->nfsd_serv pointing
to a structure that has been freed.

So remove 'static' from nfsd_last_thread() and call it when the
nfsd_serv is about to be destroyed.

Fixes: ec52361df99b ("SUNRPC: stop using ->sv_nrthreads as a refcount")
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c | 9 +++++++--
 fs/nfsd/nfsd.h   | 1 +
 fs/nfsd/nfssvc.c | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 813ae75e7128..a906d0257e3a 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -720,8 +720,10 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 
 	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
-	if (err >= 0 &&
-	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+		nfsd_last_thread(net);
+	else if (err >= 0 &&
+		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
 		svc_get(nn->nfsd_serv);
 
 	nfsd_put(net);
@@ -771,6 +773,9 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 		svc_xprt_put(xprt);
 	}
 out_err:
+	if (!nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+		nfsd_last_thread(net);
+
 	nfsd_put(net);
 	return err;
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 18bfeb67cd1c..781781b88cca 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -139,6 +139,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
 int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change);
 void nfsd_reset_versions(struct nfsd_net *nn);
 int nfsd_create_serv(struct net *net);
+void nfsd_last_thread(struct net *net);
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1d32fc985008..80a2b3631adb 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -532,7 +532,7 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 /* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
-static void nfsd_last_thread(struct net *net)
+void nfsd_last_thread(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
-- 
2.45.1


