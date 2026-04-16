Return-Path: <linux-nfs+bounces-20882-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOfUAQ4f4WlbpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20882-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:40:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7524413059
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A86E93171966
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DE73B19AA;
	Thu, 16 Apr 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANgzSFhX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654DD3ACF1C;
	Thu, 16 Apr 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360946; cv=none; b=TxZhR4JSo92Vca7eQ0bCScpe3KPWx67h/CIM5MMlO4mZShycnmSZSKHMWcVD4gHrJ4H12ZMGsY2WwH2QRz6tts612VEDm8D+fdspNmZ0fTRO6wsN8eF5J4YrukhDjZZ4jzpoXaOcJcqdlAkeO8ik/g0KwxPmTA6nzq/kpAfxGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360946; c=relaxed/simple;
	bh=s72czDExX6Nxo4FsO43XYOw6JoIhVcsInWaSiqS9x8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CsVCwQwzb9s1Y1wTxXlFBhRHrFIsmZFbUnN5Cc6PRaPxhpKdUDsUy/hLBf8Om1EIvPZZ7otPJaeUfxEWyS607xQmf+9W6rQvPiuoJAgVQfuWHk/d8tOKPs6IKBXFJwqPzjg8AXB+RUCEr4iFd4xyW0wp7p1xpTH0LcLoZUos6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANgzSFhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FDBC2BCC4;
	Thu, 16 Apr 2026 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360945;
	bh=s72czDExX6Nxo4FsO43XYOw6JoIhVcsInWaSiqS9x8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ANgzSFhXrbVb4+xnerodzNxIwcs5AMdKVShiEOh5TXKWgO9pXAEtQe8arjp0O/qXe
	 Fa6TPbAaZpwDV+L2FutfOi5uMbt+gh/0G+G/GGwyfd4RF4vWQNj8GBjpvJWrZuC8Fp
	 ZhzD+MUV9Ksf1MDTiX8w3K3TjUI6lKeSio4RPudq495/poCnbz5RDC4N9U4EMv7kXI
	 AH9MtHNm5yaCnLQLPz/X4Ty1QqsZjP51QI4+0V/+GW1FGvmrnWL++yFBHIb9/aLtVV
	 TrjKysNSfPTkw4qmjh1ZlpX/BbBGL67ZuAZeyXHUEpKlUUwbd1bhEsscuDB+omCItL
	 RKoHRfRJ1SbEw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:11 -0700
Subject: [PATCH v2 10/28] nfs_common: add new NOTIFY4_* flags proposed in
 RFC8881bis
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-10-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4154; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=s72czDExX6Nxo4FsO43XYOw6JoIhVcsInWaSiqS9x8k=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3j7Hy5Wn95eisJxtj3jfs2G6WKH8cEL4LJF
 OE+WOC+bTCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd4wAKCRAADmhBGVaC
 FXkyD/9lRyJEwEkZbdZj7urgA+FdDABIlP5uRnue5NOx7d+C5yBdldCq0V3tO8/MR31Fg18PNmD
 IWTsU4MGHrY37D3Ibng/tV/fmAk34L5O/MWDd03S65e8Iey2EdV4rYqQlMdpotlAhARq5MOGr5c
 2WiDotb22fkBbA8rlIzFF1aGo85TuvF+V3GFqWvT2qwE79toxEO/kWDns/6YmeDm3Jdat23cwjE
 RY9qEIf89vAX/axsn2n5zMmIChBhcKQx0foZh+/X3P9i4PA5agi85AQwBkgsh8GwqBX+EY5zrfM
 WBwXgLIEMvsQAANDmtJAA/CJAi8us4nohyPZcd1ynm/14Fyw8SCC8bQRfvvpxPFqv9OcrlQBuMR
 rUxMLdHAxcOUbaS3ss6jYZ6X1X08/HlLjXl5CoWFtBGvit0NdF4K85bKza0cjtw9/8/PENCJRMd
 fUKmzpVxGeAvPC0QBwKU0oB+3TwNtcfgae2dy4vwtrTFkq58Yi2jIMOd/eIZU76JFGo0UedMeO3
 xQyKis32S64Xg+g9jUWmhY3cM3zzSdWha+PJqwzUiXnoEQaRaMWEXE10IxhdwivVRYgHMrx13Ve
 kVzYrcRlHvcOBy+qvgmXH8qvE1pXvl3+V80lN5MXtHlCeDbkFcJGO5nftb3AJS9d8QqkKq4v1nY
 yQruVEWAhEAk0nQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20882-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7524413059
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
2.53.0


