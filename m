Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68D0B42CD
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 23:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391726AbfIPVON (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 17:14:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35921 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391714AbfIPVON (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 17:14:13 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so2526206iof.3
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fo4Jqs/usI+OFiQc9c0IKLBn6AoUCJ8bT53gbW7MXbI=;
        b=YkJ7lawx5GiTvmq4FJZZ4XmPDxnmwNC8O57rQDfTQxYFwx2LC+aYcjTqTdyBXH+TXB
         3Tq6nrW7T8jwEMtRoN34W6MVhVRgchGqKDl1ye3zhS8Q2Z3DdUP1icn4OQHqEU0YAJ5k
         G6gYTnF15wtjXepMJ/vgJrxz9menj/uC8ipkFyDoSlDBoWRZpTHYvt5Up+Yin8jt5DnY
         5y2kudKrvS59ub7nf9yaovcWWCPwn+qnK7UMmcMDWXmrZ26s04yaVN8jkPL4IjizsE+y
         RZTGP5GxU6ZhUEo+pSrRjs5aPGL0nuAKXba329fr8pP9MR8dwMQY9FOOI+9vD5Kt5cIJ
         GmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fo4Jqs/usI+OFiQc9c0IKLBn6AoUCJ8bT53gbW7MXbI=;
        b=KU0mgdC9sJXuBCN1TdlaiCAUI0FEoNeIRleM296ZMzDRSuL0brkhu7t97VNYayk8g0
         0Lg0fZFUM7q3AJWBJKK9kVSmRnSmBWMjOf1brXxxJCelN4XJO1mZ0USsFPCRqhSCNima
         GH/d5tugFGxMTzpSYVN5zaMg+KzeEmPKAf0DHqOg6+dqjTcIP+h1ndcOfU4noiSyjSaw
         N9EHF9JlKUJf4B5uG55GEnrClqF7IATWCy+N+1FKVU4vFGzFVnyas7ujBPwpCmFbw6t3
         mCaFt0CeQZukswLVKgFGdCGtq8qSKSeLVXy5qWFTKWyAi7ReT6rGHEBAaHKZF9L3AkHd
         3UEw==
X-Gm-Message-State: APjAAAWPWrwsMjGirj3ZqObMMDktchDQfoV1GVEhExrb7Il0mlceN5zV
        WsKr47aI+7gnVoKUJYcJacM=
X-Google-Smtp-Source: APXvYqyBnTUcvdBbP694EvKygKQ3FPy7uiSYXM4Ia58xzu5HZeRY4bR8rENsomxFZXzr6XRLM+BCKg==
X-Received: by 2002:a5e:9911:: with SMTP id t17mr329498ioj.283.1568668450336;
        Mon, 16 Sep 2019 14:14:10 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id l186sm71853ioa.54.2019.09.16.14.14.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 14:14:09 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 15/19] NFSD add COPY_NOTIFY operation
Date:   Mon, 16 Sep 2019 17:13:49 -0400
Message-Id: <20190916211353.18802-16-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
References: <20190916211353.18802-1-olga.kornievskaia@gmail.com>
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
 fs/nfsd/nfs4proc.c  |  44 ++++++++++++++++++--
 fs/nfsd/nfs4state.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/state.h     |  28 ++++++++++++-
 fs/nfsd/xdr4.h      |   2 +-
 4 files changed, 178 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 05519a2..75ecdbd 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -37,6 +37,7 @@
 #include <linux/falloc.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
+#include <linux/sunrpc/addr.h>
 
 #include "idmap.h"
 #include "cache.h"
@@ -1221,7 +1222,7 @@ static void dup_copy_fields(struct nfsd4_copy *src, struct nfsd4_copy *dst)
 
 static void cleanup_async_copy(struct nfsd4_copy *copy)
 {
-	nfs4_free_cp_state(copy);
+	nfs4_free_copy_state(copy);
 	nfsd_file_put(copy->nf_dst);
 	nfsd_file_put(copy->nf_src);
 	spin_lock(&copy->cp_clp->async_lock);
@@ -1275,7 +1276,7 @@ static int nfsd4_do_async_copy(void *data)
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
 			goto out;
-		if (!nfs4_init_cp_state(nn, copy)) {
+		if (!nfs4_init_copy_state(nn, copy)) {
 			kfree(async_copy);
 			goto out;
 		}
@@ -1342,7 +1343,44 @@ struct nfsd4_copy *
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
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 78e03af..857133f 100644
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
@@ -2906,6 +2955,26 @@ static bool client_has_openowners(struct nfs4_client *clp)
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
@@ -2914,7 +2983,8 @@ static bool client_has_state(struct nfs4_client *clp)
 #endif
 		|| !list_empty(&clp->cl_delegations)
 		|| !list_empty(&clp->cl_sessions)
-		|| !list_empty(&clp->async_copies);
+		|| !list_empty(&clp->async_copies)
+		|| client_has_copy_notifies(clp);
 }
 
 static __be32 copy_impl_id(struct nfs4_client *clp,
@@ -5192,6 +5262,9 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	struct list_head *pos, *next, reaplist;
 	time_t cutoff = get_seconds() - nn->nfsd4_lease;
 	time_t t, new_timeo = nn->nfsd4_lease;
+	struct nfs4_cpntf_state *cps;
+	copy_stateid_t *cps_t;
+	int i;
 
 	dprintk("NFSD: laundromat service - starting\n");
 
@@ -5202,6 +5275,17 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
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
@@ -5577,6 +5661,24 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
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
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d9e7cbd..967b937 100644
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
@@ -624,8 +644,10 @@ __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
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
@@ -655,6 +677,8 @@ extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name
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

