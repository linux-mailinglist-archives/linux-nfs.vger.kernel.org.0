Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844846D33CC
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Apr 2023 22:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjDAUYx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Apr 2023 16:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDAUYx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Apr 2023 16:24:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9979E2658A
        for <linux-nfs@vger.kernel.org>; Sat,  1 Apr 2023 13:24:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 331KH3lM020367
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=kMIrTzgu6YWn8QMi/VH2mILByr+W63zoDPWoRYVJi7s=;
 b=bhI9QqaiGpByWc5lM/a0mJsx8QAR8zDX/oxeWIsQBD86IMSAXihO/yyhOnGVECyNx9pb
 81O8ArfbvWbOaGyk7urZCobekwSMbAd7ftjb3F+9YK2LjQNSBhZwg+alwkCK8RnD6HRp
 o7hA3Nyd6JTNivM4Ik//BUCgkFoX+Z+Yl5vced0qfmU6oAoSHS6DrANxprr6y0L2+Ft9
 QkGO4aHRQWfkGCQ5PuBxR4VUUHVAX4b/lgq+AqnsN2rQftobtXnPLc9XMhQLgDECjtDr
 oOo2oaJSiSIuqUpbgk7kKKFriEKY8k5R81G9j1I5A8OUu6n3cwbq4IEMxsYhbZGxWjSC wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb71gvaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 01 Apr 2023 20:24:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 331JColB038324
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:24:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjn9hv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 01 Apr 2023 20:24:50 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 331KOoNL026624
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:24:50 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptjn9huw-1;
        Sat, 01 Apr 2023 20:24:50 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     calum.mackay@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [pynfs PATCH] DELEG8: adding delay to allow delegation to be revoked
Date:   Sat,  1 Apr 2023 13:24:36 -0700
Message-Id: <1680380676-22609-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304010187
X-Proofpoint-ORIG-GUID: 6PcdK8m0yZ6Rst1oeTXarpt-IEkG1EqJ
X-Proofpoint-GUID: 6PcdK8m0yZ6Rst1oeTXarpt-IEkG1EqJ
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: root <root@nfsvmd07.us.oracle.com>

**************************************************
DELEG8   st_delegation.testDelegRevocation                        : FAILURE
           RuntimeError: Out of slots
**************************************************

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 nfs4.1/server41tests/st_delegation.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/server41tests/st_delegation.py
index a25a042..b0fcb0e 100644
--- a/nfs4.1/server41tests/st_delegation.py
+++ b/nfs4.1/server41tests/st_delegation.py
@@ -9,6 +9,10 @@ op = nfs_ops.NFS4ops()
 import nfs4lib
 import threading
 
+def _getleasetime(sess):
+    res = sess.compound([op.putrootfh(), op.getattr(1 << FATTR4_LEASE_TIME)])
+    return res.resarray[-1].obj_attributes[FATTR4_LEASE_TIME]
+
 def _got_deleg(deleg):
     return (deleg.delegation_type != OPEN_DELEGATE_NONE and
             deleg.delegation_type != OPEN_DELEGATE_NONE_EXT)
@@ -179,11 +183,16 @@ def testDelegRevocation(t, env):
     how = openflag4(OPEN4_NOCREATE)
     open_op = op.open(0, OPEN4_SHARE_ACCESS_WRITE, OPEN4_SHARE_DENY_NONE,
                         owner, how, claim)
+    secs = _getleasetime(sess1) / 2
     while 1:
         res = sess2.compound(env.home + [open_op])
         if res.status == NFS4_OK:
             break;
         check(res, [NFS4_OK, NFS4ERR_DELAY])
+
+	# allow time for the delegation to be revoked
+        env.sleep(secs)
+
         # just to keep sess1 renewed.  This is a bit fragile, as we
         # depend on the above compound waiting no longer than the
         # server's lease period:
-- 
2.27.0

