Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2595B4C1ABF
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 19:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241817AbiBWSRQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 13:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242155AbiBWSRN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 13:17:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1783ED1F
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 10:16:45 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NIDlrE029457;
        Wed, 23 Feb 2022 18:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=1lXlqEw7TWDMwYFONEIfqtyIi2CZ8jjHv/6Uo2EWCow=;
 b=pxY2hA07eI9nhml5Nq8Ag7b2ev0d/+ueE/fAYde3oCCphmNdHCo+QsB2Z58uK1zeOPia
 V5CcbNitEklPGem5fXA5L4xjnoLPj2Jtf8lNn5PdjIbFz5xFQR6BgEsuMXes8IZ5S0ww
 ecLE2HioZBp9p9/XB7cgzK1Q3l8sr4jQYi6Bhp2pm8JcphwGugdc8YBlfTqSf2ShWPAr
 uyGnKe+yTJNQePjSbj0vI+afvVUMLprZX90cOR1bjN9xCSsT7pnwLrGjwPSUV2H9Z0s2
 3HecaeeK8yoFx4N0PgX3qfHwz6pXsMPA/I5z1VSah9BvSbT4b34ZyIglIWukqKi00NwS hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx54ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:16:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21NIAtHj155964;
        Wed, 23 Feb 2022 18:16:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3eapkj17rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:16:43 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21NICxfa162308;
        Wed, 23 Feb 2022 18:16:43 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3eapkj17pe-6;
        Wed, 23 Feb 2022 18:16:43 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v14 05/10] NFSD: Update find_clp_in_name_tree() to handle courtesy clients
Date:   Wed, 23 Feb 2022 10:16:32 -0800
Message-Id: <1645640197-1725-6-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: zJxmJc4g9umXBGl5C5AywxC41ZFAyeis
X-Proofpoint-GUID: zJxmJc4g9umXBGl5C5AywxC41ZFAyeis
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Update find_clp_in_name_tree:
 . skip client with CLIENT_EXPIRED flag; discarded courtesy client.
 . if courtesy client was found then clear CLIENT_COURTESY and
   set CLIENT_RECONNECTED so callers can take appropriate action.

Update find_confirmed_client_by_name to discard the courtesy
client; set CLIENT_EXPIRED.

Update nfsd4_setclientid to expire the confirmed courtesy client
to prevent multiple confirmed clients with the same name on the
the conf_id_hashtbl list.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1ffe7bafe90b..4990553180f8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2834,8 +2834,21 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
 			node = node->rb_left;
 		else if (cmp < 0)
 			node = node->rb_right;
-		else
+		else {
+			clear_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
+			/* sync with thread resolving lock/deleg conflict */
+			spin_lock(&clp->cl_cs_lock);
+			if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
+				spin_unlock(&clp->cl_cs_lock);
+				return NULL;
+			}
+			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
+				set_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
+			}
+			spin_unlock(&clp->cl_cs_lock);
 			return clp;
+		}
 	}
 	return NULL;
 }
@@ -2888,6 +2901,14 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
 	return NULL;
 }
 
+static void
+nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
+{
+	spin_lock(&clp->cl_cs_lock);
+	set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
+	spin_unlock(&clp->cl_cs_lock);
+}
+
 static struct nfs4_client *
 find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *nn)
 {
@@ -2914,8 +2935,15 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
 static struct nfs4_client *
 find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
 {
+	struct nfs4_client *clp;
+
 	lockdep_assert_held(&nn->client_lock);
-	return find_clp_in_name_tree(name, &nn->conf_name_tree);
+	clp = find_clp_in_name_tree(name, &nn->conf_name_tree);
+	if (clp && test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
+		nfsd4_discard_courtesy_clnt(clp);
+		clp = NULL;
+	}
+	return clp;
 }
 
 static struct nfs4_client *
@@ -4032,12 +4060,19 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
+	if (conf && test_bit(NFSD4_CLIENT_RECONNECTED, &conf->cl_flags)) {
+		cclient = conf;
+		conf = NULL;
+	}
+
 	if (conf && client_has_state(conf)) {
 		status = nfserr_clid_inuse;
 		if (clp_used_exchangeid(conf))
@@ -4068,7 +4103,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
-- 
2.9.5

