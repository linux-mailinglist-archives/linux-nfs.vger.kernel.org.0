Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9857A4C0E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjIRPZj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjIRPZj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:25:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF420112
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:23:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE35C16ABD;
        Mon, 18 Sep 2023 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045708;
        bh=8CPNAvxyxVIf7F9VE53I/wnnOhhBYNY6uynGY3wEaJ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kDQFiNm3y2s0C2V0eWQayIgKCwuLXHlmHYh+WOLCrbvXwIgvRLHnJMINyJirk2op8
         +5jcAzlHX7qEGItH4SAW7iACWluBb91N3PQII73yGijIMsmdL1L8GHHoVGs6oUzDIF
         Uj9cxB6djweaKuqYoz2ODpXvpcMF9r3NL12uI9n3WNadOLB9k5vvWwO9bEUIAXZUQ8
         eYRBRmsW6Jc68FLi2BQQ5p/smMYR0iMmrU77uN/+MiUud4zB2Q+UjfGOuR/pRBS6sw
         UMVooQXGOBbi9P9f6i9EV4kDlwwbk7sj4LpylXLJBnqt4IPWhxQOXbLDpe5dBko8oh
         /Id4w3SuPL/JQ==
Subject: [PATCH v1 47/52] NFSD: Add nfsd4_encode_fattr4_suppattr_exclcreat()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:01:47 -0400
Message-ID: <169504570724.133720.15944434921909768890.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_SUPPATTR_EXCLCREAT into a helper. In
a subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index aca0301dc949..02a28d07d6e4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3319,6 +3319,20 @@ static __be32 nfsd4_encode_fattr4_layout_blksize(struct xdr_stream *xdr,
 
 #endif
 
+static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
+						     const struct nfsd4_fattr_args *args)
+{
+	struct nfsd4_compoundres *resp = args->rqstp->rq_resp;
+	u32 supp[3];
+
+	memcpy(supp, nfsd_suppattrs[resp->cstate.minorversion], sizeof(supp));
+	supp[0] &= NFSD_SUPPATTR_EXCLCREAT_WORD0;
+	supp[1] &= NFSD_SUPPATTR_EXCLCREAT_WORD1;
+	supp[2] &= NFSD_SUPPATTR_EXCLCREAT_WORD2;
+
+	return nfsd4_encode_bitmap4(xdr, supp[0], supp[1], supp[2]);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3692,14 +3706,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	}
 #endif /* CONFIG_NFSD_PNFS */
 	if (bmval2 & FATTR4_WORD2_SUPPATTR_EXCLCREAT) {
-		u32 supp[3];
-
-		memcpy(supp, nfsd_suppattrs[minorversion], sizeof(supp));
-		supp[0] &= NFSD_SUPPATTR_EXCLCREAT_WORD0;
-		supp[1] &= NFSD_SUPPATTR_EXCLCREAT_WORD1;
-		supp[2] &= NFSD_SUPPATTR_EXCLCREAT_WORD2;
-
-		status = nfsd4_encode_bitmap4(xdr, supp[0], supp[1], supp[2]);
+		status = nfsd4_encode_fattr4_suppattr_exclcreat(xdr, &args);
 		if (status)
 			goto out;
 	}


