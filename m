Return-Path: <linux-nfs+bounces-2089-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A4868104
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 20:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E53D286397
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 19:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55112FF69;
	Mon, 26 Feb 2024 19:29:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1512F586;
	Mon, 26 Feb 2024 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975783; cv=none; b=gw5rrnjeh6+picChpEVaxjWq7KSh6Hff5IrAu4JxxqLxn01+GV1iyt/+5AhumuXJHBelq7jX6OGd4jZxXMKSi/oigfvoTl6lNYq8igdvvyZu3wS4FYwlMsQ1fgWEn8EcNqyusAuGCruMfWdBgGoPebb3ed3ZOuHakPME24GUr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975783; c=relaxed/simple;
	bh=Zs+IbvV7d0hitWb7oIpv8aJWVlfPLjA5xRa5/SeXvWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B7gQO/rFpdVByFFaC5eTkm4KUslstZeD1XqdpX4hba7a2EbIxbdfNKiKljbVZGDU25EMIXToXRBlhTB7eM2tPVKBgUgFuTnTKfubac5J0lDbTFmtvygEcD+DIQBzI1KamihTFLlB2U3xLQ8bQvecPk6nw4sCYKSNrTBKNP8VMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-209-155.188.097.pools.vodafone-ip.de ([188.97.209.155] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1regey-001hI7-11;
	Mon, 26 Feb 2024 20:29:08 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2] nfs: keep server info for remounts
Date: Mon, 26 Feb 2024 20:29:08 +0100
Message-Id: <20240226192908.48789-1-martin@kaiser.cx>
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
v2:
 - rebased against today's linux-next

Dear all,
I'm resending this patch, it might have slipped through the cracks. The
problem that I'm trying to fix is still present in linux-next. Thanks in
advance for any reviews and comments.


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


