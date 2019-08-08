Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B17686B47
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2019 22:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404697AbfHHUS5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Aug 2019 16:18:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40493 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404603AbfHHUS4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Aug 2019 16:18:56 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so66578936oth.7
        for <linux-nfs@vger.kernel.org>; Thu, 08 Aug 2019 13:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KreaLqx23GqvpRXtJEghnKBS2r0dJwDr/YXFcM5H9i4=;
        b=PSZwbd+kWBZ/LG7cvbDQlh6UXaQ/3TtI0mIOZ5a3owOH0GCbWF0QtMkBtxM4J046/h
         v9Eibv8ztff6h5gbrIhtSWFUsz1fAqrxS/VlKBMscX1xKnINoaWDxh43HGQmAbk9D6Ij
         qy+KQO9bDwx0ZIme990pPxJfmiZXNlsF0LCoIyrjHrgmu5pBVWqSQsu9UVHNxgWyq1vw
         eE8CGnG2F+iv3nbQ1wyT26iPCSEq79c1iFsiBxnZ+6awS/s3YZv5llFu1OfHPUbxdl4W
         uajtBsjk2ocl5lqPAd4aZsrXz5jfKMyU2GUlrf5s4m+7+SSQjLl/JZUx2ONUJhikumjm
         Nq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KreaLqx23GqvpRXtJEghnKBS2r0dJwDr/YXFcM5H9i4=;
        b=LZP3bdd75zIvINJ5408OOUjNRe3rEZYE8x6cQF7QfTs+9xlVfeM01l8TDUZQ4ylFqF
         Ghs2rghHyVUyn7crMZBuAXwY9du73p5xS28kYtflLXTyWHmhmeNy9eEw0nvJHXpRygqJ
         k5b2L8Ky7MasRn6vHyy/idLUfk/aqEiAcS0rNko4s1G5bL66NZz/KDbSHk6lx9zEjrTa
         E3W+5eLe9dtY1axEXPesImXkfP8+VPFGNaJMnjaJg7zY6l933d0JqOTo81JrMA9bXiEr
         fWU6TTpRK8BaqLwQgihyDu1f3iZdmILEWcO1SJH/Vmr9ulnjYhjkDNSNAhs0Ig+sKcmi
         s0ag==
X-Gm-Message-State: APjAAAXWS4LXLWZ3g1mSmoTaXUqFa+YJ/0hAHWJDXO+mXrDsKPZtRJdH
        LAm1SkTReV951yeeLCKUFEdsz9vC
X-Google-Smtp-Source: APXvYqy2crHb3nFvdMBIeuF8sfMElZO39cT694tjUVS1o5PcdiIDn2W+7KwkmbMtvVV8sj0pxhicPQ==
X-Received: by 2002:a02:37c6:: with SMTP id r189mr7369627jar.118.1565295535518;
        Thu, 08 Aug 2019 13:18:55 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id m20sm93590523ioh.4.2019.08.08.13.18.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 13:18:55 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 5/9] NFSD add COPY_NOTIFY operation
Date:   Thu,  8 Aug 2019 16:18:44 -0400
Message-Id: <20190808201848.36640-6-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introducing the COPY_NOTIFY operation.

Create a new unique stateid that will keep track of the copy
state and the upcoming READs that will use that stateid. Keep
it in the list associated with parent stateid. When putting
a reference on a stateid, check if there are associated copy
notify stateids, if so, account for it and remove them on
last reference.

Laundromat thread will traverse globally stored copy notify
stateid and notice if any haven't been referenced in the
lease period, if so, it'll remove them.

Return single netaddr to advertise to the copy.

Signed-off-by: Andy Adamson <andros@netapp.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c  |  47 ++++++++++++++++++--
 fs/nfsd/nfs4state.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/state.h     |  30 ++++++++++++-
 fs/nfsd/xdr4.h      |   2 +-
 4 files changed, 182 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3a2805d..47f6b52 100644
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
@@ -1283,7 +1284,7 @@ static int nfsd4_do_async_copy(void *data)
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
 			goto out;
-		if (!nfs4_init_cp_state(nn, copy)) {
+		if (!nfs4_init_copy_state(nn, copy)) {
 			kfree(async_copy);
 			goto out;
 		}
@@ -1350,7 +1351,47 @@ struct nfsd4_copy *
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
+		goto out_err;
+	memcpy(&cn->cpn_cnr_stateid, &cps->cp_stateid.stid, sizeof(stateid_t));
+
+	/* For now, only return one server address in cpn_src, the
+	 * address used by the client to connect to this server.
+	 */
+	cn->cpn_src.nl4_type = NL4_NETADDR;
+	status = nfsd4_set_netaddr((struct sockaddr *)&rqstp->rq_daddr,
+				 &cn->cpn_src.u.nl4_addr);
+	WARN_ON_ONCE(status);
+	if (status) {
+		free_cpntf_state(nn, cps);
+		goto out;
+	}
+	spin_lock(&clp->cpntf_lock);
+	list_add(&cps->cpntf, &clp->copy_notifies);
+	spin_unlock(&clp->cpntf_lock);
+out:
+	return status;
+out_err:
+	nfs4_put_stid(stid);
+	goto out;
 }
 
 static __be32
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 78926c6..bd962f1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -720,6 +720,7 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
 	/* Will be incremented before return to client: */
 	refcount_set(&stid->sc_count, 1);
 	spin_lock_init(&stid->sc_lock);
