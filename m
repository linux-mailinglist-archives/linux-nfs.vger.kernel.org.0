Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB84153181D
	for <lists+linux-nfs@lfdr.de>; Mon, 23 May 2022 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiEWTnV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 May 2022 15:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbiEWTmx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 May 2022 15:42:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01BC100
        for <linux-nfs@vger.kernel.org>; Mon, 23 May 2022 12:42:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NGup4q017035;
        Mon, 23 May 2022 19:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=mn+Q9QuwfK7d78DY4tAXqj50t7oCfxl/mPaZ4z61e5s=;
 b=Vr5caOE0ClHoR1YiZy7QO4x9gYtWh9UKVr+5PIut1gjescbQ+p2mIL1kf9vJjXbE2J1z
 siAl5N1jGfz4qVl/ZxxGteZsn7vrPrdLyzF0Tah8AewTdhNbRf7ZROPBsMA7uQKGTQpn
 k/KgmqyXKgztceeHa8Z6AWkqelBm08RxVNcoLr7nUEmAUzKijxSL6u5MshsX6uuGQQ3O
 VZkAIvLaXzB1PWw05QJQ8+rLq8cCFpJr5czfoHzD0EmprXR/oFZfSzvdLbHeghR9IfP0
 +bZkZ4wy+RA5IEXCiAx9vCB0fQI54ZazAKW/VQvU63wuxjzFhps9WMXyc/T9fuYCz2qZ sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6qps4g5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 19:42:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NJeINI003887;
        Mon, 23 May 2022 19:42:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1wcma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 19:42:34 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24NJgYsU009551;
        Mon, 23 May 2022 19:42:34 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1wcm6-1;
        Mon, 23 May 2022 19:42:34 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] Add pynfs4.0 release lockowner test RLOWN2
Date:   Mon, 23 May 2022 12:42:30 -0700
Message-Id: <1653334950-8762-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-ORIG-GUID: ImFfzvuTxHQR-o_a82FYF968KJc9SAWi
X-Proofpoint-GUID: ImFfzvuTxHQR-o_a82FYF968KJc9SAWi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: root <root@nfsvme14.us.oracle.com>

Add RLOWN2, similar to RLOWN1 but remove the file before release
lockowner. This test is to exercise to code path causing problem
of being blocked in nfsd_file_put while holding the cl_client lock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 nfs4.0/servertests/st_releaselockowner.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/nfs4.0/servertests/st_releaselockowner.py b/nfs4.0/servertests/st_releaselockowner.py
index ccd10ff..50cef88 100644
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
+    res = c.lock_file(t.word(), fh, stateid, lockowner=b"lockowner_RLOWN1")
+    check(res)
+    res = c.unlock_file(1, fh, res.lockid)
+    check(res)
+
+    ops = c.use_obj(c.homedir) + [op.remove(t.word())]
+    res = c.compound(ops)
+    check(res)
+
+    # Release lockowner
+    owner = lock_owner4(c.clientid, b"lockowner_RLOWN1")
+    res = c.compound([op.release_lockowner(owner)])
+    check(res)
-- 
1.8.3.1

