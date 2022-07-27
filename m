Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7405832F8
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 21:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiG0THk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiG0THQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 15:07:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014DAD7
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 11:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92E61619D7
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB04CC433D6
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:41:00 +0000 (UTC)
Subject: [PATCH v2 10/13] NFSD: Refactor nfsd4_do_copy()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 27 Jul 2022 14:40:59 -0400
Message-ID: <165894725996.11193.11982832325337542326.stgit@manet.1015granger.net>
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

Refactor: Now that nfsd4_do_copy() no longer calls the cleanup
helpers, plumb the use of struct file pointers all the way down to
_nfsd_copy_file_range().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bb0f8d094530..d00d517f8c7d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1670,10 +1670,10 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
 	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
 }
 
-static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
+static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
+				     struct file *dst,
+				     struct file *src)
 {
-	struct file *dst = copy->nf_dst->nf_file;
-	struct file *src = copy->nf_src->nf_file;
 	errseq_t since;
 	ssize_t bytes_copied = 0;
 	u64 bytes_total = copy->cp_count;
@@ -1709,12 +1709,15 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 	return bytes_copied;
 }
 
-static __be32 nfsd4_do_copy(struct nfsd4_copy *copy, bool sync)
+static __be32 nfsd4_do_copy(struct nfsd4_copy *copy,
+			    struct file *src, struct file *dst,
+			    bool sync)
 {
 	__be32 status;
 	ssize_t bytes;
 
-	bytes = _nfsd_copy_file_range(copy);
+	bytes = _nfsd_copy_file_range(copy, dst, src);
+
 	/* for async copy, we ignore the error, client can always retry
 	 * to get the error
 	 */
@@ -1779,11 +1782,13 @@ static int nfsd4_do_async_copy(void *data)
 			nfsd4_interssc_disconnect(copy->ss_mnt);
 			goto do_callback;
 		}
-		copy->nfserr = nfsd4_do_copy(copy, 0);
+		copy->nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
+					     copy->nf_dst->nf_file, false);
 		nfsd4_cleanup_inter_ssc(copy->ss_mnt, copy->nf_src->nf_file,
 					copy->nf_dst);
 	} else {
-		copy->nfserr = nfsd4_do_copy(copy, 0);
+		copy->nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
+					     copy->nf_dst->nf_file, false);
 		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
 	}
 
@@ -1861,7 +1866,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		wake_up_process(async_copy->copy_task);
 		status = nfs_ok;
 	} else {
-		status = nfsd4_do_copy(copy, 1);
+		status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
+				       copy->nf_dst->nf_file, true);
 		nfsd4_cleanup_intra_ssc(copy->nf_src, copy->nf_dst);
 	}
 out:


