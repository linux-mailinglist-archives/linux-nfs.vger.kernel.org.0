Return-Path: <linux-nfs+bounces-8854-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B23719FEBE6
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 01:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD777A17E3
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Dec 2024 00:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06576EED7;
	Tue, 31 Dec 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iocgM6aj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F8EEA9
	for <linux-nfs@vger.kernel.org>; Tue, 31 Dec 2024 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735604952; cv=none; b=DCOSzDwaxoilePSikoNLx0bsvFutnOwkSGDDkVWXWZdCVcPfAPw2kjcOJ9WzbiRDIiTq7k4mZkIdGHBG0LZiRQ0MVJIdD53sPEMXgNSKXpd7rJEhgIzxFEZJCLYMZm7eWYwcAjpN6BqJ8cSdXvV5z3+fSq0mBB91Cgc48V5HNG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735604952; c=relaxed/simple;
	bh=UMKqVod3TUfEi67sVr54bnVhU6ZxYeL1FCr2BTKr2LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXotDuBDfNtNLMHGomGovHk3YaWecmS2EkkEtM46pSg99G5loZkrnAvKR41V08V/vxteLXbYfnGK0FVGWEfN4HewvIjfBQSYhdlbXL87d1nlLzarxh0T4iS9CMhHpyoT3vndqyR+Tuuy8XcaV3FmnT8fluUNfemwLwHtmTgIj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iocgM6aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2713C4CED0;
	Tue, 31 Dec 2024 00:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735604952;
	bh=UMKqVod3TUfEi67sVr54bnVhU6ZxYeL1FCr2BTKr2LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iocgM6aj6zI92JLl1JCs0FzG51LtWZ3+lFo6NnLFi1Ej8X7R7ZTNMWHMkA1U0FGp/
	 MHF/KxRZKPr8zXAUDwC0BDv8Hh2+gkvr1seLhitKLiNUXz1nmzwx5Hi91D2dniYN0F
	 IS2XzqrIjozaKYK13sWTNrl5ySxolbi7NGbVszkvJY7zSLwv283soH7Jzvfa27rMDY
	 yqJMnBb/DEWxnLxzrQAHADaFM5Pp4dCUF3RKRUpjXTq80V0RqzOuHkntdS5WMV5lJy
	 qkC5AL8ga5NWWCKNkkc9W3txlSvy+7dtyBgE5wWnDzKsWdEJZd8hAENO5g0VQVOuux
	 kBnknsvhrFNcw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>,
	j.david.lists@gmail.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 7/9] NFSD: Refactor nfsd4_do_encode_secinfo() again
Date: Mon, 30 Dec 2024 19:28:58 -0500
Message-ID: <20241231002901.12725-8-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241231002901.12725-1-cel@kernel.org>
References: <20241231002901.12725-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Extract the code that encodes the secinfo4 union data type to
clarify the logic. The removed warning is pretty well obscured and
thus probably not terribly useful.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 65 +++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1afe5fe41f22..a8b99e4796c9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4612,13 +4612,41 @@ nfsd4_encode_rpcsec_gss_info(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_encode_secinfo4(struct xdr_stream *xdr, rpc_authflavor_t pf,
+		      u32 *supported)
+{
+	struct rpcsec_gss_info info;
+	__be32 status;
+
+	if (rpcauth_get_gssinfo(pf, &info) == 0) {
+		(*supported)++;
+
+		/* flavor */
+		status = nfsd4_encode_uint32_t(xdr, RPC_AUTH_GSS);
+		if (status != nfs_ok)
+			return status;
+		/* flavor_info */
+		status = nfsd4_encode_rpcsec_gss_info(xdr, &info);
+		if (status != nfs_ok)
+			return status;
+	} else if (pf < RPC_AUTH_MAXFLAVOR) {
+		(*supported)++;
+
+		/* flavor */
+		status = nfsd4_encode_uint32_t(xdr, pf);
+		if (status != nfs_ok)
+			return status;
+	}
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_do_encode_secinfo(struct xdr_stream *xdr, struct svc_export *exp)
 {
 	u32 i, nflavs, supported;
 	struct exp_flavor_info *flavs;
 	struct exp_flavor_info def_flavs[2];
-	static bool report = true;
 	__be32 *flavorsp;
 	__be32 status;
 
@@ -4642,42 +4670,17 @@ nfsd4_do_encode_secinfo(struct xdr_stream *xdr, struct svc_export *exp)
 		}
 	}
 
-	supported = 0;
 	flavorsp = xdr_reserve_space(xdr, XDR_UNIT);
 	if (!flavorsp)
 		return nfserr_resource;
 
-	for (i = 0; i < nflavs; i++) {
-		rpc_authflavor_t pf = flavs[i].pseudoflavor;
-		struct rpcsec_gss_info info;
-
-		if (rpcauth_get_gssinfo(pf, &info) == 0) {
-			supported++;
-
-			/* flavor */
-			status = nfsd4_encode_uint32_t(xdr, RPC_AUTH_GSS);
-			if (status != nfs_ok)
-				return status;
-			/* flavor_info */
-			status = nfsd4_encode_rpcsec_gss_info(xdr, &info);
-			if (status != nfs_ok)
-				return status;
-		} else if (pf < RPC_AUTH_MAXFLAVOR) {
-			supported++;
-
-			/* flavor */
-			status = nfsd4_encode_uint32_t(xdr, pf);
-			if (status != nfs_ok)
-				return status;
-		} else {
-			if (report)
-				pr_warn("NFS: SECINFO: security flavor %u "
-					"is not supported\n", pf);
-		}
+	for (i = 0, supported = 0; i < nflavs; i++) {
+		status = nfsd4_encode_secinfo4(xdr, flavs[i].pseudoflavor,
+					       &supported);
+		if (status != nfs_ok)
+			return status;
 	}
 
-	if (nflavs != supported)
-		report = false;
 	*flavorsp = cpu_to_be32(supported);
 	return 0;
 }
-- 
2.47.0


