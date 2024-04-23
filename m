Return-Path: <linux-nfs+bounces-2949-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A365B8AE811
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E951F220DE
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E536613666F;
	Tue, 23 Apr 2024 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCODRll/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BB135A61;
	Tue, 23 Apr 2024 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878765; cv=none; b=iS88k5JApzsGAODsyRYhZ+JFUa67sUhcMbBHzSHunVHdZ8pFqbD/vL0m074cbBTAYZ+OVjv9ycbi0DdTGs5FHp9rJgX0wkICcldMZFL0qKrRuLFb900HwZawtPKxQIueoVEVH8juTjJUJajyomTx7FzcGWCzUBmcytFoYVe+ckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878765; c=relaxed/simple;
	bh=4h+Tu88oHjRIeAS0PQPioRNPY+xGkKq0dyKgovl0y74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaOiKOCJr5yUWe1yIc40AxC0E3eUQzCsHU2XC0o2AvS3zuLtDCTWvohmKZNq7CP94aCpmjj9rlSYN74C2o4p3T5N+Ys75M1rSh4K0Qbr/lFJqW1mRmt9nvlGG+wqsBLjNsDv63kSSNRNbf7uzHkvkyzNG6sSn+0mK3zUDb1EkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCODRll/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D58C116B1;
	Tue, 23 Apr 2024 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713878765;
	bh=4h+Tu88oHjRIeAS0PQPioRNPY+xGkKq0dyKgovl0y74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCODRll/0qb6/s7Ar/Y63Y2IzICzRWV758FFqtxXFvM9gqYPdRlkt9g5a+SU9abIp
	 bcgxndwbJomSyUrLtihRH+GInXxSw5xjQ4F+AESUwUQ25PwmBcWPIPyAyqmpod75Jc
	 +dXNET9iqZjXskj41YUcgTWB0nAU0klZ7KyA9y09fgh4Alwv6Lhz4oDefddl2k1f6d
	 mO0RMkpuP/yMPu9N8Qyg0DdkILll6K/JLizLip0bevUCmIUDfA1YKX9neuw+Phn2p4
	 xK7QwHMHLgQBtPyjBLaJ3H8oF4WaAjFrgjJB3tVYd3bOTn1udSwXMeJj6P7dpM8uA9
	 QU3sEX6tKMoTA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: neilb@suse.de,
	lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	jlayton@kernel.org
Subject: [PATCH v9 2/7] NFSD: allow callers to pass in scope string to nfsd_svc
Date: Tue, 23 Apr 2024 15:25:39 +0200
Message-ID: <1b3af9bafba481a561e7e4c0f42409dfed16115e.1713878413.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713878413.git.lorenzo@kernel.org>
References: <cover.1713878413.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

Currently admins set this by using unshare to create a new uts
namespace, and then resetting the hostname. With the new netlink
interface we can just pass this in directly. Prepare nfsd_svc for
this change.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/nfsctl.c | 2 +-
 fs/nfsd/nfsd.h   | 2 +-
 fs/nfsd/nfssvc.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 2fe78b802f98..34148d73b6c1 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -405,7 +405,7 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
 			return -EINVAL;
 		trace_nfsd_ctl_threads(net, newthreads);
 		mutex_lock(&nfsd_mutex);
-		rv = nfsd_svc(newthreads, net, file->f_cred);
+		rv = nfsd_svc(newthreads, net, file->f_cred, NULL);
 		mutex_unlock(&nfsd_mutex);
 		if (rv < 0)
 			return rv;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 16c5a05f340e..2f6c6f3815b4 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -103,7 +103,7 @@ bool		nfssvc_encode_voidres(struct svc_rqst *rqstp,
 /*
  * Function prototypes.
  */
-int		nfsd_svc(int nrservs, struct net *net, const struct cred *cred);
+int		nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scope);
 int		nfsd_dispatch(struct svc_rqst *rqstp);
 
 int		nfsd_nrthreads(struct net *);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ca193f7ff0e1..e25b9b829749 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -769,7 +769,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
  * this is the first time nrservs is nonzero.
  */
 int
-nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
+nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scope)
 {
 	int	error;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
@@ -786,7 +786,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	if (nrservs == 0 && nn->nfsd_serv == NULL)
 		goto out;
 
-	strscpy(nn->nfsd_name, utsname()->nodename,
+	strscpy(nn->nfsd_name, scope ? scope : utsname()->nodename,
 		sizeof(nn->nfsd_name));
 
 	error = nfsd_create_serv(net);
-- 
2.44.0


