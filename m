Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53435D29EA
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2019 14:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbfJJMrG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Oct 2019 08:47:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36160 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387870AbfJJMrG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Oct 2019 08:47:06 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so13353443iof.3
        for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2019 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yHxb1F+IidAyncg2OgE/R5pq9YN+bBi0hLf8UvbYCLg=;
        b=jS9sjpKETjY8/pi0X73QEQB7f5lbb1Gl6bb5a68eRAQie/rbC0fOHxvX2pHTXSrr6y
         7pC7VpuefJTXXGDuzn8jgxAD4/wZRiiKqUFQRK1s+TrFPC4RJr4tkBqN8xhrbKHNG67V
         ticmdQXnpSBQgz3rfWyE4cLyx9WivZZnOPoh5y13jvtpKcAr7HxJft/+8i0flfwvSf3g
         jZla+YZPodvHHlmr+5W2zwU2AP7Exr2f+uVkbyHXn3PqBCuyuv0toi/aPjdy2f33p8Mg
         IOuUmeTuSbDmO80kiEdGd08K9UPobsZ3HUykY5Gzr4j/LUbCp/CT+xxOkGYXJXEOZuBv
         I8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yHxb1F+IidAyncg2OgE/R5pq9YN+bBi0hLf8UvbYCLg=;
        b=fM+SK9SSnkoiuAqoVmDwhy8EHfznM7iiAd8gqIYyIRZobTZMuUeSYxahTuWXGkll5I
         +2FCR3PLXYILSW4yT7efD0NkuBh+I2X1q7e4df256EgzgByfFUf19xM+BQFlfIiV8uZk
         W87ebh+JM42APpUPw59Cl5gz4cFKu/0CZvFBItfgG3g8T+8KCQVTMTdTaBpNiENjNLcM
         w1Nrjhlp3g5uBaY4vnCKa8TAt/pUr7S67WmsLLTw0gcp6bGMc8kpDMkQ5za3zqfUVZUN
         UNu/18hvUcbju22NA83gFFECUAp9D8hACzNPq4d+kkQCCFXMAyvxGKY+amK3BUydABdo
         LZuQ==
X-Gm-Message-State: APjAAAU6y5PiEJdcClpOV9ZHIJ5Il6efhX9QlLsyNLadnA8AS4j+zPuS
        09yewef1FDTjnGtGCZh/Rho=
X-Google-Smtp-Source: APXvYqzmlO2caAFv3cj37GoPibb89FwqNkpyGW2iDztqWFVXW3GJrotPL9MiDFRN4PsWzYqmrR//tQ==
X-Received: by 2002:a05:6602:254a:: with SMTP id j10mr7597261ioe.43.1570711624240;
        Thu, 10 Oct 2019 05:47:04 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r2sm1100930ilm.17.2019.10.10.05.47.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Oct 2019 05:47:03 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 16/20] NFSD add COPY_NOTIFY operation
Date:   Thu, 10 Oct 2019 08:46:18 -0400
Message-Id: <20191010124622.27812-17-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
References: <20191010124622.27812-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introducing the COPY_NOTIFY operation.

Create a new unique stateid that will keep track of the copy
state and the upcoming READs that will use that stateid.
Each associated parent stateid has a list of copy
notify stateids. A copy notify structure makes a copy of
the parent stateid and a clientid and will use it to look
up the parent stateid during the READ request (suggested
by Trond Myklebust <trond.myklebust@hammerspace.com>).

At nfs4_put_stid() time, we walk the list of the associated
copy notify stateids and delete them.

Laundromat thread will traverse globally stored copy notify
stateid in idr and notice if any haven't been referenced in the
lease period, if so, it'll remove them.

Return single netaddr to advertise to the copy.

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Andy Adamson <andros@netapp.com>
---
 fs/nfsd/nfs4proc.c  |  58 +++++++++++++++++++++++-----
 fs/nfsd/nfs4state.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/state.h     |  31 +++++++++++++--
 fs/nfsd/xdr4.h      |   2 +-
 4 files changed, 173 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7fa694d..9400636 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -37,6 +37,7 @@
 #include <linux/falloc.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
+#include <linux/sunrpc/addr.h>
 
 #include "idmap.h"
 #include "cache.h"
