Return-Path: <linux-nfs+bounces-13019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D69C9B034D7
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE57165DCF
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385DC1E501C;
	Mon, 14 Jul 2025 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQXopznS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133DE1E3762
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462853; cv=none; b=KK6+75PZD7gQ1weXB2q6LZVioyinMKM+8tUe6hf8JekG5oUGz1/9RmX7VDxDeQ4IwRxAXX8qayLdyqvpj0aUMJfRNfk9QcTytL6EOD3L+CqgDSVLXJADwHHyrT4FWlnf+gQZD4BKSpykdE0AZVCTcv1R0MQEznWBXFS1eB0DVcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462853; c=relaxed/simple;
	bh=bXMQ9Rh4w69pEu6oadxAwLxpFruGTjZQ8QzKCN8tCeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoYkZLx/furW0QKCbgDCm9cfjRYR4SpooGwhMXffE37NKQh6PYLg87qiWmgrArIQGTo9y/Clo1ET11AmeFsDxz9xDNCZP0RkQN/zKIWSOH7W0h6jhOzrabwzrdYHSkWWQ9w4dv7qxGkyfiTc522Pm279hsQf6D2wNQLU+V0MdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQXopznS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0568C4CEE3;
	Mon, 14 Jul 2025 03:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752462852;
	bh=bXMQ9Rh4w69pEu6oadxAwLxpFruGTjZQ8QzKCN8tCeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQXopznSinJU6tgXdOg9Y+9Ftm3rFzs5o1Z9xLxkAjYxmzb2EVzrS/DEBL/Swx4Oc
	 oiitPQppiJyTKz3K+uL7qUr09BnjBjClMdLRkReXylWSrCdm+YhOR3FYRAgKlKl1Oq
	 rsvtC4UrgRK/9Yz3wBcazYLtkgLZySHhmwL2oHmiklupvIreCrF+nLcRisgMtbHDhu
	 RyuBB7YDmlIH2Aq+gaAIa//rpMFbBUQLTgoF4Ig2nr+Ro8NW3O2v+/v5bXRNRcHpTz
	 fi2GzZ/5sLn80p3B0MZ8YZ7eEuPPJpCUblbJHaFlOb8IJFPzyS6yOSsd7NUdUTgLmv
	 1Jfb+pcGWI+cQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org
Subject: [for-6.16-final PATCH 8/9] nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
Date: Sun, 13 Jul 2025 23:13:58 -0400
Message-ID: <20250714031359.10192-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250714031359.10192-1-snitzer@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

Previously nfs_local_probe() was made to disable and then attempt to
re-enable LOCALIO (via LOCALIO protocol handshake) if/when it was
called and LOCALIO already enabled.

Vague memory for _why_ this was the case is that this was useful
if/when a local NFS server were to be restarted with a local NFS
client connected to it.

But as it happens this causes an absurd amount of LOCALIO flapping
which has a side-effect of too much IO being needlessly sent to NFSD
(using RPC over the loopback network interface).  This is the
definition of "serious performance loss" (that negates the point of
having LOCALIO).

So remove this mis-optimization for re-enabling LOCALIO if/when an NFS
server is restarted (which is an extremely rare thing to do).  Will
revisit testing that scenario again but in the meantime this patch
restores the full benefit of LOCALIO.

Fixes: 56bcd0f07fdb ("nfs: implement client support for NFS_LOCALIO_PROGRAM")
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/localio.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index a4bacd9a5052..e3ae003118cb 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -180,10 +180,8 @@ static void nfs_local_probe(struct nfs_client *clp)
 		return;
 	}
 
-	if (nfs_client_is_local(clp)) {
-		/* If already enabled, disable and re-enable */
-		nfs_localio_disable_client(clp);
-	}
+	if (nfs_client_is_local(clp))
+		return;
 
 	if (!nfs_uuid_begin(&clp->cl_uuid))
 		return;
@@ -241,7 +239,8 @@ __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		case -ENOMEM:
 		case -ENXIO:
 		case -ENOENT:
-			/* Revalidate localio, will disable if unsupported */
+			/* Revalidate localio */
+			nfs_localio_disable_client(clp);
 			nfs_local_probe(clp);
 		}
 	}
-- 
2.44.0


