Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219EF57561F
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbiGNUEm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 16:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiGNUEl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 16:04:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D7B46D87
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 13:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F4F9B828C9
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 20:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673DAC341C6;
        Thu, 14 Jul 2022 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657829076;
        bh=FUSHl8KE9FYVdXFl7kKK+SZlM7W/c3K8uLnqJ9Sfngk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CX8Lt2262WAZZJOyCQCOvxFBQhdWgaMa06tUf0VCUMZ7KPWZC/nxaJg0XJupHR8EV
         iM+9p7W3enyP16pfK25oiGm7MR7j+XK5+KSFXVk+SiSgNv9YCZd1FUFURLIyamKYw8
         akMNT5QYwqRZg+2LN4YTS01iPdYpdLwld+AwVM6OBwGYp69CWCbkPECXtj1uKk3+0w
         hNbtyyoGRSJpKoznUwhZ6e8MmdtuN0/SL9z9ykzUdYUYk8EsNqnS6mMFt9ITbLC5xs
         zwmSbDx+aajcDVdhC+qEkWlcO29tLLbJyg3Sn9/oFcNiogLDs17To4sZgH2taX0EWj
         2Ye3fTx8X4n7w==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd: drop fh argument from alloc_init_deleg
Date:   Thu, 14 Jul 2022 16:04:33 -0400
Message-Id: <20220714200434.161818-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714200434.161818-1-jlayton@kernel.org>
References: <20220714200434.161818-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, we pass the fh of the opened file down through several
functions so that alloc_init_deleg can pass it to delegation_blocked.
The filehandle of the open file is available in the nfs4_file however,
so there's no need to pass it in a separate argument.

Drop the argument from alloc_init_deleg, nfs4_open_delegation and
nfs4_set_delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8201d716a557..d2d21fdf5c41 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1131,7 +1131,6 @@ static void block_delegations(struct knfsd_fh *fh)
 
 static struct nfs4_delegation *
 alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
-		 struct svc_fh *current_fh,
 		 struct nfs4_clnt_odstate *odstate)
 {
 	struct nfs4_delegation *dp;
@@ -1141,7 +1140,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	n = atomic_long_inc_return(&num_delegations);
 	if (n < 0 || n > max_delegations)
 		goto out_dec;
-	if (delegation_blocked(&current_fh->fh_handle))
+	if (delegation_blocked(&fp->fi_fhandle))
 		goto out_dec;
 	dp = delegstateid(nfs4_alloc_stid(clp, deleg_slab, nfs4_free_deleg));
 	if (dp == NULL)
@@ -5269,7 +5268,7 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 }
 
 static struct nfs4_delegation *
-nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
+nfs4_set_delegation(struct nfs4_client *clp,
 		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
 {
 	int status = 0;
@@ -5314,7 +5313,7 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 		return ERR_PTR(status);
 
 	status = -ENOMEM;
-	dp = alloc_init_deleg(clp, fp, fh, odstate);
+	dp = alloc_init_deleg(clp, fp, odstate);
 	if (!dp)
 		goto out_delegees;
 
@@ -5382,8 +5381,7 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
  * proper support for them.
  */
 static void
-nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
-			struct nfs4_ol_stateid *stp)
+nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 {
 	struct nfs4_delegation *dp;
 	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
@@ -5415,7 +5413,7 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
 		default:
 			goto out_no_deleg;
 	}
-	dp = nfs4_set_delegation(clp, fh, stp->st_stid.sc_file, stp->st_clnt_odstate);
+	dp = nfs4_set_delegation(clp, stp->st_stid.sc_file, stp->st_clnt_odstate);
 	if (IS_ERR(dp))
 		goto out_no_deleg;
 
@@ -5547,7 +5545,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* Attempt to hand out a delegation. No error return, because the
 	* OPEN succeeds even if we fail.
 	*/
-	nfs4_open_delegation(current_fh, open, stp);
+	nfs4_open_delegation(open, stp);
 nodeleg:
 	status = nfs_ok;
 	trace_nfsd_open(&stp->st_stid.sc_stateid);
-- 
2.36.1

