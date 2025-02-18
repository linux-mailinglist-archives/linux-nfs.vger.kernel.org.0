Return-Path: <linux-nfs+bounces-10188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71535A3ABB0
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 23:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652A91714CB
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 22:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F9A1D9A50;
	Tue, 18 Feb 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="i3zglil0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794281D9587;
	Tue, 18 Feb 2025 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917869; cv=none; b=dKdcgGozN2tUEpurrhTOjstUktnfH6gK1JRqeTdykUmb1ggby3dPNLI6aKBTuj4e8MgQUZVrPPAeuZ719WdvRNyG0bawWBvBVhS283SsYs1CxdWbiM53On67vw66SVDOi65knBO0JQY8cffY+O673nlpIadhewED0paualp4DI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917869; c=relaxed/simple;
	bh=QrexZmZp5Pa+qGgO2/S3nAg6IHlh6SMfpEqr89qoqyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBvi6IrUoj3yzJfhE6/svIlB0fIBqsFbzxxTan8vAcKEEDKoJ+i74qKVWecck8OytKDrY9ckQJAcz5SxP5wR1i774piN1TLrZ/86fmn8Mkot7ZFQf+cKDyuIKhjfOLvcWinLs+BVUC61endvzBIlGwatvswxjg/02k/TUpWXLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=i3zglil0; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=uFEZd17Q2NrrbJs8WKzmWUXkQNoKRppRgUwSdcJH8/A=; b=i3zglil07rpiSapd
	PdMbBC02A1C9F2/tBNyRDEIV1p36u6b4xdqSJyAAKUHVk/Oj21wagH4p6Bhk3dEZ/FuyOnC5/RVvw
	YrSZhddB3UnVnPxX2j6v+pUxLVUyDRtp3NBhB+xSd2qTC7c+LOd49UJezZoAUqpNJyXRvamE5Sj0n
	hcqE1iEY83gGWemG5ISfYWkCfq4AUM3Qf8L/hoMDbI6Pt3ix0O/66UUN2Ol2YULdFbb0GGBAs8okx
	OPfwoXCPKpTmYW2sMVLid4KcopH5xwQ6T/ESqQ0DvalnPxYZAtYYBlBOABkRBmoVc1Qo/lf+PYPSh
	YvNdH2QEl1fLpNsszw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tkVWN-00GkMP-2Y;
	Tue, 18 Feb 2025 21:52:51 +0000
From: linux@treblig.org
To: trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] NFS: Remove unused function nfs_umount
Date: Tue, 18 Feb 2025 21:52:50 +0000
Message-ID: <20250218215250.263709-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

nfs_umount() has been unused since 2013's
commit 4580a92d44e2 ("NFS: Use server-recommended security flavor by
default (NFSv3)")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/nfs/internal.h   |  1 -
 fs/nfs/mount_clnt.c | 68 ---------------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index fae2c7ae4acc..36dcbb928c5f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -207,7 +207,6 @@ struct nfs_mount_request {
 };
 
 extern int nfs_mount(struct nfs_mount_request *info, int timeo, int retrans);
-extern void nfs_umount(const struct nfs_mount_request *info);
 
 /* client.c */
 extern const struct rpc_program nfs_program;
diff --git a/fs/nfs/mount_clnt.c b/fs/nfs/mount_clnt.c
index 57c9dd700b58..db8dfb920394 100644
--- a/fs/nfs/mount_clnt.c
+++ b/fs/nfs/mount_clnt.c
@@ -223,74 +223,6 @@ int nfs_mount(struct nfs_mount_request *info, int timeo, int retrans)
 	goto out;
 }
 
-/**
- * nfs_umount - Notify a server that we have unmounted this export
- * @info: pointer to umount request arguments
- *
- * MOUNTPROC_UMNT is advisory, so we set a short timeout, and always
- * use UDP.
- */
-void nfs_umount(const struct nfs_mount_request *info)
-{
-	static const struct rpc_timeout nfs_umnt_timeout = {
-		.to_initval = 1 * HZ,
-		.to_maxval = 3 * HZ,
-		.to_retries = 2,
-	};
-	struct rpc_create_args args = {
-		.net		= info->net,
-		.protocol	= IPPROTO_UDP,
-		.address	= (struct sockaddr *)info->sap,
-		.addrsize	= info->salen,
-		.timeout	= &nfs_umnt_timeout,
-		.servername	= info->hostname,
-		.program	= &mnt_program,
-		.version	= info->version,
-		.authflavor	= RPC_AUTH_UNIX,
-		.flags		= RPC_CLNT_CREATE_NOPING,
-		.cred		= current_cred(),
-	};
-	struct rpc_message msg	= {
-		.rpc_argp	= info->dirpath,
-	};
-	struct rpc_clnt *clnt;
-	int status;
-
-	if (strlen(info->dirpath) > MNTPATHLEN)
-		return;
-
-	if (info->noresvport)
-		args.flags |= RPC_CLNT_CREATE_NONPRIVPORT;
-
-	clnt = rpc_create(&args);
-	if (IS_ERR(clnt))
-		goto out_clnt_err;
-
-	dprintk("NFS: sending UMNT request for %s:%s\n",
-		(info->hostname ? info->hostname : "server"), info->dirpath);
-
-	if (info->version == NFS_MNT3_VERSION)
-		msg.rpc_proc = &clnt->cl_procinfo[MOUNTPROC3_UMNT];
-	else
-		msg.rpc_proc = &clnt->cl_procinfo[MOUNTPROC_UMNT];
-
-	status = rpc_call_sync(clnt, &msg, 0);
-	rpc_shutdown_client(clnt);
-
-	if (unlikely(status < 0))
-		goto out_call_err;
-
-	return;
-
-out_clnt_err:
-	dprintk("NFS: failed to create UMNT RPC client, status=%ld\n",
-			PTR_ERR(clnt));
-	return;
-
-out_call_err:
-	dprintk("NFS: UMNT request failed, status=%d\n", status);
-}
-
 /*
  * XDR encode/decode functions for MOUNT
  */
-- 
2.48.1


