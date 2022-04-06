Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A104F6DF7
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 00:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiDFWrr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 18:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbiDFWro (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 18:47:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4881A1290
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 15:45:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236LH0q6004957;
        Wed, 6 Apr 2022 22:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=dHYCaShwFxFLB8tjHr4vbO2Mv/vdoxUJRq05kqQGkm0=;
 b=SX78RZn0UOnK8QIcPQdgg3tHoo7oQDXEyQG5ogNEY72uTOo6qWmy0AMj4dcpgldBSVrl
 iRjoAbWBRFX+0cq67JnyNKmrUZk0u3Peg8Obk4XTcNtqRqfZ8kzibWlPtjw2YTL0Ux4C
 fJdm/D/yTbEVbCR+YMKgV/8tGvh/GMnhRio2mWueIdNRleB5KuR1wBwf/26BbJqwJhLV
 1Rw3EE9GzPPwLW7Zd2Ki5Kg/vQNNKb3fGwZhNG/y9lLubuQR7QJN4GpReGoN171VWovg
 Xjf2ZtgJVAj/dsbGjwaM36oOZ8ClDaJaCz+HoZCUcAawGMRe0ZwGf5iieqWX/ybTFNC2 OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d932bq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236Meb2E011769;
        Wed, 6 Apr 2022 22:45:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:43 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 236Mjcbi021908;
        Wed, 6 Apr 2022 22:45:43 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5mk-7;
        Wed, 06 Apr 2022 22:45:43 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v20 06/10] NFSD: Update find_in_sessionid_hashtbl() to handle courtesy client
Date:   Wed,  6 Apr 2022 15:45:29 -0700
Message-Id: <1649285133-16765-7-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
References: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: CDVrZbvGyUJw-iivxIIqIFVXdAjenOec
X-Proofpoint-GUID: CDVrZbvGyUJw-iivxIIqIFVXdAjenOec
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Update find_in_sessionid_hashtbl to:
 . skip client with CLIENT_EXPIRED state; discarded courtesy client.
 . if courtesy client was found then set CLIENT_RECONNECTED so caller
   can take appropriate action.

Update nfsd4_sequence and nfsd4_bind_conn_to_session to create client
record for courtesy client with CLIENT_RECONNECTED state.

Update nfsd4_destroy_session to discard courtesy client with
CLIENT_RECONNECTED state.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d14cea763511..0fd058826e85 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -701,6 +701,22 @@ __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
 		atomic_inc(&fp->fi_access[O_RDONLY]);
 }
 
+static void
+nfsd4_reactivate_courtesy_client(struct nfs4_client *clp, __be32 status)
+{
+	spin_lock(&clp->cl_cs_lock);
+	if (clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
+		if (status == nfs_ok) {
+			clp->cl_cs_client_state = NFSD4_CLIENT_ACTIVE;
+			spin_unlock(&clp->cl_cs_lock);
+			nfsd4_client_record_create(clp);
+			return;
+		}
+		clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
+	}
+	spin_unlock(&clp->cl_cs_lock);
+}
+
 /*
  * Check if courtesy clients have conflicting access and resolve it if possible
  *
@@ -1994,13 +2010,21 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
 {
 	struct nfsd4_session *session;
 	__be32 status = nfserr_badsession;
+	struct nfs4_client *clp;
 
 	session = __find_in_sessionid_hashtbl(sessionid, net);
 	if (!session)
 		goto out;
+	clp = session->se_client;
+	if (nfsd4_courtesy_clnt_expired(clp)) {
+		session = NULL;
+		goto out;
+	}
 	status = nfsd4_get_session_locked(session);
-	if (status)
+	if (status) {
 		session = NULL;
+		nfsd4_discard_reconnect_clnt(clp);
+	}
 out:
 	*ret = status;
 	return session;
@@ -3700,6 +3724,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	struct nfsd4_session *session;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	if (!nfsd4_last_compound_op(rqstp))
 		return nfserr_not_only_op;
@@ -3732,6 +3757,8 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	nfsd4_init_conn(rqstp, conn, session);
 	status = nfs_ok;
 out:
+	clp = session->se_client;
+	nfsd4_reactivate_courtesy_client(clp, status);
 	nfsd4_put_session(session);
 out_no_session:
 	return status;
@@ -3754,6 +3781,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	int ref_held_by_me = 0;
 	struct net *net = SVC_NET(r);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	status = nfserr_not_only_op;
 	if (nfsd4_compound_in_session(cstate, sessionid)) {
@@ -3766,6 +3794,11 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	ses = find_in_sessionid_hashtbl(sessionid, net, &status);
 	if (!ses)
 		goto out_client_lock;
+	clp = ses->se_client;
+	if (nfsd4_discard_reconnect_clnt(clp)) {
+		status = nfserr_badsession;
+		goto out_put_session;
+	}
 	status = nfserr_wrong_cred;
 	if (!nfsd4_mach_creds_match(ses->se_client, r))
 		goto out_put_session;
@@ -3870,7 +3903,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_session *session;
-	struct nfs4_client *clp;
+	struct nfs4_client *clp = NULL;
 	struct nfsd4_slot *slot;
 	struct nfsd4_conn *conn;
 	__be32 status;
@@ -3980,6 +4013,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (conn)
 		free_conn(conn);
 	spin_unlock(&nn->client_lock);
+	if (clp)
+		nfsd4_reactivate_courtesy_client(clp, status);
 	return status;
 out_put_session:
 	nfsd4_put_session_locked(session);
-- 
2.9.5

