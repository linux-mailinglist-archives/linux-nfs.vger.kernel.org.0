Return-Path: <linux-nfs+bounces-23261-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0IpvHZDrU2rYgAMAu9opvQ
	(envelope-from <linux-nfs+bounces-23261-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:31:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E5A745C27
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 21:31:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C1iryNVc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23261-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23261-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4417300D152
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 19:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5D3A0EA5;
	Sun, 12 Jul 2026 19:31:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C92475CB
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jul 2026 19:31:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884686; cv=none; b=VLg32JGtm8c4ADL1MypY52k/lHSQ51lks8g0LhGwfXD6xs0YkoIuKuao8cZy7e6WiZwOGCg4zWKf5t9NLxE/XLRShy4+wRHyQ+8I6b0gQCk6+9bWpm2EINamh35wTEHOxP9pWbEgNnlXqsB1PvHTTvuhY3NTFyqww0syZuOLb98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884686; c=relaxed/simple;
	bh=ClzZPYl+7QeZ5QwMGOtee9ihhC1U7UrGGa8wpaB48sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNotZTgQluP7BVVUmUeCTXRZNot2VXToxI7V89PV3piZcQgLN1FaLD1gi7Ae9akkGmNNgG9uo4w4Kx2erSfCMsVdF1Am0IP6cIAb36EO+p2TeT2EWluqJV0qtg3Vg6cVylrY79f/viD42rdQliVG6p47cbkLXlhmEfu/xRSLbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1iryNVc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836011F00A3D;
	Sun, 12 Jul 2026 19:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783884685;
	bh=R7sqz+3EBDwJY7bvRIzCnqlBCeYbIAcwo4AORL026VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C1iryNVcxFPIKoqq2hWvDXMDlz4iDsju+bkSFaU9o3m9KsmGMfDDjxXuCBc3zNClZ
	 BH/J+ko8sWNsgpu7dzHAd9e7RNSLaJb1mBsKBVswOAfxTZHCfBwAQCRE5mx31nVOeY
	 eNK5oS+KLp4UXWNkbGv+vZ144BHlIaFIp6q/Nhbx6tT/rUPtTss7yYn9RrbEJ4HDw8
	 IPfBvn6VkIMWkr+TPishodhO/Ey80iwCmhgU+QqmCFD6JQVDWEq8H5TdDSOhJqqCGz
	 BrU3fn2mKyfQ43OARtD7eKkaF4qhWZ7nsEhxUe1MOGV6WmYfcYNUvLtbvsXnSDcqrd
	 pRVrInk7ZsoKA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/5] xdrgen: Emit a blank line ahead of enum declarations
Date: Sun, 12 Jul 2026 15:31:18 -0400
Message-ID: <20260712193122.116845-2-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712193122.116845-1-cel@kernel.org>
References: <20260712193122.116845-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23261-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1E5A745C27

Clean up.

The declaration templates for structs, pointers, and typedefs each
begin with a blank line, which keeps successive declarations and the
include block above them visually separated. The enum declaration
template omits that blank line. trim_blocks collapses the template's
lone comment line to nothing, so the omission stayed invisible as
long as every generated header happened to lead with a non-enum
declaration.

Fixes: 4329010ad9c3 ("xdrgen: Address some checkpatch whitespace complaints")
Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/lockd/nlm3xdr_gen.c                                       | 2 +-
 fs/lockd/nlm3xdr_gen.h                                       | 2 +-
 fs/lockd/nlm4xdr_gen.c                                       | 2 +-
 fs/lockd/nlm4xdr_gen.h                                       | 2 +-
 fs/nfsd/nfs4xdr_gen.c                                        | 2 +-
 fs/nfsd/nfs4xdr_gen.h                                        | 5 ++++-
 include/linux/sunrpc/xdrgen/nfs4_1.h                         | 2 +-
 include/linux/sunrpc/xdrgen/nlm3.h                           | 2 +-
 include/linux/sunrpc/xdrgen/nlm4.h                           | 2 +-
 tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2 | 1 +
 10 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/nlm3xdr_gen.c b/fs/lockd/nlm3xdr_gen.c
index 352a694ca0f5..df14692ce37f 100644
--- a/fs/lockd/nlm3xdr_gen.c
+++ b/fs/lockd/nlm3xdr_gen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x
-// XDR specification modification time: Mon Jun 29 20:39:34 2026
+// XDR specification modification time: Mon Jun 29 20:42:29 2026
 
 #include <linux/sunrpc/svc.h>
 
diff --git a/fs/lockd/nlm3xdr_gen.h b/fs/lockd/nlm3xdr_gen.h
index d24cbb887b7f..3824ffe2aae4 100644
--- a/fs/lockd/nlm3xdr_gen.h
+++ b/fs/lockd/nlm3xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x */
-/* XDR specification modification time: Mon Jun 29 20:39:34 2026 */
+/* XDR specification modification time: Mon Jun 29 20:42:29 2026 */
 
 #ifndef _LINUX_XDRGEN_NLM3_DECL_H
 #define _LINUX_XDRGEN_NLM3_DECL_H
