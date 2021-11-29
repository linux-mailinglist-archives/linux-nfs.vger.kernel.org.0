Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC5461CC3
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 18:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhK2Rf3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 12:35:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:32834 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbhK2Rd0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Nov 2021 12:33:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9E544CE131E
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 17:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE23CC53FC7
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 17:30:05 +0000 (UTC)
Subject: [PATCH] NFSD: Replace nfsd4_decode_bitmap4()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Nov 2021 12:30:04 -0500
Message-ID: <163820700464.12736.7444246421454683750.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. Trond points out that xdr_stream_decode_uint32_array()
does the same thing as nfsd4_decode_bitmap4().

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   67 ++++++++++-------------------------------------------
 1 file changed, 13 insertions(+), 54 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5a93a5db4fb0..c2866904337b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -257,43 +257,6 @@ nfsd4_decode_verifier4(struct nfsd4_compoundargs *argp, nfs4_verifier *verf)
 	return nfs_ok;
 }
 
-/**
- * nfsd4_decode_bitmap4 - Decode an NFSv4 bitmap4
- * @argp: NFSv4 compound argument structure
- * @bmval: pointer to an array of u32's to decode into
- * @bmlen: size of the @bmval array
- *
- * The server needs to return nfs_ok rather than nfserr_bad_xdr when
- * encountering bitmaps containing bits it does not recognize. This
- * includes bits in bitmap words past WORDn, where WORDn is the last
- * bitmap WORD the implementation currently supports. Thus we are
- * careful here to simply ignore bits in bitmap words that this
- * implementation has yet to support explicitly.
- *
- * Return values:
- *   %nfs_ok: @bmval populated successfully
- *   %nfserr_bad_xdr: the encoded bitmap was invalid
- */
-static __be32
-nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen)
-{
-	u32 i, count;
-	__be32 *p;
-
-	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
-		return nfserr_bad_xdr;
-	/* request sanity */
-	if (count > 1000)
-		return nfserr_bad_xdr;
-	p = xdr_inline_decode(argp->xdr, count << 2);
-	if (!p)
-		return nfserr_bad_xdr;
-	for (i = 0; i < bmlen; i++)
-		bmval[i] = (i < count) ? be32_to_cpup(p++) : 0;
-
-	return nfs_ok;
-}
-
 static __be32
 nfsd4_decode_nfsace4(struct nfsd4_compoundargs *argp, struct nfs4_ace *ace)
 {
@@ -395,8 +358,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 	__be32 *p, status;
 
 	iattr->ia_valid = 0;
-	status = nfsd4_decode_bitmap4(argp, bmval, bmlen);
-	if (status)
+	if (xdr_stream_decode_uint32_array(argp->xdr, bmval, bmlen) < 0)
 		return nfserr_bad_xdr;
 
 	if (bmval[0] & ~NFSD_WRITEABLE_ATTRS_WORD0
@@ -850,8 +812,10 @@ nfsd4_decode_delegreturn(struct nfsd4_compoundargs *argp, struct nfsd4_delegretu
 static inline __be32
 nfsd4_decode_getattr(struct nfsd4_compoundargs *argp, struct nfsd4_getattr *getattr)
 {
-	return nfsd4_decode_bitmap4(argp, getattr->ga_bmval,
-				    ARRAY_SIZE(getattr->ga_bmval));
+	if (xdr_stream_decode_uint32_array(argp->xdr, getattr->ga_bmval,
+					   ARRAY_SIZE(getattr->ga_bmval)) < 0)
+		return nfserr_bad_xdr;
+	return nfs_ok;
 }
 
 static __be32
@@ -1369,12 +1333,11 @@ nfsd4_decode_setclientid_confirm(struct nfsd4_compoundargs *argp, struct nfsd4_s
 static __be32
 nfsd4_decode_verify(struct nfsd4_compoundargs *argp, struct nfsd4_verify *verify)
 {
-	__be32 *p, status;
+	__be32 *p;
 
-	status = nfsd4_decode_bitmap4(argp, verify->ve_bmval,
-				      ARRAY_SIZE(verify->ve_bmval));
-	if (status)
-		return status;
+	if (xdr_stream_decode_uint32_array(argp->xdr, verify->ve_bmval,
+					   ARRAY_SIZE(verify->ve_bmval)) < 0)
+		return nfserr_bad_xdr;
 
 	/* For convenience's sake, we compare raw xdr'd attributes in
 	 * nfsd4_proc_verify */
@@ -1459,15 +1422,11 @@ static __be32
 nfsd4_decode_state_protect_ops(struct nfsd4_compoundargs *argp,
 			       struct nfsd4_exchange_id *exid)
 {
-	__be32 status;
-
-	status = nfsd4_decode_bitmap4(argp, exid->spo_must_enforce,
-				      ARRAY_SIZE(exid->spo_must_enforce));
-	if (status)
+	if (xdr_stream_decode_uint32_array(argp->xdr, exid->spo_must_enforce,
+					   ARRAY_SIZE(exid->spo_must_enforce)) < 0)
 		return nfserr_bad_xdr;
-	status = nfsd4_decode_bitmap4(argp, exid->spo_must_allow,
-				      ARRAY_SIZE(exid->spo_must_allow));
-	if (status)
+	if (xdr_stream_decode_uint32_array(argp->xdr, exid->spo_must_allow,
+					   ARRAY_SIZE(exid->spo_must_allow)) < 0)
 		return nfserr_bad_xdr;
 
 	return nfs_ok;


