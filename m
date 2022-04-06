Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666F34F6DFC
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 00:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiDFWru (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 18:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbiDFWrm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 18:47:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C96817941E
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 15:45:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236LdvcO006381;
        Wed, 6 Apr 2022 22:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=ggIXVGT9l8eJfTtRVhpwQVfYgFowHViLiSH6Kn5NsjU=;
 b=rlNZ6b6OmetkzzMc6Uz4Y4HijDMr1GCCuaR+2lzqhkQkSREhKO5SrSxRV+Wl/RSmVSm4
 XZbXtOm0Oym9LrDuXfSzj6N/XaJ+l2kpu9uOgIKLhfRxczCYwIVALvVtmmre7k4I+JS/
 0x3xjx46r7hmSNokRlp5fgoW3igK51wb7ciDIsuI9Av9Fc3a/w6Zb9OA6MfZybI9iTPK
 pGzpYlJS5yCWR/YswB/gZsx/isJDf7eVNbtRI7fA3QcdRBaCU+CO04FZBKeFY+n1bFTn
 3iAjmHs/6e70Y3+DjvLprMRHT7Y+PbOIMoDuHm9p2FUMORB2l0t7stShifyYDHI4pGeZ 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31jd7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236MeYDG011627;
        Wed, 6 Apr 2022 22:45:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 236MjcbY021908;
        Wed, 6 Apr 2022 22:45:39 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5mk-2;
        Wed, 06 Apr 2022 22:45:39 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v20 01/10] NFSD: Add courtesy client state, macro and spinlock to support courteous server
Date:   Wed,  6 Apr 2022 15:45:24 -0700
Message-Id: <1649285133-16765-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
References: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: tPOtoU9fv8I0hCWFL9nB2WE5czJimyOf
X-Proofpoint-ORIG-GUID: tPOtoU9fv8I0hCWFL9nB2WE5czJimyOf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Update nfs4_client to add:
 . cl_cs_client_state: courtesy client state
 . cl_cs_lock: spinlock to synchronize access to cl_cs_client_state
 . cl_cs_list: list used by laundromat to process courtesy clients

Modify alloc_client to initialize these fields.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c |  2 ++
 fs/nfsd/nfsd.h      |  1 +
 fs/nfsd/state.h     | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 234e852fcdfa..a65d59510681 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2009,12 +2009,14 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	INIT_LIST_HEAD(&clp->cl_delegations);
 	INIT_LIST_HEAD(&clp->cl_lru);
 	INIT_LIST_HEAD(&clp->cl_revoked);
+	INIT_LIST_HEAD(&clp->cl_cs_list);
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&clp->cl_lo_states);
 #endif
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
 	spin_lock_init(&clp->cl_lock);
+	spin_lock_init(&clp->cl_cs_lock);
 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
 	return clp;
 err_no_hashtbl:
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4fc1fd639527..23996c6ca75e 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
 #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
 
 #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
+#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 95457cfd37fc..7f78da5d1408 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -283,6 +283,35 @@ struct nfsd4_sessionid {
 #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
 
 /*
+ *       State                Meaning                  Where set
+ * --------------------------------------------------------------------------
+ * | CLIENT_ACTIVE     | Confirmed, active    | Default                     |
+ * |------------------- ----------------------------------------------------|
+ * | CLIENT_COURTESY   | Courtesy state.      | nfs4_get_client_reaplist    |
+ * |                   | Lease/lock/share     |                             |
+ * |                   | reservation conflict |                             |
+ * |                   | can cause Courtesy   |                             |
+ * |                   | client to be expired |                             |
+ * |------------------------------------------------------------------------|
+ * | CLIENT_EXPIRED    | Courtesy client to be| nfs4_laundromat             |
+ * |                   | expired by Laundromat| nfsd4_lm_lock_expired       |
+ * |                   | due to conflict      | nfsd4_discard_courtesy_clnt |
+ * |                   |                      | nfsd4_expire_courtesy_clnt  |
+ * |------------------------------------------------------------------------|
+ * | CLIENT_RECONNECT  | Courtesy client      | nfsd4_courtesy_clnt_expired |
+ * |                   | reconnected,         |                             |
+ * |                   | becoming active      |                             |
+ * --------------------------------------------------------------------------
+ */
+
+enum courtesy_client_state {
+	NFSD4_CLIENT_ACTIVE = 0,
+	NFSD4_CLIENT_COURTESY,
+	NFSD4_CLIENT_EXPIRED,
+	NFSD4_CLIENT_RECONNECTED,
+};
+
+/*
  * struct nfs4_client - one per client.  Clientids live here.
  *
  * The initial object created by an NFS client using SETCLIENTID (for NFSv4.0)
@@ -385,6 +414,10 @@ struct nfs4_client {
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
+
+	enum courtesy_client_state	cl_cs_client_state;
+	spinlock_t		cl_cs_lock;
+	struct list_head	cl_cs_list;
 };
 
 /* struct nfs4_client_reset
-- 
2.9.5

