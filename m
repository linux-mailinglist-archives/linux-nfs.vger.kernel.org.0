Return-Path: <linux-nfs+bounces-8480-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64E39EA101
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 22:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF53D1888C5B
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 21:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D973C19FA64;
	Mon,  9 Dec 2024 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEjtJpdT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9719D082;
	Mon,  9 Dec 2024 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778860; cv=none; b=AAiyFuU0aVLoicO00ePlAwAiQ4uMMCAwAKhEFPuM5eVhO5XnZMna2TgasyRJfMPRIBvEvqlAZdYEo1erWGRm6PWom3jB8iMUTlZg4prwBWZ+h2OwsHe6n47udraSDsy/01Mx2H/9PD1L1/a6BPjsjvtSmbtN61rpdeNCRwvkGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778860; c=relaxed/simple;
	bh=b2Ye+YODeDDeRQCGrTVpIs2PnPSb+KXT7Cr6qu+61Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrwtSHpNnk5Zg6ehucUH5j8njQnlxeSSk7+elTjOut+qeHTo/lJEr+yxKxo54zE8U6D4B6LAqkC7nHK2d35/Sv7hUmTiKficvMvfALV+Icp3hD0uwNr7BDgKBHz6z2QJy1d97IT7ZFt7aMLzmETTLMSfh+giU3xqmMuWc1yNz9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEjtJpdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425DDC4CEE0;
	Mon,  9 Dec 2024 21:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733778860;
	bh=b2Ye+YODeDDeRQCGrTVpIs2PnPSb+KXT7Cr6qu+61Nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rEjtJpdTeCjKKfbQyEhgcaNg6658loKxO4inIbNwy/LjHjQqPemxkAMBC6Bdo15ew
	 QYAv4NPnGr2PTQJgU1fBa34Eifmnm2pDRstidTXgRpSmCU3LRF1ys6ddp1U2Ty8s1i
	 x40Gl1XiKlONXa3+DGYqUTjyszgv//vDy3jAlscWZLrNnNR7N6mHyF2nHy8+wAFFRg
	 406zNrX9o9v6J8X/Qa7obhDrxttStgqiAuZZ4YVO/MqcF+DzsKFgJFQXdAxZwzu7at
	 IIKzJ4P5bWHpzkDW7sFs6vxVFhgRe0sOuyNs1ZjRVfQDgeqfEPKngc+wRCuvBqfzm2
	 tz1LIriVVzOlA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 09 Dec 2024 16:13:56 -0500
Subject: [PATCH v5 04/10] nfsd: rename NFS4_SHARE_WANT_* constants to
 OPEN4_SHARE_ACCESS_WANT_*
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-delstid-v5-4-42308228f692@kernel.org>
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
In-Reply-To: <20241209-delstid-v5-0-42308228f692@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8255; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=b2Ye+YODeDDeRQCGrTVpIs2PnPSb+KXT7Cr6qu+61Nc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnV12k2LsgwIa94XJbHdyUKfJSE088fr6DKYBOF
 KDF0n487L6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ1ddpAAKCRAADmhBGVaC
 FXCyEACxg2BlOVtZBUk2eOT5QOkhDMqkf8a7BYiS04uwN/2myPODxkPfcCYJCe9bJ5oJOFUuTe+
 KZ0m/6FTNxRTGbbgwYs2bYdWthfl+rfbS5fPdd4i49mlsiIj1X6mZngLjlPVk7jHZaYLMEerLzX
 qy3BtPDjMUom/O/vDAEgVrTlEeNbHzshDJ2p00+wPbUGpIsmwFszw3oQLhilVq6yBLc3XNViS7B
 HtoZ06g2PpfkZSB1qPree6M5HDZLglfZaoOTy5ruAmP0SVExKPAbKxr4+Fvl9W0FsjTQOo74FRj
 OQ8Fc0ZQgEb91hDC/f/KRv6IPWQbH84lPzalTbRgD95Xh6qwX8+PbaBPzGU6NDE2orRhFgD3UQb
 9Mfp3fV6vZHekDt/3bBo/zdvY62Ikhk7rXO0v58GcqWhrmwEm5WGZkbijsu3+P2Ui8dhj9d31BD
 sChIR2TtdrgucNzfexGjNc95Kte3lKDoDKRzawKswgYjBU1HS+5LHYphTlBqCFgjKpNWm7aRKui
 dPN9scemQ6Fb5Nd2LA2wHBfCXTnpQAC1bX0mf4im3ad0otrfZ8be8NaXhfypgWUze3Xg1snLg+V
 r5WM75O7lHsIthW1/BjczsPe5NJrHpUty35fkyKrKmmpFK2+m+81E/71qQRywIHu9w/KfFE7g0A
 +I4+elbVUjRhFqA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the OPEN4_SHARE_ACCESS_WANT constants from the nfs4.1 and delstid
