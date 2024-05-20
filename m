Return-Path: <linux-nfs+bounces-3292-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 975598CA17A
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 19:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37629B2224C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 May 2024 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585C5137C3C;
	Mon, 20 May 2024 17:37:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C07A2D;
	Mon, 20 May 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226651; cv=none; b=poeB9tytCLRAKRoP8PMnb4L2qRRITVGCINOb992O87db2tW/QWyc8vtFC9l9xpdhrbPl2f0shg7uLMl5BsyytS1wW74/WxVYGZ38PQtSEz9jykC3dL1+12BvW2oS4ifpVqfqDjFpZUwf8WW+gN/+NASWm8iFdNJf477vgOa0JzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226651; c=relaxed/simple;
	bh=3pJWOpeUaIw55Dq1/uPdfsrzR6sFZhwannbYrrdZqUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P0tGO8hqjvPlPaN1Fgu6VogU+2AMjBxkVV3tZT+Ih7oXHRYOR9neKEAZIWR3chlLNIpXtNROtzojuJYFbm5gqJpKL+Pjb3lgWOe6hsn0fb0YYN4wKjQQT7EoCMClWkE6tgreBQh2JOOcq+XLNG7qWcK84iyJRDmg/cNK8fyhKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-084-059-234-031.084.059.pools.vodafone-ip.de ([84.59.234.31] helo=martin-debian-3.kaiser.cx)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1s96wY-000hxD-2p;
	Mon, 20 May 2024 19:37:02 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	David Howells <dhowells@redhat.com>
Cc: NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v4] nfs: keep server info for remounts
Date: Mon, 20 May 2024 19:36:39 +0200
Message-Id: <20240520173639.174439-1-martin@kaiser.cx>
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

For remounts, the nfs server address and port are populated by
nfs_init_fs_context and later overwritten with 0x00 bytes by
nfs23_parse_monolithic. The remount then fails as the server address is
invalid.

Fix this by not overwriting nfs server info in nfs23_parse_monolithic if
we're doing a remount.

Fixes: f2aedb713c28 ("NFS: Add fs_context support.")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 v4:
 - rebased against linux-next from 20th May 2024

 v3:
 - rebased against linux-next from 12th April 2024

 v2:
 - rebased against linux-next from 26th February 2024

Dear all,

I'm resending this patch again.

The problem that I'm trying to fix is still present in today's linux-next.
It affects (amongst others) systems where the rootfs is mounted via nfs2/3.
If the rootfs is mounted read-only first and remounted read-write later, the
remount will fail and the system won't boot.

Thanks in advance for any reviews and comments.

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
index d0a0956f8a13..cac1157be2c2 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1112,9 +1112,12 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
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


