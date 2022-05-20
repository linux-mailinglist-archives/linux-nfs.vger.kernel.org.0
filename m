Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C2152F4AC
	for <lists+linux-nfs@lfdr.de>; Fri, 20 May 2022 22:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiETUwn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 16:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiETUwm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 16:52:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4F6644F9
        for <linux-nfs@vger.kernel.org>; Fri, 20 May 2022 13:52:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KId7e9028574;
        Fri, 20 May 2022 20:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=aW/blrlO5TYwcyj8/UYgIWJMtjTCR14sIAJqxMt7yuQ=;
 b=qfQOn8N2sd5ELfpItLc2/JPyneZaM2hQvVMcKPeg6sqRh0K8qRZPGjE617w2rNLqMolC
 ne7uaePDEQVG9qAA9Tqdz6Crx4vhVDi/OSgtrHQexiLk+5BGuD5m2SULyHwR5vH+khJ4
 g9nHnoTO12RDTn2YPaeo3Uq4Uj6VzSuD8HcE36ZoHZ5Uf3NL+ycXfHvVq82vqLj0BJEV
 mRBRNIVNmtq/JJWh89jL+Q9I+aeleuAHnKBsjoeNa01LZeG1i5WX6j1XWLDDymZ4FCyS
 sWy7tYMCnw7HSatI4m/2bX/JdBm+bhoghs/mvUrUpZusKCR/4vxPR99CilP2jgZZ6/O5 XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g23728b5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 20:52:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24KKo9UE036558;
        Fri, 20 May 2022 20:52:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v6q0k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 20:52:15 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24KKqE8d001199;
        Fri, 20 May 2022 20:52:14 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g22v6q0k3-1;
        Fri, 20 May 2022 20:52:14 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSD: sleeping function called from invalid context at kernel/locking/rwsem.c
Date:   Fri, 20 May 2022 13:52:09 -0700
Message-Id: <1653079929-18283-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: VTg7ePhN5PBOADwU6TXlqEsKfcMYbb4a
X-Proofpoint-ORIG-GUID: VTg7ePhN5PBOADwU6TXlqEsKfcMYbb4a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Problem caused by check_for_locks() calling nfsd_file_put while
holding the cl_lock.