@@ -776,7 +777,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	/* check stateid */
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					&read->rd_stateid, RD_STATE,
-					&read->rd_nf);
+					&read->rd_nf, NULL);
 	if (status) {
 		dprintk("NFSD: nfsd4_read: couldn't process stateid!\n");
 		goto out;
@@ -948,7 +949,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
 		status = nfs4_preprocess_stateid_op(rqstp, cstate,
 				&cstate->current_fh, &setattr->sa_stateid,
-				WR_STATE, NULL);
+				WR_STATE, NULL, NULL);
 		if (status) {
 			dprintk("NFSD: nfsd4_setattr: couldn't process stateid!\n");
 			return status;
@@ -999,7 +1000,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 	trace_nfsd_write_start(rqstp, &cstate->current_fh,
 			       write->wr_offset, cnt);
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-						stateid, WR_STATE, &nf);
+						stateid, WR_STATE, &nf, NULL);
 	if (status) {
 		dprintk("NFSD: nfsd4_write: couldn't process stateid!\n");
 		return status;
@@ -1034,14 +1035,14 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 		return nfserr_nofilehandle;
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->save_fh,
-					    src_stateid, RD_STATE, src);
+					    src_stateid, RD_STATE, src, NULL);
 	if (status) {
 		dprintk("NFSD: %s: couldn't process src stateid!\n", __func__);
 		goto out;
 	}
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
-					    dst_stateid, WR_STATE, dst);
+					    dst_stateid, WR_STATE, dst, NULL);
 	if (status) {
 		dprintk("NFSD: %s: couldn't process dst stateid!\n", __func__);
 		goto out_put_src;
@@ -1220,7 +1221,7 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 
 static void cleanup_async_copy(struct nfsd4_copy *copy)
 {
-	nfs4_free_cp_state(copy);
+	nfs4_free_copy_state(copy);
 	nfsd_file_put(copy->nf_dst);
 	nfsd_file_put(copy->nf_src);
 	spin_lock(&copy->cp_clp->async_lock);
@@ -1274,7 +1275,7 @@ static int nfsd4_do_async_copy(void *data)
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
 			goto out;
-		if (!nfs4_init_cp_state(nn, copy)) {
+		if (!nfs4_init_copy_state(nn, copy)) {
 			kfree(async_copy);
 			goto out;
 		}
@@ -1341,7 +1342,44 @@ struct nfsd4_copy *
 nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		  union nfsd4_op_u *u)
 {
-	return nfserr_notsupp;
+	struct nfsd4_copy_notify *cn = &u->copy_notify;
+	__be32 status;
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfs4_stid *stid;
+	struct nfs4_cpntf_state *cps;
+	struct nfs4_client *clp = cstate->clp;
+
+	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
+					&cn->cpn_src_stateid, RD_STATE, NULL,
+					&stid);
+	if (status)
+		return status;
+
+	cn->cpn_sec = nn->nfsd4_lease;
+	cn->cpn_nsec = 0;
+
+	status = nfserrno(-ENOMEM);
+	cps = nfs4_alloc_init_cpntf_state(nn, stid);
+	if (!cps)
+		goto out;
+	memcpy(&cn->cpn_cnr_stateid, &cps->cp_stateid.stid, sizeof(stateid_t));
+	memcpy(&cps->cp_p_stateid, &stid->sc_stateid, sizeof(stateid_t));
+	memcpy(&cps->cp_p_clid, &clp->cl_clientid, sizeof(clientid_t));
+
+	/* For now, only return one server address in cpn_src, the
+	 * address used by the client to connect to this server.
+	 */
+	cn->cpn_src.nl4_type = NL4_NETADDR;
+	status = nfsd4_set_netaddr((struct sockaddr *)&rqstp->rq_daddr,
+				 &cn->cpn_src.u.nl4_addr);
+	WARN_ON_ONCE(status);
+	if (status) {
+		nfs4_put_cpntf_state(nn, cps);
+		goto out;
+	}
+out:
+	nfs4_put_stid(stid);
+	return status;
 }
 
 static __be32
@@ -1353,7 +1391,7 @@ struct nfsd4_copy *
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &fallocate->falloc_stateid,
-					    WR_STATE, &nf);
+					    WR_STATE, &nf, NULL);
 	if (status != nfs_ok) {
 		dprintk("NFSD: nfsd4_fallocate: couldn't process stateid!\n");
 		return status;
@@ -1412,7 +1450,7 @@ struct nfsd4_copy *
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					    &seek->seek_stateid,
-					    RD_STATE, &nf);
+					    RD_STATE, &nf, NULL);
 	if (status) {
 		dprintk("NFSD: nfsd4_seek: couldn't process stateid!\n");
 		return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c65aeaa..b7859b6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -80,6 +80,7 @@
 static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
 static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
 void nfsd4_end_grace(struct nfsd_net *nn);
+static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
 
 /* Locking: */
 
@@ -722,6 +723,7 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
 	/* Will be incremented before return to client: */
 	refcount_set(&stid->sc_count, 1);
 	spin_lock_init(&stid->sc_lock);
+	INIT_LIST_HEAD(&stid->sc_cp_list);
 
 	/*
 	 * It shouldn't be a problem to reuse an opaque stateid value.
@@ -741,30 +743,76 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
 /*
  * Create a unique stateid_t to represent each COPY.
  */
-int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
+static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
+			      unsigned char sc_type)
 {
 	int new_id;
 
+	stid->stid.si_opaque.so_clid.cl_boot = nn->boot_time;
+	stid->stid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
+	stid->sc_type = sc_type;
+
 	idr_preload(GFP_KERNEL);
 	spin_lock(&nn->s2s_cp_lock);
-	new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, copy, 0, 0, GFP_NOWAIT);
+	new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, stid, 0, 0, GFP_NOWAIT);
+	stid->stid.si_opaque.so_id = new_id;
 	spin_unlock(&nn->s2s_cp_lock);
 	idr_preload_end();
 	if (new_id < 0)
 		return 0;
