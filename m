Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A34F6DFD
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 00:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiDFWrv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 18:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiDFWro (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 18:47:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1326442A3D
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 15:45:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236KGjw7012451;
        Wed, 6 Apr 2022 22:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=Ie641ePHUhK+My5tElENcwJXDoLk4zAMcalKxgc5z9w=;
 b=aP3HE1fvG+ZKEE9WKyEQHbpBP9QsG2pGrRF82pkbauamYjOVPZZpMP8sJdYWzebE1H2z
 IEXhRZoDlAqS9SR6TfJWJDgfA75gOMeCkZERT3m9lACAJhjqOaYuWXG7XALRt2v9FjiB
 3qH+pPeWqtfxZy5EWw/HRaQhIRIXd+WYAgkw4Qx2q2itdVS7guzQ3WCd3z1296ekwpOs
 UWngvVtPac7NuYHBBB3qpiFVLklnkCDYrv/fayicp7u9DZsHrGKXcpOgVasiUucJf5/Q
 cFl5hzH6+Bpgq7MCTWPTv5hyRgD4sSBPZdjyGMu/fV8idt0fDMVqX+Nocty8FsuENiYB PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcj1k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236MeYDH011627;
        Wed, 6 Apr 2022 22:45:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 236Mjcbk021908;
        Wed, 6 Apr 2022 22:45:44 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5mk-8;
        Wed, 06 Apr 2022 22:45:44 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v20 07/10] NFSD: Update find_client_in_id_table() to handle courtesy client
Date:   Wed,  6 Apr 2022 15:45:30 -0700
Message-Id: <1649285133-16765-8-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
References: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: 8A5fGtM0NtgalLFU1Fm3_iitL9AXvErB
X-Proofpoint-GUID: 8A5fGtM0NtgalLFU1Fm3_iitL9AXvErB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Update find_client_in_id_table to:
 . skip client with CLIENT_EXPIRED; discarded courtesy client
 . if courtesy client was found then set CLIENT_RECONNECTED
   state so caller can take appropriate action.

Update find_confirmed_client to discard courtesy client.
Update lookup_clientid to call find_client_in_id_table directly.
Update set_client to create client record for courtesy client.
Update find_cpntf_state to discard courtesy client.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0fd058826e85..241d6a509994 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2967,6 +2967,8 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
 		if (same_clid(&clp->cl_clientid, clid)) {
 			if ((bool)clp->cl_minorversion != sessions)
 				return NULL;
+			if (nfsd4_courtesy_clnt_expired(clp))
+				continue;
 			renew_client_locked(clp);
 			return clp;
 		}
@@ -2978,9 +2980,13 @@ static struct nfs4_client *
 find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn)
 {
 	struct list_head *tbl = nn->conf_id_hashtbl;
+	struct nfs4_client *clp;
 
 	lockdep_assert_held(&nn->client_lock);
-	return find_client_in_id_table(tbl, clid, sessions);
+	clp = find_client_in_id_table(tbl, clid, sessions);
+	if (clp && nfsd4_discard_reconnect_clnt(clp))
+		clp = NULL;
+	return clp;
 }
 
 static struct nfs4_client *
@@ -4884,9 +4890,10 @@ static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
 						struct nfsd_net *nn)
 {
 	struct nfs4_client *found;
+	struct list_head *tbl = nn->conf_id_hashtbl;
 
 	spin_lock(&nn->client_lock);
-	found = find_confirmed_client(clid, sessions, nn);
+	found = find_client_in_id_table(tbl, clid, sessions);
 	if (found)
 		atomic_inc(&found->cl_rpc_users);
 	spin_unlock(&nn->client_lock);
@@ -4911,6 +4918,7 @@ static __be32 set_client(clientid_t *clid,
 	cstate->clp = lookup_clientid(clid, false, nn);
 	if (!cstate->clp)
 		return nfserr_expired;
+	nfsd4_reactivate_courtesy_client(cstate->clp, nfs_ok);
 	return nfs_ok;
 }
 
@@ -6147,7 +6155,12 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 	found = lookup_clientid(&cps->cp_p_clid, true, nn);
 	if (!found)
 		goto out;
-
+	if (nfsd4_discard_reconnect_clnt(found)) {
+		if (atomic_dec_and_lock(&found->cl_rpc_users,
+				&nn->client_lock))
+			spin_unlock(&nn->client_lock);
+		goto out;
+	}
 	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
 			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
 	if (*stid)
-- 
2.9.5

