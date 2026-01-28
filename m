Return-Path: <linux-nfs+bounces-18577-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK3yAFMpeml/3gEAu9opvQ
	(envelope-from <linux-nfs+bounces-18577-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:20:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE7FA3AEA
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C4653011065
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9867D36826C;
	Wed, 28 Jan 2026 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doHdtuno"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86A36BCE1
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613586; cv=none; b=nYQ2IaHePlDda4cNqSbHUffrQpQYJ0xSqb5aY0cXlz6TsSmSbTuTVwY/v/YRMh+xHvhjScQzo9D8ZQVNiA/KfQO0sMAxEdHwEKtTLUBeqpGaslfRDt46VxsMylgOg7bwq7yElykkyQWKqC3doDynaRF11izEY+15nW5+o+Me1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613586; c=relaxed/simple;
	bh=gph+6b66sTVSmemFJK24WF+pvbBjxYprBjbCRHE0ZYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uw7l45x/fOVc3Mek1cR6RTB4MN5fVIqHlDjOQLY555huC0iq2YI2S2PJAcY/Td2MYKLXBmM0ry1koDRhNtO49j118A8eJFGzVwCP0lB9f4Z6Cfjdx1jDLiohozAW0Ww6JbMEnJPkHXRE4zZ8ZoAJbbScejARgEJ5JBMRrkwB6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doHdtuno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF092C4CEF1;
	Wed, 28 Jan 2026 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613586;
	bh=gph+6b66sTVSmemFJK24WF+pvbBjxYprBjbCRHE0ZYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doHdtunoYWM12G5gEkbZW/yl136CTICaYqkRrDQJ40NwiJ+zGeunTO0iHRCbcT0Ja
	 8TIy6V6tpiOPAt3yvnTUOk79O6yigcV7m6/1GxI0x1vxIn8iC/i1UndeJaINQfyg2z
	 oiBoYcw48CMF4l8wX2F2SyMShbEdBY4tyR+SkVauuvf9DuygKtPmZg9l0LXo5oMKai
	 dx1fhkSw4B88wpQb2YUhzd+bpkueKU2DzTlhhU97/2S4R6M+vqbpkd72FwACwYTZKY
	 +k1ui8qcP112xtj1YR0k/NNYyKSANRYTqsBnAVIIWSUTx4x6mze4b6DnM83/fhzQIy
	 c9KpzP2FQ6ggQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 11/14] lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
Date: Wed, 28 Jan 2026 10:19:32 -0500
Message-ID: <20260128151935.1646063-12-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128151935.1646063-1-cel@kernel.org>
References: <20260128151935.1646063-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18577-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RSPAMD_EMAILBL_FAIL(0.00)[jlayton.kernel.org:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,swb.de:email,oracle.com:email]
X-Rspamd-Queue-Id: 4FE7FA3AEA
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

Forward declarations for struct nfs_fh and struct file_lock are
added to bind.h because their definitions were previously pulled
in transitively through xdr.h. Additionally, nfs3proc.c needs an
explicit include of filelock.h for FL_CLOSE.

Built and tested with lockd client/server operations. No
functional change.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h                  | 2 +-
 {include/linux => fs}/lockd/xdr.h | 8 +++-----
 fs/nfs/nfs3proc.c                 | 1 +
 include/linux/lockd/bind.h        | 5 ++---
 4 files changed, 7 insertions(+), 9 deletions(-)
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
index 077da0696f12..ba9258c96bfd 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -11,10 +11,9 @@
 #define LINUX_LOCKD_BIND_H
 
 #include <linux/lockd/nlm.h>
-/* need xdr-encoded error codes too, so... */
-#include <linux/lockd/xdr.h>
 
-/* Dummy declarations */
+struct file_lock;
+struct nfs_fh;
 struct svc_rqst;
 struct rpc_task;
 struct rpc_clnt;
-- 
2.52.0


