Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F755330C0
	for <lists+linux-nfs@lfdr.de>; Tue, 24 May 2022 20:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbiEXS5J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 May 2022 14:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbiEXS5H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 May 2022 14:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A99D5131B
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 11:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1666D615D9
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 18:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAA3C34100
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 18:57:05 +0000 (UTC)
Subject: [PATCH v2 2/6] NFSD: Fix possible sleep during
 nfsd4_release_lockowner()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 24 May 2022 14:57:04 -0400
Message-ID: <165341862441.3187.2513226782679879324.stgit@bazille.1015granger.net>
In-Reply-To: <165341832236.3187.8388683641228729897.stgit@bazille.1015granger.net>
References: <165341832236.3187.8388683641228729897.stgit@bazille.1015granger.net>
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

Instead, use the recently introduced counter field in struct
nfs4_lockowner that keeps track of how many locks are associated
with that lock owner.

Reported-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org
---
 fs/nfsd/nfs4state.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d2d9748eaca6..7cedb0da888d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7563,16 +7563,11 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		if (sop->so_is_open_owner || !same_owner_str(sop, owner))
 			continue;
 
-		/* see if there are still any locks associated with it */
 		lo = lockowner(sop);
-		list_for_each_entry(stp, &sop->so_stateids, st_perstateowner) {
-			if (check_for_locks(stp->st_stid.sc_file, lo)) {
-				status = nfserr_locks_held;
-				spin_unlock(&clp->cl_lock);
-				return status;
-			}
+		if (atomic_read(&lo->lo_lockcnt) != 0) {
+			spin_unlock(&clp->cl_lock);
+			return nfserr_locks_held;
 		}
-
 		nfs4_get_stateowner(sop);
 		break;
 	}


