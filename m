Return-Path: <linux-nfs+bounces-2797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871578A4458
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Apr 2024 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE051C20EF6
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Apr 2024 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F11353F4;
	Sun, 14 Apr 2024 17:11:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8C3134CE8;
	Sun, 14 Apr 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114674; cv=none; b=YjJqb5NIIjeYv5E4HrsXMb9W5pQQ/q3qMu7MYDTGNiBANaOZ6UO92PCmv85+U9oy+GeWR0EyxzMy0u7meRkPDqK3Z2ZjhzhRj3MoHofNJ5gG2YTMTOviVQ2ScQQLOWEmGusuccpbAHRpYw2mVKKK3OJeO7A+D/dB6CP+pkJSF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114674; c=relaxed/simple;
	bh=wpe8KlwzaSSM+u2lvF16DyF5qHpDrPDvVSCVM3ngkNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qqpCE7G9sxwBQup+0lZ6y3tCXvJ2helv3Ju61c4cJLFXwhXq4gIeKZWImGtNuSTvIZ5ofeewkT8SUjLmzyTVetd5WvnVBKUiHvSeUS64z+cD773Fiq5qjpa7S91XpAj95zfn32OK1vYe/RaRis0EEYlzoaOzWt9eBArvvWzBOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-210-242.188.097.pools.vodafone-ip.de ([188.97.210.242] helo=martin-debian-3.kaiser.cx)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rw3Dj-003uVz-0Q;
	Sun, 14 Apr 2024 19:00:47 +0200
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
Subject: [PATCH v3] nfs: keep server info for remounts
Date: Sun, 14 Apr 2024 19:01:09 +0200
Message-Id: <20240414170109.137696-1-martin@kaiser.cx>
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
 v3:
 - rebased against linux-next from 12th April 2024

 v2:
 - rebased against linux-next from 26th February 2024

Dear all,
I'm resending this patch again. The problem that I'm trying to fix is still
present in linux-next. Thanks in advance for any reviews and comments.

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


