Return-Path: <linux-nfs+bounces-21817-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOQQN7ixEGpWcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21817-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:42:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F55B9865
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03044300EDBC
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E472C37E2E0;
	Fri, 22 May 2026 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O72rg2Hs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B70379EF0;
	Fri, 22 May 2026 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478958; cv=none; b=YwAHw4kx93o3rPUIlI/KVSg5gfxJp8BnAk40ZtZKqPDIZQYooxyG7BYUFMbLg0IBxY43EKboE/8vDoVE7ozyKKchtd9q2mxLOhxt2qrrjTetDVNHYvQvcleyn1sLNKl38MCLA3FoWJxqRja+BPP4hCL6sZCsDyWiu3sXvsM2xa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478958; c=relaxed/simple;
	bh=YLh4/lMM1FLFsNW282HugdeM6AzL2tOPs8cUBDQeTEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZTF5x5r0m2JcaNY/WbJ/+uBe07S7LKq09U93+XMrAHEH692t/GZMrA9j8WDwp5BzYjiA/REt08dPkudGCNbESkIk3BomrJYNra4X+7SGvKf6CTPWszsGdfnrb/jbu3J5hCkjISl487zJRYS9JqcCM4X9GBVR+ftGi0ZX4TRG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O72rg2Hs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5801F00A3E;
	Fri, 22 May 2026 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478955;
	bh=aAgM8vwRcWxiJmuLj41yAuRh7mP2E+WvonVFr4ezXks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O72rg2Hs8cS97Pbbu/JwXVWsax+wNwwkk1mK12Gl8Nu3WTaAsAhZ0PaZObGvUDMSe
	 dlpAgcRFXBQS74Q9bJLKjXFAnpPsQO/OJqnSsHMHc2ua4fb+t0l3F7CvUQ69q7OsEc
	 1mdrLGH/BxGTGgkn7GUOqMZVyABpzWG3IXdJpcdhvgunpc0N9/aOZFrh0MoxXPS+ZY
	 l+Ma4kPpzNMmQ190HJUfk7cGu7NNcd39w5HxDaEBC+kNoWGgSDzWJOpB46RWlSo5XG
	 MGrGYjdsVjZiS5GUlPZsc/yVnQZhv39sj5wEXVdbxUMM00pSnQASvalrg1P/8L/VHK
	 zkfRwp5noLp8Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:08 -0400
Subject: [PATCH v5 03/21] nfs_common: add new NOTIFY4_* flags proposed in
 RFC8881bis
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-3-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
In-Reply-To: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4154; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YLh4/lMM1FLFsNW282HugdeM6AzL2tOPs8cUBDQeTEU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGcbcMON5xMxgSGdCKQ1MohqDCBtlHf6EA3x
 akYvvz9szKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxnAAKCRAADmhBGVaC
 FQXyEACgqvP2mfBMi74O1rYTMcO64aW1M3TFeF4QP48zHscMLpZNq3V6iNn+QQIUQt52DaU5ZXa
 KjRKOblt8BKYz61OyEj65T0RgE/cLBs64IBNBTwVkmvSROswTWIBEk3FaiUWYhlsOgvJJ2DSkgB
 /90lmKBcohg7ynP3DgUa6kt8zUeQ5VDCUME2I26Zi9R/4xzy9M2iuy8ol71/OvO6u2B02JBLMtl
 81yVSie/2CLgXPyg8evsLb4vDNtmzKIFI2Ojd3rbA6qdZEu0dnVYR8I4XhuKxcoY6UMtBWY2GRM
 BOfjICIV0pe10nvrmd4qS07yAO4zJ/RtbkOACjRSHjhhwBItjTpJepFm1/M+l31DUVgf2WoKINg
 HyYDXOvCVmDHKpdMZ8f5ix0/awVazG4XrmURU3J+gnDBUoufPCKzV1ldaifzTKm/b5Ss3FIuO7y
 B7wj/6PU/6vj/dWic1Ozb0CDKa8uNKNsaQPb9m6J6cDlRHdN+TM8Sbhg0JLtPAwmO5LX3fdg4Q9
 JTOPisncEVfHYZlKNsU2QbTEFwMS3ttj2VhX4YsWJCqc6nUo4qy5SrHsXS6iassZ5gT9d5kVCO2
 mdyvfC/5lFGgxAcipmfDJiiIEdL5sjruFCmYE9oplXnzD+kqZZjdmhFOm4DVjujE1m6dsmxUrnN
 Xnie9QNqEjcd6aw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21817-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 805F55B9865
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC8881bis adds some new flags to GET_DIR_DELEGATION that we very much
need to support.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/sunrpc/xdr/nfs4_1.x    | 16 +++++++++++++++-
 fs/nfsd/nfs4xdr_gen.c                | 13 ++++++++++++-
 fs/nfsd/nfs4xdr_gen.h                |  2 +-
 include/linux/sunrpc/xdrgen/nfs4_1.h | 13 ++++++++++++-
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/sunrpc/xdr/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
index 632f5b579c39..aa14b590b524 100644
--- a/Documentation/sunrpc/xdr/nfs4_1.x
+++ b/Documentation/sunrpc/xdr/nfs4_1.x
@@ -416,7 +416,21 @@ enum notify_type4 {
         NOTIFY4_REMOVE_ENTRY = 2,
         NOTIFY4_ADD_ENTRY = 3,
         NOTIFY4_RENAME_ENTRY = 4,
-        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5
+        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
+        /*
+         * Added in NFSv4.1 bis document
+         */
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


