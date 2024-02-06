Return-Path: <linux-nfs+bounces-1811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E084BAB8
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Feb 2024 17:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252A21F2485C
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Feb 2024 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1954E134CCC;
	Tue,  6 Feb 2024 16:17:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E807612E1ED;
	Tue,  6 Feb 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236251; cv=none; b=bPS0td5Mh0X14N9VB5fwoRlwaCu4CZoFFuBicKNleAwMUZoML8e3c7no7t8PjwqAEg2h6HGnFUh3DQvPi5i3lu5hJHrfT6Kg2sFSnX2o1LRsgtwSaaKCA4b7vzVR+5JwdUt9p4kgDw2DyUw5fr6DQdfSPw7AZy0YXT3ZqteSkDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236251; c=relaxed/simple;
	bh=ZIkXxwfLDy2zEl+CsRwUflruol8oIHsF7djmGyspYHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iPHBYtqwVWrfmJvZDWI/GlFna8UhllNPQ5+sMAqlkBRKFuJPqBi8Z2TfYOU/43yAsl2pfcLw/HBidt2uy5CfBmG5rZb1bwpWQgT+1syQMKWyWf7web7GNxGVl9zKM1EW/+LJx9rpUszLBiy6DM9Ftadq0QB5On8Q/rkYcdLkRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-178-004-206-106.178.004.pools.vodafone-ip.de ([178.4.206.106] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rXO8N-000CUo-2f;
	Tue, 06 Feb 2024 17:17:19 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] nfs: keep server info for remounts
Date: Tue,  6 Feb 2024 17:16:25 +0100
Message-Id: <20240206161625.145373-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With newer kernels that use fs_context for nfs mounts, remounts fail with
-EINVAL.

$ mount -t nfs -o nolock 10.0.0.1:/tmp/test /mnt/test/
$ mount -t nfs -o remount /mnt/test/
mount: mounting 10.0.0.1:/tmp/test on /mnt/test failed: Invalid argument

For remounts, the nfs server address and port are populated in
nfs_init_fs_context and later overwritten with invalid data by
nfs23_parse_monolithic. The remount then fails as the server address is
invalid.

Fix this by not overwriting nfs server info in nfs23_parse_monolithic if
we're doing a remount.

Fixes: f2aedb713c28 ("NFS: Add fs_context support.")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---

I guess that we're taking this path for remounts

do_remount
    fs_context_for_reconfigure
        alloc_fs_context
            init_fs_context == nfs_init_fs_context
               fc->root is set for remounts
               ctx->nfs_server is populated
    parse_monolithic_mount_data
        nfs_fs_context_parse_monolithic
            nfs23_parse_monolithic
               ctx->nfs_server is overwritten with data from mount request

An alternative to checking for !is_remount_fc(fc) would be to check 
if (ctx->nfs_server.addrlen == 0)


 fs/nfs/fs_context.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 853e8d609bb3..41126d6dcd76 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1111,9 +1111,12 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 		ctx->acdirmax	= data->acdirmax;
 		ctx->need_mount	= false;
 
-		memcpy(sap, &data->addr, sizeof(data->addr));
-		ctx->nfs_server.addrlen = sizeof(data->addr);
-		ctx->nfs_server.port = ntohs(data->addr.sin_port);
+		if (!is_remount_fc(fc)) {
+			memcpy(sap, &data->addr, sizeof(data->addr));
+			ctx->nfs_server.addrlen = sizeof(data->addr);
+			ctx->nfs_server.port = ntohs(data->addr.sin_port);
+		}
+
 		if (sap->ss_family != AF_INET ||
 		    !nfs_verify_server_address(sap))
 			goto out_no_address;
-- 
2.39.2


