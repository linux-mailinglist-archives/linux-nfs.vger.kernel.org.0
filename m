Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A625751C9
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 17:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbiGNP20 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 11:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbiGNP20 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 11:28:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AF7491D1
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 08:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B48CEB82483
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 15:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E411EC3411C;
        Thu, 14 Jul 2022 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657812502;
        bh=jzHqgeiO5g4IVxSmcIItv4fi6ExokyezGGmOSRUg1Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvr7UTuLdYH5DArB2c+QyczhMl0VEvRsV5RUX9eGirKI+YDJfbOSJItABeOQLflwp
         6vWVLRoYXkiskBPNvgo6DobJirqcvVm682rt9ltOUl18+h7o/M/vfB42tjJpwZL+gm
         Ba+o4RSnTSICosK++WRrBnCgkMsIMFmXwpx1noq9T+kq3kzSQYBz0t1wxD6gttU5Ou
         ybpInQ0x+v+Zi8T66ko6uW6dR+DroAQvnc3hPHPh4ISF9K4+WZqlDDSWdshwBfnmqr
         LSsUGNwo/lMxmnWCUCB8hoRDq1Ay6MvcVHNvE64r2feSy4gieq7DROJDab9MYz+w3d
         dBfwERImjoYLA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [RFC PATCH 1/3] nfsd: drop fh argument from alloc_init_deleg
Date:   Thu, 14 Jul 2022 11:28:17 -0400
Message-Id: <20220714152819.128276-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714152819.128276-1-jlayton@kernel.org>
References: <20220714152819.128276-1-jlayton@kernel.org>
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
The filehandle of the open file is available in the nfs4_file struct
however, so there's no need to pass it in a separate argument.

Drop the argument from alloc_init_deleg, and follow suit in several of
the callers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 994bd11bafe0..4f81c0bbd27b 100644
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
@@ -5261,7 +5260,7 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 }
 
 static struct nfs4_delegation *
-nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
+nfs4_set_delegation(struct nfs4_client *clp,
 		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
 {
 	int status = 0;
@@ -5306,7 +5305,7 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 		return ERR_PTR(status);
 
 	status = -ENOMEM;
-	dp = alloc_init_deleg(clp, fp, fh, odstate);
+	dp = alloc_init_deleg(clp, fp, odstate);
 	if (!dp)
 		goto out_delegees;
 
@@ -5374,8 +5373,7 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
  * proper support for them.
  */
 static void
-nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
-			struct nfs4_ol_stateid *stp)
+nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 {
 	struct nfs4_delegation *dp;
 	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
@@ -5407,7 +5405,7 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
 		default:
 			goto out_no_deleg;
 	}
-	dp = nfs4_set_delegation(clp, fh, stp->st_stid.sc_file, stp->st_clnt_odstate);
+	dp = nfs4_set_delegation(clp, stp->st_stid.sc_file, stp->st_clnt_odstate);
 	if (IS_ERR(dp))
 		goto out_no_deleg;
 
@@ -5539,7 +5537,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
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

