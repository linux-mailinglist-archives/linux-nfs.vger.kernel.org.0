Return-Path: <linux-nfs+bounces-2043-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC485E0C9
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Feb 2024 16:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A932878C1
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Feb 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191058005A;
	Wed, 21 Feb 2024 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SCp7SDq6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD518002D
	for <linux-nfs@vger.kernel.org>; Wed, 21 Feb 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528674; cv=none; b=ghxJEl/56u9opVzVi8YAb3Xng7HKxVHxg7vKGoX2HpsbOl0MBdwJWF09WGdiBelkGcuJl2yl6DQCv9ed+T+YSYNuv1Wrd8dnToW33fSbKuJmxt3jOhoAajyrqTZNVD81dTdh5morH65yebmxcyH7hWk12iZX8qa4Px6jt8othEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528674; c=relaxed/simple;
	bh=aHEmXLcxQjd+23Ro0h5/V90Hpcz/gw3LmC4lwsv01Ow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D/mYs3mGabcdctl5xOUA8MRltxnZIXaHVNQp+VGSyow8bAfrPzRrbJNCG8GSm/MFGehYFJZeoVy9jqYAdhJmldCmLqM3KF2dU/fYpdJjK7W62GnqNuoTYZho3Z2SmKdP2o11wEvQuyXMUqUI2O+XkxUJwOH/5wCx5NiaYjBab48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SCp7SDq6; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1708528671; x=1740064671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aHEmXLcxQjd+23Ro0h5/V90Hpcz/gw3LmC4lwsv01Ow=;
  b=SCp7SDq6qS6RgTDhvClbW5akIz2+Mb/6D4Gue0Aa8GLq5fJN0S6i4+Yq
   Rau/L1y0qplBmbAUHWMmdHZXbqBiFqz2VHmIXiyKyzpb0u/GnKMnoK0Wk
   FA2U9Ksp0sBLoyq64Nl69ZcgHMGswdgW1/7ehFJMy+PQ2FDpL8hYAerjR
   odOGO3OVdJZv7fEiGoPzG22TAM3D09dBC5fA+D5y8ChRcDROX/cx+6Fxg
   +bRUbeOafuDcjKVMFQIfd7Uh+p1Q+Gm/qf7d52fb7qLJeB098VII5i1PE
   k0HzwwFDAnD2GTwcv9cQtKqARP5azKQiJGZGzn6CpEnsEv0k2qZunLYCa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="128821842"
X-IronPort-AV: E=Sophos;i="6.06,175,1705330800"; 
   d="scan'208";a="128821842"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 00:16:40 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6267624525
	for <linux-nfs@vger.kernel.org>; Thu, 22 Feb 2024 00:16:38 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 912CFD5A0C
	for <linux-nfs@vger.kernel.org>; Thu, 22 Feb 2024 00:16:37 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 115B7200A7F21
	for <linux-nfs@vger.kernel.org>; Thu, 22 Feb 2024 00:16:37 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6696B1A006B;
	Wed, 21 Feb 2024 23:16:36 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: fix regression in handling of namlen= option in NFSv4
Date: Wed, 21 Feb 2024 23:16:13 +0800
Message-Id: <20240221151613.555-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28204.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28204.006
X-TMASE-Result: 10--3.590100-10.000000
X-TMASE-MatchedRID: m5YRaeAMZa7kWQ892nFTzDo39wOA02LhTfK5j0EZbysli8Y5a0svL+go
	SvaKsl/kIvrftAIhWmLy9zcRSkKatfIBX+jDfXGr+GYt8f/VhTuOQOsE4nDCdDqQ9oE4dACmo8W
	MkQWv6iUoTQl7wNH8Po2j49Ftap9ExlblqLlYqXLexOlFesjEtrXT7pZenTAPS8f6F7gm2TzxDH
	K2aIsclud5iPekCAlGvByE2rSKTT11nAByzqHw6HYMEhn6ZWovxczN/cbf9UgRZbRsQk5MBUB1Q
	Pq9bxnWZkAxAwjIrrMHz/H0kiLyEqGAtHMDjkk9
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Setting the maximum length of a pathname component
via the namlen= mount option is currently broken in NFSv4.

This patch will fix this issue.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 fs/nfs/namespace.c     | 2 ++
 fs/nfs/nfs4client.c    | 2 ++
 fs/nfs/nfs4namespace.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index e7494cdd957e..8da1fc9ebbd4 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -277,6 +277,8 @@ int nfs_do_submount(struct fs_context *fc)
 	if (IS_ERR(server))
 		return PTR_ERR(server);
 
+	if (ctx->namlen)
+		server->namelen = ctx->namlen;
 	ctx->server = server;
 
 	buffer = kmalloc(4096, GFP_USER);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 11e3a285594c..9826c2fcb0a7 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1187,6 +1187,8 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
 		server->rsize = nfs_io_size(ctx->rsize, server->nfs_client->cl_proto);
 	if (ctx->wsize)
 		server->wsize = nfs_io_size(ctx->wsize, server->nfs_client->cl_proto);
+	if (ctx->namlen)
+		server->namelen = ctx->namlen;
 
 	server->acregmin = ctx->acregmin * HZ;
 	server->acregmax = ctx->acregmax * HZ;
diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index 9a98595bb160..1a30224df7b9 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -465,6 +465,8 @@ int nfs4_submount(struct fs_context *fc, struct nfs_server *server)
 		return PTR_ERR(client);
 
 	ctx->selected_flavor = client->cl_auth->au_flavor;
+	if (server->namelen)
+		ctx->namlen = server->namelen;
 	if (ctx->clone_data.fattr->valid & NFS_ATTR_FATTR_V4_REFERRAL) {
 		ret = nfs_do_refmount(fc, client);
 	} else {
-- 
2.39.1