draft into the nfs4_1.x file, and regenerate the headers and source
files. Do a mass renaming of NFS4_SHARE_WANT_* to
OPEN4_SHARE_ACCESS_WANT_* in the nfsd directory.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/sunrpc/xdr/nfs4_1.x    | 15 ++++++++++++++-
 fs/nfsd/nfs4state.c                  | 16 ++++++++--------
 fs/nfsd/nfs4xdr.c                    | 12 ++++++------
 fs/nfsd/nfs4xdr_gen.c                |  2 +-
 fs/nfsd/nfs4xdr_gen.h                |  2 +-
 include/linux/sunrpc/xdrgen/nfs4_1.h | 24 +++++++++++++++++++++---
 6 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/Documentation/sunrpc/xdr/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
index ee9f8f249f1e71dbfc383007a6950ebc4104ed67..ca95150a3a29fc5418991bf2395326bd73645ea8 100644
--- a/Documentation/sunrpc/xdr/nfs4_1.x
+++ b/Documentation/sunrpc/xdr/nfs4_1.x
@@ -138,7 +138,6 @@ pragma public fattr4_open_arguments;
 const FATTR4_OPEN_ARGUMENTS     = 86;
 
 
-const OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 0x200000;
 
 
 const OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010;
@@ -161,7 +160,21 @@ pragma public		fattr4_time_deleg_modify;
 const FATTR4_TIME_DELEG_ACCESS  = 84;
 const FATTR4_TIME_DELEG_MODIFY  = 85;
 
+
+
+/* new flags for share_access field of OPEN4args */
+const OPEN4_SHARE_ACCESS_WANT_DELEG_MASK        = 0xFF00;
+const OPEN4_SHARE_ACCESS_WANT_NO_PREFERENCE     = 0x0000;
+const OPEN4_SHARE_ACCESS_WANT_READ_DELEG        = 0x0100;
+const OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG       = 0x0200;
+const OPEN4_SHARE_ACCESS_WANT_ANY_DELEG         = 0x0300;
+const OPEN4_SHARE_ACCESS_WANT_NO_DELEG          = 0x0400;
+const OPEN4_SHARE_ACCESS_WANT_CANCEL            = 0x0500;
+
+const OPEN4_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL = 0x10000;
+const OPEN4_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED = 0x20000;
 const OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 0x100000;
