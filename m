Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD647B3411
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 15:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjI2N64 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 09:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2N6z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 09:58:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD411B0
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 06:58:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BED0C433C8;
        Fri, 29 Sep 2023 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695995934;
        bh=DUPbf/xlMIpfvHuuYT+QR/z03K4DtvB2bU5gqBWPjvc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NS01UTXxZMO4gNpSS1PLSEr1wynU3/tLPF7heNzGHSieoz3CTu8NGgf/DmZJkWZCq
         1gcCfXHqykVjhk63kVcZRDCUi9jI2uQlOqTN4gBRl1nR4TrcWV1mA6+lKv2nPCZf0Z
         CvPeEnZJyNLDAP679YRc9LZMD+M83ysWxLnLFKQP3KXEbbrHl2xaPxkZ7Esm6JWkMf
         FFnNJgXE+WSXq9RNhMY7JgiwNZyl1Y6Ye/k+cGH9DJYa6PJLsdg0/Yy33ccyZHdlFC
         NTUvJSeCYAsUBGqD58Q7dEikrgnZ8jFFJWqzwLRfa8QycBQDW/PpDQQWxkcsVRWbVS
         brUZA2iE2QaxA==
Subject: [PATCH v1 1/7] NFSD: Add nfsd4_encode_lock_owner4()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 29 Sep 2023 09:58:53 -0400
Message-ID: <169599593304.5622.7690388304950965120.stgit@manet.1015granger.net>
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

To improve readability and better align the LOCK encoders with the
XDR specification, add an explicit encoder named for the lock_owner4
type.

In particular, to avoid code duplication, use
nfsd4_encode_clientid4() to encode the clientid in the lock owner
rather than open-coding it.

It looks to me like nfs4_set_lock_denied() already clears the
clientid if it won't return an owner (cf: the nevermind: label). The
code in the XDR encoder appears to be redundant and can safely be
removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d21aaa56c49a..9f7a6924ef5f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3976,6 +3976,20 @@ nfsd4_encode_getfh(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return nfsd4_encode_nfs_fh4(xdr, &fhp->fh_handle);
 }
 
+static __be32
+nfsd4_encode_lock_owner4(struct xdr_stream *xdr, const clientid_t *clientid,
+			 const struct xdr_netobj *owner)
+{
+	__be32 status;
+
+	/* clientid */
+	status = nfsd4_encode_clientid4(xdr, clientid);
+	if (status != nfs_ok)
+		return status;
+	/* owner */
+	return nfsd4_encode_opaque(xdr, owner->data, owner->len);
+}
+
 /*
 * Including all fields other than the name, a LOCK4denied structure requires
 *   8(clientid) + 4(namelen) + 8(offset) + 8(length) + 4(type) = 32 bytes.
@@ -3984,10 +3998,10 @@ static __be32
 nfsd4_encode_lock_denied(struct xdr_stream *xdr, struct nfsd4_lock_denied *ld)
 {
 	struct xdr_netobj *conf = &ld->ld_owner;
-	__be32 *p;
+	__be32 *p, status;
 
 again:
-	p = xdr_reserve_space(xdr, 32 + XDR_LEN(conf->len));
+	p = xdr_reserve_space(xdr, XDR_UNIT * 5);
 	if (!p) {
 		/*
 		 * Don't fail to return the result just because we can't
@@ -4004,14 +4018,11 @@ nfsd4_encode_lock_denied(struct xdr_stream *xdr, struct nfsd4_lock_denied *ld)
 	p = xdr_encode_hyper(p, ld->ld_start);
 	p = xdr_encode_hyper(p, ld->ld_length);
 	*p++ = cpu_to_be32(ld->ld_type);
-	if (conf->len) {
-		p = xdr_encode_opaque_fixed(p, &ld->ld_clientid, 8);
-		p = xdr_encode_opaque(p, conf->data, conf->len);
-		kfree(conf->data);
-	}  else {  /* non - nfsv4 lock in conflict, no clientid nor owner */
-		p = xdr_encode_hyper(p, (u64)0); /* clientid */
-		*p++ = cpu_to_be32(0); /* length of owner name */
-	}
+	status = nfsd4_encode_lock_owner4(xdr, &ld->ld_clientid,
+					  &ld->ld_owner);
+	if (status != nfs_ok)
+		return status;
+
 	return nfserr_denied;
 }
 


