Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5596A4C1ACC
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 19:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbiBWSRS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 13:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243680AbiBWSRO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 13:17:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E403ED1F
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 10:16:46 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NIDsSX001902;
        Wed, 23 Feb 2022 18:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=syq4AIY1zXSJPAQDPO05MJ3pl/y7Q5deB8DiBTxbbnU=;
 b=a30C00/b2OLDDnkmMRetOAkqzbB3r71LRDr9BNsy6Oaha3RezADU+LCD/Nhh+a7QUnzV
 ViOtUQQGFjSl/7P3TM6yrBouNufIt//m6WFkmOY56RZHh5ISS2XmxCyBhVZ8IqF3kgrv
 iUlKIMniW511+dbrDOU00FZWC9hU+ik3xvDohGUVvUPpufsEN6bDWGMZMhUvAax+YxSy
 GDYG47kOKc6K57bRrsI+9Mf/SjG+/i7D+Jq5pHmevwIQLbXSg1y2W1inWtLsKFtaPEVf
 2L8g/3OH3tCRGYWwGy93Qs2dAKWFom2PWJU6rfQjlLszeFesOjcMRif3uJqNNmMvUFfA yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecv6evxpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:16:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21NIAtJm155927;
        Wed, 23 Feb 2022 18:16:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3eapkj17s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:16:45 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21NICxfe162308;
        Wed, 23 Feb 2022 18:16:44 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3eapkj17pe-8;
        Wed, 23 Feb 2022 18:16:44 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v14 07/10] NFSD: Update find_client_in_id_table() to handle courtesy clients
Date:   Wed, 23 Feb 2022 10:16:34 -0800
Message-Id: <1645640197-1725-8-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: kgcaJpn_62tG876OhrmWnRUpQNsL4CFc
X-Proofpoint-ORIG-GUID: kgcaJpn_62tG876OhrmWnRUpQNsL4CFc
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
 . if courtesy client was found then clear CLIENT_COURTESY and set
   CLIENT_RECONNECTED flag so callers can take appropriate action.

Update find_confirmed_client to discard courtesy client.
Update lookup_clientid to call find_client_in_id_table directly.
Update set_client to create client record for courtesy client.
Update find_cpntf_state to discard courtesy client.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5cef1a78cc28..6e3ca0ea4f28 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2915,6 +2915,19 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
 		if (same_clid(&clp->cl_clientid, clid)) {
 			if ((bool)clp->cl_minorversion != sessions)
 				return NULL;
+
+			/* need to sync with thread resolving lock/deleg conflict */
+			clear_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
+			spin_lock(&clp->cl_cs_lock);
+			if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
+				spin_unlock(&clp->cl_cs_lock);
+				continue;
+			}
+			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
+				set_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
+			}
+			spin_unlock(&clp->cl_cs_lock);
 			renew_client_locked(clp);
 			return clp;
 		}
@@ -2922,6 +2935,7 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
 	return NULL;
 }
 
+
 static void
 nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
 {
@@ -2934,9 +2948,15 @@ static struct nfs4_client *
 find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn)
 {
 	struct list_head *tbl = nn->conf_id_hashtbl;
+	struct nfs4_client *clp;
 
 	lockdep_assert_held(&nn->client_lock);
-	return find_client_in_id_table(tbl, clid, sessions);
+	clp = find_client_in_id_table(tbl, clid, sessions);
+	if (clp && test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
+		nfsd4_discard_courtesy_clnt(clp);
+		clp = NULL;
+	}
+	return clp;
 }
 
 static struct nfs4_client *
@@ -4867,9 +4887,10 @@ static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
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
@@ -4894,6 +4915,8 @@ static __be32 set_client(clientid_t *clid,
 	cstate->clp = lookup_clientid(clid, false, nn);
 	if (!cstate->clp)
 		return nfserr_expired;
+	if (test_bit(NFSD4_CLIENT_RECONNECTED, &cstate->clp->cl_flags))
+		nfsd4_client_record_create(cstate->clp);
 	return nfs_ok;
 }
 
@@ -6222,6 +6245,13 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 	found = lookup_clientid(&cps->cp_p_clid, true, nn);
 	if (!found)
 		goto out;
+	if (test_bit(NFSD4_CLIENT_RECONNECTED, &found->cl_flags)) {
+		nfsd4_discard_courtesy_clnt(found);
+		if (atomic_dec_and_lock(&found->cl_rpc_users,
+				&nn->client_lock))
+			spin_unlock(&nn->client_lock);
+		goto out;
+	}
 
 	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
 			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
-- 
2.9.5

