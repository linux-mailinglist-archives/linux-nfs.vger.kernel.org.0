Return-Path: <linux-nfs+bounces-18366-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sERRAMDDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18366-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE4279CF2
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D38F3303C82E
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF732C08AB;
	Fri, 23 Jan 2026 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghhyO4+w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE252848AA
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194387; cv=none; b=N4LEAi7JNvEz7gSlGnTXQaqtDwcckGKsiCLHYiNTl7lZDl+eESkuXfd4eWvG3+Uax1pA9mgMPclG6oqbbxsrUKb0OgJnUBuNtQWxLe7oAFcFoBKFBwByI5U9jIQcngStPal54SkdagqgcfMPSAtlFHjBwXFy6ynoVjQ/Fo5KeTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194387; c=relaxed/simple;
	bh=2qxAVfjsfCsVnp9MlR7UX9zaCFCYPzHIjCPpyw4sZT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAxasl/frRqcsm8zWQ4Bxpi71tOsUOiL8aNXYC9jAIYCr2S6nFsO8DUnCup3Gd5dQHajttsgjMRMa4n4vOebZ6sA1GdzCVm3ELSoTq3tEXEYgsvIVI7prl/ZGPhPc4B4ol4DyhFk/AC26hBM7JeD4njD5tJNRpFgNvSr3bRP3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghhyO4+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91979C4CEF1;
	Fri, 23 Jan 2026 18:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194387;
	bh=2qxAVfjsfCsVnp9MlR7UX9zaCFCYPzHIjCPpyw4sZT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghhyO4+wBR3rPT9/yihGh7OSFfQ5n/HgmtdP2OUb29D8syGgqdILsgI1xU+nY7+Jk
	 vtSLqx/4w3eZeuOrQDnKv1Wqt8EhJILYMVKh+1+wizmYLZH+mcJLHbtI1GYtcJh7HX
	 kHVxZ7mQXHRBmf1Au1pZk35r60psc1QMyhIvzEnJBlXOjYrMav/oSdkEWdXHZ7KGlA
	 kDl1cKxm2sn8SRW4kbCwnh2O/scw2NpIKAAtLejORxCLEJe4TtegbsIYapo+PG180p
	 0DhNoxfddF8Gr8SGeeu5wOvIsWhetfgMFkRzADEf/ADxfxeuGwWVYsuTTJFYkw9jFp
	 MJJ3vnNLGwcsw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 05/42] NFS: Use nlmclnt_rpc_clnt() helper to retrieve nlm_host's rpc_clnt
Date: Fri, 23 Jan 2026 13:52:22 -0500
Message-ID: <20260123185259.1215767-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123185259.1215767-1-cel@kernel.org>
References: <20260123185259.1215767-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18366-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CE4279CF2
X-Rspamd-Action: no action

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


