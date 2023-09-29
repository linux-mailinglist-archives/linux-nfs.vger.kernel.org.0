Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D293C7B3412
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 15:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjI2N7E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjI2N7D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 09:59:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F711B0
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 06:59:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F25C433C8;
        Fri, 29 Sep 2023 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695995940;
        bh=yPahKrR9TAHt9lHlZNVcdj/Q6M2DJ2Hdtm+1ETErYxo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XZ8sh3lIa7hWThVs8jRym3snQwaCA6v+1ttM70IsgIM8KqV4lViPbQ8a3TtA6l9un
         JkHMBPqJ+0z6NsOreuhLaZMEiuKYO6ChNp0U/I/1CxmEVEg/84ybacf6uulSh+TXJZ
         lj7E+FdJcX51qt622ntN1fjTBmFnsPc6r1Q2afakevTW5bPN75AGlXqfRvXYdVsfS2
         k8J7y4QPbIFFM+sBrGTsldik6kZuMZzGPfZwXDnbgFJYHEQwdGMcPxR3ilLyyzxtW9
         q2woKF8jSo/nkjRYNGPQqs5SudQwk7sx3Yl6gY5w0KjkDAUZji6Ll9jHlApz4Azb2F
         ZN/mEw89dh0/A==
Subject: [PATCH v1 2/7] NFSD: Refactor nfsd4_encode_lock_denied()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 29 Sep 2023 09:58:59 -0400
Message-ID: <169599593949.5622.9721527655525429301.stgit@manet.1015granger.net>
In-Reply-To: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
References: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Use the modern XDR utility functions.

The LOCK and LOCKT encoder functions need to return nfserr_denied
when a lock is denied, but nfsd4_encode_lock4denied() should return
a status code that is consistent with other XDR encoders.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   73 ++++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9f7a6924ef5f..ee8a7989f54f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3990,40 +3990,26 @@ nfsd4_encode_lock_owner4(struct xdr_stream *xdr, const clientid_t *clientid,
 	return nfsd4_encode_opaque(xdr, owner->data, owner->len);
 }
 
-/*
-* Including all fields other than the name, a LOCK4denied structure requires
-*   8(clientid) + 4(namelen) + 8(offset) + 8(length) + 4(type) = 32 bytes.
-*/
 static __be32
-nfsd4_encode_lock_denied(struct xdr_stream *xdr, struct nfsd4_lock_denied *ld)
+nfsd4_encode_lock4denied(struct xdr_stream *xdr,
+			 const struct nfsd4_lock_denied *ld)
 {
-	struct xdr_netobj *conf = &ld->ld_owner;
-	__be32 *p, status;
+	__be32 status;
 
-again:
-	p = xdr_reserve_space(xdr, XDR_UNIT * 5);
-	if (!p) {
-		/*
-		 * Don't fail to return the result just because we can't
-		 * return the conflicting open:
-		 */
-		if (conf->len) {
-			kfree(conf->data);
-			conf->len = 0;
-			conf->data = NULL;
-			goto again;
-		}
-		return nfserr_resource;
-	}
-	p = xdr_encode_hyper(p, ld->ld_start);
-	p = xdr_encode_hyper(p, ld->ld_length);
-	*p++ = cpu_to_be32(ld->ld_type);
-	status = nfsd4_encode_lock_owner4(xdr, &ld->ld_clientid,
-					  &ld->ld_owner);
+	/* offset */
+	status = nfsd4_encode_offset4(xdr, ld->ld_start);
 	if (status != nfs_ok)
 		return status;
-
-	return nfserr_denied;
+	/* length */
+	status = nfsd4_encode_length4(xdr, ld->ld_length);
+	if (status != nfs_ok)
+		return status;
+	/* locktype */
+	if (xdr_stream_encode_u32(xdr, ld->ld_type) != XDR_UNIT)
+		return nfserr_resource;
+	/* owner */
+	return nfsd4_encode_lock_owner4(xdr, &ld->ld_clientid,
+					&ld->ld_owner);
 }
 
 static __be32
@@ -4032,13 +4018,21 @@ nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_lock *lock = &u->lock;
 	struct xdr_stream *xdr = resp->xdr;
+	__be32 status;
 
-	if (!nfserr)
-		nfserr = nfsd4_encode_stateid4(xdr, &lock->lk_resp_stateid);
-	else if (nfserr == nfserr_denied)
-		nfserr = nfsd4_encode_lock_denied(xdr, &lock->lk_denied);
-
-	return nfserr;
+	switch (nfserr) {
+	case nfs_ok:
+		/* resok4 */
+		status = nfsd4_encode_stateid4(xdr, &lock->lk_resp_stateid);
+		break;
+	case nfserr_denied:
+		/* denied */
+		status = nfsd4_encode_lock4denied(xdr, &lock->lk_denied);
+		break;
+	default:
+		return nfserr;
+	}
+	return status != nfs_ok ? status : nfserr;
 }
 
 static __be32
@@ -4047,9 +4041,14 @@ nfsd4_encode_lockt(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_lockt *lockt = &u->lockt;
 	struct xdr_stream *xdr = resp->xdr;
+	__be32 status;
 
-	if (nfserr == nfserr_denied)
-		nfsd4_encode_lock_denied(xdr, &lockt->lt_denied);
+	if (nfserr == nfserr_denied) {
+		/* denied */
+		status = nfsd4_encode_lock4denied(xdr, &lockt->lt_denied);
+		if (status != nfs_ok)
+			return status;
+	}
 	return nfserr;
 }
 


