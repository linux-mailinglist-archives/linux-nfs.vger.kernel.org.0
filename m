Return-Path: <linux-nfs+bounces-10634-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D4FA65FF9
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22578189806D
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7536202C40;
	Mon, 17 Mar 2025 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzQR6Vc+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1320296C;
	Mon, 17 Mar 2025 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245209; cv=none; b=hXtFJRq2/V60rFIZYtCT/xA+34rvY/T/xowzKckxYKm3WqoK2DP07EtsihDE+DjTaHpkdoxDRuOQcgLXKRhqgN5xQB3KdVdcuSWKptJ5uNCyhJePJIr/yKomU51+cxE7Wp7oyzKWgs7E25hKlpzR92Sq1q2ANS6PJ5CO+Mo0Ahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245209; c=relaxed/simple;
	bh=+G4GEs+C3F247y1XxEheT7t8MXEdbzC3dtqmXdncARw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJRMBu/pFuXw4ijg+eCjZmfaOnwWSXN9qSO1+x4/xBD0A0Vci4aN+KzrSUkD/TkYHqiHZnaqvNGTN0J4xAm58AjpqnPeIOjDO2cnq+glNgT9hCQviDX5uBnANTfpOcLGUv+izJjeHfC2x7BHXTC1PYAMP+ZeafQGw4CDZPts+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzQR6Vc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66DBC4CEEF;
	Mon, 17 Mar 2025 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245209;
	bh=+G4GEs+C3F247y1XxEheT7t8MXEdbzC3dtqmXdncARw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HzQR6Vc+47rQmBdPLXfcFpV3KmDrShA+dR+S2i3PFe4GPKGj8VsUF1kz081Tsk8Jx
	 O688l3oKvCtLPIoxYFGH2pntRpzSqV0uezhSjSzalys1/QVXa8gT6HzoFgHH+s3fJR
	 nP+kovuERymE3EFM8JCUtBBxfey7Eb33uqpoNZ67nv4aiwXMg4H5FI16NRZNTkCvN+
	 sDC3VcE5PDS/4wEoxg+UX+2VYOSYiUOFtrpzjZkoQCiZk+5SRWy7wpD9WZ5Nnc1fG9
	 mkUxvzoKf2w3uphqNdpV/etpczsWj34hxuuobJII6/IYq7/is0I+XuHy5Vumwjp5LW
	 9ZjrORlBOuy5w==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 17 Mar 2025 16:59:53 -0400
Subject: [PATCH RFC 1/9] sunrpc: transplant shutdown_client() to sunrpc
 module
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rpc-shutdown-v1-1-85ba8e20b75d@kernel.org>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
In-Reply-To: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, 
 Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3086; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+G4GEs+C3F247y1XxEheT7t8MXEdbzC3dtqmXdncARw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn2I1Ufn1hQfrwvIELveta9eb6BpvxFGO9B1fp/
 ADErQVybXqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ9iNVAAKCRAADmhBGVaC
 FdLRD/4zgiTqDasldmLP4CLSQQyQCbGPyo9GmUIFWygN19EJNbOdhs0AtGhLHEOwvkPecrFPlre
 34HHVDpatRohB66nvvzC4UD4kHjxdq4MHHrbl5RXUcSZZBhdk7r9LzmWxn+8+wepCUyOu2zIKyc
 ohRZP+/+6sYv0BNbITH/BS7EcwAgwxObZEbfF5EluHE5YNH9BkEup11i4cxEHHFtZljf8whKVsH
 9+aZksDsq074CcQYF7sGeRxdQR235p3nbMOuHstcOoVL2R/Bw1La4hIhxOR2jYtBS12NSilVmSm
 rIDMFrpa/r1dlvsblgaggYw0lvKTYY/4fzE/NdBgtZhn02pGU+IFv42spf0wOc+AlTOLu+U7rSE
 V/5PK/ElO+QzLXVNq6T5bSOq1JeHdG179wKtzezBAE+/e1rx+hdMOGp4TC/Iww0nYG+hISBQ5dV
 TkglMGbGt8/KPmhGl+WuNUYMWoVkoeizSmewaHRPRoKyGEAPhqAY1+gj30v+pWOh9Uh1CGNC1Bc
 IlTc+VIdQ+GbaWvDTf8UXQ8RGtTcWyxl8yH8rBMj1XBmbmgUfNCrmVo0PUxJbfE4NetehkSJGxA
 sZVHrhMA9KN4Dmw8t16XFeGONEcUwkQDxd9uBEOWuwAonv9cEak5RwNUzLKyQgnQ3j5izMlCeZf
 HgqIeG0aoSmLuKg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is really a sunrpc-level function, and in later patches we'll need
