Return-Path: <linux-nfs+bounces-22891-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T82WJFLpQ2rRlQoAu9opvQ
	(envelope-from <linux-nfs+bounces-22891-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 18:05:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E74F26E63E8
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 18:05:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kxM8F5rT;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22891-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22891-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F5F31D8D46
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD50B36CE19;
	Tue, 30 Jun 2026 15:56:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862845BD5C
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 15:56:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835001; cv=none; b=HGbmhEOEhDMqA9bbTlqESZpkr/Bwgp/4yCV5YIY85w1FLc3xjQPurrffL2gHj+pWbWpIbhPo4kUZBaJR6S3qhm950B/u16aZPKfNrJ81/iK2+ofBLG8gH3m3H3ZpD55Am/PSMV+w8DhLV8s//kdrSkis39/BtvlEQ9qXk6l3Dxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835001; c=relaxed/simple;
	bh=FvwE1XAeFSoY05PW+xQBorlRdfxRG61w+KMAe/ujR+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PkWFXpVp6Ft7wMcXodrXr26L5pr5+5pnViqjpO09SGYUiwRQC6mTgVLrmwPcLvQEYAk0yNzPTDOB0Sjq8hDaGNBV+h6onkvTm4Mt94kyEsAV6gSmExLl9il3kOTKlrDn/abKISWfVgfNzHqhPpSmLQED/MMJn4aO4BabuSlZ1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxM8F5rT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445461F000E9;
	Tue, 30 Jun 2026 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782834999;
	bh=oFu26EY+R3ouMlfsaY2deJWVJGL3iQbO/jZPi5GaNQE=;
	h=From:To:Cc:Subject:Date;
	b=kxM8F5rTJx85hKWzA3Mo69Qz5m6Q+fYL0gfVpBz/9k8aGJ8SsSokJ4jj/GF7zJPgA
	 8EugUTGFQ7CBwOF13z8WiPvJc/ElrtZxozlkesxCOcUmaz3hoKyURyG8voYwN3PRWw
	 35+fwOqIBrGUh73fSKz7oykOoD/lEnSRty9CVbn2MhesRKzBJu3B5sRM4zShzRb5ha
	 DrQwVoYKv7N3S67sO3z6a5lr+Q4dIFDrhcFpGChJnAPluF6+LrQQv8aP5vKRug6URg
	 jR5qVZyC0FfzEMuyW/5qRTP+g9CbG810RrjmdmVQFNsLzGE3MWM+dYvWVeQsduOQbz
	 i31LAwtQQD1Kw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>
Subject: [PATCH] lockd: Regenerate NLMv4 XDR code
Date: Tue, 30 Jun 2026 11:56:38 -0400
Message-ID: <20260630155638.874492-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	TAGGED_FROM(0.00)[bounces-22891-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E74F26E63E8

The checked-in NLMv4 xdrgen output predates the addition of enum
value validation to generated decoders. As a result the decoders for
fsh4_mode, fsh4_access, and nlm4_stats still accept any 32-bit value,
while the current generator rejects values outside the enumeration.
Resync the generated files with the in-tree xdrgen by regenerating
from the unchanged nlm4.x specification.

This is a plain regeneration with no specification change; it also
refreshes the recorded specification modification time to show that
all existing enum decoders have picked up the xdrgen tool fix.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/lockd/nlm3xdr_gen.c               |  2 +-
 fs/lockd/nlm3xdr_gen.h               |  2 +-
 fs/lockd/nlm4xdr_gen.c               | 47 ++++++++++++++++++++++++++--
 fs/lockd/nlm4xdr_gen.h               |  2 +-
 fs/nfsd/nfs4xdr_gen.c                |  2 +-
 fs/nfsd/nfs4xdr_gen.h                |  2 +-
 include/linux/sunrpc/xdrgen/nfs4_1.h |  2 +-
 include/linux/sunrpc/xdrgen/nlm3.h   |  2 +-
 include/linux/sunrpc/xdrgen/nlm4.h   |  2 +-
 9 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/nlm3xdr_gen.c b/fs/lockd/nlm3xdr_gen.c
index 9ed5a41b5daf..352a694ca0f5 100644
--- a/fs/lockd/nlm3xdr_gen.c
+++ b/fs/lockd/nlm3xdr_gen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x
-// XDR specification modification time: Thu Apr 23 10:56:34 2026
+// XDR specification modification time: Mon Jun 29 20:39:34 2026
 
 #include <linux/sunrpc/svc.h>
 
diff --git a/fs/lockd/nlm3xdr_gen.h b/fs/lockd/nlm3xdr_gen.h
index c99038e99805..d24cbb887b7f 100644
--- a/fs/lockd/nlm3xdr_gen.h
+++ b/fs/lockd/nlm3xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x */
-/* XDR specification modification time: Thu Apr 23 10:56:34 2026 */
+/* XDR specification modification time: Mon Jun 29 20:39:34 2026 */
 
 #ifndef _LINUX_XDRGEN_NLM3_DECL_H
 #define _LINUX_XDRGEN_NLM3_DECL_H
diff --git a/fs/lockd/nlm4xdr_gen.c b/fs/lockd/nlm4xdr_gen.c
index 1c8c221db456..004ea01c689e 100644
--- a/fs/lockd/nlm4xdr_gen.c
+++ b/fs/lockd/nlm4xdr_gen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x
-// XDR specification modification time: Thu Dec 25 13:10:19 2025
+// XDR specification modification time: Mon Jun 29 20:39:36 2026
 
 #include <linux/sunrpc/svc.h>
 
@@ -20,6 +20,16 @@ xdrgen_decode_fsh4_mode(struct xdr_stream *xdr, fsh4_mode *ptr)
 
 	if (xdr_stream_decode_u32(xdr, &val) < 0)
 		return false;
+	/* Compiler may optimize to a range check for dense enums */
+	switch (val) {
+	case fsm_DN:
+	case fsm_DR:
+	case fsm_DW:
+	case fsm_DRW:
+		break;
+	default:
+		return false;
+	}
 	*ptr = val;
 	return true;
 }
@@ -31,6 +41,16 @@ xdrgen_decode_fsh4_access(struct xdr_stream *xdr, fsh4_access *ptr)
 
 	if (xdr_stream_decode_u32(xdr, &val) < 0)
 		return false;
+	/* Compiler may optimize to a range check for dense enums */
+	switch (val) {
+	case fsa_NONE:
+	case fsa_R:
+	case fsa_W:
+	case fsa_RW:
+		break;
+	default:
+		return false;
+	}
 	*ptr = val;
 	return true;
 }
