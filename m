Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC6E60125D
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiJQPFB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJQPEv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 11:04:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48151BE9E
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 08:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A121B818CB
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 15:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A09C433B5;
        Mon, 17 Oct 2022 15:02:54 +0000 (UTC)
Subject: [PATCH v3 6/7] NFSD: Clean up nfs4_preprocess_stateid_op() call sites
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 17 Oct 2022 11:02:54 -0400
Message-ID: <166601897402.1714.18035781133092401829.stgit@manet.1015granger.net>
In-Reply-To: <166601838800.1714.17970169995665888062.stgit@manet.1015granger.net>
References: <166601838800.1714.17970169995665888062.stgit@manet.1015granger.net>
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

Remove the lame-duck dprintk()s around nfs4_preprocess_stateid_op()
call sites.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |   31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d0d976f847ca..42b81e88ea14 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -951,12 +951,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					&read->rd_stateid, RD_STATE,
 					&read->rd_nf, NULL);
-	if (status) {
-		dprintk("NFSD: nfsd4_read: couldn't process stateid!\n");
-		goto out;
-	}
-	status = nfs_ok;
-out:
+
 	read->rd_rqstp = rqstp;
 	read->rd_fhp = &cstate->current_fh;
 	return status;
@@ -1125,10 +1120,8 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
 				WR_STATE, NULL, NULL);
-		if (status) {
-			dprintk("NFSD: nfsd4_setattr: couldn't process stateid!\n");
+		if (status)
 			return status;
-		}
 	}
 	err = fh_want_write(&cstate->current_fh);
 	if (err)
@@ -1176,10 +1169,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			       write->wr_offset, cnt);
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 						stateid, WR_STATE, &nf, NULL);
-	if (status) {
-		dprintk("NFSD: nfsd4_write: couldn't process stateid!\n");
+	if (status)
 		return status;
-	}
 
 	write->wr_how_written = write->wr_stable_how;
 
@@ -1210,17 +1201,13 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->save_fh,
 					    src_stateid, RD_STATE, src, NULL);
-	if (status) {
-		dprintk("NFSD: %s: couldn't process src stateid!\n", __func__);
+	if (status)
 		goto out;
-	}
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    dst_stateid, WR_STATE, dst, NULL);
-	if (status) {
-		dprintk("NFSD: %s: couldn't process dst stateid!\n", __func__);
+	if (status)
 		goto out_put_src;
-	}
 
 	/* fix up for NFS-specific error code */
 	if (!S_ISREG(file_inode((*src)->nf_file)->i_mode) ||
@@ -1955,10 +1942,8 @@ nfsd4_fallocate(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &fallocate->falloc_stateid,
 					    WR_STATE, &nf, NULL);
-	if (status != nfs_ok) {
-		dprintk("NFSD: nfsd4_fallocate: couldn't process stateid!\n");
+	if (status != nfs_ok)
 		return status;
-	}
 
 	status = nfsd4_vfs_fallocate(rqstp, &cstate->current_fh, nf->nf_file,
 				     fallocate->falloc_offset,
@@ -2014,10 +1999,8 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &seek->seek_stateid,
 					    RD_STATE, &nf, NULL);
-	if (status) {
-		dprintk("NFSD: nfsd4_seek: couldn't process stateid!\n");
+	if (status)
 		return status;
-	}
 
 	switch (seek->seek_whence) {
 	case NFS4_CONTENT_DATA:


