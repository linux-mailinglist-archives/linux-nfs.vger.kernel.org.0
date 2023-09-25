Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C597AD912
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 15:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjIYN2M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 09:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjIYN2M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 09:28:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7938107
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 06:28:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678BDC433C8;
        Mon, 25 Sep 2023 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695648485;
        bh=i81Zomg4H6mtzm7iC9MpLo/A2CjjKu4RDdn8/dfCxMU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R5TEPyiN7AAettR/KjJqn37HcCSz2KlSWamTWZAHZaFD2uoCCrBK/F0nlNJT3dphG
         scC0GSwBhvJ6MXAX5JaYS+xgDaksaKF6FrVICwGob/4OBXKgXdGQdAkag2ainaZ90+
         qd/OtxlTvEBtU4R2NQvS1yiJNULqBhZllZpim254MQ/pCm9m1LlSGy+DDqUUGi9CrU
         wDghCV2PN4Xi3Sq9636bYOmpwCewsIEgGplp8DTWWVco/SJ9pcZk3pa7SdyUKEF6wl
         AmqNJRs7jEUPgyMIQAW++sS3dShepcaU/VMqVBBe38mlgg5j1ZUFXoPjPGjC0rhmnz
         O0AltrJ5zzFDw==
Subject: [PATCH v1 5/8] NFSD: Clean up nfsd4_encode_layoutcommit()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 25 Sep 2023 09:28:04 -0400
Message-ID: <169564848449.6013.5110306693095829783.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4proc.c |    4 ++--
 fs/nfsd/nfs4xdr.c  |   21 ++++++++-------------
 fs/nfsd/xdr4.h     |    2 +-
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d7e88c7beba3..60262fd27b15 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2357,10 +2357,10 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	mutex_unlock(&ls->ls_mutex);
 
 	if (new_size > i_size_read(inode)) {
-		lcp->lc_size_chg = 1;
+		lcp->lc_size_chg = true;
 		lcp->lc_newsize = new_size;
 	} else {
-		lcp->lc_size_chg = 0;
+		lcp->lc_size_chg = false;
 	}
 
 	nfserr = ops->proc_layoutcommit(inode, lcp);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 13df5b021db6..beba5677a1c9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4910,20 +4910,15 @@ nfsd4_encode_layoutcommit(struct nfsd4_compoundres *resp, __be32 nfserr,
 {
 	struct nfsd4_layoutcommit *lcp = &u->layoutcommit;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
-
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
-		return nfserr_resource;
-	*p++ = cpu_to_be32(lcp->lc_size_chg);
-	if (lcp->lc_size_chg) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			return nfserr_resource;
-		p = xdr_encode_hyper(p, lcp->lc_newsize);
-	}
 
-	return 0;
+	/* ns_sizechanged */
+	nfserr = nfsd4_encode_bool(xdr, lcp->lc_size_chg);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	if (lcp->lc_size_chg)
+		/* ns_size */
+		return nfsd4_encode_length4(xdr, lcp->lc_newsize);
+	return nfs_ok;
 }
 
 static __be32
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 1a99db22b25c..1b393f1734e4 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -618,7 +618,7 @@ struct nfsd4_layoutcommit {
 	u32			lc_layout_type;	/* request */
 	u32			lc_up_len;	/* layout length */
 	void			*lc_up_layout;	/* decoded by callback */
-	u32			lc_size_chg;	/* boolean for response */
+	bool			lc_size_chg;	/* response */
 	u64			lc_newsize;	/* response */
 };
 


