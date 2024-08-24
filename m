Return-Path: <linux-nfs+bounces-5688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18395DEF5
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38641F21DCE
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F185229422;
	Sat, 24 Aug 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/oBkHc7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843128DD1;
	Sat, 24 Aug 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724516504; cv=none; b=WR0zzqVro8Hjg1ipYwwIva5kW+2Z1UabFE0gDay+1Ck+ubwv5ehEA9JwF9H/Tg1HKndvNEzocY2sfworpEAXukBQZpIfWTde4JDi0T5Yt7fTrdvc5TaN1DpKvxTwHuoddzdsZACGXiz/PgvSgYgbwWjkacTK4XCwCr3MXk+0WMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724516504; c=relaxed/simple;
	bh=u8uOJ2emCnTz93KJ2STsHVugtH3Gb9EimYkXEh2uibY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RkMGu1i6iHuWG/JpnBNn8FN3S6xkvUmIANP4dlOv3ffQtcLSemE3NsBWYipKNjvxvu0IVKA5C6rnnX1daKgL8VCcO9iEpLCqpJOwfzw15XSZi/W4gPODVqckSz8mr5EzpKQ3mfjX8hmapV5+qB7z1ncJyE3+XmpyfhVZWe1/cCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/oBkHc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13F1C32781;
	Sat, 24 Aug 2024 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724516504;
	bh=u8uOJ2emCnTz93KJ2STsHVugtH3Gb9EimYkXEh2uibY=;
	h=From:To:Cc:Subject:Date:From;
	b=B/oBkHc7bYLuA5zbbDBy1fDmufmAWckVf7lRCb+KZXfrH/QLJjOatxYY6S82yPbIV
	 YHPWGUrgzZ34lARnLOf13vPjJqLRYoXDtdhSO93j/E8GsJzy9wxkefSa7zNfW6I0Qp
	 uYxMpplgEYN/LEKM7cClkpUzh/tIIojgblAuHHl0eoxpmlHoTY7NPXg4fJ7OsVQ8ce
	 24MG3gcU/GJdBtz1wkW2Lbqyaep/qzAFsy0orGxqZQOChThNkOdPV645VrLrZjfL4T
	 I57610q18SFgG700iuPzhujT58HzTIMM3bg9dXVyr8tXfUMlxsXVKUFgweh2RRQQQk
	 2pLJ8OTSzoJdA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	lilingfeng3@huawei.com,
	NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6.y] NFSD: simplify error paths in nfsd_svc()
Date: Sat, 24 Aug 2024 12:21:37 -0400
Message-ID: <20240824162137.2157-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
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

Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
Suggested-by: Li Lingfeng <lilingfeng3@huawei.com>
Tested-by: Li Lingfeng <lilingfeng3@huawei.com>

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 7911c4b3b5d3..710a54c7dffc 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -567,7 +567,6 @@ void nfsd_last_thread(struct net *net)
 		return;
 
 	nfsd_shutdown_net(net);
-	pr_info("nfsd: last server has exited, flushing export cache\n");
 	nfsd_export_flush(net);
 }
 
@@ -783,7 +782,6 @@ int
 nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 {
 	int	error;
-	bool	nfsd_up_before;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
@@ -803,8 +801,6 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	error = nfsd_create_serv(net);
 	if (error)
 		goto out;
-
-	nfsd_up_before = nn->nfsd_net_up;
 	serv = nn->nfsd_serv;
 
 	error = nfsd_startup_net(net, cred);
@@ -812,17 +808,15 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
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


