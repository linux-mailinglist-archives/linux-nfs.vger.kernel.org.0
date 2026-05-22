Return-Path: <linux-nfs+bounces-21784-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ9lOIdNEGoJWAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21784-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:35:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A665E5B41D9
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11109300FF8F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AA3389119;
	Fri, 22 May 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhxeIAMW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D746F37CD4D;
	Fri, 22 May 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452956; cv=none; b=eKZ+geHl1GFbn241FADKkDU7H0/3GrHgFqskmE+xK6hepFh+VMK1qwX2RT40FSnSNTlrxahFYmAuz7snSapTenVi+Kp1FrubYBuUJS4Pk6W5tqRKrRsb6R5dk9+0YEol2yVz9uyO7/C/pkC+CWI54qO9R4lBRJHwrV//bKlODqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452956; c=relaxed/simple;
	bh=YLh4/lMM1FLFsNW282HugdeM6AzL2tOPs8cUBDQeTEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AJqHM1wTHW59x6H2AEkwtZjz4bi2i/02VndclvZxJYkJNr32ymiDNxDoJKGwBg3OyO8sOBXQ0UBAWmQq4zvBk4UidV6oSgSh9cuQm7hf/JmY8DNwJbzPcjxZB2ZnbvHFuP5h80NrSomJPYjwZbuh2V07TpLc7Y/cNCqwoIGpGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhxeIAMW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147981F000E9;
	Fri, 22 May 2026 12:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452954;
	bh=aAgM8vwRcWxiJmuLj41yAuRh7mP2E+WvonVFr4ezXks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JhxeIAMWJSjQa7xApj5ol1JHSQDFI3dqZ4ig+i5iKT2OXzQU+T/jN7MVHhN0PTR3P
	 ECYM3LXzwEWoskzSZPLnRI5r2ZBdNbZzywXMRPaLOtHCT2EgnbIUYSUURB25TiW9ID
	 DY3vGg5uSB2fbLpi7OZW7StqPxS/vEIcWbqE0B3HycA3hFwB7LBFwUaKfIXQj38HsS
	 xANKsXamQhLxYBhlmbzg9CSvjzSiZ9Ofg0liPjQ6zgpMqVN2R2RB16l1cHWvE6PIdQ
	 MShd57deNxOSvGWjny0sJ3HzpoCfq48SFjU+Pk2Ie6sKsYcdxwxHJc2DSWiPVt6mnJ
	 8eojnYUbHDtEw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:28:52 -0400
Subject: [PATCH v4 03/21] nfs_common: add new NOTIFY4_* flags proposed in
 RFC8881bis
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-3-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
In-Reply-To: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4154; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YLh4/lMM1FLFsNW282HugdeM6AzL2tOPs8cUBDQeTEU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwNcEdbzPr1iYqi2n9VQZizyuxg1vs0f2FFL
 KwIVSNbteuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMDQAKCRAADmhBGVaC
 FeuPEACMFjZyCivfHdG/ha0YaAzGhS2Kj5/etvIg/UkCVuy62rNm+72nuWG3mkMLC44Jr619nTg
 NKMNvbHQYLp4gLhRmZQrlT1YwujuMmkb+OWcm0na85fMHIT4F0st2JeCMUHU10muc1Ahoc1NunK
 cPLZTb4/n399ZY/OcFbv2G/+XKjmsrkQo9veyujFx+iszJ9MzOlbxf6qRAu8sze4vfpg12z4h8a
 CVzs3W+U0XYSLB6Xdsb7ZR6fPwLszr4Gbn5s2VjgUX4ko9c61GtPS2IK9AEDzCIDGDsA6kRwSFI
 P/fWInox1Hqtkeml0We8S9KyLrAcYr5Jw2pbYIc67wm8N1ajSdEI+bQk250tjGuWvnCtkBiDYAk
 xCrI5cBP4IymqKYRMbroNitHq+MkxX3UM1vlg+tn3HXe8L2AIEwIfxdtIisSRr9m3J9nqGUZNA+
 BNZCSSBY7Dv/Pds3N+9mCUqbWX37ONACD4m493y5aR9tP721kB2skDjlKFcxTaz7dzFjfMIJg6k
 xzjIkJDOyEUpDxPiJPzhumgIQyXkK4cQIc6325N6BYGV7kXXZi4hxPpJzQRgUWH70/I/jb6dnWk
 cPohAElSsDmg8AzvirsD7YVj+J6/y1QHAvGinqCOSmgISM6oODtTrd13YOCtZPMha9/y2GOqQqK
 NRTivlK/g4mBPcw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21784-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A665E5B41D9
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


