Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE12FF852
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 00:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbhAUW73 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 17:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbhAUW7F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 17:59:05 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CC3C0617AB
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 14:57:47 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7BB01150A; Thu, 21 Jan 2021 17:57:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7BB01150A
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH v3 2/9] nfsd: simplify process_lock
Date:   Thu, 21 Jan 2021 17:57:38 -0500
Message-Id: <1611269865-30153-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611269865-30153-1-git-send-email-bfields@redhat.com>
References: <20210121204251.GB13298@pick.fieldses.org>
 <1611269865-30153-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Similarly, this STALE_CLIENTID check is already handled by:

nfs4_preprocess_confirmed_seqid_op()->
        nfs4_preprocess_seqid_op()->
                nfsd4_lookup_stateid()->
                        set_client()->
                                STALE_CLIENTID()

(This may cause it to return a different error in some cases where
there are multiple things wrong; pynfs test SEQ10 regressed on this
commit because of that, but I think that's the test's fault, and I've
fixed it separately.)

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f9f89229dba6..7ea63d7cec4d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6697,10 +6697,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				&cstate->session->se_client->cl_clientid,
 				sizeof(clientid_t));
 
-		status = nfserr_stale_clientid;
-		if (STALE_CLIENTID(&lock->lk_new_clientid, nn))
-			goto out;
-
 		/* validate and update open stateid and open seqid */
 		status = nfs4_preprocess_confirmed_seqid_op(cstate,
 				        lock->lk_new_open_seqid,
-- 
2.29.2

