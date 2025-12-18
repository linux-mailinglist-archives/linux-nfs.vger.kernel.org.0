Return-Path: <linux-nfs+bounces-17196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8390CCCD7E0
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABDF03028F66
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866C6263C8C;
	Thu, 18 Dec 2025 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/ugQLPn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112E2C3248
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088836; cv=none; b=f9OB4vM1OGeT7hyBYtm6ps+7MGPQtDE4r4pV0j7gCbz40BvFR1UfOxyaJIIWIv7wUN/dp9eVSkXHpkE8lSI40sGUDAVpfIXxrXJPrg0k/eJilJLszKu/06NFRoLMmQXT7bwR06EzfPohNla4fjHkCt+r8aHSXGqoSDzu8XK42jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088836; c=relaxed/simple;
	bh=9kdBpq6FQJta2CkT991cJ6wuKPoO0QWkktL+AnSi7Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6Z28mRTpG2S/X+U4m7Ufq3XRl1A17UN6OlsvL6LugywjYDSZQ8SATiCEltvW3n6JCjEzgwyr0Uiw30e3FRasYAbBI7rXgKE+kWRLMnfRqa67Z2MGGc7NCMzsuQl4nm1KudybL9bxi2nf/Gx+4a4XgXhQ6+M5eypSC+073sQ2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/ugQLPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E16CC4CEFB;
	Thu, 18 Dec 2025 20:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088836;
	bh=9kdBpq6FQJta2CkT991cJ6wuKPoO0QWkktL+AnSi7Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/ugQLPn7fcWaCzWZm1mNm3O9cJZ54wN2yPp5k6C/e7moJj32dutvxQ2k8ELF3nzX
	 tl5caYireWBcwLBri8fNoZku8Zu90oxyEXq78eq+5uBDO0lii+LG1D9PYve9zCXslx
	 lEMNHRG1ou+xnachLN88ydpmdYD+3mMwfLbYWp6pkzMwHs4iBvYGf67TgMNCFCGFdB
	 vij8eD3JLLoRmKrLjnkqz6ocIY+M4c4/FZOAWxFubyPUX+dm0IGhe0tVPpO8YogqW5
	 jZtV63Icpi+bmbAkfSUYao7PFOPL+gDCN4g+EVNDTup0DJhfxeIPp3iy/eEme4Ot5R
	 JidmY48zi9SlQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 08/36] lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
Date: Thu, 18 Dec 2025 15:13:18 -0500
Message-ID: <20251218201346.1190928-9-cel@kernel.org>
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

The lockd subsystem unnecessarily exposes internal NLM XDR type
definitions through the global include path. These definitions are
not used by any code outside fs/lockd/, making them inappropriate
for include/linux/lockd/.

Moving xdr.h to fs/lockd/ narrows the API surface and clarifies
that these types are internal implementation details. The comment
in linux/lockd/bind.h claiming xdr.h was needed for "xdr-encoded
error codes" is stale: no lockd API consumers actually use those
codes. A forward declaration for struct nfs_fh is needed because
its definition was previously pulled in transitively through xdr.h.

Built and tested with lockd client/server operations. No functional
change.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h                  | 2 +-
 {include/linux => fs}/lockd/xdr.h | 8 +++-----
 include/linux/lockd/bind.h        | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)
 rename {include/linux => fs}/lockd/xdr.h (96%)

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 535f752d5de1..94345bf2d6ce 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -15,7 +15,7 @@
 #include <linux/refcount.h>
 #include <linux/utsname.h>
 #include <linux/lockd/bind.h>
-#include <linux/lockd/xdr.h>
+#include "xdr.h"
 #include <linux/sunrpc/debug.h>
 #include <linux/sunrpc/svc.h>
 
diff --git a/include/linux/lockd/xdr.h b/fs/lockd/xdr.h
similarity index 96%
rename from include/linux/lockd/xdr.h
rename to fs/lockd/xdr.h
index 17d53165d9f2..a8090191434e 100644
--- a/include/linux/lockd/xdr.h
+++ b/fs/lockd/xdr.h
@@ -1,14 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * linux/include/linux/lockd/xdr.h
- *
  * XDR types for the NLM protocol
  *
  * Copyright (C) 1996 Olaf Kirch <okir@monad.swb.de>
  */
 
-#ifndef LOCKD_XDR_H
-#define LOCKD_XDR_H
+#ifndef _LOCKD_XDR_H
+#define _LOCKD_XDR_H
 
 #include <linux/fs.h>
 #include <linux/filelock.h>
@@ -112,4 +110,4 @@ bool	nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-#endif /* LOCKD_XDR_H */
+#endif /* _LOCKD_XDR_H */
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index be11b9795934..fdb906ae65d2 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -11,10 +11,9 @@
 #define LINUX_LOCKD_BIND_H
 
 #include <linux/lockd/nlm.h>
-/* need xdr-encoded error codes too, so... */
-#include <linux/lockd/xdr.h>
 
 /* Dummy declarations */
+struct nfs_fh;
 struct svc_rqst;
 struct rpc_task;
 struct rpc_clnt;
-- 
2.52.0


