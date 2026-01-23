Return-Path: <linux-nfs+bounces-18371-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODDkNcTDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18371-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D379D07
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BAD9300D558
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFD128853A;
	Fri, 23 Jan 2026 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbSHi9Sf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983B248176
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194391; cv=none; b=Ett/CqUHKoVakVyxGWRDupyUcHcVPcMaSL56eZSlO5/wnyFZA/GwoNW+IjMy2RIerCA5FeS08fXBQd1/YD0+OGzpvHW33mHRrUOEVbO29xVLvZ1OScH5SJm1oXg4xDofajX3XsIJ/lIgx45hHtYx0drRgN+AhJbEeHXrXvnhXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194391; c=relaxed/simple;
	bh=iaUUas58QTVRX0yv/9xcy7xGhCmszMpeHOue9EtSLRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQOoOPLE/ibbTxXilYvrvfzk2E4+5KkaN/ojuDXoHp8kDHrKYZJ3KsEmMOF7rIs3RPWUFgjXGPAHSLpBDUOX2YYzH5+SEsZ0zTAPWzAPotNECFo75YDo0O3rrLej5J/vYMqd1YQFgSSBipVv7H7/Nz9Q6eEuFQoVmiYTw0M8+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbSHi9Sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C13C4CEF1;
	Fri, 23 Jan 2026 18:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194391;
	bh=iaUUas58QTVRX0yv/9xcy7xGhCmszMpeHOue9EtSLRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbSHi9SfX9cXDitf++0D+m/6jtP8NHdGmlvi1CaO+CSBaatgHIhFCKe7eQjT5pvp7
	 Nvl6Pu4uWUHTCGnOj//az/gs1Xw3AwHT2d+Y+NXrlO0eY47tA2pqMOCyXYyjaFYFpm
	 hEPAZ5PjTV1sX87xGQdSbWkv+T0uqBIFt5c1WxcJCS43OIxM8ZiuZAx2Vvm/OsM7RF
	 +wa3x1H2yrdabjdjKtHfflIL2FFQ2EYE6dR1iOIZcQ/I2rYL99E5RdP02W+a42+ic1
	 WYVJOVWTkrrLJpPrngRf+A+uNL5GbUtPRzV0oJtl0YWvRtsvd6c/2h4PJkR1bUOezo
	 ZUCkS16sGuASw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 10/42] lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
Date: Fri, 23 Jan 2026 13:52:27 -0500
Message-ID: <20260123185259.1215767-11-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18371-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[swb.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 2E2D379D07
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The lockd subsystem unnecessarily exposes internal NLM XDR type
definitions through the global include path. These definitions are
not used by any code outside fs/lockd/, making them inappropriate
for include/linux/lockd/.

Moving xdr.h to fs/lockd/ narrows the API surface and clarifies
that these types are internal implementation details. The comment
in linux/lockd/bind.h stating xdr.h was needed for "xdr-encoded
error codes" is stale: no lockd API consumers use those codes. A
forward declaration for struct nfs_fh is needed because its
definition was previously pulled in transitively through xdr.h.

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
index 3ddbf8772b59..892c54198f1e 100644
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
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index a7f765e397a0..a65472139ff8 100644
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


