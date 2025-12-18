Return-Path: <linux-nfs+bounces-17191-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F91CCD7BC
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75299302D4E8
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7423263C8C;
	Thu, 18 Dec 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImiP72Nu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2E2D877D
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088832; cv=none; b=tcAxkXSpd9YbGya8feB+0yL64ngUFI5hkWnY1fnF1LUrfL0DPKx0BTX6P6MoJpfzB3vbH7Pvb+UV8/ekhk/pm9c4NEBg94NykGm43hGcrVzxvoPyuaydFsRr23jxfqMO/Api1EFYUIbO0WUw5JlSrDe6rHd/BY3aRD4E+Fy01Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088832; c=relaxed/simple;
	bh=5h1M0taXmUPRfgp5Fihh9uH8QRkwG1dM3kdaboZvgMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtXUMi9sEVhBVRZRGezNcKbxd6to7GYEBFmH/UIKe3Xq+y5BTHJ3f5aD51c5P3qoL8a1qmGPrKolW+AiNtIQwAmPTeFb2C/y7v7euDhtYVLYBbYw8yhz08HkKrbU2gj1YMxMZv8uDEjLj2xbXAYjKtGTkwqnd/qQh+GueFhslKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImiP72Nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D4FC116D0;
	Thu, 18 Dec 2025 20:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088831;
	bh=5h1M0taXmUPRfgp5Fihh9uH8QRkwG1dM3kdaboZvgMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImiP72NuNtc6FbUtS1o5bvamfLFDcn9g/jU6iEsmzZXCkxS0YiAwy5HlADO5ZYVv2
	 jRO6SO2+7MuBxgv45iN47RtPbdAjr4xLqLZVFooGZqE0xwk7HxYbJePAj2PTOLYmSZ
	 cpKVNPqYRq4uQPhsqeWoU4g4dLCMvnOBKfa3D6FxMu/Sv+/OG/rQ9yzvf5Y5YLRWs7
	 +CmQiw2RMsNRgby31rwGT1U1PEOp96SDi2+lvQjWMUHw58E9wmnUvh2wpTC/BewSB5
	 N5yv2h7acLnhhf8QiIHVAhNQfotxLKQkiULvU2Pv3256QzWYVF6wqYsck3Z6h4zTEh
	 sAThdsKU1tmzQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 02/36] lockd: Relocate nlmsvc_unlock API declarations
Date: Thu, 18 Dec 2025 15:13:12 -0500
Message-ID: <20251218201346.1190928-3-cel@kernel.org>
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

The nlmsvc_unlock_all_by_sb() and nlmsvc_unlock_all_by_ip()
functions are part of lockd's external API, consumed by other
kernel subsystems. Their declarations currently reside in
linux/lockd/lockd.h alongside internal implementation details,
which blurs the boundary between lockd's public interface and
its private internals.

Moving these declarations to linux/lockd/bind.h groups them
with other external API functions and makes the separation
explicit. This clarifies which functions are intended for
external use and reduces the risk of internal implementation
details leaking into the public API surface.

Build-tested with allyesconfig; no functional changes.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/lockd.c             | 1 +
 fs/nfsd/nfsctl.c            | 2 +-
 include/linux/lockd/bind.h  | 3 +++
 include/linux/lockd/lockd.h | 6 ------
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index f2a9bda513cf..ea0ed8f0f822 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/file.h>
+#include <linux/fs.h>
 #include <linux/lockd/bind.h>
 #include "nfsd.h"
 #include "vfs.h"
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 04125917e635..d24b3bd2dede 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -11,7 +11,7 @@
 #include <linux/fs_context.h>
 
 #include <linux/sunrpc/svcsock.h>
-#include <linux/lockd/lockd.h>
+#include <linux/lockd/bind.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/gss_api.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index 2f5dd9e943ee..e5ba61b7739f 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -80,4 +80,7 @@ extern int	nlmclnt_proc(struct nlm_host *host, int cmd, struct file_lock *fl, vo
 extern int	lockd_up(struct net *net, const struct cred *cred);
 extern void	lockd_down(struct net *net);
 
+int nlmsvc_unlock_all_by_sb(struct super_block *sb);
+int nlmsvc_unlock_all_by_ip(struct sockaddr *server_addr);
+
 #endif /* LINUX_LOCKD_BIND_H */
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 330e38776bb2..e31893ab4ecd 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -302,12 +302,6 @@ void		  nlmsvc_mark_resources(struct net *);
 void		  nlmsvc_free_host_resources(struct nlm_host *);
 void		  nlmsvc_invalidate_all(void);
 
-/*
- * Cluster failover support
- */
-int           nlmsvc_unlock_all_by_sb(struct super_block *sb);
-int           nlmsvc_unlock_all_by_ip(struct sockaddr *server_addr);
-
 static inline struct file *nlmsvc_file_file(const struct nlm_file *file)
 {
 	return file->f_file[O_RDONLY] ?
-- 
2.52.0


