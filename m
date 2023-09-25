Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D387AD915
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjIYN2V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjIYN2U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 09:28:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5381911B
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 06:28:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C079DC433CA;
        Mon, 25 Sep 2023 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695648492;
        bh=SA+yZhDzYXp/u530y4wUu74cwlukkGC/kPghk3B5Egc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pkOWpyrfO2XEkHH5mbCOFpHXncOJzu2H49ckvDtIDj/cb6rDMfPBmZqsofLF2Gp2T
         M3YVEq/QSs1Jt1zr9xFNa+kXRd4z1ZBwu9nuaSTZO+WgO/5nMNaE5Ti91sFap4MB6q
         Rnuy+xkdomSj+COovcm5L7El/pFvOVBC+CScW1dz66NCD5kYMrcQEIkpZoJEV2O8xU
         j6wsI46sq0Wp+A9NP3szFC7bZzJsDPlxzZ4Mu3fQncRIxlkxNeieFaEwSiB6ywotVh
         X8c/8Y03JslRofSUMzAyywH+hsacmrwGyXJRwSIOONrz99U8wRzVdxDQMb42o7ju7y
         a9El6XXdi9V2w==
Subject: [PATCH v1 6/8] NFSD: Clean up nfsd4_encode_layoutreturn()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 25 Sep 2023 09:28:10 -0400
Message-ID: <169564849080.6013.9045083643257491751.stgit@klimt.1015granger.net>
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

Adopt the use of conventional XDR utility functions. Restructure
the encoder to better align with the XDR definition of the result.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4layouts.c |    6 +++---
 fs/nfsd/nfs4xdr.c     |   12 ++++++------
 fs/nfsd/xdr4.h        |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index e8a80052cb1b..5e8096bc5eaa 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -515,11 +515,11 @@ nfsd4_return_file_layouts(struct svc_rqst *rqstp,
 	if (!list_empty(&ls->ls_layouts)) {
 		if (found)
 			nfs4_inc_and_copy_stateid(&lrp->lr_sid, &ls->ls_stid);
-		lrp->lrs_present = 1;
+		lrp->lrs_present = true;
 	} else {
 		trace_nfsd_layoutstate_unhash(&ls->ls_stid.sc_stateid);
 		nfs4_unhash_stid(&ls->ls_stid);
-		lrp->lrs_present = 0;
+		lrp->lrs_present = false;
 	}
 	spin_unlock(&ls->ls_lock);
 
@@ -539,7 +539,7 @@ nfsd4_return_client_layouts(struct svc_rqst *rqstp,
 	struct nfs4_layout *lp, *t;
 	LIST_HEAD(reaplist);
 
-	lrp->lrs_present = 0;
+	lrp->lrs_present = false;
 
 	spin_lock(&clp->cl_lock);
 	list_for_each_entry_safe(ls, n, &clp->cl_lo_states, ls_perclnt) {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index beba5677a1c9..38217ac74b01 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4927,15 +4927,15 @@ nfsd4_encode_layoutreturn(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_layoutreturn *lrp = &u->layoutreturn;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
-		return nfserr_resource;
-	*p++ = cpu_to_be32(lrp->lrs_present);
+	/* lrs_present */
+	nfserr = nfsd4_encode_bool(xdr, lrp->lrs_present);
+	if (nfserr != nfs_ok)
+		return nfserr;
 	if (lrp->lrs_present)
+		/* lrs_stateid */
 		return nfsd4_encode_stateid4(xdr, &lrp->lr_sid);
-	return 0;
+	return nfs_ok;
 }
 #endif /* CONFIG_NFSD_PNFS */
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 1b393f1734e4..aba07d5378fc 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -630,7 +630,7 @@ struct nfsd4_layoutreturn {
 	u32			lrf_body_len;	/* request */
 	void			*lrf_body;	/* request */
 	stateid_t		lr_sid;		/* request/response */
-	u32			lrs_present;	/* response */
+	bool			lrs_present;	/* response */
 };
 
 struct nfsd4_fallocate {


