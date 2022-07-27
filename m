Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9AA5832FA
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 21:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiG0THm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 15:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiG0THQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 15:07:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBDF1F7
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 11:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6547B821D5
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4451DC433C1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 18:41:07 +0000 (UTC)
Subject: [PATCH v2 11/13] NFSD: Remove kmalloc from nfsd4_do_async_copy()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 27 Jul 2022 14:41:06 -0400
Message-ID: <165894726621.11193.10540376055028362017.stgit@manet.1015granger.net>
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

Instead of manufacturing a phony struct nfsd_file, pass the
struct file returned by nfs42_ssc_open() directly to
nfsd4_do_copy().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d00d517f8c7d..336fdfae2230 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1763,29 +1763,31 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 	nfs4_put_copy(copy);
 }
 
+/**
+ * nfsd4_do_async_copy - kthread function for background server-side COPY
+ * @data: arguments for COPY operation
+ *
+ * Return values:
+ *   %0: Copy operation is done.
+ */
 static int nfsd4_do_async_copy(void *data)
 {
 	struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
 	struct nfsd4_copy *cb_copy;
 
 	if (nfsd4_ssc_is_inter(copy)) {
-		copy->nf_src = kzalloc(sizeof(struct nfsd_file), GFP_KERNEL);
-		if (!copy->nf_src) {
-			copy->nfserr = nfserr_serverfault;
-			nfsd4_interssc_disconnect(copy->ss_mnt);
-			goto do_callback;
-		}
-		copy->nf_src->nf_file = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
-					      &copy->stateid);
-		if (IS_ERR(copy->nf_src->nf_file)) {
+		struct file *filp;
+
+		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
+				      &copy->stateid);
+		if (IS_ERR(filp)) {
 			copy->nfserr = nfserr_offload_denied;
 			nfsd4_interssc_disconnect(copy->ss_mnt);
 			goto do_callback;
 		}
-		copy->nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
+		copy->nfserr = nfsd4_do_copy(copy, filp,
 					     copy->nf_dst->nf_file, false);
-		nfsd4_cleanup_inter_ssc(copy->ss_mnt, copy->nf_src->nf_file,
-					copy->nf_dst);
+		nfsd4_cleanup_inter_ssc(copy->ss_mnt, filp, copy->nf_dst);
 	} else {
 		copy->nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
 					     copy->nf_dst->nf_file, false);
@@ -1807,8 +1809,6 @@ static int nfsd4_do_async_copy(void *data)
 			      &copy->fh, copy->cp_count, copy->nfserr);
 	nfsd4_run_cb(&cb_copy->cp_cb);
 out:
-	if (nfsd4_ssc_is_inter(copy))
-		kfree(copy->nf_src);
 	cleanup_async_copy(copy);
 	return 0;
 }


