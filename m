Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF8E57E837
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbiGVUTv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbiGVUTu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:19:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2D67F50A
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD2BEB82A1E
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618AAC341C6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:19:47 +0000 (UTC)
Subject: [PATCH v1 08/11] NFSD: Refactor nfsd4_do_copy()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:19:46 -0400
Message-ID: <165852118632.11403.16111373549116263352.stgit@manet.1015granger.net>
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

Refactor: Now that nfsd4_do_copy() no longer calls the cleanup
helpers, plumb the use of struct file pointers all the way down to
_nfsd_copy_file_range().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e47106698967..347a86a6730e 100644
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


