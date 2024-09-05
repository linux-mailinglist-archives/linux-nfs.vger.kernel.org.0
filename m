Return-Path: <linux-nfs+bounces-6236-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448C796DE4A
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 17:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB111F278CC
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A319DF51;
	Thu,  5 Sep 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFoMYa7I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425B919DF44;
	Thu,  5 Sep 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550286; cv=none; b=iYqc3XsTjwaj0nvCYYsrzh3+ER07VsdHZJ6OzUaxFHcTRuiOI4wFiEld29hgDkVcDOrOwcUvAsGNIIyWFKHRXmFJ2WcBALC+XPdGb5bbyobd7IeSQ1B4UI2x+x2KVDhU0bkMTZhDFfIY5Obh20MCHyxrlxdXL8lJ0ofe/TsXOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550286; c=relaxed/simple;
	bh=c9LzjEs+YEEjSeQA6IdNWXH+Ub4Fif/LxtCd2j00ft0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9vkFKnfh89eWuLbTbPSr5AXu1yzvg8cgcmXImTD9Ro7DaRp76ULHPA4+G7fAe6spc6CSNYR4HHHX5MMttitvQyGeh9wq3QEOCGInnYdMOKsuvQrqy3nxWuq9LEHbmJgkLzPI/Lpa6VqtZnBf4cDmEQ0uBGCC7+pkr8AAsB3IbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFoMYa7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB7DC4CEC7;
	Thu,  5 Sep 2024 15:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725550283;
	bh=c9LzjEs+YEEjSeQA6IdNWXH+Ub4Fif/LxtCd2j00ft0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFoMYa7IiO4H5RD9naGXo2mhGXnXmk8LhwbIhpTxwm4Vl0SmA7Cq1vh34JZ3D57s0
	 5onxbD46ZjnmbNzNSC2rhegahu6HBBRUJfWOygYGV5kqRsLnHtLSucyWGPyVTfv5D4
	 5sHMipnC+EhJrMDoTmmsSj0SRcfrXydOsptb5O5XbrkdpPHloA3jQLC4pVVJ8x7hJ7
	 ZU6vQaKaGABVeqtvpbPas6IcgUD0PTyTdOaQvBOcIYbhENi1uyQhC9aq3aIunbhy5R
	 D8GMgWJEJOAHDDQ7+T8h9yMN6WBiE4VyUwTAbFghzF9/eX301eo3/12l8HeVW6hO0G
	 2fI8/nQfnnNSw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Petr Vorel <pvorel@suse.cz>,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.10.y 07/19] NFSD: simplify error paths in nfsd_svc()
Date: Thu,  5 Sep 2024 11:30:49 -0400
Message-ID: <20240905153101.59927-8-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240905153101.59927-1-cel@kernel.org>
References: <20240905153101.59927-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit bf32075256e9dd9c6b736859e2c5813981339908 ]

The error paths in nfsd_svc() are needlessly complex and can result in a
final call to svc_put() without nfsd_last_thread() being called.  This
results in the listening sockets not being closed properly.

The per-netns setup provided by nfsd_startup_new() and removed by
nfsd_shutdown_net() is needed precisely when there are running threads.
So we don't need nfsd_up_before.  We don't need to know if it *was* up.
We only need to know if any threads are left.  If none are, then we must
call nfsd_shutdown_net().  But we don't need to do that explicitly as
nfsd_last_thread() does that for us.

So simply call nfsd_last_thread() before the last svc_put() if there are
no running threads.  That will always do the right thing.

Also discard:
 pr_info("nfsd: last server has exited, flushing export cache\n");
It may not be true if an attempt to start the first server failed, and
it isn't particularly helpful and it simply reports normal behaviour.

Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a68e9904224a..3fdff9a3b182 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -567,7 +567,6 @@ void nfsd_last_thread(struct net *net)
 		return;
 
 	nfsd_shutdown_net(net);
-	pr_info("nfsd: last server has exited, flushing export cache\n");
 	nfsd_export_flush(net);
 }
 
@@ -782,7 +781,6 @@ int
 nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 {
 	int	error;
-	bool	nfsd_up_before;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
@@ -802,8 +800,6 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	error = nfsd_create_serv(net);
 	if (error)
 		goto out;
-
-	nfsd_up_before = nn->nfsd_net_up;
 	serv = nn->nfsd_serv;
 
 	error = nfsd_startup_net(net, cred);
@@ -811,17 +807,15 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 		goto out_put;
 	error = svc_set_num_threads(serv, NULL, nrservs);
 	if (error)
-		goto out_shutdown;
+		goto out_put;
 	error = serv->sv_nrthreads;
-	if (error == 0)
-		nfsd_last_thread(net);
-out_shutdown:
-	if (error < 0 && !nfsd_up_before)
-		nfsd_shutdown_net(net);
 out_put:
 	/* Threads now hold service active */
 	if (xchg(&nn->keep_active, 0))
 		svc_put(serv);
+
+	if (serv->sv_nrthreads == 0)
+		nfsd_last_thread(net);
 	svc_put(serv);
 out:
 	mutex_unlock(&nfsd_mutex);
-- 
2.45.1


