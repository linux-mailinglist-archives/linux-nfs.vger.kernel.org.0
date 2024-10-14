Return-Path: <linux-nfs+bounces-7164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3599D763
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 21:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B677D1F236A5
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCA21CF2B8;
	Mon, 14 Oct 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmcKigP7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34621CF2AF;
	Mon, 14 Oct 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934034; cv=none; b=IuAB2iJfgzE7TN3aOm4npRmNWQHPibN6iUhHRPvcHYQVN8K0mo9tdTaaGCFeQAbVbe7fcy6H3gvtmHhj86r2VQHTG5uVltP0xwUs24PUrj1ho/3cWQkvTP+kz76mg32URwNUe9QRQgwHkKPkzKeigARb3vd3i9BYNQo9JQfIunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934034; c=relaxed/simple;
	bh=KgABKazkhUlOOAfF3IvLNRQrTCuZpIbnKXg2NqI/6sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gh1QrQaPb7NBDFa2RNRhF0LJrI7xI7SWroLAYvBlhzKQcSS4vYNmXq0Pd/0YyyLNkMvRtFbgQUoDwgAhrNHfwiT7khcvss8c+XvDktVVhIFI9buTW7RAyc15RjOZwUEZFB5npdN+0vO96wddi/LxxUMIfl9DtTJUlXizCedHbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmcKigP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643F6C4CECE;
	Mon, 14 Oct 2024 19:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728934033;
	bh=KgABKazkhUlOOAfF3IvLNRQrTCuZpIbnKXg2NqI/6sg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QmcKigP7ZiiG950Za3QmuUcJI73JAQws4WkcMWKHoatlAaKXIFVtE/aP1salKKH1w
	 l5iyTtt85lHoXyiRA3O5eXxrwVmh0hNqiRw0AVETOmsjTu6Y3elHBiCrrK6751bIh2
	 QeQYJM4Pr1PVM25sGTGULeCq3mdYlEfF+C9bZBthOgOEg9odicczq6T79EOPfJGuGb
	 7fpHb7KOqurhYbENi2zg5oJVfzIQ5Tz3iGHxlLdltnJITrVReipzm6ZvYasTfos5vZ
	 sPGkzMpzgCwAtSI4Ws78EirGVogIxQWsYbVaw0Aqn7hrZp4V06lwJ/8VDFNKy2uZq7
	 6sFxMU61C4f2w==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Oct 2024 15:26:51 -0400
Subject: [PATCH 3/6] nfsd: rename NFS4_SHARE_WANT_* constants to
 OPEN4_SHARE_ACCESS_WANT_*
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-delstid-v1-3-7ce8a2f4dd24@kernel.org>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
In-Reply-To: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Thomas Haynes <loghyr@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8260; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KgABKazkhUlOOAfF3IvLNRQrTCuZpIbnKXg2NqI/6sg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnDXCLqmUXuhGy49NhzA5eTTPg4KigIFKHfFAd7
 1ZY8XAWMzSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZw1wiwAKCRAADmhBGVaC
 FX1kD/9FszNJEgNxXf4N7/l9F1gdEDprn3cAWfJ2Wv0ALY2ip4pIhAQXlcBMGuGB9AV4cLbsm0a
 osAawVXQmoxpmExw7tLS5qLitrMmH8yZPWL2UG7Y4m1wgYx+apQWj7r9TxhCw6pXnxIaJK8yRs0
 wpBl7vlbBhQtz9ZIAEee80kCK0Dx1iKUtTjefG3PVqqqXQTna9kNxyFlUxxj/+6TsRxi/s/ppJb
 VFR+poHcWOZsTOC38wEQ80L8fOxV0K9WsC4F6/z+egU0r2YqNc+aUz0SxtXfhElJehFGNfMR1SL
 /f4tqxwFVmsI1NSFOQNS4AyhnhxsnxOeTRDdFw7YzSGpJ8rq0TiqpactzgtznZH6pn/jqaAB2Y8
 nYtudcOyJ5Klbo1tYLciqrsU3wiXENFRVztV/GVT8mnGv2DybirVJ5gUnGCCGhKRUrTNux12+JO
 K2jJJwT0avTCS8Rz/fi2amcZUUlHjBPAxkhjLopZ/PJGZWGUVLK2kKPjqFjrzS2XLIKQqtpeBnG
 ejhn5IK7YDV8YZRqIwMVL4DToQERK72FMD714hJXSisA3T9iUCoOjbi8te7CpbzD1++z7DK7VLZ
 7n7Gtn+wzCnxHPW9Amb59uvVbOjaIwBm5MqZ6th5aRj3W1n8GMHBse2afwTISNgdasR5PjDMzDG
 /ZtlJqVPcrIm7fQ==
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
index c8b4c2b9135128f98800bc525563503bff2d2ed2..fe74d8c0c61e76f635a3133a4c71b7fb7b622a48 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5925,14 +5925,14 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
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
@@ -6062,11 +6062,11 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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
@@ -6168,7 +6168,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	mutex_unlock(&stp->st_mutex);
 
 	if (nfsd4_has_session(&resp->cstate)) {
-		if (open->op_deleg_want & NFS4_SHARE_WANT_NO_DELEG) {
+		if (open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_NO_DELEG) {
 			open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
 			open->op_why_no_deleg = WND4_NOT_WANTED;
 			goto nodeleg;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 682fc6a32c8562bbd8531458da9b7ff1de69bcd1..e95f6ba5cc65611b47d5d297584ff6e478d80a1f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1068,12 +1068,12 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 	if (!argp->minorversion)
 		return nfserr_bad_xdr;
 	switch (w & NFS4_SHARE_WANT_TYPE_MASK) {
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
2.47.0


