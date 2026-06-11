Return-Path: <linux-nfs+bounces-22476-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sdmGGbv1Kmo00AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22476-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:51:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D235674293
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:51:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=m1D42YHF;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22476-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22476-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CA1B3028749
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC374968F2;
	Thu, 11 Jun 2026 17:50:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3E481259;
	Thu, 11 Jun 2026 17:50:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200239; cv=none; b=a3lnaWKWMRkR+BzvcjXpVabL/ywJJa8+Cgty0jraepjo9gIBY1ZJZvpjL6jAcjg5KcLX19kIrQiLK+U8/YNEX83/CV3M6mOuC5x+lh1bP+1uWhKKs4c8VrxYtDDHOEcMtBzaNT18ijBSEgrRz+Dirzb26r+UuECcKpe+r4iKjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200239; c=relaxed/simple;
	bh=5QdCAzFj1xtHr3OX/4DTtTD3Q8MMOgPMdXfNVFwXwfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kuv1HIzFuVUrDXwanv7Y2uWQ1E4bG0QNdaCyDhkgHAsNNp3GSqkj2IP8N58woarhxex3LW5v1R2M0K1yYmiqTo4HoSRGMvC9ioN1xwusOQskTTndcJwAqMDsllzCT8U3qZdV7QVDxRXg4xtywLco4KOO9sI0dAQgJcbpwVyPq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1D42YHF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147961F00899;
	Thu, 11 Jun 2026 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200237;
	bh=83FiQeH2SCsz+66SuLbU9Iro/2Sv9Pc5c7i5osKqhqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m1D42YHF7IThB6V3IS+v1k484QWgUs7sZPsCilFB4oqOhTAXVyusaEojHf8cKHfEr
	 syc/vh/R277NkMsLdu3MSvn6kH1I0+4ReYUL7ZUyyLuua9j/STlnyMIXUnt6fcah7d
	 K1OU79f/OguKa3buseCDtyjZ4W+1coBIZvLL9tMgMrgTzP8O6eaA+kJ7ZsXYLfQIU+
	 GSWG6gtMpXLwFBlTwx2QuUUhbCA3GJp5EXtuzJ1WuJT4MrgsGl1QU6bY5Tz4q/Jm09
	 WdoJihhMT9f3R/x//N9ha5rjT3qFk5r0QkAlcCw7AgcIBzxn1xYbHdzPdSJ1xyDlLB
	 S/tl44ViS3opA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:09 -0400
Subject: [PATCH v6 03/20] nfs_common: add new NOTIFY4_* flags proposed in
 RFC8881bis
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-3-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
In-Reply-To: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4503; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5QdCAzFj1xtHr3OX/4DTtTD3Q8MMOgPMdXfNVFwXwfw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVed9Lomu67k0PZRAin1inoQNrbKtzdWshiZ
 3rrzN7BfzGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1XgAKCRAADmhBGVaC
 FdiOEACR7e0ZQcIKT+2j997S6LNWci6gu0yYegzVa75aQH7e6vzl9WH6xoskP9RHhZx27+lL7kC
 KvaR8Q00DHCSmUX8Fk+nOlAzGq4Xkc93dszZtTzqkq15wwP1rnsFYYU0qfArqce71ijKM2o8nn+
 ibixiUQqRtuyg4mg6aWi8Sal3I6EdqwbJgdXQO4lgBNqtcbbEypkaEn6l2FnxKu6cLVCWm8gyvP
 Klo2AW5CM5H34hAmE1YWhFoO1nFYL2ywVMG3uTt61zJLA/CPPhOLFtuxVgBuKKqMNh2CR12nzAb
 a6tLSAufjcVfa0e5VsNs8HMMsbveKJ2bj40Tn4p6KrE0Ao3EnGS/MXF1NSVJc31HE8TGJOxtECU
 uA2Z2P/BErv7I2YWOZWxWQoaurMJp4nhpmPiC+RWZEzEGiqW5bKZRAGtZNz+FpOaiZAzDlOHoFc
 CZ8DMTh1eEvu4YIU5sgKEic6ZC+ro73EP9csvCmk+OaNc1c30vfYAYncfcJYQNrHw3qqJeBvOBD
 ODrkXNE4ycNMQNtogNLh2BvZ5wOgGoqQLffVdKBe7NPozFzJW/yb/C5ndVK+hnqNZd9izlvZ5hY
 S8eo/cUaiivEoecfxEcbvh/GLEhtc6IJaNMMN7RN7Yn4CjuI2rzNrW4gAFD6QGYAflAd5cyIEvV
 fUoC362Tfu9cFvw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22476-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D235674293

RFC8881bis adds some new flags to GET_DIR_DELEGATION that later patches
will consume. In particular, Linux nfsd can't easily provide info about
directory cookies and ordering. The new flags allow it to omit that
information.

