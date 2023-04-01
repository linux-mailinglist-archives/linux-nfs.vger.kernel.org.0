Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5916D6D33D5
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Apr 2023 22:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDAUdy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Apr 2023 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDAUdy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Apr 2023 16:33:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACAF2658B
        for <linux-nfs@vger.kernel.org>; Sat,  1 Apr 2023 13:33:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 331KMcMq020724
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=KqyatoJIl9O/8tj5OBBN7ctr2XcXZqoCRkphS+O0B8I=;
 b=DuGJfKn/RnJYMszvZTaFiVqqdJvtFzOvNRsCEn8ouHM9Xiy0LVJJnKM9YUHmqSzqnjRX
 zaa+bfkEF752boCo7AYBZOsMee3eNLZcuc9vRNMlH6xcC8ZJYvPsDMoqSG0nEqKNcN8M
 ulDcU/uXIDF9eoTwmuJQQOm9Ndqu3HwI3kb0YODd5bwcTT1i204oks/ALNQotmcmX6Ki
 Nly9IcUNsgJCpGnpzX0eBWbF46FJfhVaFMPoXu2heVm436UxtHRfcBjkLvtJ8Aij+YgU
 /ubhqT9QNlcl2f/r/pH18Wj81nvJbDb8R/qfvzz7KREwxXkf9/V3DnWe3LXikuGkRKSi Cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5u8su9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 01 Apr 2023 20:33:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 331JKExf018458
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:33:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp39jgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 01 Apr 2023 20:33:51 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 331KXoXr005843
        for <linux-nfs@vger.kernel.org>; Sat, 1 Apr 2023 20:33:50 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptp39jet-1;
        Sat, 01 Apr 2023 20:33:50 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     calum.mackay@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [pynfs PATCH v2] DELEG8: adding delay to allow delegation to be revoked
Date:   Sat,  1 Apr 2023 13:33:42 -0700
Message-Id: <1680381222-23409-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304010188
X-Proofpoint-ORIG-GUID: 8zBofj7xJ3O_QG0HYdyu71TNLHgrkWj-
X-Proofpoint-GUID: 8zBofj7xJ3O_QG0HYdyu71TNLHgrkWj-
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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

