Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D62531DD1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 23:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiEWVdC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 17:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiEWVdB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 17:33:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A52AF1D6
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 14:32:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NKopaI030639;
        Mon, 23 May 2022 21:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=dZNXUXeXgK5dL2d7JT3Phu4zHUETku4KcgAEf1P35S4=;
 b=HQvdTeYlaOhDVPo/rjTZIC1HsmIMtU+K+X3IoPw2AMjX/1QF/2h1CV1H4fXiQ9dhpibS
 F5ywcSNoXlR2F9jmkMv0t8VNJ7Hklc9qSrFcAPz4TE+I2T6b7v0ergwZWmj/wwpzGz5u
 7KUYm8q2Hkb5Rq2jMiwssoVr4QuH0VQoWj0pAD0exVsnDA6r59kDfcjDzo5l6j9unjfs
 FPEf5+dZqEMMeHolC6TfqSvp3uCLd56/Buf+iM2c2kUi84RvyVKX2SQBuwMy+8c8dI+N
 Tj84Hpf74NjHRNovGWQMXZipQz1/P2lLPDd6y7NU8mUiHALw/JyihP2W8314eKLkopkV Pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pp04nex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 21:32:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NLK5mv018776;
        Mon, 23 May 2022 21:32:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph21vw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 21:32:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24NLWq5r011079;
        Mon, 23 May 2022 21:32:52 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph21vvr-1;
        Mon, 23 May 2022 21:32:52 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] Add pynfs4.0 release lockowner test RLOWN2
Date:   Mon, 23 May 2022 14:32:50 -0700
Message-Id: <1653341570-22461-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-ORIG-GUID: TdioVvHhskW6Q8FsOh_pPM7PFPjpQu8V
X-Proofpoint-GUID: TdioVvHhskW6Q8FsOh_pPM7PFPjpQu8V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add RLOWN2, similar to RLOWN1 but remove the file before release
lockowner. This test is to exercise to code path causing problem
of being blocked in nfsd_file_put while holding the cl_client lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 nfs4.0/servertests/st_releaselockowner.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/nfs4.0/servertests/st_releaselockowner.py b/nfs4.0/servertests/st_releaselockowner.py
index ccd10ff..2c83f99 100644
--- a/nfs4.0/servertests/st_releaselockowner.py
+++ b/nfs4.0/servertests/st_releaselockowner.py
@@ -24,3 +24,28 @@ def testFile(t, env):
     owner = lock_owner4(c.clientid, b"lockowner_RLOWN1")
     res = c.compound([op.release_lockowner(owner)])
     check(res)
+
+def testFile2(t, env):
+    """RELEASE_LOCKOWNER 2 - same as basic test but remove
+    file before release lockowner.
+
+    FLAGS: releaselockowner all
+    DEPEND:
+    CODE: RLOWN2
+    """
+    c = env.c1
+    c.init_connection()
+    fh, stateid = c.create_confirm(t.word())
+    res = c.lock_file(t.word(), fh, stateid, lockowner=b"lockowner_RLOWN2")
+    check(res)
+    res = c.unlock_file(1, fh, res.lockid)
+    check(res)
+
+    ops = c.use_obj(c.homedir) + [op.remove(t.word())]
+    res = c.compound(ops)
+    check(res)
+
+    # Release lockowner
+    owner = lock_owner4(c.clientid, b"lockowner_RLOWN2")
+    res = c.compound([op.release_lockowner(owner)])
+    check(res)
-- 
1.8.3.1