+const OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 0x200000;
 
 enum open_delegation_type4 {
        OPEN_DELEGATE_NONE                  = 0,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c0e46ce0e068d8c73226dfe73adc58c24a630d77..76b07c78559a0f59c0864b6247214f7136cd3dd2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5964,14 +5964,14 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
 	else {
 		open->op_why_no_deleg = WND4_RESOURCE;
 		switch (open->op_deleg_want) {
-		case NFS4_SHARE_WANT_READ_DELEG:
-		case NFS4_SHARE_WANT_WRITE_DELEG:
-		case NFS4_SHARE_WANT_ANY_DELEG:
+		case OPEN4_SHARE_ACCESS_WANT_READ_DELEG:
+		case OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG:
+		case OPEN4_SHARE_ACCESS_WANT_ANY_DELEG:
 			break;
-		case NFS4_SHARE_WANT_CANCEL:
+		case OPEN4_SHARE_ACCESS_WANT_CANCEL:
 			open->op_why_no_deleg = WND4_CANCELLED;
 			break;
-		case NFS4_SHARE_WANT_NO_DELEG:
+		case OPEN4_SHARE_ACCESS_WANT_NO_DELEG:
 			WARN_ON_ONCE(1);
 		}
 	}
@@ -6101,11 +6101,11 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
 					struct nfs4_delegation *dp)
 {
-	if (open->op_deleg_want == NFS4_SHARE_WANT_READ_DELEG &&
+	if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_READ_DELEG &&
 	    dp->dl_type == OPEN_DELEGATE_WRITE) {
 		open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
 		open->op_why_no_deleg = WND4_NOT_SUPP_DOWNGRADE;
-	} else if (open->op_deleg_want == NFS4_SHARE_WANT_WRITE_DELEG &&
+	} else if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG &&
 		   dp->dl_type == OPEN_DELEGATE_WRITE) {
 		open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
 		open->op_why_no_deleg = WND4_NOT_SUPP_UPGRADE;
@@ -6201,7 +6201,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	mutex_unlock(&stp->st_mutex);
 
 	if (nfsd4_has_session(&resp->cstate)) {
-		if (open->op_deleg_want & NFS4_SHARE_WANT_NO_DELEG) {
+		if (open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_NO_DELEG) {
 			open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
 			open->op_why_no_deleg = WND4_NOT_WANTED;
 			goto nodeleg;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 593cf8c2ffe9dad90549ae0d0d5d9cbcbf18a690..39a3b21bb90590f9f2711ca1cc0f44a68819d4a0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1067,12 +1067,12 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 	if (!argp->minorversion)
 		return nfserr_bad_xdr;
 	switch (w & NFS4_SHARE_WANT_MASK) {
-	case NFS4_SHARE_WANT_NO_PREFERENCE:
-	case NFS4_SHARE_WANT_READ_DELEG:
-	case NFS4_SHARE_WANT_WRITE_DELEG:
-	case NFS4_SHARE_WANT_ANY_DELEG:
-	case NFS4_SHARE_WANT_NO_DELEG:
-	case NFS4_SHARE_WANT_CANCEL:
+	case OPEN4_SHARE_ACCESS_WANT_NO_PREFERENCE:
+	case OPEN4_SHARE_ACCESS_WANT_READ_DELEG:
+	case OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG:
+	case OPEN4_SHARE_ACCESS_WANT_ANY_DELEG:
+	case OPEN4_SHARE_ACCESS_WANT_NO_DELEG:
+	case OPEN4_SHARE_ACCESS_WANT_CANCEL:
 		break;
 	default:
 		return nfserr_bad_xdr;
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index a0e01f50a28d7f6828f3e6ef02f90b84bf180841..a17b5d8e60b3579caa2e2a8b40ed757070e1a622 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Generated by xdrgen. Manual edits will be lost.
 // XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x
-// XDR specification modification time: Sat Oct 12 08:10:54 2024
+// XDR specification modification time: Mon Oct 14 09:10:13 2024
 
 #include <linux/sunrpc/svc.h>
 
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index 3fc8bde2b3b5db6f80f17b41e7f5991487cfa959..41a0033b72562ee3c1fcdcd4a887ce635385b22b 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Sat Oct 12 08:10:54 2024 */
+/* XDR specification modification time: Mon Oct 14 09:10:13 2024 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DECL_H
 #define _LINUX_XDRGEN_NFS4_1_DECL_H
diff --git a/include/linux/sunrpc/xdrgen/nfs4_1.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
index 9ca83a4a04cff8ebb5aafa08a24a2db771d6c1ef..cf21a14aa8850f4b21cd365cb7bc22a02c6097ce 100644
--- a/include/linux/sunrpc/xdrgen/nfs4_1.h
+++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Generated by xdrgen. Manual edits will be lost. */
 /* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_1.x */
-/* XDR specification modification time: Sat Oct 12 08:10:54 2024 */
+/* XDR specification modification time: Mon Oct 14 09:10:13 2024 */
 
 #ifndef _LINUX_XDRGEN_NFS4_1_DEF_H
 #define _LINUX_XDRGEN_NFS4_1_DEF_H
@@ -84,8 +84,6 @@ typedef struct open_arguments4 fattr4_open_arguments;
 
 enum { FATTR4_OPEN_ARGUMENTS = 86 };
 
-enum { OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 0x200000 };
-
 enum { OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010 };
 
 typedef struct nfstime4 fattr4_time_deleg_access;
@@ -96,8 +94,28 @@ enum { FATTR4_TIME_DELEG_ACCESS = 84 };
 
 enum { FATTR4_TIME_DELEG_MODIFY = 85 };
 
+enum { OPEN4_SHARE_ACCESS_WANT_DELEG_MASK = 0xFF00 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_NO_PREFERENCE = 0x0000 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_READ_DELEG = 0x0100 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG = 0x0200 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_ANY_DELEG = 0x0300 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_NO_DELEG = 0x0400 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_CANCEL = 0x0500 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL = 0x10000 };
+
+enum { OPEN4_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED = 0x20000 };
+
 enum { OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 0x100000 };
 
+enum { OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 0x200000 };
+
 enum open_delegation_type4 {
 	OPEN_DELEGATE_NONE = 0,
 	OPEN_DELEGATE_READ = 1,

-- 
2.47.1


