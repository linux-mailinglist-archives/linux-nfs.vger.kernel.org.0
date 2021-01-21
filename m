Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CB12FF496
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 20:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbhAUTdd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 14:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbhAUSvK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 13:51:10 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC40C061351
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 10:50:00 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id CEE5B6F0B; Thu, 21 Jan 2021 13:49:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CEE5B6F0B
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 6/9] nfsd: find_cpntf_state cleanup
Date:   Thu, 21 Jan 2021 13:49:52 -0500
Message-Id: <1611254995-23131-6-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611254995-23131-1-git-send-email-bfields@redhat.com>
References: <6D288689-85E5-4E3E-9117-B71FB45FFABB@oracle.com>
 <1611254995-23131-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

I think this unusual use of struct compound_state could cause confusion.

It's not that much more complicated just to open-code this stateid
lookup.

The only change in behavior should be a different error return in the
case the copy is using a source stateid that is a revoked delegation,
but I doubt that matters.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c74bf3b5b0de..db10fef1c1d2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5812,21 +5812,27 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 {
 	__be32 status;
 	struct nfs4_cpntf_state *cps = NULL;
-	struct nfsd4_compound_state cstate;
+	struct nfs4_client *found;
 
 	status = manage_cpntf_state(nn, st, NULL, &cps);
 	if (status)
 		return status;
 
 	cps->cpntf_time = ktime_get_boottime_seconds();
-	memset(&cstate, 0, sizeof(cstate));
-	status = set_client(&cps->cp_p_clid, &cstate, nn, true);
-	if (status)
+
+	status = nfserr_expired;
+	found = lookup_clientid(&cps->cp_p_clid, true, nn);
+	if (!found)
 		goto out;
-	status = nfsd4_lookup_stateid(&cstate, &cps->cp_p_stateid,
-				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
-				stid, nn);
-	put_client_renew(cstate.clp);
+
+	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
+			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
+	if (stid)
+		status = nfs_ok;
+	else
+		status = nfserr_bad_stateid;
+
+	put_client_renew(found);
 out:
 	nfs4_put_cpntf_state(nn, cps);
 	return status;
-- 
2.29.2

