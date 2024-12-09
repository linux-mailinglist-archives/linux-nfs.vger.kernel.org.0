Return-Path: <linux-nfs+bounces-8483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD999EA10A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 22:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3498C166C6A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 21:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F0A1A0BFA;
	Mon,  9 Dec 2024 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+8OTdKs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695551A0BE3;
	Mon,  9 Dec 2024 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778864; cv=none; b=UsZPSEc1ieXaiWorEMzleMDFIsUXS5Fg8Rh78qo4qQYKJ57YXW7TAR+Bcmo5cFplN8pcHeKMEVNDrzv+eHE1phX9Kf2DFWyjfdi0Uemu+Hpj8mkiDX5wGFCovznVK59sNX5TTrg+TKG8A1M6yzeV3eLfQsCzvxD6IY1GSK7rfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778864; c=relaxed/simple;
	bh=rQEx98rn8d9+pbS2nmZE+3Rzrcgee4u6M78asDv5644=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TcGRC57Psy+Xnf6TemF3BnEplxS7NVGXxGfnkoguz/WwQaK3TJ5jVA8qnIaUTrzHDU0VZLTQ/IPSrOCcJaSJ0V9ex7QUz7AZH5FmiF/d7t954LQkiGulpv/SYe+DDqF7AnWJwIp1vVRaujEmswKMhxXLIE5AEhZYj6zSe3T5qn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+8OTdKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4C1C4CED1;
	Mon,  9 Dec 2024 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733778864;
	bh=rQEx98rn8d9+pbS2nmZE+3Rzrcgee4u6M78asDv5644=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o+8OTdKsrn1sltLnY7OEjSRjDrx2/i1K3HV+daj1gdJGj3iLJhl7CvC4rUbxjBqhl
	 MaFW5ulxGEpkPORn3ydqs9+7e3OpLn+saCpdI2XfIQE7Gr5X/eiBRBaGsnjPSEUd7u
	 oYMCAy+JnbRAAtz79LDT74PksJjrn46t5pI37NLQPceCxYGpn72N4BURxrh0ftQfFu
	 J1t93BHJJ5v7x47IlHY+PUQy2EPoHJfi3AhRWssGMcu2w7BoeNitasgqXr2Jff+Sx+
	 4kaH5UHlHiS3bBJkykV2nOheVq0XeWIOk0ZCWdIAaAAynPCP6JahRxSK1JjFk+ZC3b
	 zyqirx3n10U6w==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 09 Dec 2024 16:13:59 -0500
Subject: [PATCH v5 07/10] nfsd: rework NFS4_SHARE_WANT_* flag handling
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-delstid-v5-7-42308228f692@kernel.org>
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
In-Reply-To: <20241209-delstid-v5-0-42308228f692@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3253; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rQEx98rn8d9+pbS2nmZE+3Rzrcgee4u6M78asDv5644=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGdXXaWiZQK7EixCCJzVU33DBioa0QVfbEGFjYd6POSvVydKr
 YkCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJnV12lAAoJEAAOaEEZVoIV96QQAIPs
 Z2D8rdr8xesCz4br6nT1rY46GeGtI4vBBm13lLl/uRD69/HxrOEKonImHusiwreDRJ4+5O3lVtW
 EwUloHYnRilp6qZfbx8M6hgkY7+QKSxU80aFNdywqDo5lFnu3oiIcPNwHUuWOms4albC7F2vBY1
 vr4/SkOygTSStKt0h6+uPLFGT6OxL4uY2ImP/pZBoTyAsNr1nHVDoPPL95sI2OuhgrkuYJZHhri
 qoELDiZYbyZLPoCt3gM9sRjYySLgoCqbaJaoQ8ne2dBxhiazhraQNLHRxrdm5FrgQftnkJy+gmY
 E6whZ9TiuR0BiaP98GLgALq8RGq85OuGqZyM1KJVcvYb2s0V3ItZhQbu0sLiBsY03VXWDFlKY+o
 ksLG1DJ9bWNFmU9PizHPSsDXAYP0IRZoWVcLUDQ+fTtKkbmmUJ6kkvi/MZnKfiEbJ2+n34mG1eD
 k8NwWThzlbM+IRd17rBxHrZ4EH9beDfyvQCqYxvOwsXW3Rp1xFfMXtzAEV+3xtEcFTKTr1F1j5Y
 Z9M+YdORFWEhyd4xVMTrxHx67erQjCuqa2zYvk/ZGQrmx2KdfOw5O9V4zta1AA1eBtnh/oNg2CV
 QNUtVyzruR3Tlc84euMMf1IFBqfbnu8t74I1CbGIyjHvNaD0MrI7f3RzXv+RM3igj+CeSIhTmvm
 rrnit
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The delstid draft adds new NFS4_SHARE_WANT_TYPE_MASK values that don't
fit neatly into the existing WANT_MASK or WHEN_MASK. Add a new
NFS4_SHARE_WANT_MOD_MASK value and redefine NFS4_SHARE_WANT_MASK to
include it.

