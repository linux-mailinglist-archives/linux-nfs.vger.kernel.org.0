Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557D565EA7D
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 13:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjAEMPV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 07:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjAEMPR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 07:15:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E42559DE
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 04:15:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1763619FF
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 12:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FB6C433F1;
        Thu,  5 Jan 2023 12:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672920916;
        bh=zxF6rfc1pRplAF1s3BDaUNR09oF2RCVgVRRhxBsuoAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+fgEzRDiSADgugdQclFYP5YAeMlrru+Y4zZhWDiq7E8+yL2ybFmI8bNRXenfCibz
         HENn8yJSc2TELhFe2SQRMiRUHIhx2bjSj1Z+cMECchZYy7BvrMMyYbKflDLyX3Ny/W
         riEH2arsStz/1BdnO7YJMWgCLeG4paIV2VXD9No3VUCMiFT9iE5Y+ghsdr28DPLrJo
         B/ixbZo1S9w8lwtHoVwUTbSam1DAhdIqNzRg7+YJE3i7ghL3WFFEKgz4s7mz2O3JS3
         QptxDrhS1/wBZo1bQRgJA7DNzu8MCuWtax2VXARzGfnEHXVTIVHwHPcUVIlZS5okfm
         04SlYERMowKzw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] nfsd: don't kill nfsd_files because of lease break error
Date:   Thu,  5 Jan 2023 07:15:11 -0500
Message-Id: <20230105121512.21484-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105121512.21484-1-jlayton@kernel.org>
References: <20230105121512.21484-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

An error from break_lease is non-fatal, so we needn't destroy the
nfsd_file in that case. Just put the reference like we normally would
and return the error.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a67b22579c6e..f0ca9501edb2 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1113,7 +1113,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	nf = nfsd_file_alloc(&key, may_flags);
 	if (!nf) {
 		status = nfserr_jukebox;
-		goto out_status;
+		goto out;
 	}
 
 	ret = rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
@@ -1122,13 +1122,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (likely(ret == 0))
 		goto open_file;
 
-	nfsd_file_slab_free(&nf->nf_rcu);
-	nf = NULL;
 	if (ret == -EEXIST)
 		goto retry;
 	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
 	status = nfserr_jukebox;
-	goto out_status;
+	goto construction_err;
 
 wait_for_construction:
 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
@@ -1138,28 +1136,24 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
 		if (!open_retry) {
 			status = nfserr_jukebox;
-			goto out;
+			goto construction_err;
 		}
 		open_retry = false;
-		if (refcount_dec_and_test(&nf->nf_ref))
-			nfsd_file_free(nf);
 		goto retry;
 	}
-
 	this_cpu_inc(nfsd_file_cache_hits);
 
 	status = nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_flags));
+	if (status != nfs_ok) {
+		nfsd_file_put(nf);
+		nf = NULL;
+	}
+
 out:
 	if (status == nfs_ok) {
 		this_cpu_inc(nfsd_file_acquisitions);
 		*pnf = nf;
-	} else {
-		if (refcount_dec_and_test(&nf->nf_ref))
-			nfsd_file_free(nf);
-		nf = NULL;
 	}
-
-out_status:
 	put_cred(key.cred);
 	trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
 	return status;
@@ -1189,6 +1183,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (status != nfs_ok)
 		nfsd_file_unhash(nf);
 	clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
+	if (status == nfs_ok)
+		goto out;
+
+construction_err:
+	if (refcount_dec_and_test(&nf->nf_ref))
+		nfsd_file_free(nf);
+	nf = NULL;
 	goto out;
 }
 
-- 
2.39.0

