Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAAC66035A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 16:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjAFPd6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Jan 2023 10:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjAFPd4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Jan 2023 10:33:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C70435936
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 07:33:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A663CB81D9F
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 15:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EABC433EF;
        Fri,  6 Jan 2023 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673019230;
        bh=dEt2Nspqb40esxLCGIj5lmXJCX8tUhEZPxrDBvS4PYc=;
        h=From:To:Cc:Subject:Date:From;
        b=OAj9rqrEV674IpPPM/ePrnW8bP4KK7Dix6sW8aLE4Rz5Kj0GiyQLW7tQYg0cerCaw
         Ugz4L6ZJ5dgdHzkxgJNx8ZOFtu9+CYNxvu84yoSEH76+QR7QTylNsdaOUWB6ZuE0nq
         yQeVgUmwxioBdHuvS7v4qysf2H5RhySXL38bPuQKtKndjzS6JvtxKqOOR/+kyR175i
         yXwtzZ19QTTD5ALcOusfpe0oCSXZY0AW/kHbvaNZWwzxpuHAslwPYz6JzIrgKhjVzj
         90xkaTW7+jhuq7k3lf7wo97qm9e3GDA5YI643DcgkePGETFit6p6to+yQ1KzSQhNCY
         AIzRFkaSPwVPA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>
Subject: [PATCH v2 1/2] nfsd: allow nfsd_file_get to sanely handle a NULL pointer
Date:   Fri,  6 Jan 2023 10:33:47 -0500
Message-Id: <20230106153348.104214-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
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

...and remove some now-useless NULL pointer checks in its callers.

Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 5 ++---
 fs/nfsd/nfs4state.c | 4 +---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 0ef070349014..58ac93e7e680 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -452,7 +452,7 @@ static bool nfsd_file_lru_remove(struct nfsd_file *nf)
 struct nfsd_file *
 nfsd_file_get(struct nfsd_file *nf)
 {
-	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
+	if (nf && refcount_inc_not_zero(&nf->nf_ref))
 		return nf;
 	return NULL;
 }
@@ -1096,8 +1096,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	rcu_read_lock();
 	nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
 			       nfsd_file_rhash_params);
-	if (nf)
-		nf = nfsd_file_get(nf);
+	nf = nfsd_file_get(nf);
 	rcu_read_unlock();
 
 	if (nf) {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4809ae0f0138..655fcfec0ace 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -602,9 +602,7 @@ put_nfs4_file(struct nfs4_file *fi)
 static struct nfsd_file *
 __nfs4_get_fd(struct nfs4_file *f, int oflag)
 {
-	if (f->fi_fds[oflag])
-		return nfsd_file_get(f->fi_fds[oflag]);
-	return NULL;
+	return nfsd_file_get(f->fi_fds[oflag]);
 }
 
 static struct nfsd_file *
-- 
2.39.0

