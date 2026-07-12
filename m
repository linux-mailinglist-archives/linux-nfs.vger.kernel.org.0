Return-Path: <linux-nfs+bounces-23278-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uyq7NiD9U2qNggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23278-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A5745E0A
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="J7/ZzOG8";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23278-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23278-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E085300D33E
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0666352C28;
	Sun, 12 Jul 2026 20:46:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28523B42F8
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:46:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783889161; cv=none; b=jW/YyHWJQPpJtU2/jogNezJTWC/qGuwmpavMzjYGwYZ/Lk5hTcaCFetEcWJgT1m1uZB+uJzNYny67Lq1ELjwKIv91q3BZftbXpRtkcL9D+lT6B5yDc6vEoqVbtTXdpXoS8R/NYKDvZZfys8k5IDPIoPGPLi/TxyxeiB9nENs1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783889161; c=relaxed/simple;
	bh=mE3588FAf7Wt7yJRk38a8mcUiwf8oNXvSRW7mBPSUXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMqNoBNkA2LGzEpItHSnQLgjPcraxgZl4cpmmprTvnUMjnwBaddnUkzNxu8Wp8Uky+6BKE1UeoBnUGayH/k1Aa1o6a4GEPrCUVfAANOtsSXGdnAxrDCctB8UZGi+Nz20NkmRT+AW40mz1JKjMOFX6oxXXX4XZdUF7XO9Ew5qMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7/ZzOG8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAF71F00A3A;
	Sun, 12 Jul 2026 20:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783889160;
	bh=8onOtOYMMLr/gwuFAp5Nh+7qO/59+tPzfQTG7Fb1e/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J7/ZzOG8K8htFKO9/VZqjPkWhAhCJqBc5sokZfCRgCbZ2SotUnmoWGh3l257LS2oy
	 12pKLwbzY8t6RRtumuLOkpxtx0Zmyb5NMKpIv1IVpkX5ZCHLreFC2tG1c51WbAulnb
	 4iD2YVSWr/9eBGUxlEi9SWy2g080giVQteHUA9zUlTc1aRzcnXZFBBVdN4tuczwKm7
	 OnQ3qPEG2cmeZ4vA+2CO4CPP2ZUit+ZJkATcPR/t9+iUgA0mqjjWzfDviLIIVb/z7t
	 iMZcL9JFvP42lxsHCx5dd5xosPm7m1DIW9kfyhlaVvvxhOzPFx+gLsgtFS3HKZdo1e
	 Qj8LyuJ+rYabw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 6/9] NFSD: Move struct readdir_cd
Date: Sun, 12 Jul 2026 16:45:51 -0400
Message-ID: <20260712204554.125308-7-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712204554.125308-1-cel@kernel.org>
References: <20260712204554.125308-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23278-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F9A5745E0A

struct readdir_cd is part of the VFS readdir API, but it lives in
nfsd.h, the subsystem's catch-all header, rather than alongside that
API. That forces vfs.h to include nfsd.h solely to declare readdir_cd
for its nfsd_readdir() prototype, a layering inversion since vfs.h is
the lower-level shim.

Relocate readdir_cd to vfs.h, just below the nfsd_filldir_t callback
typedef. vfs.h then defines the struct itself and no longer includes
nfsd.h. The xdr headers that embed readdir_cd by value include vfs.h
to obtain the definition. This prepares the ground for dropping nfsd.h
from more files.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfsd.h | 4 ----
 fs/nfsd/vfs.h  | 5 ++++-
 fs/nfsd/xdr.h  | 1 +
 fs/nfsd/xdr3.h | 1 +
 fs/nfsd/xdr4.h | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index b35e9a9a112d..0503ee0e1bbe 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -47,10 +47,6 @@ enum {
 	NFSSVC_MAXBLKSIZE       = RPCSVC_MAXPAYLOAD,
 };
 
-struct readdir_cd {
-	__be32			err;	/* 0, nfserr, or nfserr_eof */
-};
-
 /* Maximum number of operations per session compound */
 #define NFSD_MAX_OPS_PER_COMPOUND	200
 
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index e09ea04a51b9..4af2ff9e9dfe 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -9,7 +9,6 @@
 #include <linux/fs.h>
 #include <linux/posix_acl.h>
 #include "nfsfh.h"
-#include "nfsd.h"
 
 /*
  * Flags for nfsd_permission
@@ -45,6 +44,10 @@ struct nfsd_file;
  */
 typedef int (*nfsd_filldir_t)(void *, const char *, int, loff_t, u64, unsigned);
 
+struct readdir_cd {
+	__be32			err;	/* nfs_ok, nfserr, or nfserr_eof */
+};
+
 /* nfsd/vfs.c */
 struct nfsd_attrs {
 	struct iattr		*na_iattr;	/* input */
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 852f71580bd0..df540c940cef 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -7,6 +7,7 @@
 #include <linux/vfs.h>
 #include "nfsd.h"
 #include "nfsfh.h"
+#include "vfs.h"
 
 struct nfsd_fhandle {
 	struct svc_fh		fh;
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index a7c9714b0b0e..344203874b4c 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -9,6 +9,7 @@
 #define _LINUX_NFSD_XDR3_H
 
 #include "xdr.h"
+#include "vfs.h"
 
 struct nfsd3_sattrargs {
 	struct svc_fh		fh;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 805c7122eb93..0ec0f43b1a87 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -38,7 +38,7 @@
 #define _LINUX_NFSD_XDR4_H
 
 #include "state.h"
-#include "nfsd.h"
+#include "vfs.h"
 
 #define NFSD4_MAX_TAGLEN	128
 #define XDR_LEN(n)                     (((n) + 3) & ~3)
-- 
2.54.0