@@ -62,7 +82,30 @@ xdrgen_decode_int32(struct xdr_stream *xdr, int32 *ptr)
 static bool __maybe_unused
 xdrgen_decode_nlm4_stats(struct xdr_stream *xdr, nlm4_stats *ptr)
 {
-	return xdr_stream_decode_be32(xdr, ptr) == 0;
+	__be32 raw;
+	u32 val;
+
+	if (xdr_stream_decode_be32(xdr, &raw) < 0)
+		return false;
+	val = be32_to_cpu(raw);
+	/* Compiler may optimize to a range check for dense enums */
+	switch (val) {
+	case NLM4_GRANTED:
+	case NLM4_DENIED:
+	case NLM4_DENIED_NOLOCKS:
+	case NLM4_BLOCKED:
+	case NLM4_DENIED_GRACE_PERIOD:
+	case NLM4_DEADLCK:
+	case NLM4_ROFS:
+	case NLM4_STALE_FH:
+	case NLM4_FBIG:
+	case NLM4_FAILED:
+		break;
+	default:
+		return false;
+	}
+	*ptr = raw;
+	return true;
 }
 
 static bool __maybe_unused
diff --git a/fs/lockd/nlm4xdr_gen.h b/fs/lockd/nlm4xdr_gen.h
index b6008b296a3e..b5898f0e0689 100644
--- a/fs/lockd/nlm4xdr_gen.h
+++ b/fs/lockd/nlm4xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x */
-/* XDR specification modification time: Thu Dec 25 13:10:19 2025 */
+/* XDR specification modification time: Mon Jun 29 20:39:36 2026 */
 
 #ifndef _LINUX_XDRGEN_NLM4_DECL_H
 #define _LINUX_XDRGEN_NLM4_DECL_H
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index a6725c773768..e5a6ea4a9349 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x
-// XDR specification modification time: Wed Mar 25 11:40:02 2026
+// XDR specification modification time: Tue Jun 30 11:56:05 2026
 
 #include <linux/sunrpc/svc.h>
 
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index f6a458a07406..4092379a9efa 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Wed Mar 25 11:40:02 2026 */
+/* XDR specification modification time: Tue Jun 30 11:56:05 2026 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DECL_H
 #define _LINUX_XDRGEN_NFS4_1_DECL_H
diff --git a/include/linux/sunrpc/xdrgen/nfs4_1.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
index 356c3da9f4e0..6ff4d727b0d2 100644
--- a/include/linux/sunrpc/xdrgen/nfs4_1.h
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Wed Mar 25 11:40:02 2026 */
+/* XDR specification modification time: Tue Jun 30 11:56:05 2026 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DEF_H
 #define _LINUX_XDRGEN_NFS4_1_DEF_H
diff --git a/include/linux/sunrpc/xdrgen/nlm3.h b/include/linux/sunrpc/xdrgen/nlm3.h
index 897e7d91807c..3cc69a09c1c7 100644
--- a/include/linux/sunrpc/xdrgen/nlm3.h
+++ b/include/linux/sunrpc/xdrgen/nlm3.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm3.x */
-/* XDR specification modification time: Thu Apr 23 10:56:34 2026 */
+/* XDR specification modification time: Mon Jun 29 20:39:34 2026 */
 
 #ifndef _LINUX_XDRGEN_NLM3_DEF_H
 #define _LINUX_XDRGEN_NLM3_DEF_H
diff --git a/include/linux/sunrpc/xdrgen/nlm4.h b/include/linux/sunrpc/xdrgen/nlm4.h
index e95e8f105624..7b6f10ea2838 100644
--- a/include/linux/sunrpc/xdrgen/nlm4.h
+++ b/include/linux/sunrpc/xdrgen/nlm4.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nlm4.x */
-/* XDR specification modification time: Thu Dec 25 13:10:19 2025 */
+/* XDR specification modification time: Mon Jun 29 20:39:36 2026 */
 
 #ifndef _LINUX_XDRGEN_NLM4_DEF_H
 #define _LINUX_XDRGEN_NLM4_DEF_H
-- 
2.54.0