-	copy->cp_stateid.si_opaque.so_id = new_id;
-	copy->cp_stateid.si_opaque.so_clid.cl_boot = nn->boot_time;
-	copy->cp_stateid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
 	return 1;
 }
 
-void nfs4_free_cp_state(struct nfsd4_copy *copy)
+int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
+{
+	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID);
+}
+
+struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
+						     struct nfs4_stid *p_stid)
+{
+	struct nfs4_cpntf_state *cps;
+
+	cps = kzalloc(sizeof(struct nfs4_cpntf_state), GFP_KERNEL);
+	if (!cps)
+		return NULL;
+	cps->cpntf_time = get_seconds();
+	refcount_set(&cps->cp_stateid.sc_count, 1);
+	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
+		goto out_free;
+	spin_lock(&nn->s2s_cp_lock);
+	list_add(&cps->cp_list, &p_stid->sc_cp_list);
+	spin_unlock(&nn->s2s_cp_lock);
+	return cps;
+out_free:
+	kfree(cps);
+	return NULL;
+}
+
+void nfs4_free_copy_state(struct nfsd4_copy *copy)
 {
 	struct nfsd_net *nn;
 
+	WARN_ON_ONCE(copy->cp_stateid.sc_type != NFS4_COPY_STID);
 	nn = net_generic(copy->cp_clp->net, nfsd_net_id);
 	spin_lock(&nn->s2s_cp_lock);
-	idr_remove(&nn->s2s_cp_stateids, copy->cp_stateid.si_opaque.so_id);
+	idr_remove(&nn->s2s_cp_stateids,
+		   copy->cp_stateid.stid.si_opaque.so_id);
+	spin_unlock(&nn->s2s_cp_lock);
+}
+
+static void nfs4_free_cpntf_statelist(struct net *net, struct nfs4_stid *stid)
+{
+	struct nfs4_cpntf_state *cps;
+	struct nfsd_net *nn;
+
+	nn = net_generic(net, nfsd_net_id);
+	spin_lock(&nn->s2s_cp_lock);
+	while (!list_empty(&stid->sc_cp_list)) {
+		cps = list_first_entry(&stid->sc_cp_list,
+				       struct nfs4_cpntf_state, cp_list);
+		_free_cpntf_state_locked(nn, cps);
+	}
 	spin_unlock(&nn->s2s_cp_lock);
 }
 
@@ -915,6 +963,7 @@ static void block_delegations(struct knfsd_fh *fh)
 		return;
 	}
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
+	nfs4_free_cpntf_statelist(clp->net, s);
 	spin_unlock(&clp->cl_lock);
 	s->sc_free(s);
 	if (fp)
@@ -5210,6 +5259,9 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	struct list_head *pos, *next, reaplist;
 	time_t cutoff = get_seconds() - nn->nfsd4_lease;
 	time_t t, new_timeo = nn->nfsd4_lease;
+	struct nfs4_cpntf_state *cps;
+	copy_stateid_t *cps_t;
+	int i;
 
 	dprintk("NFSD: laundromat service - starting\n");
 
@@ -5220,6 +5272,17 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	dprintk("NFSD: end of grace period\n");
 	nfsd4_end_grace(nn);
 	INIT_LIST_HEAD(&reaplist);
+
+	spin_lock(&nn->s2s_cp_lock);
+	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
+		cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
+		if (cps->cp_stateid.sc_type == NFS4_COPYNOTIFY_STID &&
+				!time_after((unsigned long)cps->cpntf_time,
+				(unsigned long)cutoff))
+			_free_cpntf_state_locked(nn, cps);
+	}
+	spin_unlock(&nn->s2s_cp_lock);
+
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
@@ -5595,6 +5658,24 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 out:
 	return status;
 }
