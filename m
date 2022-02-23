Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF4D4C1ACB
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 19:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242155AbiBWSRR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 13:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243616AbiBWSRO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 13:17:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CD83F32A
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 10:16:45 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NIDlCx029459;
        Wed, 23 Feb 2022 18:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=rIJPt+A+ak4PFGluCnj/+PVYjxKV1SP6JJRbkBtsgW4=;
 b=Kf91I2WfH8YrJCa4TFuROu3hxx0ypf1aSXN+ErDxrUJQ8g5IU8Cgx13sgkB5jascsqfi
 PLnt9v+LmQu/aK45zw+LhU8yh3xdfAqIQdeiQgGXUAdStLDmBl7tCklNrUKepB/Qz732
 K9uFRfNaj8pC/9hcOOAjxXBZr3VmRtWgyBxlxjt/BIRF05Zi9ITmCyYAP8BhgTFZrrHr
 OT0lZ8Bs7gRHRRqdF7+qf2mRrT7xSEyvEA7bySlKfqY+iv0xRGIYxFZdtjs9ztQy/u8H
 fMYwxe5fO3i5Vuqrd8rr+ohl9iHM0nrVEfIbG4bX50yvCzt2dSVgAX2wIRkynsK905/n 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx54ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:16:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21NIAtfh155954;
        Wed, 23 Feb 2022 18:16:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3eapkj17rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:16:44 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21NICxfc162308;
        Wed, 23 Feb 2022 18:16:43 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3eapkj17pe-7;
        Wed, 23 Feb 2022 18:16:43 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v14 06/10] NFSD: Update find_in_sessionid_hashtbl() to handle courtesy clients
Date:   Wed, 23 Feb 2022 10:16:33 -0800
Message-Id: <1645640197-1725-7-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: -o8b47xDglb3_VyqKRxdXIKO3CJB_YpV
X-Proofpoint-GUID: -o8b47xDglb3_VyqKRxdXIKO3CJB_YpV
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
 . skip client with CLIENT_EXPIRED flag; discarded courtesy client.
 . if courtesy client was found then clear CLIENT_COURTESY and
   set CLIENT_RECONNECTED so callers can take appropriate action.

Update nfsd4_sequence and nfsd4_bind_conn_to_session to create client
record for client with CLIENT_RECONNECTED set.

Update nfsd4_destroy_session to discard client with CLIENT_RECONNECTED
set.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4990553180f8..5cef1a78cc28 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1935,10 +1935,31 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
 {
 	struct nfsd4_session *session;
 	__be32 status = nfserr_badsession;
+	struct nfs4_client *clp;
 
 	session = __find_in_sessionid_hashtbl(sessionid, net);
 	if (!session)
 		goto out;
+	clp = session->se_client;
+	if (clp) {
+		clear_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
+		/* need to sync with thread resolving lock/deleg conflict */
+		spin_lock(&clp->cl_cs_lock);
+		if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
+			spin_unlock(&clp->cl_cs_lock);
+			session = NULL;
+			goto out;
+		}
+		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+			/*
+			 * clear CLIENT_COURTESY flag to prevent it from being
+			 * destroyed by thread trying to resolve conflicts.
+			 */
+			clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
+			set_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
+		}
+		spin_unlock(&clp->cl_cs_lock);
+	}
 	status = nfsd4_get_session_locked(session);
 	if (status)
 		session = NULL;
@@ -3661,6 +3682,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	struct nfsd4_session *session;
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	if (!nfsd4_last_compound_op(rqstp))
 		return nfserr_not_only_op;
@@ -3693,6 +3715,13 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	nfsd4_init_conn(rqstp, conn, session);
 	status = nfs_ok;
 out:
+	clp = session->se_client;
+	if (test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
+		if (status == nfs_ok)
+			nfsd4_client_record_create(clp);
+		else
+			nfsd4_discard_courtesy_clnt(clp);
+	}
 	nfsd4_put_session(session);
 out_no_session:
 	return status;
@@ -3715,6 +3744,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	int ref_held_by_me = 0;
 	struct net *net = SVC_NET(r);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfs4_client *clp;
 
 	status = nfserr_not_only_op;
 	if (nfsd4_compound_in_session(cstate, sessionid)) {
@@ -3727,6 +3757,12 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	ses = find_in_sessionid_hashtbl(sessionid, net, &status);
 	if (!ses)
 		goto out_client_lock;
+	clp = ses->se_client;
+	if (test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
+		status = nfserr_badsession;
+		nfsd4_discard_courtesy_clnt(clp);
+		goto out_put_session;
+	}
 	status = nfserr_wrong_cred;
 	if (!nfsd4_mach_creds_match(ses->se_client, r))
 		goto out_put_session;
@@ -3831,7 +3867,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	struct xdr_stream *xdr = resp->xdr;
 	struct nfsd4_session *session;
-	struct nfs4_client *clp;
+	struct nfs4_client *clp = NULL;
 	struct nfsd4_slot *slot;
 	struct nfsd4_conn *conn;
 	__be32 status;
@@ -3941,6 +3977,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (conn)
 		free_conn(conn);
 	spin_unlock(&nn->client_lock);
+	if (clp && test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
+		if (status == nfs_ok)
+			nfsd4_client_record_create(clp);
+		else
+			nfsd4_discard_courtesy_clnt(clp);
+	}
 	return status;
 out_put_session:
 	nfsd4_put_session_locked(session);
-- 
2.9.5