Fix by moving nfsd_file_put to callers of check_for_locks() and serialize
access to nf_putfile using the cl_putfile mutex. nfsd4_release_lockowner
delays calling nfsd_file_put until after releasing the cl_lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/filecache.c | 13 +++++++++++++
 fs/nfsd/filecache.h |  2 ++
 fs/nfsd/nfs4state.c | 46 ++++++++++++++++++++++++++++------------------
 fs/nfsd/state.h     |  3 +++
 4 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2c1b027774d4..4a8ae1e562d2 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -175,6 +175,7 @@ nfsd_file_alloc(struct inode *inode, unsigned int may, unsigned int hashval,
 	if (nf) {
 		INIT_HLIST_NODE(&nf->nf_node);
 		INIT_LIST_HEAD(&nf->nf_lru);
+		INIT_LIST_HEAD(&nf->nf_putfile);
 		nf->nf_file = NULL;
 		nf->nf_cred = get_current_cred();
 		nf->nf_net = net;
@@ -315,6 +316,18 @@ nfsd_file_put(struct nfsd_file *nf)
 		nfsd_file_gc();
 }
 
+void
+nfsd_file_bulk_put(struct list_head *putlist)
+{
+	struct nfsd_file *nf;
+
+	while (!list_empty(putlist)) {
+		nf = list_first_entry(putlist, struct nfsd_file, nf_putfile);
+		list_del_init(&nf->nf_putfile);
+		nfsd_file_put(nf);
+	}
+}
+
 struct nfsd_file *
 nfsd_file_get(struct nfsd_file *nf)
 {
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 435ceab27897..2d775fea431a 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -46,6 +46,7 @@ struct nfsd_file {
 	refcount_t		nf_ref;
 	unsigned char		nf_may;
 	struct nfsd_file_mark	*nf_mark;
+	struct list_head	nf_putfile;
 };
 
 int nfsd_file_cache_init(void);
@@ -54,6 +55,7 @@ void nfsd_file_cache_shutdown(void);
 int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
+void nfsd_file_bulk_put(struct list_head *putlist);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
 bool nfsd_file_is_cached(struct inode *inode);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 234e852fcdfa..ef533707d198 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -80,7 +80,7 @@ static u64 current_sessionid = 1;
 #define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))
 
 /* forward declarations */
-static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
+static bool check_for_locks(struct nfsd_file *nf, struct nfs4_lockowner *lowner);
 static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
 void nfsd4_end_grace(struct nfsd_net *nn);
 static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
@@ -2015,6 +2015,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
 	spin_lock_init(&clp->cl_lock);
+	mutex_init(&clp->cl_putfile);
 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
 	return clp;
 err_no_hashtbl:
@@ -6139,6 +6140,7 @@ static __be32
 nfsd4_free_lock_stateid(stateid_t *stateid, struct nfs4_stid *s)
 {
 	struct nfs4_ol_stateid *stp = openlockstateid(s);
+	struct nfsd_file *nf;
 	__be32 ret;
 
 	ret = nfsd4_lock_ol_stateid(stp);
@@ -6150,9 +6152,14 @@ nfsd4_free_lock_stateid(stateid_t *stateid, struct nfs4_stid *s)
 		goto out;
 
 	ret = nfserr_locks_held;
-	if (check_for_locks(stp->st_stid.sc_file,
-			    lockowner(stp->st_stateowner)))
-		goto out;
+	nf = find_any_file(stp->st_stid.sc_file);
+	if (nf) {
+		if (check_for_locks(nf, lockowner(stp->st_stateowner))) {
+			nfsd_file_put(nf);
+			goto out;
+		}
+		nfsd_file_put(nf);
+	}
 
 	release_lock_stateid(stp);
 	ret = nfs_ok;
@@ -7266,20 +7273,13 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  * 	false: no locks held by lockowner
  */
 static bool
-check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
+check_for_locks(struct nfsd_file *nf, struct nfs4_lockowner *lowner)
 {
 	struct file_lock *fl;
 	int status = false;
-	struct nfsd_file *nf = find_any_file(fp);
 	struct inode *inode;
 	struct file_lock_context *flctx;
 
-	if (!nf) {
-		/* Any valid lock stateid should have some sort of access */
-		WARN_ON_ONCE(1);
-		return status;
-	}
-
 	inode = locks_inode(nf->nf_file);
 	flctx = inode->i_flctx;
 
@@ -7293,7 +7293,6 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 		}
 		spin_unlock(&flctx->flc_lock);
 	}
-	nfsd_file_put(nf);
 	return status;
 }
 
@@ -7313,6 +7312,8 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct nfs4_client *clp;
 	LIST_HEAD (reaplist);
+	LIST_HEAD(putlist);
+	struct nfsd_file *nf;
 
 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
 		clid->cl_boot, clid->cl_id);
@@ -7323,6 +7324,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 
 	clp = cstate->clp;
 	/* Find the matching lock stateowner */
+	mutex_lock(&clp->cl_putfile);
 	spin_lock(&clp->cl_lock);
 	list_for_each_entry(sop, &clp->cl_ownerstr_hashtbl[hashval],
 			    so_strhash) {
@@ -7333,18 +7335,24 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		/* see if there are still any locks associated with it */
 		lo = lockowner(sop);
 		list_for_each_entry(stp, &sop->so_stateids, st_perstateowner) {
-			if (check_for_locks(stp->st_stid.sc_file, lo)) {
-				status = nfserr_locks_held;
-				spin_unlock(&clp->cl_lock);
-				return status;
+			nf = find_any_file(stp->st_stid.sc_file);
+			if (nf) {
+				list_add(&nf->nf_putfile, &putlist);
+				if (check_for_locks(nf, lo)) {
+					status = nfserr_locks_held;
+					spin_unlock(&clp->cl_lock);
+					nfsd_file_bulk_put(&putlist);
+					mutex_unlock(&clp->cl_putfile);
+					return status;
+				}
 			}
 		}
-
 		nfs4_get_stateowner(sop);
 		break;
 	}
 	if (!lo) {
 		spin_unlock(&clp->cl_lock);
+		mutex_unlock(&clp->cl_putfile);
 		return status;
 	}
 
@@ -7357,6 +7365,8 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		put_ol_stateid_locked(stp, &reaplist);
 	}
 	spin_unlock(&clp->cl_lock);
+	nfsd_file_bulk_put(&putlist);
+	mutex_unlock(&clp->cl_putfile);
 	free_ol_stateid_reaplist(&reaplist);
 	remove_blocked_locks(lo);
 	nfs4_put_stateowner(&lo->lo_owner);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 95457cfd37fc..c452d719369d 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -385,6 +385,9 @@ struct nfs4_client {
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
+
+	/* serialize access to nf_putfile */
+	struct mutex		cl_putfile;
 };
 
 /* struct nfs4_client_reset
-- 
2.9.5

