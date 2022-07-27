Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2717D5832F0
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiG0THe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 15:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiG0THL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 15:07:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137306051A
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 11:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE0DAB82246
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E75C433D7
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:40:23 +0000 (UTC)
Subject: [PATCH v2 04/13] NFSD: Shrink size of struct nfsd4_copy
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 27 Jul 2022 14:40:22 -0400
Message-ID: <165894722241.11193.7469616123084291963.stgit@manet.1015granger.net>
In-Reply-To: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
References: <165894669884.11193.6386905165076468843.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

struct nfsd4_copy is part of struct nfsd4_op, which resides in an
8-element array.

sizeof(struct nfsd4_op):
Before: /* size: 1696, cachelines: 27, members: 5 */
After:  /* size: 672, cachelines: 11, members: 5 */

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    8 ++++++--
 fs/nfsd/nfs4xdr.c  |    5 ++++-
 fs/nfsd/xdr4.h     |    2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index dca4c6b8f74c..4feafb903335 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1289,6 +1289,7 @@ void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
+	kfree(copy->cp_src);
 	kfree(copy);
 }
 
@@ -1549,7 +1550,7 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
 	if (status)
 		goto out;
 
-	status = nfsd4_interssc_connect(&copy->cp_src, rqstp, mount);
+	status = nfsd4_interssc_connect(copy->cp_src, rqstp, mount);
 	if (status)
 		goto out;
 
@@ -1761,7 +1762,7 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 		dst->nf_src = nfsd_file_get(src->nf_src);
 
 	memcpy(&dst->cp_stateid, &src->cp_stateid, sizeof(src->cp_stateid));
-	memcpy(&dst->cp_src, &src->cp_src, sizeof(struct nl4_server));
+	memcpy(dst->cp_src, src->cp_src, sizeof(struct nl4_server));
 	memcpy(&dst->stateid, &src->stateid, sizeof(src->stateid));
 	memcpy(&dst->c_fh, &src->c_fh, sizeof(src->c_fh));
 	dst->ss_mnt = src->ss_mnt;
@@ -1855,6 +1856,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
 			goto out_err;
+		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
+		if (!async_copy->cp_src)
+			goto out_err;
 		if (!nfs4_init_copy_state(nn, copy))
 			goto out_err;
 		refcount_set(&async_copy->refcount, 1);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 06a9d7632552..90d3a1a302b4 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1920,6 +1920,9 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 
 	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
 		return nfserr_bad_xdr;
+	copy->cp_src = svcxdr_tmpalloc(argp, sizeof(*copy->cp_src));
+	if (copy->cp_src == NULL)
+		return nfserr_jukebox;
 	copy->cp_intra = false;
 	if (count == 0) { /* intra-server copy */
 		copy->cp_intra = true;
@@ -1927,7 +1930,7 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 	}
 
 	/* decode all the supplied server addresses but use only the first */
-	status = nfsd4_decode_nl4_server(argp, &copy->cp_src);
+	status = nfsd4_decode_nl4_server(argp, copy->cp_src);
 	if (status)
 		return status;
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index f253fc3f4708..f5ad2939e6ee 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -540,7 +540,7 @@ struct nfsd4_copy {
 	u64			cp_src_pos;
 	u64			cp_dst_pos;
 	u64			cp_count;
-	struct nl4_server	cp_src;
+	struct nl4_server	*cp_src;
 	bool			cp_intra;
 
 	/* both */


