Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF737BE94A
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 20:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377502AbjJISaP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 14:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377428AbjJISaN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 14:30:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A903DB4
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 11:30:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19875C433C8;
        Mon,  9 Oct 2023 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696876211;
        bh=fog+67ICV9/vHluZsaXFk+TqyuSarjucRLLr9ypM/VU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CEvgr++v+QmA2CPGC4Os4IF5nYFaFR31oiQRVyQDkFQiVAnbVIgZOq44NhKVC4tpc
         CS99MW6B22kBnlKJef30XoWY5FKK3uDCcl64IU5iNVhb6IcLry9YumREjRadIQWOk0
         xjUek8sin0YzM41xd68//W+9CEv3z0P+4ELFYJXUj4fVcBN6Y54hvVUjOeNgFSy5ep
         yUzIjiQgdTk1EcifNtXw772VrsVaxlM2E19ejD+iJMeCaahus71jN+It6uKy2k2D9j
         ZNB0vlxqko4I+DwYpt6P1L/yRFkZi1YMGKuxNFkLKCwK9ypJjTuGDNgvVcVAw0eOvg
         ZDZA93zibs8yA==
Subject: [PATCH v1 5/8] NFSD: Clean up nfsd4_encode_copy()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 09 Oct 2023 14:30:09 -0400
Message-ID: <169687620976.41382.17227369054217394444.stgit@oracle-102.nfsv4bat.org>
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

Restructure this function using conventional XDR utility functions
and so it aligns better with the XDR in the specification.

I've also moved nfsd4_encode_copy() closer to the data type encoders
that only it uses.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   84 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 859ee70e076f..b9339a1452c8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5075,32 +5075,56 @@ nfsd4_encode_layoutreturn(struct nfsd4_compoundres *resp, __be32 nfserr,
 #endif /* CONFIG_NFSD_PNFS */
 
 static __be32
-nfsd42_encode_write_res(struct nfsd4_compoundres *resp,
-		struct nfsd42_write_res *write, bool sync)
+nfsd4_encode_write_response4(struct xdr_stream *xdr,
+			     const struct nfsd4_copy *copy)
 {
-	__be32 *p;
-	p = xdr_reserve_space(resp->xdr, 4);
-	if (!p)
-		return nfserr_resource;
+	const struct nfsd42_write_res *write = &copy->cp_res;
+	u32 count = nfsd4_copy_is_sync(copy) ? 0 : 1;
+	__be32 status;
 
-	if (sync)
-		*p++ = cpu_to_be32(0);
-	else {
-		__be32 nfserr;
-		*p++ = cpu_to_be32(1);
-		nfserr = nfsd4_encode_stateid4(resp->xdr, &write->cb_stateid);
-		if (nfserr)
-			return nfserr;
+	/* wr_callback_id<1> */
+	if (xdr_stream_encode_u32(xdr, count) != XDR_UNIT)
+		return nfserr_resource;
+	if (count) {
+		status = nfsd4_encode_stateid4(xdr, &write->cb_stateid);
+		if (status != nfs_ok)
+			return status;
 	}
-	p = xdr_reserve_space(resp->xdr, 8 + 4 + NFS4_VERIFIER_SIZE);
-	if (!p)
+
+	/* wr_count */
+	status = nfsd4_encode_length4(xdr, write->wr_bytes_written);
+	if (status != nfs_ok)
+		return status;
+	/* wr_committed */
+	if (xdr_stream_encode_u32(xdr, write->wr_stable_how) != XDR_UNIT)
 		return nfserr_resource;
+	/* wr_writeverf */
+	return nfsd4_encode_verifier4(xdr, &write->wr_verifier);
+}
 
-	p = xdr_encode_hyper(p, write->wr_bytes_written);
-	*p++ = cpu_to_be32(write->wr_stable_how);
-	p = xdr_encode_opaque_fixed(p, write->wr_verifier.data,
-				    NFS4_VERIFIER_SIZE);
-	return nfs_ok;
+static __be32 nfsd4_encode_copy_requirements4(struct xdr_stream *xdr,
+					      const struct nfsd4_copy *copy)
+{
+	__be32 status;
+
+	/* cr_consecutive */
+	status = nfsd4_encode_bool(xdr, true);
+	if (status != nfs_ok)
+		return status;
+	/* cr_synchronous */
+	return nfsd4_encode_bool(xdr, nfsd4_copy_is_sync(copy));
+}
+
+static __be32
+nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
+		  union nfsd4_op_u *u)
+{
+	struct nfsd4_copy *copy = &u->copy;
+
+	nfserr = nfsd4_encode_write_response4(resp->xdr, copy);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	return nfsd4_encode_copy_requirements4(resp->xdr, copy);
 }
 
 static __be32
@@ -5143,24 +5167,6 @@ nfsd42_encode_nl4_server(struct nfsd4_compoundres *resp, struct nl4_server *ns)
 	return 0;
 }
 
-static __be32
-nfsd4_encode_copy(struct nfsd4_compoundres *resp, __be32 nfserr,
-		  union nfsd4_op_u *u)
-{
-	struct nfsd4_copy *copy = &u->copy;
-	__be32 *p;
-
-	nfserr = nfsd42_encode_write_res(resp, &copy->cp_res,
-					 nfsd4_copy_is_sync(copy));
-	if (nfserr)
-		return nfserr;
-
-	p = xdr_reserve_space(resp->xdr, 4 + 4);
-	*p++ = xdr_one; /* cr_consecutive */
-	*p = nfsd4_copy_is_sync(copy) ? xdr_one : xdr_zero;
-	return 0;
-}
-
 static __be32
 nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 			    union nfsd4_op_u *u)


