Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9044C1ABE
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 19:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiBWSRO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 13:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbiBWSRM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 13:17:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49B03EAA3
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 10:16:44 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NIDrF5001879;
        Wed, 23 Feb 2022 18:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=SmAUODvkqaf9mGb+3zygEAH0N35O0ouxz14SUhCVduc=;
 b=LBFf2jT5xkJ7eXlh9/tNdiaTKCDwksOxFPbZD76Ah1UDkYFB3nH7wQf5BC74+4Jz8kkp
 ARHb13fA/QC8ZzReYK7uJk3z3dMJKdGnyvXNcFDoiDrNLIgduivztJD63cNDx6wJZ6hL
 c+I0TsG5jmRUjmSg0Ko3MzUCDbCsLMUz4Thl1/JnwWHU561a1TsJhDDTY7RAaaIoEO57
 CCgcAfyw9bdX9Ce0Knb/TvrMhF8w9lU22sFMsKdhPf7es9+EI/vsA+8le9Gr9HUeCU9A
 P7e9zQTjPf8i5uSvc8iCjctr874RRIQr5ZLBXHs/Mz5lH5uWZlHcdyclB0dPkd9581q4 uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecv6evxpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:16:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21NIAtuJ155985;
        Wed, 23 Feb 2022 18:16:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3eapkj17qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 18:16:42 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21NICxfW162308;
        Wed, 23 Feb 2022 18:16:42 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3eapkj17pe-4;
        Wed, 23 Feb 2022 18:16:42 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v14 03/10] NFSD: Update nfsd_breaker_owns_lease() to handle courtesy clients
Date:   Wed, 23 Feb 2022 10:16:30 -0800
Message-Id: <1645640197-1725-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: 2KVumqflwnuq-0hl45taFrSwSNoH1TDc
X-Proofpoint-ORIG-GUID: 2KVumqflwnuq-0hl45taFrSwSNoH1TDc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Update nfsd_breaker_owns_lease() to handle delegation conflict
with courtesy clients. If conflict was caused courtesy client
then discard the courtesy client by setting CLIENT_EXPIRED and
return conflict resolved. Client with CLIENT_EXPIRED is expired
by the laundromat.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6bca727978ea..542a13676c91 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4727,6 +4727,24 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
+	clp = dl->dl_stid.sc_client;
+	/*
+	 * need to sync with courtesy client trying to reconnect using
+	 * the cl_cs_lock, nn->client_lock can not be used since this
+	 * function is called with the fl_lck held.
+	 */
+	spin_lock(&clp->cl_cs_lock);
+	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
+		spin_unlock(&clp->cl_cs_lock);
+		return true;
+	}
+	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+		set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
+		spin_unlock(&clp->cl_cs_lock);
+		return true;
+	}
+	spin_unlock(&clp->cl_cs_lock);
+
 	if (!i_am_nfsd())
 		return false;
 	rqst = kthread_data(current);
-- 
2.9.5

