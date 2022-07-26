Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9988580BD8
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 08:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiGZGqm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 02:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiGZGqm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 02:46:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FFA20BD6
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 23:46:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6CEA34595;
        Tue, 26 Jul 2022 06:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658817999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ePa1x2uD8CtuHpfLxEYr/n7k1l/cebYMz0fEjvXQz40=;
        b=OYLJrya4pcSi+L32rmSMbFsr5awCIIvA8oVwVUBKqWeCDQz4W1v3EPnGh9Av6QrCnXV4MI
        e8a1lFDAh49cSB56/Ojg4wI07jUEV7aBG+dAUUQMDfa23FaHOH0GamkLRP4u04ZF7FD8g3
        PminR6XWdtX1BQDTFKfSYzIhbL70/uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658817999;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ePa1x2uD8CtuHpfLxEYr/n7k1l/cebYMz0fEjvXQz40=;
        b=Z5E2ld7X7l4Y4FlqX7pt0v3hTPPUqdN/mMQBtEf/l6KwtT0KYrlTm5IrYVqaal3hKBA97W
        Xr81zEyK2SWTEMBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A888713A7C;
        Tue, 26 Jul 2022 06:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1C0DGc6N32I3WAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Jul 2022 06:46:38 +0000
Subject: [PATCH 01/13] NFSD: drop fh argument from alloc_init_deleg
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 26 Jul 2022 16:45:30 +1000
Message-ID: <165881793053.21666.13673223627958617026.stgit@noble.brown>
In-Reply-To: <165881740958.21666.5904057696047278505.stgit@noble.brown>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

Currently, we pass the fh of the opened file down through several
functions so that alloc_init_deleg can pass it to delegation_blocked.
The filehandle of the open file is available in the nfs4_file however,
so there's no need to pass it in a separate argument.

Drop the argument from alloc_init_deleg, nfs4_open_delegation and
nfs4_set_delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e46e3392d557..279c7a1502c9 100644
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
@@ -5290,7 +5289,7 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 }
 
 static struct nfs4_delegation *
-nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
+nfs4_set_delegation(struct nfs4_client *clp,
 		    struct nfs4_file *fp, struct nfs4_clnt_odstate *odstate)
 {
 	int status = 0;
@@ -5335,7 +5334,7 @@ nfs4_set_delegation(struct nfs4_client *clp, struct svc_fh *fh,
 		return ERR_PTR(status);
 
 	status = -ENOMEM;
-	dp = alloc_init_deleg(clp, fp, fh, odstate);
+	dp = alloc_init_deleg(clp, fp, odstate);
 	if (!dp)
 		goto out_delegees;
 
@@ -5403,8 +5402,7 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
  * proper support for them.
  */
 static void
-nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
-			struct nfs4_ol_stateid *stp)
+nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp)
 {
 	struct nfs4_delegation *dp;
 	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
@@ -5436,7 +5434,7 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
 		default:
 			goto out_no_deleg;
 	}
-	dp = nfs4_set_delegation(clp, fh, stp->st_stid.sc_file, stp->st_clnt_odstate);
+	dp = nfs4_set_delegation(clp, stp->st_stid.sc_file, stp->st_clnt_odstate);
 	if (IS_ERR(dp))
 		goto out_no_deleg;
 
@@ -5568,7 +5566,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	* Attempt to hand out a delegation. No error return, because the
 	* OPEN succeeds even if we fail.
 	*/
-	nfs4_open_delegation(current_fh, open, stp);
+	nfs4_open_delegation(open, stp);
 nodeleg:
 	status = nfs_ok;
 	trace_nfsd_open(&stp->st_stid.sc_stateid);


