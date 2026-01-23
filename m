Return-Path: <linux-nfs+bounces-18372-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CgiOczDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18372-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1CF79D32
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19E3C303FBDF
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D4829A309;
	Fri, 23 Jan 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJRil/aP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667B248176
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194392; cv=none; b=E7cPwnlgogi7+2aNZiEdKGfx8CGhI/okwA24ZOFFY92VnPZoiv5RG4iA2KYnmpAQW3B9YDM1VVxMWuxNqPAJ4QnfAkdBSJdkZ4WDvC1PmU5IGTO4UmFZWXdWY6m2cHgtpav9EgFMwcwKs/WFbkOU3QV/82Iwusf+CIxCmbJBKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194392; c=relaxed/simple;
	bh=c+rl4xyUo9eQKENDc08c2U/PLQ7KQxbOHljhrqH5G10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaeYOTAS+n/gOAWXpMch3YjV1EPkS/W0JcIXf/kgddphCo9Q+BnM2hBpIbzmbFYMLYRguZ26sueHR7MpCgsPrn2AhdNSUQKjbHC+Zga/aAkF3rZa2WOit0INMByEFwKmzlV2Emck5xjpjeYdxfTizXMY7KidyNR9DEBBIgnd5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJRil/aP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530FBC19424;
	Fri, 23 Jan 2026 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194391;
	bh=c+rl4xyUo9eQKENDc08c2U/PLQ7KQxbOHljhrqH5G10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJRil/aPhMe79Nt2LlI/7EgdI5LOLJ0KWx4OF0TUbg8rvsrPpoCQ7lEnAF8LbPnHa
	 IbHq+Ju8XU5ozIEG9UTjPaQjl71Oau78gLFVakIKTAuaCo5TfJvyI09A5H8jKcHBvA
	 ZgO0Ju10uYlKTOu/eVH8E9YVd59X6yOfmpWSfjwec58e4fg9GeSUUW5tyPxmnAS20Y
	 r+D+OKx5ZrTkxOHoATVgVAnxY9y4RraywUq2Vupc7XZf3JvtDns5Dkz+/zxrswdOBd
	 mHK49eYRm97Cr6I79UkVGpA1QNziPyzJzoC72FFz4ULEKuvBjJWYeFTjSuUj4Uf0Ri
	 4CbG6zY9VVPQw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 11/42] lockd: Make linux/lockd/nlm.h an internal header
Date: Fri, 23 Jan 2026 13:52:28 -0500
Message-ID: <20260123185259.1215767-12-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18372-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,swb.de:email]
X-Rspamd-Queue-Id: 7B1CF79D32
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The NLM protocol constants and status codes in nlm.h are needed
only by lockd's internal implementation. NFS client code and
NFSD interact with lockd through the stable API in bind.h and
have no direct use for protocol-level definitions.

Exposing these definitions globally via bind.h creates unnecessary
coupling between lockd internals and its consumers. Moving nlm.h
from include/linux/lockd/ to fs/lockd/ clarifies the API boundary:
bind.h provides the lockd service interface, while nlm.h remains
available only to code within fs/lockd/ that implements the
protocol.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/lockd.h                  | 1 +
 {include/linux => fs}/lockd/nlm.h | 8 +++-----
 fs/lockd/svclock.c                | 1 -
 include/linux/lockd/bind.h        | 2 --
 4 files changed, 4 insertions(+), 8 deletions(-)
 rename {include/linux => fs}/lockd/nlm.h (91%)

diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 892c54198f1e..3f44820974cd 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -14,6 +14,7 @@
 #include <linux/kref.h>
 #include <linux/refcount.h>
 #include <linux/utsname.h>
+#include "nlm.h"
 #include <linux/lockd/bind.h>
 #include "xdr.h"
 #include <linux/sunrpc/debug.h>
diff --git a/include/linux/lockd/nlm.h b/fs/lockd/nlm.h
similarity index 91%
rename from include/linux/lockd/nlm.h
rename to fs/lockd/nlm.h
index 6e343ef760dc..47be65d0111f 100644
--- a/include/linux/lockd/nlm.h
+++ b/fs/lockd/nlm.h
@@ -1,14 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * linux/include/linux/lockd/nlm.h
- *
  * Declarations for the Network Lock Manager protocol.
  *
  * Copyright (C) 1996, Olaf Kirch <okir@monad.swb.de>
  */
 
-#ifndef LINUX_LOCKD_NLM_H
-#define LINUX_LOCKD_NLM_H
+#ifndef _LOCKD_NLM_H
+#define _LOCKD_NLM_H
 
 
 /* Maximum file offset in file_lock.fl_end */
@@ -55,4 +53,4 @@ enum {
 #define NLMPROC_NM_LOCK		22
 #define NLMPROC_FREE_ALL	23
 
-#endif /* LINUX_LOCKD_NLM_H */
+#endif /* _LOCKD_NLM_H */
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index cd9e11781494..6b3be2ff9c1c 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -28,7 +28,6 @@
 #include <linux/sched.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc_xprt.h>
-#include <linux/lockd/nlm.h>
 
 #include "lockd.h"
 
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index a65472139ff8..e6f1a4cdb685 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -10,8 +10,6 @@
 #ifndef LINUX_LOCKD_BIND_H
 #define LINUX_LOCKD_BIND_H
 
-#include <linux/lockd/nlm.h>
-
 /* Dummy declarations */
 struct nfs_fh;
 struct svc_rqst;
-- 
2.52.0


