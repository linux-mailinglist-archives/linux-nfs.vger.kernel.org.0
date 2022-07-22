Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AFF57E831
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiGVUTX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbiGVUTO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:19:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D47F50A
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9E1DFCE26D2
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022C4C341C6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:19:09 +0000 (UTC)
Subject: [PATCH v1 02/11] NFSD: Shrink size of struct nfsd4_copy
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:19:09 -0400
Message-ID: <165852114903.11403.8544275041086740489.stgit@manet.1015granger.net>
In-Reply-To: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
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
 fs/nfsd/nfs4proc.c |    6 +++++-
 fs/nfsd/nfs4xdr.c  |    6 +++++-
 fs/nfsd/xdr4.h     |    2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 22c5ccb83d20..0bcfb9afca03 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1289,6 +1289,7 @@ void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
+	kfree(copy->cp_src);
 	kfree(copy);
 }
 
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
index 335431199077..045301ad6bb5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1926,8 +1926,12 @@ nfsd4_decode_copy(struct nfsd4_compoundargs *argp, struct nfsd4_copy *copy)
 		return nfs_ok;
 	}
 
+	copy->cp_src = svcxdr_tmpalloc(argp, sizeof(*copy->cp_src));
+	if (copy->cp_src == NULL)
+		return nfserrno(-ENOMEM);	/* XXX: jukebox? */
+
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


