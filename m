Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1624D7050A4
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjEPO0c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 10:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjEPO0b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 10:26:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42A87EDA
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 07:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2705463AC6
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 14:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A8AC4339B;
        Tue, 16 May 2023 14:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684247170;
        bh=RhO8BiLjO2d6XygeYZfAmjUBgMQ/b7LqRhM03gQl0yg=;
        h=Subject:From:To:Cc:Date:From;
        b=C6njIOCxq0NBDBFEMAOAvuTk3eZxzC2EL/EWZ2Ccl5dPVRCGXohOuUuek59/2IZzJ
         3G6UEirTlyKKduoFLLxVhOyElyK5IBFGUhL8uzZ7k45FTPxtbRh1X+oYRKKsshsgDJ
         2NXld7qQfBrZGmNT9AsyNwwa3LoOfHro20R1k94YamK+Ze5FiMoBqrR9/1bQp4klUj
         1n4SsA/Jj/DZEBobqWVs3wtDYX5SxhfNrgdwNkz2l9XLDgxDUIEDLHeygYjCZ7n4Bh
         c/Pg/SylfPZVxmxHQd6uGBtP+bZdM05XEk5oRHMtRfY475zxpKm98nRLX1tmYPIrku
         cKgnae3t+F+Fg==
Subject: [PATCH 1/2] NFSD: Add encoders for NFSv4 clientids and verifiers
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Tue, 16 May 2023 10:26:09 -0400
Message-ID: <168424716929.9951.1129941008353547304.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Deduplicate some common code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |  107 +++++++++++++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 52 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 76db2fe29624..1488ce978f7c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3688,6 +3688,30 @@ nfsd4_encode_dirent(void *ccdv, const char *name, int namlen,
 	return -EINVAL;
 }
 
+static __be32
+nfsd4_encode_verifier4(struct xdr_stream *xdr, const nfs4_verifier *verf)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, NFS4_VERIFIER_SIZE);
+	if (!p)
+		return nfserr_resource;
+	memcpy(p, verf->data, sizeof(verf->data));
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_encode_clientid4(struct xdr_stream *xdr, const clientid_t *clientid)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, sizeof(__be64));
+	if (!p)
+		return nfserr_resource;
+	memcpy(p, clientid, sizeof(*clientid));
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_encode_stateid(struct xdr_stream *xdr, stateid_t *sid)
 {
@@ -3752,15 +3776,8 @@ nfsd4_encode_commit(struct nfsd4_compoundres *resp, __be32 nfserr,
 		    union nfsd4_op_u *u)
 {
 	struct nfsd4_commit *commit = &u->commit;
-	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, NFS4_VERIFIER_SIZE);
-	if (!p)
-		return nfserr_resource;
-	p = xdr_encode_opaque_fixed(p, commit->co_verf.data,
-						NFS4_VERIFIER_SIZE);
-	return 0;
+	return nfsd4_encode_verifier4(resp->xdr, &commit->co_verf);
 }
 
 static __be32
@@ -4213,15 +4230,9 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr,
 	int starting_len = xdr->buf->len;
 	__be32 *p;
 
-	p = xdr_reserve_space(xdr, NFS4_VERIFIER_SIZE);
-	if (!p)
-		return nfserr_resource;
-
-	/* XXX: Following NFSv3, we ignore the READDIR verifier for now. */
-	*p++ = cpu_to_be32(0);
-	*p++ = cpu_to_be32(0);
-	xdr->buf->head[0].iov_len = (char *)xdr->p -
-				    (char *)xdr->buf->head[0].iov_base;
+	nfserr = nfsd4_encode_verifier4(xdr, &readdir->rd_verf);
+	if (nfserr != nfs_ok)
+		return nfserr;
 
 	/*
 	 * Number of bytes left for directory entries allowing for the
@@ -4448,23 +4459,25 @@ nfsd4_encode_setclientid(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_setclientid *scd = &u->setclientid;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
 	if (!nfserr) {
-		p = xdr_reserve_space(xdr, 8 + NFS4_VERIFIER_SIZE);
-		if (!p)
-			return nfserr_resource;
-		p = xdr_encode_opaque_fixed(p, &scd->se_clientid, 8);
-		p = xdr_encode_opaque_fixed(p, &scd->se_confirm,
-						NFS4_VERIFIER_SIZE);
-	}
-	else if (nfserr == nfserr_clid_inuse) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			return nfserr_resource;
-		*p++ = cpu_to_be32(0);
-		*p++ = cpu_to_be32(0);
+		nfserr = nfsd4_encode_clientid4(xdr, &scd->se_clientid);
+		if (nfserr != nfs_ok)
+			goto out;
+		nfserr = nfsd4_encode_verifier4(xdr, &scd->se_confirm);
+	} else if (nfserr == nfserr_clid_inuse) {
+		/* empty network id */
+		if (xdr_stream_encode_u32(xdr, 0) < 0) {
+			nfserr = nfserr_resource;
+			goto out;
+		}
+		/* empty universal address */
+		if (xdr_stream_encode_u32(xdr, 0) < 0) {
+			nfserr = nfserr_resource;
+			goto out;
+		}
 	}
+out:
 	return nfserr;
 }
 
@@ -4473,17 +4486,12 @@ nfsd4_encode_write(struct nfsd4_compoundres *resp, __be32 nfserr,
 		   union nfsd4_op_u *u)
 {
 	struct nfsd4_write *write = &u->write;
-	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 16);
-	if (!p)
+	if (xdr_stream_encode_u32(resp->xdr, write->wr_bytes_written) < 0)
 		return nfserr_resource;
-	*p++ = cpu_to_be32(write->wr_bytes_written);
-	*p++ = cpu_to_be32(write->wr_how_written);
-	p = xdr_encode_opaque_fixed(p, write->wr_verifier.data,
-						NFS4_VERIFIER_SIZE);
-	return 0;
+	if (xdr_stream_encode_u32(resp->xdr, write->wr_how_written) < 0)
+		return nfserr_resource;
+	return nfsd4_encode_verifier4(resp->xdr, &write->wr_verifier);
 }
 
 static __be32
@@ -4505,20 +4513,15 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 	server_scope = nn->nfsd_name;
 	server_scope_sz = strlen(nn->nfsd_name);
 
-	p = xdr_reserve_space(xdr,
-		8 /* eir_clientid */ +
-		4 /* eir_sequenceid */ +
-		4 /* eir_flags */ +
-		4 /* spr_how */);
-	if (!p)
+	if (nfsd4_encode_clientid4(xdr, &exid->clientid) != nfs_ok)
+		return nfserr_resource;
+	if (xdr_stream_encode_u32(xdr, exid->seqid) < 0)
+		return nfserr_resource;
+	if (xdr_stream_encode_u32(xdr, exid->flags) < 0)
 		return nfserr_resource;
 
-	p = xdr_encode_opaque_fixed(p, &exid->clientid, 8);
-	*p++ = cpu_to_be32(exid->seqid);
-	*p++ = cpu_to_be32(exid->flags);
-
-	*p++ = cpu_to_be32(exid->spa_how);
-
+	if (xdr_stream_encode_u32(xdr, exid->spa_how) < 0)
+		return nfserr_resource;
 	switch (exid->spa_how) {
 	case SP4_NONE:
 		break;


