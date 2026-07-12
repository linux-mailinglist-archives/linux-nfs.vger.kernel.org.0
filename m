Return-Path: <linux-nfs+bounces-23276-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7n8nBBj9U2qJggMAu9opvQ
	(envelope-from <linux-nfs+bounces-23276-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CFB745E07
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 22:46:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="i3Od8WN/";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23276-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23276-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D22D73011BC5
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 20:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4E5369981;
	Sun, 12 Jul 2026 20:46:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF233B2D14
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 20:45:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783889160; cv=none; b=aroa8I5vdGOQ7rTgYTGqK61IeGL9xmgvyuXVhk0KbH7cXWbGBV+4alXX5dDObnrOervcYGv78WhL5Thw8YzFEDKEsLlO7vBMe93vc0ccsov3ZoFq1wh8Tl+V8XBRGMza6V6lwLrbfJdKpK3dAbvz0wMAt/m+bgb/lz8lQT+o4xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783889160; c=relaxed/simple;
	bh=xirf/NacVe+RWNPRGKcbpugNVxqG38QdCOYf0uOmDvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fostcTBldOUgRcWLOhUz+wgrO2bryouG7dKeLc69ObT6yMyMTKeW8B2kH5+X/I97E2gEsHPJARe86+7VZIhmFOd4PZUDQqum5TOIYan7/jarbpBiXsKYUPDPCDeC1I3geZQUW1vw5PF7CtC3+CAy1SMTm2yXoSHDYPyPdzzlzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3Od8WN/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5D21F000E9;
	Sun, 12 Jul 2026 20:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783889158;
	bh=t5g/dnG/VpqHQuwRkwWWaRwXgqDdtLbqwrZJKqkYaXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i3Od8WN/DJ6iXlCfZJSrYS3VtrHdp7H3g/Oves4eH/mxIpN/vUa5dgra52MekZAhi
	 +UgQZRnXQLay4A2g7j8pY0xVEcpaKnoxa1QzqoR7smWFiaUQrFECDhpXBZHXINaOBW
	 a6zk5KcK9SKTDd5bWvRNpRUpS2pmmrnEr4qgMQss79mM3iS8RFDBJ4an/Rw4ILkdtS
	 6NXfZEuYLk7rLcYnIFIcJV8t7GnrccHTDlIVfrBKOOdO3y7UNRHKBYsgaINF0bdH3v
	 rs0uw2azGV9nvut8dcYGK1J7ZyVPOX5jV9XYFei25apcz0FqV86dEjH1hsB0wvj2dx
	 KHULFrWufgvWA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 3/9] NFSD: include "netns.h"
Date: Sun, 12 Jul 2026 16:45:48 -0400
Message-ID: <20260712204554.125308-4-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-23276-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,swb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70CFB745E07

Nothing in fs/nfsd/nfsd.h needs the contents of "netns.h"; the
prototypes there that take a struct nfsd_net pointer need only a
forward declaration of that type. Relocate the existing forward
declaration ahead of the first such prototype, drop the "netns.h"
include from nfsd.h, and include it directly in the translation
units that operate on struct nfsd_net.

"netns.h" had also been the path by which <linux/filelock.h>
reached nfsxdr.c and state.h. Both now include <linux/filelock.h>
themselves.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfscache.c | 1 +
 fs/nfsd/nfsctl.c   | 1 +
 fs/nfsd/nfsd.h     | 6 ++----
 fs/nfsd/nfsfh.c    | 1 +
 fs/nfsd/nfsxdr.c   | 2 ++
 fs/nfsd/state.h    | 3 +++
 fs/nfsd/stats.c    | 1 +
 fs/nfsd/trace.h    | 1 +
 fs/nfsd/vfs.c      | 1 +
 9 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index bdf92ec00e7e..07a53a5b3d37 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -19,6 +19,7 @@
 #include <net/checksum.h>
 
 #include "nfsd.h"
+#include "netns.h"
 #include "stats.h"
 #include "cache.h"
 #include "trace.h"
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 4de0a8dc7ebe..7e1d5a5d6511 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -23,6 +23,7 @@
 
 #include "idmap.h"
 #include "nfsd.h"
+#include "netns.h"
 #include "stats.h"
 #include "cache.h"
 #include "state.h"
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 0b225eb3ef3f..4583d7d51a88 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -40,8 +40,6 @@
 #define NFSD_SUPPORTED_MINOR_VERSION	2
 bool nfsd_support_version(int vers);
 
-#include "netns.h"
-
 /*
  * Default and maximum payload size (NFS READ or WRITE), in bytes.
  * The maximum is an implementation limit.
@@ -100,6 +98,8 @@ struct nfsdfs_client {
 	void (*cl_release)(struct kref *kref);
 };
 
+struct nfsd_net;
+
 struct nfsdfs_client *get_nfsdfs_client(struct inode *);
 struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
 				 struct nfsdfs_client *ncl, u32 id,
@@ -125,8 +125,6 @@ extern const struct svc_version nfsd_acl_version3;
 extern const struct svc_version localio_version1;
 #endif
 
-struct nfsd_net;
-
 enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
 int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
 int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c23ae31f60e0..c7c60c35bdfc 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -13,6 +13,7 @@
 #include <linux/sunrpc/svcauth_gss.h>
 #include <crypto/utils.h>
 #include "nfsd.h"
+#include "netns.h"
 #include "stats.h"
 #include "vfs.h"
 #include "auth.h"
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 86c9dd4b334b..019f0cc971a7 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -5,6 +5,8 @@
  * Copyright (C) 1995, 1996 Olaf Kirch <okir@monad.swb.de>
  */
 
+#include <linux/filelock.h>
+
 #include "vfs.h"
 #include "xdr.h"
 #include "auth.h"
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index bc0181ef1cb6..7255d184b41f 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -36,9 +36,12 @@
 #define _NFSD4_STATE_H
 
 #include <crypto/md5.h>
+
+#include <linux/filelock.h>
 #include <linux/idr.h>
 #include <linux/refcount.h>
 #include <linux/sunrpc/svc_xprt.h>
+
 #include "nfsfh.h"
 #include "nfsd.h"
 
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index d7edbda260f0..9a03e097cfe5 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -26,6 +26,7 @@
 #include <net/net_namespace.h>
 
 #include "nfsd.h"
+#include "netns.h"
 #include "stats.h"
 
 static int nfsd_show(struct seq_file *seq, void *v)
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index db0a0dc70660..7d7a1483109a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -19,6 +19,7 @@
 #include "export.h"
 #include "nfsfh.h"
 #include "xdr4.h"
+#include "netns.h"
 
 #define NFSD_TRACE_PROC_CALL_FIELDS(r) \
 		__field(unsigned int, netns_ino) \
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0a1e7bfea3c8..8923a9910a08 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -43,6 +43,7 @@
 #endif /* CONFIG_NFSD_V4 */
 
 #include "nfsd.h"
+#include "netns.h"
 #include "stats.h"
 #include "vfs.h"
 #include "filecache.h"
-- 
2.54.0


