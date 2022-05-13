Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A6A526729
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 18:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382409AbiEMQet (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 12:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381735AbiEMQer (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 12:34:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9092646
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 09:34:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFd7x1001960
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 16:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=tjo4vQrZyyLNA4+WghrqeA+04nFvNj0xJLIe5oKFQts=;
 b=YWiKh9QKEOLhk1aD2h+uFMrnzzapGa1m//+9c3rSVTNJC1/XshFIUhQZKOoAPzsptzBc
 +VsYRhBlPoRJeIOd543HUVevJc7cpYHtL7PSoB154Ei99VY6x5Bu5Seq4WeeQ2sQGPkc
 NKrj5rY49zoZdgoRSKemyb8FX6Fmnpl7Cf1fWXqGjPMYVxIX7AA4EOhMJbM2J/AyeuOD
 An+P4G89wfDB937IJhpY37WsFfLInUVtOhTsYOJSZ4/je1bDX1Hpj+yNUPWXCm/8+g99
 5RbriQXTGtvuAsVlBD64nBYhj5rBjpdiTRTgzjqOMahSXKi0IOVeTPGAGa7h04Ioocq4 sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6cfhn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 16:34:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24DGFZCk017082
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 16:34:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf767ffh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 16:34:41 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24DGYf9s003458
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 16:34:41 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf767ffa-1;
        Fri, 13 May 2022 16:34:41 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: sleeping function called from invalid context at kernel/locking/rwsem.c
Date:   Fri, 13 May 2022 09:34:35 -0700
Message-Id: <1652459676-23701-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-ORIG-GUID: ffo0GXiLUKIObvIZ1baEjmsT-4S3U8U4
X-Proofpoint-GUID: ffo0GXiLUKIObvIZ1baEjmsT-4S3U8U4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Problem caused by check_for_locks() calling nfsd_file_put while
holding the cl_lock.

Fix by moving nfsd_file_put to callers of check_for_locks().
nfsd4_release_lockowner delays calling nfsd_file_put until after
releasing the cl_lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/filecache.c | 13 +++++++++++++
 fs/nfsd/filecache.h |  2 ++
 fs/nfsd/nfs4state.c | 41 +++++++++++++++++++++++------------------
 3 files changed, 38 insertions(+), 18 deletions(-)

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
index 234e852fcdfa..1486f77541fe 100644
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
@@ -6139,6 +6139,7 @@ static __be32
 nfsd4_free_lock_stateid(stateid_t *stateid, struct nfs4_stid *s)
 {
 	struct nfs4_ol_stateid *stp = openlockstateid(s);
+	struct nfsd_file *nf;
 	__be32 ret;
 
 	ret = nfsd4_lock_ol_stateid(stp);
@@ -6150,9 +6151,14 @@ nfsd4_free_lock_stateid(stateid_t *stateid, struct nfs4_stid *s)
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
@@ -7266,20 +7272,13 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
 
@@ -7293,7 +7292,6 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 		}
 		spin_unlock(&flctx->flc_lock);
 	}
-	nfsd_file_put(nf);
 	return status;
 }
 
@@ -7313,6 +7311,8 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct nfs4_client *clp;
 	LIST_HEAD (reaplist);
+	LIST_HEAD(putlist);
+	struct nfsd_file *nf;
 
 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
 		clid->cl_boot, clid->cl_id);
@@ -7333,13 +7333,17 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
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
+					return status;
+				}
 			}
 		}
-
 		nfs4_get_stateowner(sop);
 		break;
 	}
@@ -7357,6 +7361,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		put_ol_stateid_locked(stp, &reaplist);
 	}
 	spin_unlock(&clp->cl_lock);
+	nfsd_file_bulk_put(&putlist);
 	free_ol_stateid_reaplist(&reaplist);
 	remove_blocked_locks(lo);
 	nfs4_put_stateowner(&lo->lo_owner);
-- 
2.9.5

