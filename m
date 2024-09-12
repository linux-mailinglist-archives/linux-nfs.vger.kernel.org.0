Return-Path: <linux-nfs+bounces-6408-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04A59769E2
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 15:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 014F8B24195
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E821A76D7;
	Thu, 12 Sep 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVPwUt1a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B981A724C;
	Thu, 12 Sep 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146161; cv=none; b=t64hseHhS/6fGDIMvu4q6NVBdd3Bb2X8QrIYPWQ9csAwRZ0xQYiCemiCwgDCS1PF3pEYnmNHAENR/1aIdz+2t3Mcig+EsVFZkW40L8jttPV7lZo3qKRtgZhsmwIGws3MuUwh3NrmyXDUMiLYvMMWXu+MqV1xh5vlbVFCazxWSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146161; c=relaxed/simple;
	bh=ptLyRrhx22moDL3wpObMavhKGoI23EYMx3FtOroktGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XA+DtkzDnV++DH29zoYdwxp0hjDd0vU/1hzZiLP95cPSq5qa1m1sP69XjvBxRBfXdsYk5JhVMcjOcu9Id7n+lJ5i+poE7Z3vHwNyA5/oB3kxAv1BNtTz19+AaF/qJHHOrPyvav3w4ROPcxpqbsV6BkQSCsyKK5x/qaxdpytnVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVPwUt1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E93C4AF09;
	Thu, 12 Sep 2024 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726146161;
	bh=ptLyRrhx22moDL3wpObMavhKGoI23EYMx3FtOroktGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVPwUt1aEVG660iImRNCEn7rEEzTdgJCW0yUhaj8QCcriZTT54nm6r86kioqqLbt3
	 PUHZMr2Aa65eIA1FkeAGziopwEk8jt4jefGOCyJUfv4CvALEZBsyYEO36DXDThtS/o
	 h9IIydnAfopM6RLKPFgoYT97Kys0jmMrQqpoMKZYpsbW4QornRTEUsEpAUIdJjFZ7p
	 vIFafvYI2+1bf4mmPAMBhZXM/XZF0FSxjhIbSyFig95PxoarUwkKrPn0Sh4ab/HAWv
	 Pv8CyeW65/y8NG5WjoNgN/3EO0nmhnmLN9l1rfdqjDv7OtR1G8Zh0/niD36a0htWZH
	 LlYRsoqaLMcTA==
Received: by pali.im (Postfix)
	id EA5C3B9A; Thu, 12 Sep 2024 15:02:35 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] nfs: Try to use AUTH_NULL for NFS3 mount when no -o sec was given
Date: Thu, 12 Sep 2024 15:02:18 +0200
Message-Id: <20240912130220.17032-4-pali@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912130220.17032-1-pali@kernel.org>
References: <20240912130220.17032-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As an absolutely last chance, after all previous failed attempts, try to
use also AUTH_NULL when mounting NFS3 export. Try AUTH_NULL also when MNTv3
server does not announce it because of Linux MNTv3 server rpc.mountd bug
which does not announce AUTH_NULL even when this is the only allowed method
on the server.

Currently AUTH_NULL is always skipped in nfs_try_mount_request() function
even when MNTv3 server announces it and so it is not possible to mount NFS3
export with AUTH_UNIX disallowed on server.

nfs_try_mount_request() function currently tries AUTH_UNIX method even when
server does not announces it. But it does not try to use AUTH_NULL when
server announces AUTH_NULL.

With this patch, AUTH_UNIX behavior as described above is not changed and
after the AUTH_UNIX attempt is added AUTH_NULL attempt as the absolutely
last chance.

With this patch it is possible to mount NFS3 exports with AUTH_NULL method
if all other methods are rejected by server. AUTH_NULL method is useful for
public read-only data exports which do not require any user authentication.

This change fixes mounting of NFS3 AUTH_NULL-only exports without need to
specify any special mount options, like -o sec.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 fs/nfs/super.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 3fef2afd94bd..4cb319be55ca 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -911,6 +911,7 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	int status;
 	unsigned int i;
+	int first_err = 0;
 	bool tried_auth_unix = false;
 	bool auth_null_in_list = false;
 	struct nfs_server *server = ERR_PTR(-EACCES);
@@ -947,7 +948,8 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 	/*
 	 * No sec= option was provided. RFC 2623, section 2.7 suggests we
 	 * SHOULD prefer the flavor listed first. However, some servers list
-	 * AUTH_NULL first. Avoid ever choosing AUTH_NULL.
+	 * AUTH_NULL first. So skip AUTH_NULL here and try it as an absolutely
+	 * last chance at the end of this function.
 	 */
 	for (i = 0; i < authlist_len; ++i) {
 		rpc_authflavor_t flavor;
@@ -971,20 +973,46 @@ static struct nfs_server *nfs_try_mount_request(struct fs_context *fc)
 		server = ctx->nfs_mod->rpc_ops->create_server(fc);
 		if (!IS_ERR(server))
 			return server;
+		if (!first_err)
+			first_err = PTR_ERR(server);
 	}
 
 	/*
-	 * Nothing we tried so far worked. At this point, give up if we've
-	 * already tried AUTH_UNIX or if the server's list doesn't contain
-	 * AUTH_NULL
+	 * If AUTH_UNIX was not available in the server's list and AUTH_NULL was
+	 * then for compatibility with old NFS3 servers try also AUTH_UNIX.
 	 */
-	if (tried_auth_unix || !auth_null_in_list)
+	if (!tried_auth_unix && auth_null_in_list) {
+		dfprintk(MOUNT,
+			 "NFS: attempting to use auth flavor %u%s\n",
+			 RPC_AUTH_UNIX,
+			 ", even it was not announced by server");
+		ctx->selected_flavor = RPC_AUTH_UNIX;
+		server = ctx->nfs_mod->rpc_ops->create_server(fc);
+		if (!IS_ERR(server))
+			return server;
+		tried_auth_unix = true;
+	}
+
+	/*
+	 * Linux MNTv3 server rpc.mountd since nfs-utils version 1.1.3, commit
+	 * https://git.linux-nfs.org/?p=steved/nfs-utils.git;a=commit;h=3c1bb23c0379
+	 * does not include AUTH_NULL into server's list export response even
+	 * when AUTH_NULL is supported and enabled for that export on Linux
+	 * NFS3 server. AUTH_NULL was skipped when processing server's list,
+	 * so always try AUTH_NULL as an absolutely last chance and also when
+	 * it was not available in the server's list.
+	 */
+	dfprintk(MOUNT,
+		 "NFS: attempting to use auth flavor %u%s\n",
+		 RPC_AUTH_NULL,
+		 auth_null_in_list ? "" : ", even it was not announced by server");
+	ctx->selected_flavor = RPC_AUTH_NULL;
+	server = ctx->nfs_mod->rpc_ops->create_server(fc);
+	if (!IS_ERR(server))
 		return server;
 
-	/* Last chance! Try AUTH_UNIX */
-	dfprintk(MOUNT, "NFS: attempting to use auth flavor %u\n", RPC_AUTH_UNIX);
-	ctx->selected_flavor = RPC_AUTH_UNIX;
-	return ctx->nfs_mod->rpc_ops->create_server(fc);
+	/* Prefer error code from the first attempt of server's list. */
+	return first_err ? ERR_PTR(first_err) : server;
 }
 
 int nfs_try_get_tree(struct fs_context *fc)
-- 
2.20.1