diff --git a/fs/lockd/nlm4xdr_gen.c b/fs/lockd/nlm4xdr_gen.c
index 004ea01c689e..5a60aff06714 100644
--- a/fs/lockd/nlm4xdr_gen.c
+++ b/fs/lockd/nlm4xdr_gen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x
-// XDR specification modification time: Mon Jun 29 20:39:36 2026
+// XDR specification modification time: Mon Jun 29 20:42:29 2026
 
 #include <linux/sunrpc/svc.h>
 
diff --git a/fs/lockd/nlm4xdr_gen.h b/fs/lockd/nlm4xdr_gen.h
index b5898f0e0689..ce9dda0a052a 100644
--- a/fs/lockd/nlm4xdr_gen.h
+++ b/fs/lockd/nlm4xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x */
-/* XDR specification modification time: Mon Jun 29 20:39:36 2026 */
+/* XDR specification modification time: Mon Jun 29 20:42:29 2026 */
 
 #ifndef _LINUX_XDRGEN_NLM4_DECL_H
 #define _LINUX_XDRGEN_NLM4_DECL_H
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index e5a6ea4a9349..d77835033a8c 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x
-// XDR specification modification time: Tue Jun 30 11:56:05 2026
+// XDR specification modification time: Tue Jun 30 11:57:21 2026
 
 #include <linux/sunrpc/svc.h>
 
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index 4092379a9efa..21ca82078615 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Tue Jun 30 11:56:05 2026 */
+/* XDR specification modification time: Tue Jun 30 11:57:21 2026 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DECL_H
 #define _LINUX_XDRGEN_NFS4_1_DECL_H
@@ -21,10 +21,13 @@ bool xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4
 
 bool xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr);
 bool xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify *value);
+
 bool xdrgen_decode_aclmodel4(struct xdr_stream *xdr, aclmodel4 *ptr);
 bool xdrgen_encode_aclmodel4(struct xdr_stream *xdr, aclmodel4 value);
+
 bool xdrgen_decode_aclscope4(struct xdr_stream *xdr, aclscope4 *ptr);
 bool xdrgen_encode_aclscope4(struct xdr_stream *xdr, aclscope4 value);
+
 bool xdrgen_decode_posixacetag4(struct xdr_stream *xdr, posixacetag4 *ptr);
 bool xdrgen_encode_posixacetag4(struct xdr_stream *xdr, posixacetag4 value);
 
diff --git a/include/linux/sunrpc/xdrgen/nfs4_1.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
index 6ff4d727b0d2..bd3289a1d66a 100644
--- a/include/linux/sunrpc/xdrgen/nfs4_1.h
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Tue Jun 30 11:56:05 2026 */
+/* XDR specification modification time: Tue Jun 30 11:57:21 2026 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DEF_H
 #define _LINUX_XDRGEN_NFS4_1_DEF_H
diff --git a/include/linux/sunrpc/xdrgen/nlm3.h b/include/linux/sunrpc/xdrgen/nlm3.h
index 3cc69a09c1c7..0fc627031d8a 100644
--- a/include/linux/sunrpc/xdrgen/nlm3.h
+++ b/include/linux/sunrpc/xdrgen/nlm3.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x */
-/* XDR specification modification time: Mon Jun 29 20:39:34 2026 */
+/* XDR specification modification time: Mon Jun 29 20:42:29 2026 */
 
 #ifndef _LINUX_XDRGEN_NLM3_DEF_H
 #define _LINUX_XDRGEN_NLM3_DEF_H
diff --git a/include/linux/sunrpc/xdrgen/nlm4.h b/include/linux/sunrpc/xdrgen/nlm4.h
index 7b6f10ea2838..77860a3d1c1e 100644
--- a/include/linux/sunrpc/xdrgen/nlm4.h
+++ b/include/linux/sunrpc/xdrgen/nlm4.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x */
-/* XDR specification modification time: Mon Jun 29 20:39:36 2026 */
+/* XDR specification modification time: Mon Jun 29 20:42:29 2026 */
 
 #ifndef _LINUX_XDRGEN_NLM4_DEF_H
 #define _LINUX_XDRGEN_NLM4_DEF_H
diff --git a/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2 b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
index c7ae506076bb..d1405c7c5354 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/enum/declaration/enum.j2
@@ -1,3 +1,4 @@
 {# SPDX-License-Identifier: GPL-2.0 #}
+
 bool xdrgen_decode_{{ name }}(struct xdr_stream *xdr, {{ name }} *ptr);
 bool xdrgen_encode_{{ name }}(struct xdr_stream *xdr, {{ name }} value);
-- 
2.54.0


