Return-Path: <linux-nfs+bounces-3968-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B48F390C10B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 03:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0251C211D4
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 01:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A071CD1B;
	Tue, 18 Jun 2024 01:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwWuXQWh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60011CD13
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672980; cv=none; b=uIcm/rSJDFAsgKnSkUhaF5zdH/evet0kITZqsPyBtl8zkyMubbgv/brQS2TtyD3Zxgc1Vle5lFbTR1QT0WEkWFnqNj+QJokAqHR/rrHNDpjMvPAXHoD+mjxIQXnMDk3vvcbhl9h74daQJ7NeueRmwy0XtgaHO4CzOPbP1hJT4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672980; c=relaxed/simple;
	bh=IO4PFDIWH0vsNcrerIifcqvw8iPa0/mgwDJDU6MJWpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1B3SELPuCEkUt7nxX6L/yzK6xl4Ks0QULeT4tfIWskJSNhHEbD2ktwe+GhXggxd1tYpGY43tsIXbfzJeL1H0gvdQbCJRMkb14aYy5rekEMd2G3YCJOFG35s/EPrBZZEe3Z/UKybtKuxNjjs/AszyhyD3GXzhP0VZMQNTrfE1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwWuXQWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A35C2BD10;
	Tue, 18 Jun 2024 01:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718672980;
	bh=IO4PFDIWH0vsNcrerIifcqvw8iPa0/mgwDJDU6MJWpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwWuXQWh6fGX3haKJLf3MHLt18ELi03u/6Nrp9iQVOqNHxLT0xfXNe9sY2vThs0g3
	 MkbodamFuliskweEWjizjw5eW113ZO5D7o3dS14nIrwfYp86JMENp/cFie6D+ZLqZb
	 ZYTGuDyopEJUx4U8XpbUGhFjxgwBYvpY/O82l5kwS6n20LiPQSoepp5aLEKzUWykij
	 JCxActyZE+YVMj4ZQ9D+Hb1uNC2N1R9++HlhWCGgDtTGytF7EOM84ggQEK1TrfUOJE
	 XkC9UeaphT0qajzhGBIsiVO1unMB+rwFH85sQt2g/jvATQK6TpNQvXNrbXYbDiSPtY
	 cVVcfRAA23DiQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com,
	axboe@kernel.dk
Subject: [PATCH v4 17/18] nfsd/localio: use SRCU to dereference nn->nfsd_serv in nfsd_open_local_fh
Date: Mon, 17 Jun 2024 21:09:16 -0400
Message-ID: <20240618010917.23385-18-snitzer@kernel.org>
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

Use nfsd_serv_get to SRCU deference nn->nfsd_serv and pass the
resulting svc_serv to nfsd_local_fakerqst_create, open the file handle
and then drop the reference using nfsd_serv_put at the end of
nfsd_open_local_fh.

Verified to fix an easy to hit crash that would occur if an nfsd
instance running in a container, with a localio client mounted, is
shutdown. Upon restart of the container and associated nfsd the client
would go on to crash due to NULL pointer dereference that occuured due
to the nfs client's localio attempting to nfsd_open_local_fh(), using
nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/localio.c          |  4 +++-
 include/linux/nfslocalio.h | 24 +++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index cdf8e115b33e..d1d9fbaab82e 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -193,6 +193,7 @@ int nfsd_open_local_fh(struct net *net,
 	struct nfsd_file *nf;
 	int status = 0;
 	int mayflags = NFSD_MAY_LOCALIO;
+	int srcu_idx;
 	struct svc_serv *serv;
 	__be32 beres;
 
@@ -207,7 +208,7 @@ int nfsd_open_local_fh(struct net *net,
 	}
 	nn = net_generic(net, nfsd_net_id);
 
-	serv = READ_ONCE(nn->nfsd_serv);
+	serv = nfsd_serv_get(nn, &srcu_idx);
 	if (unlikely(!serv)) {
 		dprintk("%s: localio denied. Server not running\n", __func__);
 		status = -ENXIO;
@@ -247,6 +248,7 @@ int nfsd_open_local_fh(struct net *net,
 out_revertcred:
 	revert_creds(save_cred);
 out_net:
+	nfsd_serv_put(nn, srcu_idx);
 	put_net(net);
 	return status;
 }
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index c9592ad0afe2..face80fc80cf 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -19,7 +19,29 @@ extern struct list_head nfsd_uuids;
 /*
  * Each nfsd instance has an nfsd_uuid_t that is accessible through the
  * global nfsd_uuids list. Useful to allow a client to negotiate if localio
- * possible with its server.
+ * possible with its server. See fs/nfs/localio.c:nfs_local_probe() for the
+ * code that handshakes with nfsd to determine if localio is possible.
+ *
+ * The nfsd_uuids list is the basis for localio enablement, as such it has
+ * members that point to nfsd memory for direct use by the client (e.g. 'net'
+ * is the server's network namespace, through it the client can access
+ * nn->nfsd_serv with proper rcu read access). It is this client and server
+ * synchronization that enables advanced usage and lifetime of objects to
+ * span from the host kernel's nfsd to per-container knfsd instances that
+ * are connected to nfs client's running on the same local host.
+ *
+ * See fs/nfs/localio.c:nfs_local_open_fh() and
+ * fs/nfsd/localio.c:nfsd_open_local_fh() for the interface that makes
+ * focused use of nfsd_uuid_t struct to allow a client local to a server
+ * to open a file pointer without needing to go over the network.
+ *
+ * The performance advantage realized from localio's ability to bypass
+ * using XDR and RPC for reads, writes and commits can be extreme, e.g.:
+ * fio for 20 secs with 24 libaio threads, 64k directio reads, qd of 8,
+ * with localio:
+ *  read: IOPS=795k, BW=48.5GiB/s (52.1GB/s)(971GiB/20002msec)
+ * without localio:
+ *  read: IOPS=15.6k, BW=974MiB/s (1021MB/s)(19.0GiB/20013msec)
  */
 typedef struct {
 	uuid_t uuid;
-- 
2.44.0


