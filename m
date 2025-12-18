Return-Path: <linux-nfs+bounces-17190-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D24CCCD7C2
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF033302C4E3
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A032C08C0;
	Thu, 18 Dec 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDpPVijn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC1263C8C
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088832; cv=none; b=TqX7yceNFUHgnzKZPTbD3t70iw0/gtOWH+o5qxasM3vlMfdQCDX42Aqj2Bvndv1tMbAVGAgg0j46yJ6R7Bg1I846jHZMEEn3X08kJCLom0epW6qABTmH4s7ItDzqMT6k9bEx1FAj5upVTpV1HLhBECA34N2QNNx4t4xkdH1sxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088832; c=relaxed/simple;
	bh=2qxAVfjsfCsVnp9MlR7UX9zaCFCYPzHIjCPpyw4sZT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCuojXlr3IAbjCiItlUy4TWuwMk4DRtoJuQTQjSqxqr+MdRMqwcKwZZfUNcKphk8/pIoIfHPr/E6ER9VGZ6cIDaXe6wyCTPf0q4zfy7CgtMYoxF/LBfJCrBoyFJbCRYoDkirM0QgJcjDMPexhX1o12u7OD2rHdfNCBrWosIyLTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDpPVijn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802E2C113D0;
	Thu, 18 Dec 2025 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088832;
	bh=2qxAVfjsfCsVnp9MlR7UX9zaCFCYPzHIjCPpyw4sZT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDpPVijnwTAzrxMrUGjA4BY5f2UUoqid59ollImY94j3cQQb86czwNr2kDGjETFko
	 mwQSmZGOKdkR5OERJp1nF8iu89ljlNzwwYjWMazcSGW2p7aIoQmu3R/h4H5gzDVI8f
	 gnfA7woYzfqom1h9h0vieFSG9tLl/HLYdRGzNlWHlqxFFmvQOttQgJBFqQoUxUP81x
	 GUhxhau6sjYJVaJZ6Ng1kU8fh0sdG1QTreIQc4RUdD1RWtXmsGOtLMYLGW7KQRHn6e
	 qqZhQnBvkXqmKqj6e34K/+noD6J+oTqY9U3ErlkciW3I02Y7Riu/3vqw/2I8K4ZXoq
	 MV+VOeUtL5/Hg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 03/36] NFS: Use nlmclnt_rpc_clnt() helper to retrieve nlm_host's rpc_clnt
Date: Thu, 18 Dec 2025 15:13:13 -0500
Message-ID: <20251218201346.1190928-4-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The external API definitions for lockd reside in linux/lockd/bind.h.
Because "struct nlm_host" is an internal lockd structure, bind.h
does not include a definition of it. Dereferencing that structure
outside of lockd violates the layering boundary between NFS and
lockd.

The proper approach is to use the nlmclnt_rpc_clnt() helper function
already provided in lockd/bind.h, which retrieves the NLM host's
struct rpc_clnt without exposing internal lockd structures. This
maintains clean separation between the NFS client and lockd
internals.

Note that the nlm_host's h_rpcclnt field can be NULL during
initialization (host.c:141) or after cleanup (host.c:629). Add a
NULL check before calling shutdown_client() to prevent a potential
NULL pointer dereference in the sysfs shutdown path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/sysfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index ea6e6168092b..186b29de0129 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -12,7 +12,7 @@
 #include <linux/string.h>
 #include <linux/nfs_fs.h>
 #include <linux/rcupdate.h>
-#include <linux/lockd/lockd.h>
+#include <linux/lockd/bind.h>
 
 #include "internal.h"
 #include "nfs4_fs.h"
@@ -284,8 +284,12 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (!IS_ERR(server->client_acl))
 		shutdown_client(server->client_acl);
 
-	if (server->nlm_host)
-		shutdown_client(server->nlm_host->h_rpcclnt);
+	if (server->nlm_host) {
+		struct rpc_clnt *nlm_clnt = nlmclnt_rpc_clnt(server->nlm_host);
+
+		if (nlm_clnt)
+			shutdown_client(nlm_clnt);
+	}
 out:
 	shutdown_nfs_client(server->nfs_client);
 	return count;
-- 
2.52.0