+static void
+_free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
+{
+	WARN_ON_ONCE(cps->cp_stateid.sc_type != NFS4_COPYNOTIFY_STID);
+	if (!refcount_dec_and_test(&cps->cp_stateid.sc_count))
+		return;
+	list_del(&cps->cp_list);
+	idr_remove(&nn->s2s_cp_stateids,
+		   cps->cp_stateid.stid.si_opaque.so_id);
+	kfree(cps);
+}
+
+void nfs4_put_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
+{
+	spin_lock(&nn->s2s_cp_lock);
+	_free_cpntf_state_locked(nn, cps);
+	spin_unlock(&nn->s2s_cp_lock);
+}
 
 /*
  * Checks for stateid operations
@@ -5602,7 +5683,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 __be32
 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
-		stateid_t *stateid, int flags, struct nfsd_file **nfp)
+		stateid_t *stateid, int flags, struct nfsd_file **nfp,
+		struct nfs4_stid **cstid)
 {
 	struct inode *ino = d_inode(fhp->fh_dentry);
 	struct net *net = SVC_NET(rqstp);
@@ -5651,8 +5733,12 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	if (status == nfs_ok && nfp)
 		status = nfs4_check_file(rqstp, fhp, s, nfp, flags);
 out:
-	if (s)
-		nfs4_put_stid(s);
+	if (s) {
+		if (!status && cstid)
+			*cstid = s;
+		else
+			nfs4_put_stid(s);
+	}
 	return status;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 46f56af..967b937 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -56,6 +56,14 @@
 	stateid_opaque_t        si_opaque;
 } stateid_t;
 
+typedef struct {
+	stateid_t		stid;
+#define NFS4_COPY_STID 1
+#define NFS4_COPYNOTIFY_STID 2
+	unsigned char		sc_type;
+	refcount_t		sc_count;
+} copy_stateid_t;
+
 #define STATEID_FMT	"(%08x/%08x/%08x/%08x)"
 #define STATEID_VAL(s) \
 	(s)->si_opaque.so_clid.cl_boot, \
@@ -96,6 +104,7 @@ struct nfs4_stid {
 #define NFS4_REVOKED_DELEG_STID 16
 #define NFS4_CLOSED_DELEG_STID 32
 #define NFS4_LAYOUT_STID 64
+	struct list_head	sc_cp_list;
 	unsigned char		sc_type;
 	stateid_t		sc_stateid;
 	spinlock_t		sc_lock;
@@ -104,6 +113,17 @@ struct nfs4_stid {
 	void			(*sc_free)(struct nfs4_stid *);
 };
 
+/* Keep a list of stateids issued by the COPY_NOTIFY, associate it with the
+ * parent OPEN/LOCK/DELEG stateid.
+ */
+struct nfs4_cpntf_state {
+	copy_stateid_t		cp_stateid;
+	struct list_head	cp_list;	/* per parent nfs4_stid */
+	stateid_t		cp_p_stateid;	/* copy of parent's stateid */
+	clientid_t		cp_p_clid;	/* copy of parent's clid */
+	time_t			cpntf_time;	/* last time stateid used */
+};
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -617,14 +637,17 @@ struct nfsd4_blocked_lock {
 
 extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, struct svc_fh *fhp,
-		stateid_t *stateid, int flags, struct nfsd_file **filp);
+		stateid_t *stateid, int flags, struct nfsd_file **filp,
+		struct nfs4_stid **cstid);
 __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		     stateid_t *stateid, unsigned char typemask,
 		     struct nfs4_stid **s, struct nfsd_net *nn);
 struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
 				  void (*sc_free)(struct nfs4_stid *));
-int nfs4_init_cp_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
-void nfs4_free_cp_state(struct nfsd4_copy *copy);
+int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
+void nfs4_free_copy_state(struct nfsd4_copy *copy);
+struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
+			struct nfs4_stid *p_stid);
 void nfs4_unhash_stid(struct nfs4_stid *s);
 void nfs4_put_stid(struct nfs4_stid *s);
 void nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid);
@@ -654,6 +677,8 @@ extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name
 extern void nfs4_put_copy(struct nfsd4_copy *copy);
 extern struct nfsd4_copy *
 find_async_copy(struct nfs4_client *clp, stateid_t *staetid);
+extern void nfs4_put_cpntf_state(struct nfsd_net *nn,
+				 struct nfs4_cpntf_state *cps);
 static inline void get_nfs4_file(struct nfs4_file *fi)
 {
 	refcount_inc(&fi->fi_ref);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 8231fe0..2937e06 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -542,7 +542,7 @@ struct nfsd4_copy {
 	struct nfsd_file        *nf_src;
 	struct nfsd_file        *nf_dst;
 
-	stateid_t		cp_stateid;
+	copy_stateid_t		cp_stateid;
 
 	struct list_head	copies;
 	struct task_struct	*copy_task;
-- 
1.8.3.1

