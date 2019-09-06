Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB40AC33C
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393169AbfIFXgb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38466 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393113AbfIFXgb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:31 -0400
Received: by mail-io1-f66.google.com with SMTP id p12so16623006iog.5
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NcjqHzC2Uko5xYGnvnj+RHGcQ+rQaSo0iCRWmFV/Rzs=;
        b=GyyNm6QiBLcFbDrprBZ+tr6bopWBLPa9fjUNXFH4eBGSlqz48oqBftvYVBpLLCW0C4
         HPro4tcmALuggXk8OG6ejG3Ym9B3hlBtoXTvuhFRqxmwjM3m0C2aCAh5fE6rEaZFHblO
         /bPe6l5N+IBQfpCFgqsefNOF8Q+56hjBWo7LwpZoLmETBwXlDbnxymlMH2osNcFUUVsd
         0654aZLBW1yqKFu+X1ywGBJWWngpYMhp/bjX/tcXFIAZf68WJ7a/YfWr73Ij8vtKKeXM
         m3FDMXmce7idOFV5IEjA78/ST4wvBiVXkVeMBavkzMXyUjErC0+eHbevYqIAjjKdS6qR
         DnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NcjqHzC2Uko5xYGnvnj+RHGcQ+rQaSo0iCRWmFV/Rzs=;
        b=i1eo5TRRCWw7MyEGR7wj6aD1sT1RG6Vy0kJhq4RU4b4m5il6ZApFQZKMCaH57vRr59
         3LALJW6cu5muKFW2uyDXnAazL1rJUVmRPJdp4HnQeiaDLnCGh0ELM31jUpFFC5aOJh4u
         jUqnCwHp8u15sXz5ITvFA3/NFq5WFpwPGGhOip5hQ3ScTcsg90wn9QuGx/XYetD412I/
         31F9F8xikJVl15Id9fJY814yrB1868QbWdqQpttiYL8NeKACzSXnkrknuj8FL4oi9JjS
         dHpknTe6NMAN2UO1zHhHb9GGb4uuNk15/i6NiFOAfDkMxga8CvaFODnJl13Ld9T81e92
         k6Ng==
X-Gm-Message-State: APjAAAWd0YpaUhik7QqkBStD4ZLwpl9IQcU46jSGf18/PJE+/7YLr/Q4
        BtmzlVJOoZYU2ZCKYFet9rprViBo5Eo=
X-Google-Smtp-Source: APXvYqznvuJATV/4lww9cirmIB4ugyqZ7R8/tavyNwliMsSb/ffqK3MpGpf3/iKvn8oXxuJ59PaYsA==
X-Received: by 2002:a6b:e903:: with SMTP id u3mr2163007iof.241.1567812990057;
        Fri, 06 Sep 2019 16:36:30 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:29 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 17/21] NFSD add COPY_NOTIFY operation
Date:   Fri,  6 Sep 2019 19:36:07 -0400
Message-Id: <20190906233611.4031-18-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
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
 fs/nfsd/nfs4proc.c  |  44 +++++++++++++++--
 fs/nfsd/nfs4state.c | 118 +++++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/state.h     |  28 ++++++++++-
 fs/nfsd/xdr4.h      |   2 +-
 4 files changed, 178 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3a2805d4cb90..e220c43bbc25 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -37,6 +37,7 @@
 #include <linux/falloc.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
+#include <linux/sunrpc/addr.h>
 
 #include "idmap.h"
 #include "cache.h"