+	INIT_LIST_HEAD(&stid->sc_cp_list);
 
 	/*
 	 * It shouldn't be a problem to reuse an opaque stateid value.
@@ -739,33 +740,89 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
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
 {
-	struct nfsd_net *nn;
+	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID);
+}
 
-	nn = net_generic(copy->cp_clp->net, nfsd_net_id);
+struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
+						     struct nfs4_stid *p_stid)
+{
+	struct nfs4_cpntf_state *cps;
+
+	cps = kzalloc(sizeof(struct nfs4_cpntf_state), GFP_KERNEL);
+	if (!cps)
+		return NULL;
+	cps->cp_p_stid = p_stid;
+	cps->cpntf_time = get_seconds();
+	cps->net = nn;
+	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
+		goto out_free;
+	spin_lock(&p_stid->sc_lock);
+	list_add(&cps->cp_list, &p_stid->sc_cp_list);
+	p_stid->sc_cp_list_size++;
+	spin_unlock(&p_stid->sc_lock);
+	return cps;
+out_free:
+	kfree(cps);
+	return NULL;
+}
+void _free_copy_cpntf_stateid(struct nfsd_net *nn, stateid_t *stid)
+{
 	spin_lock(&nn->s2s_cp_lock);
-	idr_remove(&nn->s2s_cp_stateids, copy->cp_stateid.si_opaque.so_id);
+	idr_remove(&nn->s2s_cp_stateids, stid->si_opaque.so_id);
 	spin_unlock(&nn->s2s_cp_lock);
 }
 
+void nfs4_free_copy_state(struct nfsd4_copy *copy)
+{
+	struct nfsd_net *nn;
+
+	nn = net_generic(copy->cp_clp->net, nfsd_net_id);
+	_free_copy_cpntf_stateid(nn, &copy->cp_stateid.stid);
+}
+
+static void nfs4_free_cpntf_statelist(struct net *net, struct nfs4_stid *stid)
+{
+	struct nfs4_cpntf_state *cps;
+	struct nfsd_net *nn;
+
+	nn = net_generic(net, nfsd_net_id);
+	spin_lock(&stid->sc_lock);
+	while (!list_empty(&stid->sc_cp_list)) {
+		cps = list_first_entry(&stid->sc_cp_list,
+				       struct nfs4_cpntf_state, cp_list);
+		stid->sc_cp_list_size--;
+		list_del(&cps->cp_list);
+		_free_copy_cpntf_stateid(nn, &cps->cp_stateid.stid);
+		spin_lock(&stid->sc_client->cpntf_lock);
+		list_del(&cps->cpntf);
+		spin_unlock(&stid->sc_client->cpntf_lock);
+		kfree(cps);
+	}
+	spin_unlock(&stid->sc_lock);
+}
+
 static struct nfs4_ol_stateid * nfs4_alloc_open_stateid(struct nfs4_client *clp)
 {
 	struct nfs4_stid *stid;
@@ -905,15 +962,25 @@ static void block_delegations(struct knfsd_fh *fh)
 {
 	struct nfs4_file *fp = s->sc_file;
 	struct nfs4_client *clp = s->sc_client;
+	size_t size = 0;
+
+	spin_lock(&s->sc_lock);
+	size = s->sc_cp_list_size;
+	spin_unlock(&s->sc_lock);
 
 	might_lock(&clp->cl_lock);
 
 	if (!refcount_dec_and_lock(&s->sc_count, &clp->cl_lock)) {
-		wake_up_all(&close_wq);
-		return;
+		if (!refcount_sub_and_test_checked(s->sc_cp_list_size,
+				&s->sc_count)) {
+			refcount_add_checked(s->sc_cp_list_size, &s->sc_count);
+			wake_up_all(&close_wq);
+			return;
+		}
 	}
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
 	spin_unlock(&clp->cl_lock);
+	nfs4_free_cpntf_statelist(clp->net, s);
 	s->sc_free(s);
 	if (fp)
 		put_nfs4_file(fp);
@@ -1881,6 +1948,8 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 #endif
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
+	INIT_LIST_HEAD(&clp->copy_notifies);
+	spin_lock_init(&clp->cpntf_lock);
 	spin_lock_init(&clp->cl_lock);
 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
 	return clp;
@@ -2909,7 +2978,8 @@ static bool client_has_state(struct nfs4_client *clp)
 #endif
 		|| !list_empty(&clp->cl_delegations)
 		|| !list_empty(&clp->cl_sessions)
-		|| !list_empty(&clp->async_copies);
+		|| !list_empty(&clp->async_copies)
+		|| !list_empty(&clp->copy_notifies);
 }
 
 static __be32 copy_impl_id(struct nfs4_client *clp,
@@ -5184,9 +5254,10 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	struct nfs4_delegation *dp;
 	struct nfs4_ol_stateid *stp;
 	struct nfsd4_blocked_lock *nbl;
-	struct list_head *pos, *next, reaplist;
+	struct list_head *pos, *next, *ppos, *pnext, reaplist, cpntflist;
 	time_t cutoff = get_seconds() - nn->nfsd4_lease;
 	time_t t, new_timeo = nn->nfsd4_lease;
+	struct nfs4_cpntf_state *cps;
 
 	dprintk("NFSD: laundromat service - starting\n");
 
@@ -5197,9 +5268,19 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	dprintk("NFSD: end of grace period\n");
 	nfsd4_end_grace(nn);
 	INIT_LIST_HEAD(&reaplist);
+	INIT_LIST_HEAD(&cpntflist);
+
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		spin_lock(&clp->cpntf_lock);
+		list_for_each_safe(ppos, pnext, &clp->copy_notifies) {
+			cps = list_entry(ppos, struct nfs4_cpntf_state, cpntf);
+			if (!time_after((unsigned long)cps->cpntf_time,
+					(unsigned long)cutoff))
+				list_move(&cps->cpntf, &cpntflist);
+		}
+		spin_unlock(&clp->cpntf_lock);
 		if (time_after((unsigned long)clp->cl_time, (unsigned long)cutoff)) {
 			t = clp->cl_time - cutoff;
 			new_timeo = min(new_timeo, t);
@@ -5213,6 +5294,11 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 		list_add(&clp->cl_lru, &reaplist);
 	}
 	spin_unlock(&nn->client_lock);
+	list_for_each_safe(pos, next, &cpntflist) {
+		cps = list_entry(pos, struct nfs4_cpntf_state, cpntf);
+		list_del_init(&cps->cpntf);
+		free_cpntf_state(cps->net, cps);
+	}
 	list_for_each_safe(pos, next, &reaplist) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
 		dprintk("NFSD: purging unused client (clientid %08x)\n",
@@ -5576,6 +5662,16 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 
 	return 0;
 }
+void free_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
+{
+	spin_lock(&cps->cp_p_stid->sc_lock);
+	list_del(&cps->cp_list);
+	cps->cp_p_stid->sc_cp_list_size--;
+	spin_unlock(&cps->cp_p_stid->sc_lock);
+	_free_copy_cpntf_stateid(nn, &cps->cp_stateid.stid);
+	nfs4_put_stid(cps->cp_p_stid);
+	kfree(cps);
+}
 
 /*
  * Checks for stateid operations
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 25c7a45..16be2f4 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -56,6 +56,13 @@
 	stateid_opaque_t        si_opaque;
 } stateid_t;
 
+typedef struct {
+	stateid_t		stid;
+#define NFS4_COPY_STID 1
+#define NFS4_COPYNOTIFY_STID 2
+	unsigned char		sc_type;
+} copy_stateid_t;
+
 #define STATEID_FMT	"(%08x/%08x/%08x/%08x)"
 #define STATEID_VAL(s) \
 	(s)->si_opaque.so_clid.cl_boot, \
@@ -96,6 +103,8 @@ struct nfs4_stid {
 #define NFS4_REVOKED_DELEG_STID 16
 #define NFS4_CLOSED_DELEG_STID 32
 #define NFS4_LAYOUT_STID 64
+	struct list_head	sc_cp_list;
+	size_t			sc_cp_list_size;
 	unsigned char		sc_type;
 	stateid_t		sc_stateid;
 	spinlock_t		sc_lock;
@@ -104,6 +113,18 @@ struct nfs4_stid {
 	void			(*sc_free)(struct nfs4_stid *);
 };
 
+/* Keep a list of stateids issued by the COPY_NOTIFY, associate it with the
+ * parent OPEN/LOCK/DELEG stateid.
+ */
+struct nfs4_cpntf_state {
+	copy_stateid_t		cp_stateid;
+	struct list_head	cp_list;	/* per parent nfs4_stid */
+	struct nfs4_stid	*cp_p_stid;	/* pointer to parent */
+	struct list_head	cpntf;		/* list of copy_notifies */
+	time_t			cpntf_time;	/* last time stateid used */
+	struct nfsd_net		*net;
+};
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -367,6 +388,8 @@ struct nfs4_client {
 	struct net		*net;
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
+	struct list_head	copy_notifies;	/* list of copy notify stids */
+	spinlock_t		cpntf_lock;	/* lock for copy_notifies */
 };
 
 /* struct nfs4_client_reset
@@ -623,8 +646,10 @@ __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
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
@@ -654,6 +679,7 @@ extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name
 extern void nfs4_put_copy(struct nfsd4_copy *copy);
 extern struct nfsd4_copy *
 find_async_copy(struct nfs4_client *clp, stateid_t *staetid);
+extern void free_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
 static inline void get_nfs4_file(struct nfs4_file *fi)
 {
 	refcount_inc(&fi->fi_ref);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c497032..c6c8b43 100644
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
1.8.3.1