Also fix the checks in nfsd4_deleg_xgrade_none_ext() to check for the
flags instead of equality, since there may be modifier flags in the
value.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c       | 4 ++--
 fs/nfsd/nfs4xdr.c         | 2 +-
 include/uapi/linux/nfs4.h | 7 +++++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b1e71462b9d91119457a60210a07021febedaf5c..4c36e50b9eda119948461411ae8bc851907b2eb3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6115,10 +6115,10 @@ static void nfsd4_deleg_xgrade_none_ext(struct nfsd4_open *open,
 					struct nfs4_delegation *dp)
 {
 	if (deleg_is_write(dp->dl_type)) {
-		if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_READ_DELEG) {
+		if (open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_READ_DELEG) {
 			open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
 			open->op_why_no_deleg = WND4_NOT_SUPP_DOWNGRADE;
-		} else if (open->op_deleg_want == OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG) {
+		} else if (open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG) {
 			open->op_delegate_type = OPEN_DELEGATE_NONE_EXT;
 			open->op_why_no_deleg = WND4_NOT_SUPP_UPGRADE;
 		}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3006406aac8332e27ca9310288c724954f804e75..7b867d0e5099608cc199c216a6140f3d45292376 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1067,7 +1067,7 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 		return nfs_ok;
 	if (!argp->minorversion)
 		return nfserr_bad_xdr;
-	switch (w & NFS4_SHARE_WANT_MASK) {
+	switch (w & NFS4_SHARE_WANT_TYPE_MASK) {
 	case OPEN4_SHARE_ACCESS_WANT_NO_PREFERENCE:
 	case OPEN4_SHARE_ACCESS_WANT_READ_DELEG:
 	case OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG:
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index caf4db2fcbb94686631ec2232a8ff189c97c8617..4273e0249fcbb54996f5642f9920826b9d68b7b9 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -58,7 +58,7 @@
 #define NFS4_SHARE_DENY_BOTH	0x0003
 
 /* nfs41 */
-#define NFS4_SHARE_WANT_MASK		0xFF00
+#define NFS4_SHARE_WANT_TYPE_MASK	0xFF00
 #define NFS4_SHARE_WANT_NO_PREFERENCE	0x0000
 #define NFS4_SHARE_WANT_READ_DELEG	0x0100
 #define NFS4_SHARE_WANT_WRITE_DELEG	0x0200
@@ -66,13 +66,16 @@
 #define NFS4_SHARE_WANT_NO_DELEG	0x0400
 #define NFS4_SHARE_WANT_CANCEL		0x0500
 
-#define NFS4_SHARE_WHEN_MASK		0xF0000
+#define NFS4_SHARE_WHEN_MASK				0xF0000
 #define NFS4_SHARE_SIGNAL_DELEG_WHEN_RESRC_AVAIL	0x10000
 #define NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED		0x20000
 
+#define NFS4_SHARE_WANT_MOD_MASK			0xF00000
 #define NFS4_SHARE_WANT_DELEG_TIMESTAMPS		0x100000
 #define NFS4_SHARE_WANT_OPEN_XOR_DELEGATION		0x200000
 
+#define NFS4_SHARE_WANT_MASK	(NFS4_SHARE_WANT_TYPE_MASK | NFS4_SHARE_WANT_MOD_MASK)
+
 #define NFS4_CDFC4_FORE	0x1
 #define NFS4_CDFC4_BACK 0x2
 #define NFS4_CDFC4_BOTH 0x3

-- 
2.47.1


