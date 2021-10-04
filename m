Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FC7421A52
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 00:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhJDWzP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 18:55:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61334 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233501AbhJDWzO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Oct 2021 18:55:14 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194LiiK1029426;
        Mon, 4 Oct 2021 22:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=6IjbFoEfYg3t2ZGVhT1YwTurJTvbIpQfdNL+BhA3fDA=;
 b=nriOzoS7kQMZxzgrpgpv2RF95EbbXvuYQlZmA+ssdh4lkbVPPi+nssFnfWZsmWZgabj6
 qYviIyW4IlJVPMh9c+UtJ+te6/yy4n+/3do86Ho7D3Pzi+qYBb7BX2g+MLi1JWIDoNv4
 dwsiaYR9eD8EPJjMSHyp44RheaHatekiW0IMZk2DDOOfddwUHgr0cJxGAC7uF9lYSTZW
 d///Qkf3aBRdJ/fMEqw1KVtlFNAlv+kwkfjVxGXM6FA52yIRPVG1HSNVOSAkHaqeG+gj
 kaBls0BghnzAm4yDxTRR6sm63oqrYvn86n5Zx92SO/Som4BHH8y8aWCQfN82dWEjW50J Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kk7rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 22:53:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194MoHKI142374;
        Mon, 4 Oct 2021 22:53:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3bev8vuj7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 22:53:23 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 194MrMni163982;
        Mon, 4 Oct 2021 22:53:22 GMT
Received: from userp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 3bev8vuj7c-1;
        Mon, 04 Oct 2021 22:53:22 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] st_courtesy.py: add more tests for Courteous Server
Date:   Mon,  4 Oct 2021 18:53:20 -0400
Message-Id: <20211004225320.25368-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IM_IRKQEdvPmpqfp4K1sWC1Eeroxnkd4
X-Proofpoint-ORIG-GUID: IM_IRKQEdvPmpqfp4K1sWC1Eeroxnkd4
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

COUR3: Test OPEN file with OPEN4_SHARE_DENY_WRITE
COUR4: Test Share Reservation. Test 2 clients with same deny mode
COUR5: Test Share Reservation. Test Courtesy client's file access mode
       conflicts with deny mode
COUR6: Test Share Reservation. Test Courtesy client's deny mode conflicts
       with file access mode

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 nfs4.1/server41tests/st_courtesy.py | 230 ++++++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/nfs4.1/server41tests/st_courtesy.py b/nfs4.1/server41tests/st_courtesy.py
index dd911a37772d..f810aa4ac557 100644
--- a/nfs4.1/server41tests/st_courtesy.py
+++ b/nfs4.1/server41tests/st_courtesy.py
@@ -9,6 +9,9 @@ from xdrdef.nfs4_type import open_to_lock_owner4
 import nfs_ops
 op = nfs_ops.NFS4ops()
 import threading
+import logging
+
+log = logging.getLogger("test.env")
 
 
 def _getleasetime(sess):
@@ -73,6 +76,8 @@ def testLockSleepLock(t, env):
 
     c2 = env.c1.new_client(b"%s_2" % env.testname(t))
     sess2 = c2.create_session()
+    res = sess2.compound([op.reclaim_complete(FALSE)])
+    check(res)
 
     res = open_file(sess2, env.testname(t), access=OPEN4_SHARE_ACCESS_WRITE)
     check(res)
@@ -81,3 +86,228 @@ def testLockSleepLock(t, env):
     stateid = res.resarray[-2].stateid
     res = sess2.compound(cour_lockargs(fh, stateid))
     check(res, NFS4_OK)
