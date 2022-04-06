Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BD24F6DF8
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 00:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiDFWrr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 18:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiDFWrn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 18:47:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C9F198EE8
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 15:45:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236JV8QD014716;
        Wed, 6 Apr 2022 22:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=dTenKcU8PpnAqDdAJyYJ7vdmgRE/7uhM1oGSN99Liyg=;
 b=KvfJ0WiVABlO6/EN5KkChqZqt3cfncWtSUh3aViWCn4bZcKeCw49ZZKpaDuBB5kLXKLf
 tUWPWk8U85+D5yFtVKlRrbc+VXglsSlO/MdM35GSe4h4bZCOq/rnoUdBA+4JgxGcpFeC
 rq62Zj2whV6wTRF6g/NNvsBoT9Ltm6ugkZx/ZOPD1Pqvt/fefxH1nbrHM9vskwo4SONP
 Dj7A5w7yuoMrazsHrUwfDqZXNf/R8+wz7lCAR/gSP0xxxdHFkm/zrvYeesugHMNWWiZg
 mNZytsaEz9ULX5kfm95P0/P2wROkQtkhuen8ASHlxnR4rLNJnA9Ls3u4XpbkF2ZAaY4p 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9t3rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236MeZXc011713;
        Wed, 6 Apr 2022 22:45:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:43 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 236Mjcbg021908;
        Wed, 6 Apr 2022 22:45:42 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5mk-6;
        Wed, 06 Apr 2022 22:45:42 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v20 05/10] NFSD: Update find_clp_in_name_tree() to handle courtesy client
Date:   Wed,  6 Apr 2022 15:45:28 -0700
Message-Id: <1649285133-16765-6-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
References: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: gNbxruvvVfBxalhUsUlrXnF2pCm-H4Bq
X-Proofpoint-ORIG-GUID: gNbxruvvVfBxalhUsUlrXnF2pCm-H4Bq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Update find_clp_in_name_tree to check and expire courtesy client.

Update find_confirmed_client_by_name to discard the courtesy
client by setting CLIENT_EXPIRED.

Update nfsd4_setclientid to expire client with CLIENT_EXPIRED
state to prevent multiple confirmed clients with the same name
on the conf_name_tree.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++++++++---
 fs/nfsd/state.h     | 28 ++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fe8969ba94b3..d14cea763511 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2893,8 +2893,11 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
 			node = node->rb_left;
 		else if (cmp < 0)
 			node = node->rb_right;
-		else
+		else {
+			if (nfsd4_courtesy_clnt_expired(clp))
+				return NULL;
 			return clp;
+		}
 	}
 	return NULL;
 }
@@ -2973,8 +2976,13 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
 static struct nfs4_client *
 find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
 {
+	struct nfs4_client *clp;
+
 	lockdep_assert_held(&nn->client_lock);
-	return find_clp_in_name_tree(name, &nn->conf_name_tree);
+	clp = find_clp_in_name_tree(name, &nn->conf_name_tree);
+	if (clp && nfsd4_discard_reconnect_clnt(clp))
+		clp = NULL;
+	return clp;
 }
 
 static struct nfs4_client *
@@ -4091,12 +4099,19 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_client	*unconf = NULL;
 	__be32 			status;
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfs4_client	*cclient = NULL;
 
 	new = create_client(clname, rqstp, &clverifier);
 	if (new == NULL)
 		return nfserr_jukebox;
 	spin_lock(&nn->client_lock);
-	conf = find_confirmed_client_by_name(&clname, nn);
+	/* find confirmed client by name */
+	conf = find_clp_in_name_tree(&clname, &nn->conf_name_tree);
+	if (conf && conf->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
+		cclient = conf;
+		conf = NULL;
+	}
+
 	if (conf && client_has_state(conf)) {
 		status = nfserr_clid_inuse;
 		if (clp_used_exchangeid(conf))
@@ -4127,7 +4142,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	new = NULL;
 	status = nfs_ok;
 out:
+	if (cclient)
+		unhash_client_locked(cclient);
 	spin_unlock(&nn->client_lock);
+	if (cclient)
+		expire_client(cclient);
 	if (new)
 		free_client(new);
 	if (unconf) {
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 8b81493ee48a..16167f223353 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -735,6 +735,7 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
 extern int nfsd4_client_record_check(struct nfs4_client *clp);
 extern void nfsd4_record_grace_done(struct nfsd_net *nn);
 
+/* courteous server */
 static inline bool
 nfsd4_expire_courtesy_clnt(struct nfs4_client *clp)
 {
@@ -749,4 +750,31 @@ nfsd4_expire_courtesy_clnt(struct nfs4_client *clp)
 	return rc;
 }
 
+static inline bool
+nfsd4_discard_reconnect_clnt(struct nfs4_client *clp)
+{
+	bool ret = false;
+
+	spin_lock(&clp->cl_cs_lock);
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
+		clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
+		ret = true;
+	}
+	spin_unlock(&clp->cl_cs_lock);
+	return ret;
+}
+
+static inline bool
+nfsd4_courtesy_clnt_expired(struct nfs4_client *clp)
+{
+	bool rc = false;
+
+	spin_lock(&clp->cl_cs_lock);
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_EXPIRED)
+		rc = true;
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY)
+		clp->cl_cs_client_state = NFSD4_CLIENT_RECONNECTED;
+	spin_unlock(&clp->cl_cs_lock);
+	return rc;
+}
 #endif   /* NFSD4_STATE_H */
-- 
2.9.5