@@ -1229,7 +1230,7 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 
 static void cleanup_async_copy(struct nfsd4_copy *copy)
 {
-	nfs4_free_cp_state(copy);
+	nfs4_free_copy_state(copy);
 	fput(copy->file_dst);
 	fput(copy->file_src);
 	spin_lock(&copy->cp_clp->async_lock);
@@ -1283,7 +1284,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
 			goto out;
-		if (!nfs4_init_cp_state(nn, copy)) {
+		if (!nfs4_init_copy_state(nn, copy)) {
 			kfree(async_copy);
 			goto out;
 		}
@@ -1350,7 +1351,44 @@ static __be32
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
+					NULL, &stid);
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
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 78926c6b2b49..a6405c7e48ad 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -79,6 +79,7 @@ static u64 current_sessionid = 1;
 static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
 static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
 void nfsd4_end_grace(struct nfsd_net *nn);
+static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
 
 /* Locking: */
 
@@ -720,6 +721,7 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
 	/* Will be incremented before return to client: */
 	refcount_set(&stid->sc_count, 1);
 	spin_lock_init(&stid->sc_lock);
+	INIT_LIST_HEAD(&stid->sc_cp_list);
 
 	/*
 	 * It shouldn't be a problem to reuse an opaque stateid value.
@@ -739,30 +741,76 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
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
 
@@ -913,6 +961,7 @@ nfs4_put_stid(struct nfs4_stid *s)
 		return;
 	}
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
+	nfs4_free_cpntf_statelist(clp->net, s);
 	spin_unlock(&clp->cl_lock);
 	s->sc_free(s);
 	if (fp)
@@ -2901,6 +2950,26 @@ static bool client_has_openowners(struct nfs4_client *clp)
 	return false;
 }
 
+static bool client_has_copy_notifies(struct nfs4_client *clp)
+{
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	copy_stateid_t *cps_t;
+	struct nfs4_cpntf_state *cps;
+	int i;
+
+	spin_lock(&nn->s2s_cp_lock);
+	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
+		cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
+		if (cps->cp_stateid.sc_type == NFS4_COPYNOTIFY_STID &&
+				same_clid(&cps->cp_p_clid, &clp->cl_clientid)) {
+			spin_unlock(&nn->s2s_cp_lock);
+			return true;
+		}
+	}
+	spin_unlock(&nn->s2s_cp_lock);
+	return false;
+}
+
 static bool client_has_state(struct nfs4_client *clp)
 {
 	return client_has_openowners(clp)
@@ -2909,7 +2978,8 @@ static bool client_has_state(struct nfs4_client *clp)
 #endif
 		|| !list_empty(&clp->cl_delegations)
 		|| !list_empty(&clp->cl_sessions)
-		|| !list_empty(&clp->async_copies);
+		|| !list_empty(&clp->async_copies)
+		|| client_has_copy_notifies(clp);
 }
 
 static __be32 copy_impl_id(struct nfs4_client *clp,
@@ -5187,6 +5257,9 @@ nfs4_laundromat(struct nfsd_net *nn)
 	struct list_head *pos, *next, reaplist;
 	time_t cutoff = get_seconds() - nn->nfsd4_lease;
 	time_t t, new_timeo = nn->nfsd4_lease;
+	struct nfs4_cpntf_state *cps;
+	copy_stateid_t *cps_t;
+	int i;
 
 	dprintk("NFSD: laundromat service - starting\n");
 
@@ -5197,6 +5270,17 @@ nfs4_laundromat(struct nfsd_net *nn)
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
@@ -5576,6 +5660,24 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 
 	return 0;
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
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 25c7a45c8e78..127c929039a9 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -56,6 +56,14 @@ typedef struct {
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
@@ -623,8 +643,10 @@ __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
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
@@ -654,6 +676,8 @@ void put_nfs4_file(struct nfs4_file *fi);
 extern void nfs4_put_copy(struct nfsd4_copy *copy);
 extern struct nfsd4_copy *
 find_async_copy(struct nfs4_client *clp, stateid_t *staetid);
+extern void nfs4_put_cpntf_state(struct nfsd_net *nn,
+				 struct nfs4_cpntf_state *cps);
 static inline void get_nfs4_file(struct nfs4_file *fi)
 {
 	refcount_inc(&fi->fi_ref);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c49703258cae..c6c8b4337cfa 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -543,7 +543,7 @@ struct nfsd4_copy {
 	struct file             *file_src;
 	struct file             *file_dst;
 
-	stateid_t		cp_stateid;
+	copy_stateid_t		cp_stateid;
 
 	struct list_head	copies;
 	struct task_struct	*copy_task;
-- 
2.18.1