+
+
+def testShareReservation00(t, env):
+    """Test OPEN file with OPEN4_SHARE_DENY_WRITE
+       1st client opens file with OPEN4_SHARE_DENY_WRITE
+       1st client opens same file with OPEN4_SHARE_ACCESS_BOTH and OPEN4_SHARE_DENY_NONE
+           expected reply is NFS4ERR_SHARE_DENIED
+       2nd client opens file with OPEN4_SHARE_ACCESS_WRITE
+           expected reply is NFS4ERR_SHARE_DENIED
+       sleep to force lease of client 1 to expire
+       3rd client opens file with OPEN4_SHARE_ACCESS_WRITE
+           expected reply is NFS4_OK
+
+    FLAGS: courteous all
+    CODE: COUR3
+    """
+
+    sess1 = env.c1.new_client_session(env.testname(t))
+    res = create_file(sess1, env.testname(t), want_deleg=False, deny=OPEN4_SHARE_DENY_WRITE)
+    check(res)
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    claim = open_claim4(CLAIM_FH)
+    how = openflag4(OPEN4_NOCREATE)
+    oowner = open_owner4(0, b"My Open Owner 2")
+    access = OPEN4_SHARE_ACCESS_BOTH|OPEN4_SHARE_ACCESS_WANT_NO_DELEG
+    open_op = op.open(0, access, OPEN4_SHARE_DENY_NONE,
+                      oowner, how, claim)
+    res = sess1.compound([op.putfh(fh), open_op])
+    check(res, NFS4ERR_SHARE_DENIED)
+    log.info("local open conflict detected - PASSED\n")
+
+    """ 2nd client """
+    c2 = env.c1.new_client(b"%s_2" % env.testname(t))
+    sess2 = c2.create_session()
+    res = sess2.compound([op.reclaim_complete(FALSE)])
+    check(res)
+
+    name = env.testname(t)
+    owner = b"owner_%s" % name
+    path = sess1.c.homedir + [name]
+    res = open_file(sess2, owner, path, access=OPEN4_SHARE_ACCESS_WRITE)
+    check(res, NFS4ERR_SHARE_DENIED)
+    log.info("2nd client open conflict detected - PASSED\n")
+
+    """ force lease of both c1 to expire """
+    log.info("force lease to expire...\n")
+    lease_time = _getleasetime(sess1)
+    env.sleep(lease_time * 2, "twice the lease period")
+
+    """ 3rd client """
+    c3 = env.c1.new_client(b"%s_3" % env.testname(t))
+    sess3 = c3.create_session()
+    res = sess3.compound([op.reclaim_complete(FALSE)])
+    check(res)
+    log.info("C3 created...\n")
+
+    """ should succeed """
+    name = env.testname(t)
+    owner = b"owner_%s" % name
+    path = sess3.c.homedir + [name]
+    res = open_file(sess3, owner, path, access=OPEN4_SHARE_ACCESS_WRITE)
+    check(res)
+    log.info("3nd client opened OK - no conflict detected - PASSED\n")
+
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    res = close_file(sess3, fh, stateid=stateid)
+    check(res)
+
+
+def testShareReservationDB01(t, env):
+    """ Test 2 clients with same deny mode
+    Client 1 opens file with OPEN4_SHARE_ACCESS_WRITE &  OPEN4_SHARE_DENY_READ
+    Client 2 opens file with OPEN4_SHARE_ACCESS_WRITE &  OPEN4_SHARE_DENY_READ
+    Client 2 open should succeed
+
+    FLAGS: courteous all
+    CODE: COUR4
+    """
+
+    """ client1 creates file with OPEN4_SHARE_ACCESS_WRITE &  OPEN4_SHARE_DENY_READ """
+
+    sess1 = env.c1.new_client_session(env.testname(t))
+    res = create_file(sess1, env.testname(t), want_deleg=False,
+		access=OPEN4_SHARE_ACCESS_WRITE, deny=OPEN4_SHARE_DENY_READ)
+    check(res)
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    """ create 2nd client """
+    c2 = env.c1.new_client(b"%s_2" % env.testname(t))
+    sess2 = c2.create_session()
+    res = sess2.compound([op.reclaim_complete(FALSE)])
+    check(res)
+
+    """ client2 open file with OPEN4_SHARE_ACCESS_WRITE &  OPEN4_SHARE_DENY_READ """
+    name = env.testname(t)
+    owner = b"owner_%s" % name
+    path = sess2.c.homedir + [name]
+    res = open_file(sess2, owner, path, deny=OPEN4_SHARE_DENY_READ,
+		access=OPEN4_SHARE_ACCESS_WRITE|OPEN4_SHARE_ACCESS_WANT_NO_DELEG)
+    check(res)
+    fh2 = res.resarray[-1].object
+    stateid2 = res.resarray[-2].stateid
+
+    log.info("2nd client open OK - PASSED\n")
+
+    res = close_file(sess1, fh, stateid=stateid)
+    check(res)
+
+    res = close_file(sess2, fh2, stateid=stateid2)
+    check(res)
+
+def testShareReservationDB02(t, env):
+    """ Test courtesy client's file access mode conflicts with deny mode
+        client 1 creates file with OPEN4_SHARE_ACCESS_WRITE
+        sleep to force lease of client 1 to expire
+        client 2 opens file with OPEN4_SHARE_ACCESS_READ & OPEN4_SHARE_DENY_WRITE
+            expected reply is NFS4_OK
+
+    FLAGS: courteous all
+    CODE: COUR5
+    """
+
+    """ client1 creates file with OPEN4_SHARE_ACCESS_WRITE """
+
+    sess1 = env.c1.new_client_session(env.testname(t))
+    res = create_file(sess1, env.testname(t), want_deleg=False,
+		access=OPEN4_SHARE_ACCESS_WRITE)
+    check(res)
+    log.info("client 1 creates file OK\n")
+
+    """ force lease of client1 to expire """
+    log.info("force lease to expire...\n")
+    lease_time = _getleasetime(sess1)
+    env.sleep(lease_time + 10, "the lease period + 10 secs")
+
+    """ create 2nd client """
+    c2 = env.c1.new_client(b"%s_3" % env.testname(t))
+    sess2 = c2.create_session()
+    res = sess2.compound([op.reclaim_complete(FALSE)])
+    check(res)
+    log.info("created 2nd client OK\n")
+
+    """ 2nd client open file with OPEN4_SHARE_ACCESS_READ & OPEN4_SHARE_DENY_WRITE """
+    name = env.testname(t)
+    owner = b"owner_%s" % name
+    path = sess2.c.homedir + [name]
+    res = open_file(sess2, owner, path,
+		access=OPEN4_SHARE_ACCESS_READ|OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+		deny=OPEN4_SHARE_DENY_WRITE)
+    check(res)
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    log.info("2nd client open OK - PASSED\n")
+
+    res = close_file(sess2, fh, stateid=stateid)
+    check(res)
+
+def testShareReservationDB03(t, env):
+    """ Test courtesy clients' deny mode conflicts with file access mode
+    Client 1 opens file with with OPEN4_SHARE_ACCESS_WRITE &  OPEN4_SHARE_DENY_READ
+    Client 2 opens same file with with OPEN4_SHARE_ACCESS_WRITE &  OPEN4_SHARE_DENY_READ
+        expected reply is NFS4_OK
+    sleep to force lease of client 1 and client 2 to expire
+    client 3 opens same file with OPEN4_SHARE_ACCESS_READ
+        expected reply is NFS4_OK
+
+    FLAGS: courteous all
+    CODE: COUR6
+    """
+
+    """ client1 creates file with OPEN4_SHARE_ACCESS_WRITE &  OPEN4_SHARE_DENY_READ """
+    sess1 = env.c1.new_client_session(env.testname(t))
+    res = create_file(sess1, env.testname(t), want_deleg=False,
+		access=OPEN4_SHARE_ACCESS_WRITE, deny=OPEN4_SHARE_DENY_READ)
+    check(res)
+    log.info("client 1 creates file OK\n")
+
+    """ create 2nd client """
+    c2 = env.c1.new_client(b"%s_2" % env.testname(t))
+    sess2 = c2.create_session()
+    res = sess2.compound([op.reclaim_complete(FALSE)])
+    check(res)
+
+    name = env.testname(t)
+    owner = b"owner_%s" % name
+    path = sess2.c.homedir + [name]
+
+    res = open_file(sess2, owner, path,
+		access=OPEN4_SHARE_ACCESS_WRITE|OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+		deny=OPEN4_SHARE_DENY_READ)
+    check(res)
+    log.info("client 2 open file OK\n")
+
+    """ force lease of client1 and client2 to expire """
+    log.info("force lease to expire...\n")
+    lease_time = _getleasetime(sess1)
+    env.sleep(lease_time + 10, "the lease period + 10 secs")
+
+    """ create 3nd client """
+    c3 = env.c1.new_client(b"%s_3" % env.testname(t))
+    sess3 = c3.create_session()
+    res = sess3.compound([op.reclaim_complete(FALSE)])
+    check(res)
+    log.info("created 3rd client OK\n")
+
+    """ client3 open file with OPEN4_SHARE_ACCESS_READ """
+    name = env.testname(t)
+    owner = b"owner_%s" % name
+    path = sess3.c.homedir + [name]
+    res = open_file(sess3, owner, path,
+		access=OPEN4_SHARE_ACCESS_READ|OPEN4_SHARE_ACCESS_WANT_NO_DELEG)
+    check(res)
+    fh = res.resarray[-1].object
+    stateid = res.resarray[-2].stateid
+
+    log.info("3rd client open OK - PASSED\n")
+
+    res = close_file(sess3, fh, stateid=stateid)
+    check(res)
-- 
2.9.5

