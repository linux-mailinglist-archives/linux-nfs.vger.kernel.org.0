Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501477BE947
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 20:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377392AbjJIS3x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 14:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376869AbjJIS3w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 14:29:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC982A4
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 11:29:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AFEC433C7;
        Mon,  9 Oct 2023 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876191;
        bh=GOTir1A39P1jtcQNSe+/aluX7ULH/7AyN4zFASXT3ec=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t+59TYKgq2P71+5QvfZvuJk2HeeHe0vySaC4ztlQPFfKtTKmVQYMIURiOpYVJQqm3
         TtXQ2yUwUHlhOgTBOXaFDoIaeaFJBHlV99SwwkrubxNvRv4FuZuKQIhCbhdKO/1hym
         EBhseR0poyjL7zwppN9hRxHQs1qOvtArqgXDk2ceq38YU0DoMk73Nxnj2iVB2K3J6V
         XKZ2ugQfkpcmdoaD7oT0n1ly6cu+lzF5GurCcN4YXn2Ke4jQV5bDsoV56iw+B1CLbq
         1g0ffWVirgNTVr5EnAObOpoeattGLAn58xA19sH3HxknuoI5FOMZYutbB9m8VS68xU
         WruHnvZs6s/Pw==
Subject: [PATCH v1 2/8] NFSD: Clean up nfsd4_do_encode_secinfo()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 09 Oct 2023 14:29:49 -0400
Message-ID: <169687618990.41382.7001696356336148462.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <169687606447.41382.568611605570999245.stgit@oracle-102.nfsv4bat.org>
References: <169687606447.41382.568611605570999245.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Refactor nfsd4_encode_secinfo() so it is more clear what XDR data
item is being encoded by which piece of code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   56 +++++++++++++++++++++++++++++++++++++----------------
 fs/nfsd/xdr4.h    |    1 +
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 12a1254c5f54..085f4bda5c58 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4551,14 +4551,35 @@ nfsd4_encode_rename(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return nfsd4_encode_change_info4(xdr, &rename->rn_tinfo);
 }
 
+static __be32
+nfsd4_encode_rpcsec_gss_info(struct xdr_stream *xdr,
+			     struct rpcsec_gss_info *info)
+{
+	__be32 status;
+
+	/* oid */
+	if (xdr_stream_encode_opaque(xdr, info->oid.data, info->oid.len) < 0)
+		return nfserr_resource;
+	/* qop */
+	status = nfsd4_encode_qop4(xdr, info->qop);
+	if (status != nfs_ok)
+		return status;
+	/* service */
+	if (xdr_stream_encode_u32(xdr, info->service) != XDR_UNIT)
+		return nfserr_resource;
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_do_encode_secinfo(struct xdr_stream *xdr, struct svc_export *exp)
 {
 	u32 i, nflavs, supported;
 	struct exp_flavor_info *flavs;
 	struct exp_flavor_info def_flavs[2];
-	__be32 *p, *flavorsp;
 	static bool report = true;
+	__be32 *flavorsp;
+	__be32 status;
 
 	if (exp->ex_nflavors) {
 		flavs = exp->ex_flavors;
@@ -4581,10 +4602,9 @@ nfsd4_do_encode_secinfo(struct xdr_stream *xdr, struct svc_export *exp)
 	}
 
 	supported = 0;
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
+	flavorsp = xdr_reserve_space(xdr, XDR_UNIT);
+	if (!flavorsp)
 		return nfserr_resource;
-	flavorsp = p++;		/* to be backfilled later */
 
 	for (i = 0; i < nflavs; i++) {
 		rpc_authflavor_t pf = flavs[i].pseudoflavor;
@@ -4592,20 +4612,22 @@ nfsd4_do_encode_secinfo(struct xdr_stream *xdr, struct svc_export *exp)
 
 		if (rpcauth_get_gssinfo(pf, &info) == 0) {
 			supported++;
-			p = xdr_reserve_space(xdr, 4 + 4 +
-					      XDR_LEN(info.oid.len) + 4 + 4);
-			if (!p)
-				return nfserr_resource;
-			*p++ = cpu_to_be32(RPC_AUTH_GSS);
-			p = xdr_encode_opaque(p,  info.oid.data, info.oid.len);
-			*p++ = cpu_to_be32(info.qop);
-			*p++ = cpu_to_be32(info.service);
+
+			/* flavor */
+			status = nfsd4_encode_uint32_t(xdr, RPC_AUTH_GSS);
+			if (status != nfs_ok)
+				return status;
+			/* flavor_info */
+			status = nfsd4_encode_rpcsec_gss_info(xdr, &info);
+			if (status != nfs_ok)
+				return status;
 		} else if (pf < RPC_AUTH_MAXFLAVOR) {
 			supported++;
-			p = xdr_reserve_space(xdr, 4);
-			if (!p)
-				return nfserr_resource;
-			*p++ = cpu_to_be32(pf);
+
+			/* flavor */
+			status = nfsd4_encode_uint32_t(xdr, pf);
+			if (status != nfs_ok)
+				return status;
 		} else {
 			if (report)
 				pr_warn("NFS: SECINFO: security flavor %u "
@@ -4615,7 +4637,7 @@ nfsd4_do_encode_secinfo(struct xdr_stream *xdr, struct svc_export *exp)
 
 	if (nflavs != supported)
 		report = false;
-	*flavorsp = htonl(supported);
+	*flavorsp = cpu_to_be32(supported);
 	return 0;
 }
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 6f5c3f4b4ca3..947345d8490d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -96,6 +96,7 @@ nfsd4_encode_uint32_t(struct xdr_stream *xdr, u32 val)
 #define nfsd4_encode_count4(x, v)	nfsd4_encode_uint32_t(x, v)
 #define nfsd4_encode_mode4(x, v)	nfsd4_encode_uint32_t(x, v)
 #define nfsd4_encode_nfs_lease4(x, v)	nfsd4_encode_uint32_t(x, v)
+#define nfsd4_encode_qop4(x, v)		nfsd4_encode_uint32_t(x, v)
 #define nfsd4_encode_sequenceid4(x, v)	nfsd4_encode_uint32_t(x, v)
 #define nfsd4_encode_slotid4(x, v)	nfsd4_encode_uint32_t(x, v)
 


