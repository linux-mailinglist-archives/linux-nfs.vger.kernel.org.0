Return-Path: <linux-nfs+bounces-6774-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC298C6DD
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 22:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E99B2219D
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 20:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68491CDA08;
	Tue,  1 Oct 2024 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atePX4dL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D601CCEF2
	for <linux-nfs@vger.kernel.org>; Tue,  1 Oct 2024 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814841; cv=none; b=QVxqlPr6TE8MIebLeAoA5jZ/s1ap8x+ImoRFJCV+oD0ZlNY7XgkRG5fqUMsLf9kf8UW67Xm5mxHVhduy17pvZXxn5jzC/tIYJJ0gNzren3R18oscCDTKRzly7IEUeNC5KlhUu0sIQCGiq88aTl989gTPUQi2DurPo8XJtmBW9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814841; c=relaxed/simple;
	bh=4kyehUr49bd1l6Y38JTbt9Fz18jQ8I3oUMl4DAnEgKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMaFOVmazXrVFEHNsU8ZKVA3bVcUq4kzPtJAaSXaDOMo6tS0oWdLVaytPdopMByYZ0+pDZL+iNLZaIEyyD8jDfTqCkjUTJKmtYKMz92UeoEF1K/dSwDPk8F2QC0n+USpZBBpBILdUIwD0lSzzsScVrHTJvnfcJ2fYipR/0UuaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atePX4dL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197EAC4CED1;
	Tue,  1 Oct 2024 20:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727814841;
	bh=4kyehUr49bd1l6Y38JTbt9Fz18jQ8I3oUMl4DAnEgKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atePX4dLYhMiEae/7SnCw0ndro64WwIGd+tZqLYmmJEi/SOZaqAYSb6ZGx59nAuhx
	 g1u9SaLUZKzWW6wiSIYC2tQfnNAp4S/1oYyOeKdmT20DgAiesz8hGgZDx/fiy3WCQk
	 drm8+GgJG5NMFH9kZFJrwuQcnnyGZ23R5FT4jM78itm+caCfRA6POp+DLzEEa35M0d
	 Hr+jy2PIhcYO0lgX+fvCcYJUwiEKXXjoqqCwL8EitzEZXaZhkmpfe5zLE9DxFlRlg0
	 EHewLEl65vf6md61RvlzGi7fDTdGE9B6KdmQXy8rOWf2Xnr66laNpaz5KK42PDFo/Q
	 Zhu0o06YD33WA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 5/5] NFS: Implement get_nfs_version()
Date: Tue,  1 Oct 2024 16:33:44 -0400
Message-ID: <20241001203344.327044-6-anna@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001203344.327044-1-anna@kernel.org>
References: <20241001203344.327044-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This is a pair for put_nfs_version(), and is used for incrementing the
reference count on the nfs version module. I also updated the callers I
could find who had this hardcoded up until now.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/client.c     | 10 ++++++++--
 fs/nfs/fs_context.c |  4 ++--
 fs/nfs/namespace.c  |  2 +-
 fs/nfs/nfs.h        |  1 +
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4fe5a635f329..68a88f29a1d6 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -100,12 +100,18 @@ struct nfs_subversion *find_nfs_version(unsigned int version)
 	if (!nfs)
 		return ERR_PTR(-EPROTONOSUPPORT);
 
-	if (!try_module_get(nfs->owner))
+	if (!get_nfs_version(nfs))
 		return ERR_PTR(-EAGAIN);
 
 	return nfs;
 }
 
+int get_nfs_version(struct nfs_subversion *nfs)
+{
+	return try_module_get(nfs->owner);
+}
+EXPORT_SYMBOL_GPL(get_nfs_version);
+
 void put_nfs_version(struct nfs_subversion *nfs)
 {
 	module_put(nfs->owner);
@@ -149,7 +155,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 
 	clp->cl_minorversion = cl_init->minorversion;
 	clp->cl_nfs_mod = cl_init->nfs_mod;
-	if (!try_module_get(clp->cl_nfs_mod->owner))
+	if (!get_nfs_version(clp->cl_nfs_mod))
 		goto error_dealloc;
 
 	clp->rpc_ops = clp->cl_nfs_mod->rpc_ops;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index d553daa4c09c..b069385eea17 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1541,7 +1541,7 @@ static int nfs_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 	}
 	nfs_copy_fh(ctx->mntfh, src->mntfh);
 
-	__module_get(ctx->nfs_mod->owner);
+	get_nfs_version(ctx->nfs_mod);
 	ctx->client_address		= NULL;
 	ctx->mount_server.hostname	= NULL;
 	ctx->nfs_server.export_path	= NULL;
@@ -1633,7 +1633,7 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		}
 
 		ctx->nfs_mod = nfss->nfs_client->cl_nfs_mod;
-		__module_get(ctx->nfs_mod->owner);
+		get_nfs_version(ctx->nfs_mod);
 	} else {
 		/* defaults */
 		ctx->timeo		= NFS_UNSPEC_TIMEO;
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index e7494cdd957e..2d53574da605 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -182,7 +182,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	ctx->version		= client->rpc_ops->version;
 	ctx->minorversion	= client->cl_minorversion;
 	ctx->nfs_mod		= client->cl_nfs_mod;
-	__module_get(ctx->nfs_mod->owner);
+	get_nfs_version(ctx->nfs_mod);
 
 	ret = client->rpc_ops->submount(fc, server);
 	if (ret < 0) {
diff --git a/fs/nfs/nfs.h b/fs/nfs/nfs.h
index a30bf8ef79d7..8a5f51be013a 100644
--- a/fs/nfs/nfs.h
+++ b/fs/nfs/nfs.h
@@ -22,6 +22,7 @@ struct nfs_subversion {
 };
 
 struct nfs_subversion *find_nfs_version(unsigned int);
+int get_nfs_version(struct nfs_subversion *);
 void put_nfs_version(struct nfs_subversion *);
 void register_nfs_version(struct nfs_subversion *);
 void unregister_nfs_version(struct nfs_subversion *);
-- 
2.46.2


