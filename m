Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E685E6937
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIVRKl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 13:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiIVRKk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 13:10:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1969F8EF
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 10:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA053B838AC
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 17:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADE5C433C1
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 17:10:36 +0000 (UTC)
Subject: [PATCH] NFSD: Rename the fields in copy_stateid_t
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 22 Sep 2022 13:10:35 -0400
Message-ID: <166386663545.30286.10148498990492494243.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Code maintenance: The name of the copy_stateid_t::sc_count field
collides with the sc_count field in struct nfs4_stid, making the
latter difficult to grep for when auditing stateid reference
counting.

No behavior change expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c  |    6 +++---
 fs/nfsd/nfs4state.c |   30 +++++++++++++++---------------
 fs/nfsd/state.h     |    6 +++---
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a72ab97f77ef..d913aa40d059 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1826,7 +1826,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (!nfs4_init_copy_state(nn, copy))
 			goto out_err;
 		refcount_set(&async_copy->refcount, 1);
-		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.stid,
+		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
 			sizeof(copy->cp_res.cb_stateid));
 		dup_copy_fields(copy, async_copy);
 		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
@@ -1862,7 +1862,7 @@ find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
 
 	spin_lock(&clp->async_lock);
 	list_for_each_entry(copy, &clp->async_copies, copies) {
-		if (memcmp(&copy->cp_stateid.stid, stateid, NFS4_STATEID_SIZE))
+		if (memcmp(&copy->cp_stateid.cs_stid, stateid, NFS4_STATEID_SIZE))
 			continue;
 		refcount_inc(&copy->refcount);
 		spin_unlock(&clp->async_lock);
@@ -1916,7 +1916,7 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	cps = nfs4_alloc_init_cpntf_state(nn, stid);
 	if (!cps)
 		goto out;
-	memcpy(&cn->cpn_cnr_stateid, &cps->cp_stateid.stid, sizeof(stateid_t));
+	memcpy(&cn->cpn_cnr_stateid, &cps->cp_stateid.cs_stid, sizeof(stateid_t));
 	memcpy(&cps->cp_p_stateid, &stid->sc_stateid, sizeof(stateid_t));
 	memcpy(&cps->cp_p_clid, &clp->cl_clientid, sizeof(clientid_t));
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c5d199d7e6b4..18fd7a23c7f3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -963,19 +963,19 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
  * Create a unique stateid_t to represent each COPY.
  */
 static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
-			      unsigned char sc_type)
+			      unsigned char cs_type)
 {
 	int new_id;
 
-	stid->stid.si_opaque.so_clid.cl_boot = (u32)nn->boot_time;
-	stid->stid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
-	stid->sc_type = sc_type;
+	stid->cs_stid.si_opaque.so_clid.cl_boot = (u32)nn->boot_time;
+	stid->cs_stid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
+	stid->cs_type = cs_type;
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&nn->s2s_cp_lock);
 	new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, stid, 0, 0, GFP_NOWAIT);
-	stid->stid.si_opaque.so_id = new_id;
-	stid->stid.si_generation = 1;
+	stid->cs_stid.si_opaque.so_id = new_id;
+	stid->cs_stid.si_generation = 1;
 	spin_unlock(&nn->s2s_cp_lock);
 	idr_preload_end();
 	if (new_id < 0)
@@ -997,7 +997,7 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 	if (!cps)
 		return NULL;
 	cps->cpntf_time = ktime_get_boottime_seconds();
-	refcount_set(&cps->cp_stateid.sc_count, 1);
+	refcount_set(&cps->cp_stateid.cs_count, 1);
 	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
 		goto out_free;
 	spin_lock(&nn->s2s_cp_lock);
@@ -1013,11 +1013,11 @@ void nfs4_free_copy_state(struct nfsd4_copy *copy)
 {
 	struct nfsd_net *nn;
 
-	WARN_ON_ONCE(copy->cp_stateid.sc_type != NFS4_COPY_STID);
+	WARN_ON_ONCE(copy->cp_stateid.cs_type != NFS4_COPY_STID);
 	nn = net_generic(copy->cp_clp->net, nfsd_net_id);
 	spin_lock(&nn->s2s_cp_lock);
 	idr_remove(&nn->s2s_cp_stateids,
-		   copy->cp_stateid.stid.si_opaque.so_id);
+		   copy->cp_stateid.cs_stid.si_opaque.so_id);
 	spin_unlock(&nn->s2s_cp_lock);
 }
 
@@ -5920,7 +5920,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_lock(&nn->s2s_cp_lock);
 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
 		cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
-		if (cps->cp_stateid.sc_type == NFS4_COPYNOTIFY_STID &&
+		if (cps->cp_stateid.cs_type == NFS4_COPYNOTIFY_STID &&
 				state_expired(&lt, cps->cpntf_time))
 			_free_cpntf_state_locked(nn, cps);
 	}
@@ -6244,12 +6244,12 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 static void
 _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
 {
-	WARN_ON_ONCE(cps->cp_stateid.sc_type != NFS4_COPYNOTIFY_STID);
-	if (!refcount_dec_and_test(&cps->cp_stateid.sc_count))
+	WARN_ON_ONCE(cps->cp_stateid.cs_type != NFS4_COPYNOTIFY_STID);
+	if (!refcount_dec_and_test(&cps->cp_stateid.cs_count))
 		return;
 	list_del(&cps->cp_list);
 	idr_remove(&nn->s2s_cp_stateids,
-		   cps->cp_stateid.stid.si_opaque.so_id);
+		   cps->cp_stateid.cs_stid.si_opaque.so_id);
 	kfree(cps);
 }
 /*
@@ -6271,12 +6271,12 @@ __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 	if (cps_t) {
 		state = container_of(cps_t, struct nfs4_cpntf_state,
 				     cp_stateid);
-		if (state->cp_stateid.sc_type != NFS4_COPYNOTIFY_STID) {
+		if (state->cp_stateid.cs_type != NFS4_COPYNOTIFY_STID) {
 			state = NULL;
 			goto unlock;
 		}
 		if (!clp)
-			refcount_inc(&state->cp_stateid.sc_count);
+			refcount_inc(&state->cp_stateid.cs_count);
 		else
 			_free_cpntf_state_locked(nn, state);
 	}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ae596dbf8667..89032b90af34 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -57,11 +57,11 @@ typedef struct {
 } stateid_t;
 
 typedef struct {
-	stateid_t		stid;
+	stateid_t		cs_stid;
 #define NFS4_COPY_STID 1
 #define NFS4_COPYNOTIFY_STID 2
-	unsigned char		sc_type;
-	refcount_t		sc_count;
+	unsigned char		cs_type;
+	refcount_t		cs_count;
 } copy_stateid_t;
 
 struct nfsd4_callback {


