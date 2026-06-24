Return-Path: <linux-nfs+bounces-22813-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mWluAeYtPGoslAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22813-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 21:20:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF056C0FE9
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 21:20:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ir8HANea;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22813-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22813-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21967300EF91
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D91320CD9;
	Wed, 24 Jun 2026 19:17:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E948632E72F
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 19:17:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328630; cv=none; b=j1gvwd4BHm+RGjfYpO1Uy9HvnUMpoSS02P2a4arQGrmI6lHvS8IBZFYDnmB6V9adSUp6ppBIZpdTCelpxo2QKNJPmGSym2ZSoM0ukoPFSfw/Sm+nw/On3STraYao7jVFfTj9J7XM59Ky4nRTI9uNdkD2zAxiuoUstkzo+tpQgNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328630; c=relaxed/simple;
	bh=Z7GD5Ogq4/xmXtmEZgK5YVWkjiKVGujhba90By0TgPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wyh2Wa0daurZJN0TbH9Vs6uJbq09pwWzTdGMl9+xldiPUBMqWl3TFULyY+JZBy7mnYHveyqIZaP5A7Y1fIDcEiK7WcZw3gSE7/jTilO6fUczT6XpwUJlyNsHzB8GypoCcHBjpA16B88Yp++AI+JeV4pZQEOoIQmZ0F2ofwSo4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir8HANea; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718811F00A3A;
	Wed, 24 Jun 2026 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782328628;
	bh=v00UL0PgeF8VMWSPq8GPouAC2dJPUgo4Ebh9/cWk2D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ir8HANea4PumKgnPgYxDxKo8Wf4JcSTLOeqlxzqaH+I+94qfbp8gTVZJ5hm0QpLXg
	 kYIKRpO8D3us1tLgKcxr1iIG8sikkjF36iTK0FG7UWQqS+6KV5Vzgi8K2LeHN/iHwF
	 bVtvhfjdERNomIZhH7dmsq0l7QUQP/8BIymcxLaZ3Y9vq9NFAYF7i6fCwiBZMOvBM+
	 B7gHxFEdDMtwWKGC7viBqozwMwzGMOsqhl9tlp5XI04H2cfH23jdbZ/rGznNxA30Pe
	 jwoOs5B1QYDEHp4zcpAgMnhfVtRIPer5AO2HkR8TcSyoaHCbIWoMmCYl9tZ+4NwHbe
	 MuSGq+1AwRKyw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@hammerspace.com>,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] nfs4.2: add nfs4_2.x to generate the UNCACHEABLE_FILE_DATA attribute
Date: Wed, 24 Jun 2026 15:17:03 -0400
Message-ID: <20260624191706.72544-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260624191706.72544-1-snitzer@kernel.org>
References: <20260624191706.72544-1-snitzer@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22813-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:loghyr@hammerspace.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AF056C0FE9

Introduce Documentation/sunrpc/xdr/nfs4_2.x for NFSv4.2 protocol
extensions and define the UNCACHEABLE_FILE_DATA attribute (attr 87)
there, verbatim from draft-ietf-nfsv4-uncacheable-files Section 7:

  typedef bool            fattr4_uncacheable_file_data;
  const FATTR4_UNCACHEABLE_FILE_DATA      = 87;

This mirrors how the sibling NFSv4.2 attributes (FATTR4_OFFLINE=83,
FATTR4_TIME_DELEG_*=84/85, FATTR4_OPEN_ARGUMENTS=86) are defined in
Documentation/sunrpc/xdr/nfs4_1.x and generated by
tools/net/sunrpc/xdrgen into <linux/sunrpc/xdrgen/nfs4_1.h>, which
nfs4.h already includes.

Wire the fs/nfsd "make xdrgen" target to generate the definitions header
<linux/sunrpc/xdrgen/nfs4_2.h> and include it from <linux/nfs4.h>, so the
generated FATTR4_UNCACHEABLE_FILE_DATA constant and the
NFS4_fattr4_uncacheable_file_data_sz size macro are available to the
NFSv4.2 client support that follows.

No functional change.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 Documentation/sunrpc/xdr/nfs4_2.x    | 52 ++++++++++++++++++++++++++++
 fs/nfsd/Makefile                     |  5 ++-
 include/linux/nfs4.h                 |  1 +
 include/linux/sunrpc/xdrgen/nfs4_2.h | 19 ++++++++++
 4 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/sunrpc/xdr/nfs4_2.x
 create mode 100644 include/linux/sunrpc/xdrgen/nfs4_2.h

