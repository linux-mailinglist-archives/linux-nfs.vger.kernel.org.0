Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338272FF4B7
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 20:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbhAUThd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 14:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbhAUSu7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 13:50:59 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3C4C061797
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 10:49:59 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A22286EF5; Thu, 21 Jan 2021 13:49:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A22286EF5
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4/9] nfsd: rename lookup_clientid->set_client
Date:   Thu, 21 Jan 2021 13:49:50 -0500
Message-Id: <1611254995-23131-4-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611254995-23131-1-git-send-email-bfields@redhat.com>
References: <6D288689-85E5-4E3E-9117-B71FB45FFABB@oracle.com>
 <1611254995-23131-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

I think this is a better name, and I'm going to reuse elsewhere the code
that does the lookup itself.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ba955bbf21df..4bdd90074e24 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4633,7 +4633,7 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
 	return nfserr_bad_seqid;
 }
 
-static __be32 lookup_clientid(clientid_t *clid,
+static __be32 set_client(clientid_t *clid,
 		struct nfsd4_compound_state *cstate,
 		struct nfsd_net *nn,
 		bool sessions)
@@ -4688,7 +4688,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	if (open->op_file == NULL)
 		return nfserr_jukebox;
 
-	status = lookup_clientid(clientid, cstate, nn, false);
+	status = set_client(clientid, cstate, nn, false);
 	if (status)
 		return status;
 	clp = cstate->clp;
@@ -5298,7 +5298,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 	trace_nfsd_clid_renew(clid);
-	status = lookup_clientid(clid, cstate, nn, false);
+	status = set_client(clid, cstate, nn, false);
 	if (status)
 		return status;
 	clp = cstate->clp;
@@ -5681,8 +5681,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
-	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn,
-				 false);
+	status = set_client(&stateid->si_opaque.so_clid, cstate, nn, false);
 	if (status == nfserr_stale_clientid) {
 		if (cstate->session)
 			return nfserr_bad_stateid;
@@ -5821,7 +5820,7 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 
 	cps->cpntf_time = ktime_get_boottime_seconds();
 	memset(&cstate, 0, sizeof(cstate));
-	status = lookup_clientid(&cps->cp_p_clid, &cstate, nn, true);
+	status = set_client(&cps->cp_p_clid, &cstate, nn, true);
 	if (status)
 		goto out;
 	status = nfsd4_lookup_stateid(&cstate, &cps->cp_p_stateid,
@@ -6900,8 +6899,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		 return nfserr_inval;
 
 	if (!nfsd4_has_session(cstate)) {
-		status = lookup_clientid(&lockt->lt_clientid, cstate, nn,
-					 false);
+		status = set_client(&lockt->lt_clientid, cstate, nn, false);
 		if (status)
 			goto out;
 	}
@@ -7085,7 +7083,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
 		clid->cl_boot, clid->cl_id);
 
-	status = lookup_clientid(clid, cstate, nn, false);
+	status = set_client(clid, cstate, nn, false);
 	if (status)
 		return status;
 
@@ -7232,7 +7230,7 @@ nfs4_check_open_reclaim(clientid_t *clid,
 	__be32 status;
 
 	/* find clientid in conf_id_hashtbl */
-	status = lookup_clientid(clid, cstate, nn, false);
+	status = set_client(clid, cstate, nn, false);
 	if (status)
 		return nfserr_reclaim_bad;
 
-- 
2.29.2

