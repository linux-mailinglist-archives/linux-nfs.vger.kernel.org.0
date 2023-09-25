Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854217AD90E
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 15:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjIYN14 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 09:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjIYN1y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 09:27:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878E19A
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 06:27:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526EFC433C7;
        Mon, 25 Sep 2023 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695648466;
        bh=sp3knqrgg+GEcrgpg88qx/bZFtD9+90BJA4NhkCaoRg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Zv/ez8TBqojET4vznCVxUmOhKatknhoxktr/S0IGWXjLhOW6n6Xy4LEEFCNKs0LF0
         YGMwyehEasNA3R+OOYeACwS6DIhreyXrfeyjfWy/ni0WOguEbpgDEgTlGyaKNLO+/S
         YdR3BY9zNMyQaMwKJGAZ36LavSCqZUbtkGzQy4GgSjjgRwaneaogAcVC/JoNnhc3uV
         PHlXKabe6qR5x9KiAPBtG6tZi6seqBBPBROJ7Wg5fMv/m2G5dNlSQKB9xEpDBlGbCx
         FGYB2t02x8pHXIQnycqnZDQ1NtgxClomR3z4LvYCkcW+23b3KU/Q/TChF9qe4obVqN
         Eb47C6SvbTt2g==
Subject: [PATCH v1 2/8] NFSD: Clean up nfsd4_encode_stateid()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 25 Sep 2023 09:27:45 -0400
Message-ID: <169564846537.6013.13509404725060635727.stgit@klimt.1015granger.net>
In-Reply-To: <169564827064.6013.5014460767978657478.stgit@klimt.1015granger.net>
References: <169564827064.6013.5014460767978657478.stgit@klimt.1015granger.net>
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

Update the encoder function name to match the type name, as is the
convention with other such encoder utility functions, and with
nfsd4_decode_stateid4().

Make the @stateid argument a const so that callers of
nfsd4_encode_stateid4() in the future can be passed const pointers
to structures.

Since the compiler is allowed to add padding to structs, use the
wire (spec-defined) size when reserving buffer space.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index bc802f187c63..24caa1c5613b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3867,18 +3867,18 @@ nfsd4_encode_clientid4(struct xdr_stream *xdr, const clientid_t *clientid)
 	return nfs_ok;
 }
 
+/* This is a frequently-encoded item; open-coded for speed */
 static __be32
-nfsd4_encode_stateid(struct xdr_stream *xdr, stateid_t *sid)
+nfsd4_encode_stateid4(struct xdr_stream *xdr, const stateid_t *sid)
 {
 	__be32 *p;
 
-	p = xdr_reserve_space(xdr, sizeof(stateid_t));
+	p = xdr_reserve_space(xdr, NFS4_STATEID_SIZE);
 	if (!p)
 		return nfserr_resource;
 	*p++ = cpu_to_be32(sid->si_generation);
-	p = xdr_encode_opaque_fixed(p, &sid->si_opaque,
-					sizeof(stateid_opaque_t));
-	return 0;
+	memcpy(p, &sid->si_opaque, sizeof(sid->si_opaque));
+	return nfs_ok;
 }
 
 static __be32
@@ -3922,7 +3922,8 @@ nfsd4_encode_close(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_close *close = &u->close;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_encode_stateid(xdr, &close->cl_stateid);
+	/* open_stateid */
+	return nfsd4_encode_stateid4(xdr, &close->cl_stateid);
 }
 
 
@@ -4022,7 +4023,7 @@ nfsd4_encode_lock(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct xdr_stream *xdr = resp->xdr;
 
 	if (!nfserr)
-		nfserr = nfsd4_encode_stateid(xdr, &lock->lk_resp_stateid);
+		nfserr = nfsd4_encode_stateid4(xdr, &lock->lk_resp_stateid);
 	else if (nfserr == nfserr_denied)
 		nfserr = nfsd4_encode_lock_denied(xdr, &lock->lk_denied);
 
@@ -4048,7 +4049,8 @@ nfsd4_encode_locku(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_locku *locku = &u->locku;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_encode_stateid(xdr, &locku->lu_stateid);
+	/* lock_stateid */
+	return nfsd4_encode_stateid4(xdr, &locku->lu_stateid);
 }
 
 
@@ -4071,7 +4073,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct xdr_stream *xdr = resp->xdr;
 	__be32 *p;
 
-	nfserr = nfsd4_encode_stateid(xdr, &open->op_stateid);
+	nfserr = nfsd4_encode_stateid4(xdr, &open->op_stateid);
 	if (nfserr)
 		return nfserr;
 	nfserr = nfsd4_encode_change_info4(xdr, &open->op_cinfo);
@@ -4094,7 +4096,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 	case NFS4_OPEN_DELEGATE_NONE:
 		break;
 	case NFS4_OPEN_DELEGATE_READ:
-		nfserr = nfsd4_encode_stateid(xdr, &open->op_delegate_stateid);
+		nfserr = nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
 		if (nfserr)
 			return nfserr;
 		p = xdr_reserve_space(xdr, 20);
@@ -4111,7 +4113,7 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 		*p++ = cpu_to_be32(0);   /* XXX: is NULL principal ok? */
 		break;
 	case NFS4_OPEN_DELEGATE_WRITE:
-		nfserr = nfsd4_encode_stateid(xdr, &open->op_delegate_stateid);
+		nfserr = nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
 		if (nfserr)
 			return nfserr;
 
@@ -4169,7 +4171,8 @@ nfsd4_encode_open_confirm(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_open_confirm *oc = &u->open_confirm;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_encode_stateid(xdr, &oc->oc_resp_stateid);
+	/* open_stateid */
+	return nfsd4_encode_stateid4(xdr, &oc->oc_resp_stateid);
 }
 
 static __be32
@@ -4179,7 +4182,8 @@ nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr,
 	struct nfsd4_open_downgrade *od = &u->open_downgrade;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_encode_stateid(xdr, &od->od_stateid);
+	/* open_stateid */
+	return nfsd4_encode_stateid4(xdr, &od->od_stateid);
 }
 
 /*
@@ -4919,7 +4923,7 @@ nfsd4_encode_layoutreturn(struct nfsd4_compoundres *resp, __be32 nfserr,
 		return nfserr_resource;
 	*p++ = cpu_to_be32(lrp->lrs_present);
 	if (lrp->lrs_present)
-		return nfsd4_encode_stateid(xdr, &lrp->lr_sid);
+		return nfsd4_encode_stateid4(xdr, &lrp->lr_sid);
 	return 0;
 }
 #endif /* CONFIG_NFSD_PNFS */
@@ -4938,7 +4942,7 @@ nfsd42_encode_write_res(struct nfsd4_compoundres *resp,
 	else {
 		__be32 nfserr;
 		*p++ = cpu_to_be32(1);
-		nfserr = nfsd4_encode_stateid(resp->xdr, &write->cb_stateid);
+		nfserr = nfsd4_encode_stateid4(resp->xdr, &write->cb_stateid);
 		if (nfserr)
 			return nfserr;
 	}
@@ -5122,7 +5126,7 @@ nfsd4_encode_copy_notify(struct nfsd4_compoundres *resp, __be32 nfserr,
 	*p++ = cpu_to_be32(cn->cpn_nsec);
 
 	/* cnr_stateid */
-	nfserr = nfsd4_encode_stateid(xdr, &cn->cpn_cnr_stateid);
+	nfserr = nfsd4_encode_stateid4(xdr, &cn->cpn_cnr_stateid);
 	if (nfserr)
 		return nfserr;
 