diff --git a/Documentation/sunrpc/xdr/nfs4_2.x b/Documentation/sunrpc/xdr/nfs4_2.x
new file mode 100644
index 000000000000..d10a91d657b0
--- /dev/null
+++ b/Documentation/sunrpc/xdr/nfs4_2.x
@@ -0,0 +1,52 @@
+/*
+ * Copyright (c) 2026 IETF Trust and the persons identified
+ * as the document authors.  All rights reserved.
+ *
+ * The document authors are identified in RFC 7862 and
+ * draft-ietf-nfsv4-uncacheable-files.
+ *
+ * Redistribution and use in source and binary forms, with
+ * or without modification, are permitted provided that the
+ * following conditions are met:
+ *
+ * - Redistributions of source code must retain the above
+ *   copyright notice, this list of conditions and the
+ *   following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the
+ *   following disclaimer in the documentation and/or other
+ *   materials provided with the distribution.
+ *
+ * - Neither the name of Internet Society, IETF or IETF
+ *   Trust, nor the names of specific contributors, may be
+ *   used to endorse or promote products derived from this
+ *   software without specific prior written permission.
+ *
+ *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS
+ *   AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
+ *   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ *   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ *   FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
+ *   EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ *   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
+ *   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *   NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ *   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ *   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ *   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ *   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ *   IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ *   ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+pragma header nfs4;
+
+/*
+ * The following content was extracted from
+ * draft-ietf-nfsv4-uncacheable-files
+ */
+
+typedef bool            fattr4_uncacheable_file_data;
+
+const FATTR4_UNCACHEABLE_FILE_DATA      = 87;
diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index f0da4d69dc74..0ff198e102a3 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -37,11 +37,14 @@ nfsd-$(CONFIG_DEBUG_FS) += debugfs.o
 #
 .PHONY: xdrgen
 
-xdrgen: ../../include/linux/sunrpc/xdrgen/nfs4_1.h nfs4xdr_gen.h nfs4xdr_gen.c
+xdrgen: ../../include/linux/sunrpc/xdrgen/nfs4_1.h ../../include/linux/sunrpc/xdrgen/nfs4_2.h nfs4xdr_gen.h nfs4xdr_gen.c
 
 ../../include/linux/sunrpc/xdrgen/nfs4_1.h: ../../Documentation/sunrpc/xdr/nfs4_1.x
 	../../tools/net/sunrpc/xdrgen/xdrgen definitions $< > $@
 
+../../include/linux/sunrpc/xdrgen/nfs4_2.h: ../../Documentation/sunrpc/xdr/nfs4_2.x
+	../../tools/net/sunrpc/xdrgen/xdrgen definitions $< > $@
+
 nfs4xdr_gen.h: ../../Documentation/sunrpc/xdr/nfs4_1.x
 	../../tools/net/sunrpc/xdrgen/xdrgen declarations $< > $@
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 44e5e9fa12e1..34aa303354bc 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -18,6 +18,7 @@
 #include <uapi/linux/nfs4.h>
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/xdrgen/nfs4_1.h>
+#include <linux/sunrpc/xdrgen/nfs4_2.h>
 
 enum nfs4_acl_whotype {
 	NFS4_ACL_WHO_NAMED = 0,
diff --git a/include/linux/sunrpc/xdrgen/nfs4_2.h b/include/linux/sunrpc/xdrgen/nfs4_2.h
new file mode 100644
index 000000000000..9441f6cefbff
--- /dev/null
+++ b/include/linux/sunrpc/xdrgen/nfs4_2.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Generated by xdrgen. Manual edits will be lost. */
+/* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_2.x */
+/* XDR specification modification time: Fri Jun 12 10:44:36 2026 */
+
+#ifndef _LINUX_XDRGEN_NFS4_2_DEF_H
+#define _LINUX_XDRGEN_NFS4_2_DEF_H
+
+#include <linux/types.h>
+#include <linux/sunrpc/xdrgen/_defs.h>
+
+typedef bool fattr4_uncacheable_file_data;
+
+enum { FATTR4_UNCACHEABLE_FILE_DATA = 87 };
+
+#define NFS4_fattr4_uncacheable_file_data_sz \
+	(XDR_bool)
+
+#endif /* _LINUX_XDRGEN_NFS4_2_DEF_H */
-- 
2.47.3


