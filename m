Return-Path: <linux-nfs+bounces-13449-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24048B1BD08
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CC2181C77
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F9C2BD5AD;
	Tue,  5 Aug 2025 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqBpTG8E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF620B7ED
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436071; cv=none; b=ia9l/WvS41J8R2xDKGjjCz2Rt8Tn0EZvS8lVbtEJcfGydW93Sw8AADUXPUiHW7toa7UDJ/y8go04kKeJ07zofQRCHZebyyXtQiI9WtnIDVShphhxQa7Ab2EAaNf+ijx9s7ageKBFJd5wXCcUlB5Zks5el+FdqQQPX9isayjqki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436071; c=relaxed/simple;
	bh=rLIacBkfVQCsQ+bglaocvU6DzGVhqb+ZFsvTqIXQtpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2pjQ3LEo0xs9bYS9K6QG7VTDL1F+F2CxRwBjXZT6t/E22OoxGVvJAquTBFJz+NN4y3AgSrr2lmXUK1JTIjDggDZYDSfH64KpH5zIf9doy4j/QahwuQuIuvm+sUfizyb+jIrCZjZq2syhAIOsPOgdI80XSLGXFyYuxkP59xNbs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqBpTG8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC5AC4CEF4;
	Tue,  5 Aug 2025 23:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436070;
	bh=rLIacBkfVQCsQ+bglaocvU6DzGVhqb+ZFsvTqIXQtpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqBpTG8EjBnuTeIHzmiL0Xa8OYypvENB0vBdVqLa7T4phvTaLZ68cXfzTptSE41zE
	 xpHuAHNBJUx3338vskHudknEP1t8zYMx+U0szqUxP/fn0KFCSmtsdxcGmFebXrch4Y
	 lOkz2fWxjD4fNFd7Ydsdg+75BIWOm8E3aIes2F+S/PTT0dPkSV8fVk3c7tFXwdKpdH
	 4NG/X1imCPxMeioGQXAyumDGzFR0xYgtITGHBwy3ABez9ZRNZof9hxz2FCYW+Kbr7n
	 fNjQG41FFzslnljiLvcKEmFerj7FqBbn3q0ltTZlKlE5CUMCWWRtT8CzpRzdSDt031
	 HwvEmz4Cl1NEw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 02/11] NFS/localio: nfs_uuid_put() fix races with nfs_open/close_local_fh()
Date: Tue,  5 Aug 2025 19:20:57 -0400
Message-ID: <20250805232106.8656-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805232106.8656-1-snitzer@kernel.org>
References: <20250805232106.8656-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In order for the wait in nfs_uuid_put() to be safe, it is necessary to
ensure that nfs_uuid_add_file() doesn't add a new entry once the
nfs_uuid->net has been NULLed out.

Also fix up the wake_up_var_locked() / wait_var_event_spinlock() to both
use the nfs_uuid address, since nfl, and &nfl->uuid could be used elsewhere.

Acked-by: Mike Snitzer <snitzer@kernel.org>
Tested-by: Mike Snitzer <snitzer@kernel.org>
Link: https://lore.kernel.org/all/175262893035.2234665.1735173020338594784@noble.neil.brown.name/
Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs_common/nfslocalio.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 64949c46c1741..f1f1592ac1348 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -177,7 +177,7 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 			/* nfs_close_local_fh() is doing the
 			 * close and we must wait. until it unlinks
 			 */
-			wait_var_event_spinlock(nfl,
+			wait_var_event_spinlock(nfs_uuid,
 						list_first_entry_or_null(
 							&nfs_uuid->files,
 							struct nfs_file_localio,
@@ -243,15 +243,20 @@ void nfs_localio_invalidate_clients(struct list_head *nn_local_clients,
 }
 EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
 
-static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl)
+static int nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl)
 {
+	int ret = 0;
+
 	/* Add nfl to nfs_uuid->files if it isn't already */
 	spin_lock(&nfs_uuid->lock);
-	if (list_empty(&nfl->list)) {
+	if (rcu_access_pointer(nfs_uuid->net) == NULL) {
+		ret = -ENXIO;
+	} else if (list_empty(&nfl->list)) {
 		rcu_assign_pointer(nfl->nfs_uuid, nfs_uuid);
 		list_add_tail(&nfl->list, &nfs_uuid->files);
 	}
 	spin_unlock(&nfs_uuid->lock);
+	return ret;
 }
 
 /*
@@ -285,11 +290,13 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	}
 	rcu_read_unlock();
 	/* We have an implied reference to net thanks to nfsd_net_try_get */
-	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
-					     cred, nfs_fh, pnf, fmode);
+	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt, cred,
+					     nfs_fh, pnf, fmode);
+	if (!IS_ERR(localio) && nfs_uuid_add_file(uuid, nfl) < 0) {
+		/* Delete the cached file when racing with nfs_uuid_put() */
+		nfs_to_nfsd_file_put_local(pnf);
+	}
 	nfs_to_nfsd_net_put(net);
-	if (!IS_ERR(localio))
-		nfs_uuid_add_file(uuid, nfl);
 
 	return localio;
 }
@@ -338,7 +345,7 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 	 */
 	spin_lock(&nfs_uuid->lock);
 	list_del_init(&nfl->list);
-	wake_up_var_locked(&nfl->nfs_uuid, &nfs_uuid->lock);
+	wake_up_var_locked(nfs_uuid, &nfs_uuid->lock);
 	spin_unlock(&nfs_uuid->lock);
 }
 EXPORT_SYMBOL_GPL(nfs_close_local_fh);
-- 
2.44.0


