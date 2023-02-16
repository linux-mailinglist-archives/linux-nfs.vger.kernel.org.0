Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE8699D49
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Feb 2023 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBPUBa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Feb 2023 15:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBPUB3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Feb 2023 15:01:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6417350340
        for <linux-nfs@vger.kernel.org>; Thu, 16 Feb 2023 12:01:28 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GJ0AhR020107;
        Thu, 16 Feb 2023 20:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=q67y1rytO3mbOA5fgIv0OJPkubkKmFNrWrITTLGoPVM=;
 b=J9E7nO1cqA8Z39PfQL55eB/VKmjUfoRGs3d0H1lz+hDf6VeeEwVcpqkICxukiJPIl3Q4
 phzdLc36lmvc2dkNhXobxlURRYDxE2YfBFQIMeus8sSJvhz8zTouvZnrVq2rk4oOgny6
 dlg7Qc9T+lxI6J3DfhU5JvM7Qwr94LWHodGUhPBJYBkGWcbBsqnoDe9/zEgh3IZnbOdI
 QAvzC8O0/dBtxWRxkbsmCOc/GoyQnT8nNzYnXVQMLo7gK/J21ARzhZeJHzoXNTaQXD2i
 r0AaLSTFKhcjUI7IO9azobS3XR2wd4TzCuvZah6mZszCSHD1IxDall0KOfBEgz2c900F lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2wa47xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 20:01:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31GJb1EL014076;
        Thu, 16 Feb 2023 20:01:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8txf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 20:01:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31GK1OGw035285;
        Thu, 16 Feb 2023 20:01:24 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3np1f8txet-1;
        Thu, 16 Feb 2023 20:01:24 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] st_opendowngrade.py: add open upgrade with deny mode tests
Date:   Thu, 16 Feb 2023 12:01:15 -0800
Message-Id: <1676577675-16451-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_16,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160172
X-Proofpoint-GUID: BEY6u6qaElOSdEhwS07_GJE2BJY4V6Iv
X-Proofpoint-ORIG-GUID: BEY6u6qaElOSdEhwS07_GJE2BJY4V6Iv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add 2 tests, OPDG12 and OPDG13, to test deny mode code paths in
nfs4_upgrade_open.

OPDG12: test open upgrade that has deny mode conflict with an active
client.

OPDG12: test open upgrade that has deny mode conflict with a courtesy
client.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 nfs4.0/servertests/st_opendowngrade.py | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/nfs4.0/servertests/st_opendowngrade.py b/nfs4.0/servertests/st_opendowngrade.py
index 59e975000724..de7e4d3db2b0 100644
--- a/nfs4.0/servertests/st_opendowngrade.py
+++ b/nfs4.0/servertests/st_opendowngrade.py
@@ -180,3 +180,65 @@ def testOpenDowngradeLock(t, env):
     os.open(OPEN4_SHARE_ACCESS_READ)
     os.downgrade(OPEN4_SHARE_ACCESS_READ)
     os.close()
+
+def testOpenUpgradeconflict(t, env):
+    """test open upgrade that conflicts with another active client
+
+    FLAGS: opendowngrade all
+    DEPEND: MKFILE
+    CODE:OPDG12
+    """
+    c = env.c1
+    c.init_connection()
+    os = open_sequence(c, t.word())
+    os.open(OPEN4_SHARE_ACCESS_WRITE)
+
+    c2 = env.c2
+    c2.init_connection()
+    res = c2.open_file(t.word(), access=OPEN4_SHARE_ACCESS_READ,
+                       deny=OPEN4_SHARE_DENY_NONE)
+    check(res)
+    fh, stateid = c2.confirm(t.word(), res)
+    res = c2.open_file(t.word(), access=OPEN4_SHARE_ACCESS_READ,
+                       deny=OPEN4_SHARE_DENY_WRITE)
+    check(res, NFS4ERR_SHARE_DENIED)
+
+    res = c2.close_file(t.word(), fh, stateid)
+    check(res)
+    os.close()
+
+def testOpenUpgradeCourtesy(t, env):
+    """test open upgrade that conflicts with courtesy client
+
+    FLAGS: opendowngrade all
+    DEPEND: MKFILE
+    CODE:OPDG13
+    """
+    c = env.c1
+    c.init_connection()
+    os = open_sequence(c, t.word())
+    os.open(OPEN4_SHARE_ACCESS_WRITE)
+    leasetime = c.getLeaseTime()
+    env.sleep(leasetime/2, "sleep 1/2 grace period")
+
+    c2 = env.c2
+    c2.init_connection()
+    owner = t.word()
+    res = c2.open_file(owner, access=OPEN4_SHARE_ACCESS_READ,
+                       deny=OPEN4_SHARE_DENY_NONE)
+    check(res)
+    fh, stateid = c2.confirm(owner, res)
+
+    env.sleep((leasetime/2) + 5, "wait for c1's lease to expire")
+    while 1:
+        res = c2.open_file(owner, access=OPEN4_SHARE_ACCESS_READ,
+                       deny=OPEN4_SHARE_DENY_WRITE)
+        if res.status == NFS4_OK: break
+        check(res, [NFS4_OK, NFS4ERR_DELAY],
+                   "Open which causes conflict with courtesy client")
+        env.sleep(2, 'Got NFS4ERR_DELAY on open')
+
+    fh = res.resarray[-1].switch.switch.object
+    stateid = res.resarray[-2].switch.switch.stateid
+    res = c2.close_file(owner, fh, stateid)
+    check(res)
-- 
2.27.0