to call this routine from lockd as well. Move it to the sunrpc module,
rename and export it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/sysfs.c               | 19 ++++---------------
 include/linux/sunrpc/sched.h |  1 +
 net/sunrpc/clnt.c            | 12 ++++++++++++
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 7b59a40d40c061a41b0fbde91aa006314f02c1fb..c29c5fd639554461bdcd9ff612726194910d85b5 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -217,17 +217,6 @@ void nfs_netns_sysfs_destroy(struct nfs_net *netns)
 	}
 }
 
-static bool shutdown_match_client(const struct rpc_task *task, const void *data)
-{
-	return true;
-}
-
-static void shutdown_client(struct rpc_clnt *clnt)
-{
-	clnt->cl_shutdown = 1;
-	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
-}
-
 static ssize_t
 shutdown_show(struct kobject *kobj, struct kobj_attribute *attr,
 				char *buf)
@@ -258,14 +247,14 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 		goto out;
 
 	server->flags |= NFS_MOUNT_SHUTDOWN;
-	shutdown_client(server->client);
-	shutdown_client(server->nfs_client->cl_rpcclient);
+	rpc_clnt_shutdown(server->client);
+	rpc_clnt_shutdown(server->nfs_client->cl_rpcclient);
 
 	if (!IS_ERR(server->client_acl))
-		shutdown_client(server->client_acl);
+		rpc_clnt_shutdown(server->client_acl);
 
 	if (server->nlm_host)
-		shutdown_client(server->nlm_host->h_rpcclnt);
+		rpc_clnt_shutdown(server->nlm_host->h_rpcclnt);
 out:
 	return count;
 }
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index eac57914dcf3200c1a6ed39ab030e3fe8b4da3e1..fe7c39a17ce44ec68c0cf057133d0f8e7f0ae797 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -232,6 +232,7 @@ unsigned long	rpc_cancel_tasks(struct rpc_clnt *clnt, int error,
 				 bool (*fnmatch)(const struct rpc_task *,
 						 const void *),
 				 const void *data);
+void		rpc_clnt_shutdown(struct rpc_clnt *clnt);
 void		rpc_execute(struct rpc_task *);
 void		rpc_init_priority_wait_queue(struct rpc_wait_queue *, const char *);
 void		rpc_init_wait_queue(struct rpc_wait_queue *, const char *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 2fe88ea79a70c134e58abfb03fca230883eddf1f..0028858b12d97e7b45f4c24cfbd761ba2a734b32 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -934,6 +934,18 @@ unsigned long rpc_cancel_tasks(struct rpc_clnt *clnt, int error,
 }
 EXPORT_SYMBOL_GPL(rpc_cancel_tasks);
 
+static bool shutdown_match_client(const struct rpc_task *task, const void *data)
+{
+	return true;
+}
+
+void rpc_clnt_shutdown(struct rpc_clnt *clnt)
+{
+	clnt->cl_shutdown = 1;
+	rpc_cancel_tasks(clnt, -EIO, shutdown_match_client, NULL);
+}
+EXPORT_SYMBOL_GPL(rpc_clnt_shutdown);
+
 static int rpc_clnt_disconnect_xprt(struct rpc_clnt *clnt,
 				    struct rpc_xprt *xprt, void *dummy)
 {

-- 
2.48.1


