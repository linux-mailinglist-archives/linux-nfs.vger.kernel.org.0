Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6FD32A953
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Mar 2021 19:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580759AbhCBSUH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Mar 2021 13:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351209AbhCBPr1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Mar 2021 10:47:27 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD53C061788
        for <linux-nfs@vger.kernel.org>; Tue,  2 Mar 2021 07:46:25 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9E05225FE; Tue,  2 Mar 2021 10:46:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9E05225FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614699983;
        bh=B8icvTjftwk345gCsOe2lYsRmIv8YIEm+x2a3ISqNtg=;
        h=Date:From:To:Cc:Subject:From;
        b=0TwZUJFB9lPgSm06EFOCZhGyr3BVorHh0AUromUXWCdqi2im0QR+l4d4O5IfKEAhb
         QMPcwDnXOFPxnyLxWOvBYbyQCOCnq2DqHEeJib8kcvhx8nh4yJFX368c8pqudHayiO
         d+TmWTdiWuKJP2MYZODRy67/A3FOojGRz3l41pF8=
Date:   Tue, 2 Mar 2021 10:46:23 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsd: helper for laundromat expiry calculations
Message-ID: <20210302154623.GA2263@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

We do this same logic repeatedly, and it's easy to get the sense of the
comparison wrong.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 49 +++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

My original version of this patch... actually got the sense of the
comparison wrong!

Now actually tested.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 61552e89bd89..8e6938902b49 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5363,6 +5363,22 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	return true;
 }
 
+struct laundry_time {
+	time64_t cutoff;
+	time64_t new_timeo;
+};
+
+bool state_expired(struct laundry_time *lt, time64_t last_refresh)
+{
+	time64_t time_remaining;
+
+	if (last_refresh < lt->cutoff)
+		return true;
+	time_remaining = last_refresh - lt->cutoff;
+	lt->new_timeo = min(lt->new_timeo, time_remaining);
+	return false;
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -5372,14 +5388,16 @@ nfs4_laundromat(struct nfsd_net *nn)
 	struct nfs4_ol_stateid *stp;
 	struct nfsd4_blocked_lock *nbl;
 	struct list_head *pos, *next, reaplist;
-	time64_t cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease;
-	time64_t t, new_timeo = nn->nfsd4_lease;
+	struct laundry_time lt = {
+		.cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease,
+		.new_timeo = nn->nfsd4_lease
+	};
 	struct nfs4_cpntf_state *cps;
 	copy_stateid_t *cps_t;
 	int i;
 
 	if (clients_still_reclaiming(nn)) {
-		new_timeo = 0;
+		lt.new_timeo = 0;
 		goto out;
 	}
 	nfsd4_end_grace(nn);
@@ -5389,7 +5407,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
 		cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
 		if (cps->cp_stateid.sc_type == NFS4_COPYNOTIFY_STID &&
-				cps->cpntf_time < cutoff)
+				state_expired(&lt, cps->cpntf_time))
 			_free_cpntf_state_locked(nn, cps);
 	}
 	spin_unlock(&nn->s2s_cp_lock);
@@ -5397,11 +5415,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		if (clp->cl_time > cutoff) {
-			t = clp->cl_time - cutoff;
-			new_timeo = min(new_timeo, t);
+		if (!state_expired(&lt, clp->cl_time))
 			break;
-		}
 		if (mark_client_expired_locked(clp)) {
 			trace_nfsd_clid_expired(&clp->cl_clientid);
 			continue;
@@ -5418,11 +5433,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		if (dp->dl_time > cutoff) {
-			t = dp->dl_time - cutoff;
-			new_timeo = min(new_timeo, t);
+		if (!state_expired(&lt, dp->dl_time))
 			break;
-		}
 		WARN_ON(!unhash_delegation_locked(dp));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
@@ -5438,11 +5450,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	while (!list_empty(&nn->close_lru)) {
 		oo = list_first_entry(&nn->close_lru, struct nfs4_openowner,
 					oo_close_lru);
-		if (oo->oo_time > cutoff) {
-			t = oo->oo_time - cutoff;
-			new_timeo = min(new_timeo, t);
+		if (!state_expired(&lt, oo->oo_time))
 			break;
-		}
 		list_del_init(&oo->oo_close_lru);
 		stp = oo->oo_last_closed_stid;
 		oo->oo_last_closed_stid = NULL;
@@ -5468,11 +5477,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	while (!list_empty(&nn->blocked_locks_lru)) {
 		nbl = list_first_entry(&nn->blocked_locks_lru,
 					struct nfsd4_blocked_lock, nbl_lru);
-		if (nbl->nbl_time > cutoff) {
-			t = nbl->nbl_time - cutoff;
-			new_timeo = min(new_timeo, t);
+		if (!state_expired(&lt, nbl->nbl_time))
 			break;
-		}
 		list_move(&nbl->nbl_lru, &reaplist);
 		list_del_init(&nbl->nbl_list);
 	}
@@ -5485,8 +5491,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		free_blocked_lock(nbl);
 	}
 out:
-	new_timeo = max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
-	return new_timeo;
+	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 }
 
 static struct workqueue_struct *laundry_wq;
-- 
2.29.2

