Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B66F6D33C9
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Apr 2023 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjDAUW1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Apr 2023 16:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDAUW1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Apr 2023 16:22:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A53B46F
        for <linux-nfs@vger.kernel.org>; Sat,  1 Apr 2023 13:22:26 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3313IwS7027015
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=XLJT5eSV97fI2ryXuSJzCS33QN/pPjAfrUZc4fdWNwA=;
 b=eF0HOJPox2bTdEoK8yZGut6ZDZmNuUnEwtOZVTDXRlrmlnt7Cx7vY/WzR6vEeS6rUmJt
 Az03RSgMe6dxMXQiJTdD0cxcH64hUOZFy9w/Xm946noMx3LVIXMgNimLeOdrY3pY9oRE
 4g9AG005pj1itDbq5Pifu59RZx1IALRPGAuIQNLlSCYWnaTMpt2Vq0ldsxMGoqAzT+1j
 Ho6lMFPV4LPLlFp88Im3ZXuxT0Wvu/M6F6FSrtjqVjAdxhqpfkI5+UoZ3kwyi9Hv5SIk
 g20nsCQt7+UnRrIJQ2+XfAW49z4xcrxIb4Vnrc/DVXtyo6Q9Hk0cdvJhyyrqgrNN+GJu AQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbhbruwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 01 Apr 2023 20:22:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 331JK6W1017930
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:22:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp39anh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 01 Apr 2023 20:22:24 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 331KMNSv023448
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:22:23 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptp39am7-1;
        Sat, 01 Apr 2023 20:22:23 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: callback request does not use correct credential for AUTH_SYS
Date:   Sat,  1 Apr 2023 13:22:08 -0700
Message-Id: <1680380528-22306-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304010186
X-Proofpoint-GUID: JYOhCNsatbQihUqMU_Lbyi9VofT3ter0
X-Proofpoint-ORIG-GUID: JYOhCNsatbQihUqMU_Lbyi9VofT3ter0
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently callback request does not use the credential specified in
CREATE_SESSION if the security flavor for the back channel is AUTH_SYS.

Problem was discovered by pynfs 4.1 DELEG5 and DELEG7 test with error:
DELEG5   st_delegation.testCBSecParms     : FAILURE
           expected callback with uid, gid == 17, 19, got 0, 0

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 2a815f5a52c4..4039ffcf90ba 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -946,8 +946,8 @@ static const struct cred *get_backchannel_cred(struct nfs4_client *clp, struct r
 		if (!kcred)
 			return NULL;
 
-		kcred->uid = ses->se_cb_sec.uid;
-		kcred->gid = ses->se_cb_sec.gid;
+		kcred->fsuid = ses->se_cb_sec.uid;
+		kcred->fsgid = ses->se_cb_sec.gid;
 		return kcred;
 	}
 }
-- 
2.9.5

