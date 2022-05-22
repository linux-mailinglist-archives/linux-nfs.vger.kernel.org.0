Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6155303E3
	for <lists+linux-nfs@lfdr.de>; Sun, 22 May 2022 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348137AbiEVPit (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 May 2022 11:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241366AbiEVPit (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 May 2022 11:38:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A8837014
        for <linux-nfs@vger.kernel.org>; Sun, 22 May 2022 08:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28060B80CA9
        for <linux-nfs@vger.kernel.org>; Sun, 22 May 2022 15:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7297C385AA
        for <linux-nfs@vger.kernel.org>; Sun, 22 May 2022 15:38:45 +0000 (UTC)
Subject: [PATCH RFC] NFSD: Fix possible sleep during nfsd4_release_lockowner()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 22 May 2022 11:38:44 -0400
Message-ID: <165323344948.2381.7808135229977810927.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd4_release_lockowner() holds clp->cl_lock when it calls
check_for_locks(). However, check_for_locks() calls nfsd_file_get()
/ nfsd_file_put() to access the backing inode's flc_posix list, and
nfsd_file_put() can sleep if the inode was recently removed.

Let's instead rely on the stateowner's reference count to gate
whether the release is permitted. This should be a reliable
indication of locks-in-use since file lock operations and
->lm_get_owner take appropriate references, which are released
appropriately when file locks are removed.

Reported-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org
---
 fs/nfsd/nfs4state.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

This might be a naive approach, but let's start with it.

This passes light testing, but it's not clear how much our existing
fleet of tests exercises this area. I've locally built a couple of
pynfs tests (one is based on the one Dai posted last week) and they
pass too.

I don't believe that FREE_STATEID needs the same simplification.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a280256cbb03..b77894e668a4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7559,12 +7559,9 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 
 		/* see if there are still any locks associated with it */
 		lo = lockowner(sop);
-		list_for_each_entry(stp, &sop->so_stateids, st_perstateowner) {
-			if (check_for_locks(stp->st_stid.sc_file, lo)) {
-				status = nfserr_locks_held;
-				spin_unlock(&clp->cl_lock);
-				return status;
-			}
+		if (atomic_read(&sop->so_count) > 1) {
+			spin_unlock(&clp->cl_lock);
+			return nfserr_locks_held;
 		}
 
 		nfs4_get_stateowner(sop);


