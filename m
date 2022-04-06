Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5F4F6DFA
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 00:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbiDFWrs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Apr 2022 18:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbiDFWrm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Apr 2022 18:47:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0CC179422
        for <linux-nfs@vger.kernel.org>; Wed,  6 Apr 2022 15:45:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236KgkhR012570;
        Wed, 6 Apr 2022 22:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=0EQOOOdY4EGMVPmEDzzSC8tjUGihm8PKNfnZJ9IAmRs=;
 b=nIgYMfsFet+K0m10mxseZld80jQmLB0gQMKNY4BzwY5rE48/TWBrnu68K9HU4PCd73me
 FoqMAzMMwf3syQyfXUG4Z1BLh0DJsgx1FDdS7BNNpnCdeahJLTDvzoelR0rQbOZ6YhbF
 RBrtbO4bCuADx875XHLlT2qNfB2DuXh0ldJxm7DfFgNR+nVQqzQ15th4IqT0tXQ0sQ80
 Z9deWQW7Dsr1zBfzrdz733yxP+LzlAu9bHA7G3WauFxPgb0pvHxsIi0cKrzveCcbrl/G
 ZNXXeF8uiWOT3z/O9lSOSTVPb2vNSmr35dDRPgW9taF+8jh08f8J/HWD2cTyg69sOoGm SA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcj1k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236MeY3m011594;
        Wed, 6 Apr 2022 22:45:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:45:41 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 236Mjcbc021908;
        Wed, 6 Apr 2022 22:45:41 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9803d5mk-4;
        Wed, 06 Apr 2022 22:45:41 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v20 03/10] NFSD: Update nfsd_breaker_owns_lease() to handle courtesy client
Date:   Wed,  6 Apr 2022 15:45:26 -0700
Message-Id: <1649285133-16765-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
References: <1649285133-16765-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: nJZ0-yZGQk6wQjmJaiLfrVV89aIQ6TQK
X-Proofpoint-GUID: nJZ0-yZGQk6wQjmJaiLfrVV89aIQ6TQK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Update nfsd_breaker_owns_lease() to handle delegation conflict with
courtesy client by calling nfsd4_expire_courtesy_clnt.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 80772662236b..f20c75890594 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4727,6 +4727,9 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
+	if (nfsd4_expire_courtesy_clnt(dl->dl_stid.sc_client))
+		return true;
+
 	if (!i_am_nfsd())
 		return false;
 	rqst = kthread_data(current);
-- 
2.9.5