There is some risk here -- RFC8881bis is still a working group document,
and has been for years. The changes to directory delegations have been
stable for the last year or so however, so the hope is that those parts
won't change (much).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/sunrpc/xdr/nfs4_1.x    | 14 +++++++++++++-
 fs/nfsd/nfs4xdr_gen.c                | 13 ++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                |  2 +-
 include/linux/sunrpc/xdrgen/nfs4_1.h | 13 ++++++++++++-
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/sunrpc/xdr/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
index 632f5b579c39..6039eb024e0e 100644
--- a/Documentation/sunrpc/xdr/nfs4_1.x
+++ b/Documentation/sunrpc/xdr/nfs4_1.x
@@ -416,7 +416,19 @@ enum notify_type4 {
         NOTIFY4_REMOVE_ENTRY = 2,
         NOTIFY4_ADD_ENTRY = 3,
         NOTIFY4_RENAME_ENTRY = 4,
-        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5
+        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
+        /* Proposed in RFC8881bis */
+        NOTIFY4_GFLAG_EXTEND = 6,
+        NOTIFY4_AUFLAG_VALID = 7,
+        NOTIFY4_AUFLAG_USER = 8,
+        NOTIFY4_AUFLAG_GROUP = 9,
+        NOTIFY4_AUFLAG_OTHER = 10,
+        NOTIFY4_CHANGE_AUTH = 11,
+        NOTIFY4_CFLAG_ORDER = 12,
+        NOTIFY4_AUFLAG_GANOW = 13,
+        NOTIFY4_AUFLAG_GALATER = 14,
+        NOTIFY4_CHANGE_GA = 15,
+        NOTIFY4_CHANGE_AMASK = 16
 };
 
 /* Changed entry information.  */
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index 5e656d6bbb8e..80369139ef7e 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x
-// XDR specification modification time: Wed Mar 25 11:39:22 2026
+// XDR specification modification time: Wed Mar 25 11:40:02 2026
 
 #include <linux/sunrpc/svc.h>
 
@@ -590,6 +590,17 @@ xdrgen_decode_notify_type4(struct xdr_stream *xdr, notify_type4 *ptr)
 	case NOTIFY4_ADD_ENTRY:
 	case NOTIFY4_RENAME_ENTRY:
 	case NOTIFY4_CHANGE_COOKIE_VERIFIER:
+	case NOTIFY4_GFLAG_EXTEND:
+	case NOTIFY4_AUFLAG_VALID:
+	case NOTIFY4_AUFLAG_USER:
+	case NOTIFY4_AUFLAG_GROUP:
+	case NOTIFY4_AUFLAG_OTHER:
+	case NOTIFY4_CHANGE_AUTH:
+	case NOTIFY4_CFLAG_ORDER:
+	case NOTIFY4_AUFLAG_GANOW:
+	case NOTIFY4_AUFLAG_GALATER:
+	case NOTIFY4_CHANGE_GA:
+	case NOTIFY4_CHANGE_AMASK:
 		break;
 	default:
 		return false;
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index 503fe2ccba51..092a1ed399c7 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Wed Mar 25 11:39:22 2026 */
+/* XDR specification modification time: Wed Mar 25 11:40:02 2026 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DECL_H
 #define _LINUX_XDRGEN_NFS4_1_DECL_H
diff --git a/include/linux/sunrpc/xdrgen/nfs4_1.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
index f761c3ddb4c7..537504069f24 100644
--- a/include/linux/sunrpc/xdrgen/nfs4_1.h
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Wed Mar 25 11:39:22 2026 */
+/* XDR specification modification time: Wed Mar 25 11:40:02 2026 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DEF_H
 #define _LINUX_XDRGEN_NFS4_1_DEF_H
@@ -377,6 +377,17 @@ enum notify_type4 {
 	NOTIFY4_ADD_ENTRY = 3,
 	NOTIFY4_RENAME_ENTRY = 4,
 	NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
+	NOTIFY4_GFLAG_EXTEND = 6,
+	NOTIFY4_AUFLAG_VALID = 7,
+	NOTIFY4_AUFLAG_USER = 8,
+	NOTIFY4_AUFLAG_GROUP = 9,
+	NOTIFY4_AUFLAG_OTHER = 10,
+	NOTIFY4_CHANGE_AUTH = 11,
+	NOTIFY4_CFLAG_ORDER = 12,
+	NOTIFY4_AUFLAG_GANOW = 13,
+	NOTIFY4_AUFLAG_GALATER = 14,
+	NOTIFY4_CHANGE_GA = 15,
+	NOTIFY4_CHANGE_AMASK = 16,
 };
 
 typedef enum notify_type4 notify_type4;

-- 
2.54.0


