Return-Path: <linux-nfs+bounces-18504-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMZBJ9vGd2nckgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18504-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:56:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C75C8CD1D
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1080303B4C6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE1628BAB9;
	Mon, 26 Jan 2026 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEdv1EGl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8028DB46
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457347; cv=none; b=iPHSHbxp7i6dDQPM9p/4PyvM7JR7hkXdq08K8xI0XelMqA6lRdRGhbpgP2wLJ1M48IFtgo7HGP0+HeW8d0LWcx6i5d5ZkGTg8oSCo6zZhRH1VzEJPVFH/8bOjpvu0GYC/sUt7Rl2BJmBmYyWZI7BsCutnMUcRJDpGWGv9z0FBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457347; c=relaxed/simple;
	bh=txufS+KOmZ4tCSgEGhQQR0jWfE6Y6AciaCVd/HcPiOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIdX5KfBMr/VHyKNoLPA1Av1qjicMJgp4Jqc0CGoqTMp2GxkKvrV0Az3sa97Ov3Z28d2ixokkoR/vv+Mgp26hKPfAP9qNymD4uX1iBr19tVTJin+uuugSGHS1O4dhskkm6YZBvhNstTB9chxZq9MOKAmH3iKC5ZcBebLhfVbbcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEdv1EGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D839C19422;
	Mon, 26 Jan 2026 19:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457347;
	bh=txufS+KOmZ4tCSgEGhQQR0jWfE6Y6AciaCVd/HcPiOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WEdv1EGlJgne/iutAVhWdvW+09XTYx4h3jJM04qBUbhKHX901VEAzF0LKgrZ1hU1L
	 Tg07917kKbpmcO3/D1XqiX7O2cNZJ9uVB/SiHASTQFiVsQ6dWL91l0UfClqQMX9JDL
	 n0i1hLLqoHyG7lfERHAJzYaioK7tVgVvbEebpbweFiRKgEA8tw9iq6uFkwL5a5fahX
	 iF1KJeR0cnhoUqlsYmmucntfnqAClICRL1kGfdHVsTkOLqVFZJMX9tOycNdNmnio7E
	 k7pHcybotBtgXwonW9ggmIfqKssBmYdHG4wcnTxQbHlJkfc+jK0drd4CUABnxlXEsP
	 aJWXk4KAOMYNA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 11/14] lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
Date: Mon, 26 Jan 2026 14:55:32 -0500
Message-ID: <20260126195535.154697-12-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126195535.154697-1-cel@kernel.org>
References: <20260126195535.154697-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18504-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,swb.de:email]
X-Rspamd-Queue-Id: 0C75C8CD1D
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The lockd subsystem unnecessarily exposes internal NLM XDR type
definitions through the global include path. These definitions
are not used by any code outside fs/lockd/, making them
inappropriate for include/linux/lockd/.

Moving xdr.h to fs/lockd/ narrows the API surface and clarifies
that these types are internal implementation details. The
comment in linux/lockd/bind.h stating xdr.h was needed for
"xdr-encoded error codes" is stale: no lockd API consumers use
those codes.

A forward declaration for struct nfs_fh is added to bind.h
because its definition was previously pulled in transitively
through xdr.h. Additionally, nfs3proc.c needs an explicit
include of filelock.h for struct file_lock and FL_CLOSE, which
xdr.h previously provided.

Built and tested with lockd client/server operations. No
functional change.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h                  | 2 +-
 {include/linux => fs}/lockd/xdr.h | 8 +++-----
 fs/nfs/nfs3proc.c                 | 1 +
 include/linux/lockd/bind.h        | 4 +---
 4 files changed, 6 insertions(+), 9 deletions(-)
 rename {include/linux => fs}/lockd/xdr.h (96%)

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 460ccb701749..6f83b9a7257f 100644
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
index 292e4e38d17d..af821ecf2a4e 100644
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
@@ -110,4 +108,4 @@ bool	nlmsvc_encode_res(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_encode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlmsvc_encode_shareres(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 
-#endif /* LOCKD_XDR_H */
+#endif /* _LOCKD_XDR_H */
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1181f9cc6dbd..c54808db0260 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -16,6 +16,7 @@
 #include <linux/nfs3.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_page.h>
+#include <linux/filelock.h>
 #include <linux/lockd/bind.h>
 #include <linux/nfs_mount.h>
 #include <linux/freezer.h>
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index 077da0696f12..38d69fe8dfd5 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -11,10 +11,8 @@
 #define LINUX_LOCKD_BIND_H
 
 #include <linux/lockd/nlm.h>
-/* need xdr-encoded error codes too, so... */
-#include <linux/lockd/xdr.h>
 
-/* Dummy declarations */
+struct nfs_fh;
 struct svc_rqst;
 struct rpc_task;
 struct rpc_clnt;
-- 
2.52.0


