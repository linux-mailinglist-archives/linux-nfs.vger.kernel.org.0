Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0619A7EFB3A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 23:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjKQWOj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 17:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQWOi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 17:14:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32554D4F
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 14:14:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AE6C433C7
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 22:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700259274;
        bh=sup+iVZdIKvY0XQV8mPGWpmDXOHzD3LXdW+eKrvhZUc=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=OyE5bZCX0Jgbmh+tCvAF66pY63j7ZJbDacYiIH4F5lo/GMzzGIZdY1Lywhyh1dgAG
         7Rwf8qSzBFVIo1WeL7tsPHLoHRdy1Non4MOYO9TX/q+RfOufqrYr7uvzOyURZoaeFN
         LS5XD3JoFJYCrFRZDi1ApMdfJQPLEJkCxatcxBxWrYTkbbgd5oa8LWAFlxV20vu56j
         Uh1q0bPU8sZDCtcoNNy0Kd3vkeGHJshQFmVfjG2zEg4xuYYMlcIdIGp4dDYePx/UaT
         +3wTx0SUCdJQ7og5XQe7goFR7Hx4TAE8d+A5lIj66BFAqC7HPrsrqgtcXamNnjUGDR
         XG1gbTGkMpkbA==
Subject: [PATCH v2 2/4] NFSD: Replace RQ_SPLICE_OK in nfsd_read()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 17 Nov 2023 17:14:33 -0500
Message-ID: <170025927377.4577.15971872542273069502.stgit@bazille.1015granger.net>
In-Reply-To: <170025895725.4577.18051288602708688381.stgit@bazille.1015granger.net>
References: <170025895725.4577.18051288602708688381.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

RQ_SPLICE_OK is a bit of a layering violation. Also, a subsequent
patch is going to provide a mechanism for always disabling splice
reads.

Splicing is an issue only for NFS READs, so refactor nfsd_read() to
check the auth type directly instead of relying on an rq_flag
setting.

The new helper will be added into the NFSv4 read path in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   26 +++++++++++++++++++++++++-
 fs/nfsd/vfs.h |    1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fbbea7498f02..0ea7f533f816 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1216,6 +1216,30 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	return nfserr;
 }
 
+/**
+ * nfsd_read_splice_ok - check if spliced reading is supported
+ * @rqstp: RPC transaction context
+ *
+ * Return values:
+ *   %true: nfsd_splice_read() may be used
+ *   %false: nfsd_splice_read() must not be used
+ *
+ * NFS READ normally uses splice to send data in-place. However the
+ * data in cache can change after the reply's MIC is computed but
+ * before the RPC reply is sent. To prevent the client from
+ * rejecting the server-computed MIC in this somewhat rare case, do
+ * not use splice with the GSS integrity and privacy services.
+ */
+bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
+{
+	switch (svc_auth_flavor(rqstp)) {
+	case RPC_AUTH_GSS_KRB5I:
+	case RPC_AUTH_GSS_KRB5P:
+		return false;
+	}
+	return true;
+}
+
 /**
  * nfsd_read - Read data from a file
  * @rqstp: RPC transaction context
@@ -1245,7 +1269,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		return err;
 
 	file = nf->nf_file;
-	if (file->f_op->splice_read && test_bit(RQ_SPLICE_OK, &rqstp->rq_flags))
+	if (file->f_op->splice_read && nfsd_read_splice_ok(rqstp))
 		err = nfsd_splice_read(rqstp, fhp, file, offset, count, eof);
 	else
 		err = nfsd_iter_read(rqstp, fhp, file, offset, count, 0, eof);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index e3c29596f4df..702fbc4483bf 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -114,6 +114,7 @@ __be32		nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
 				unsigned long *count, unsigned int base,
 				u32 *eof);
+bool		nfsd_read_splice_ok(struct svc_rqst *rqstp);
 __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				loff_t offset, unsigned long *count,
 				u32 *eof);


