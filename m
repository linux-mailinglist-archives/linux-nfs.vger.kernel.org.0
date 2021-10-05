Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C336423489
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 01:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhJEXnb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 19:43:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57842 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236909AbhJEXn2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 19:43:28 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195Mhkbm022505;
        Tue, 5 Oct 2021 23:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=sQVfAkKTQ2O/TwhTsO55YY6jvzhu/mT0tTAXAO4dL4w=;
 b=lEGJnHbLTnn0OgGMlsQxro3j8lkSeuXQ4J/Ieis/hBaE3Um7187xHmWwCmcSjHZQ7y8Q
 H02vul0+pwJZblTdwhz4ovSHrTLP04f3oXZWsLquS29JnJEWLOLxWXHdrsa+JzPeRW7F
 ynGY+qaV02QSrC9YDLOzbThgtcSTO/ej6UtN/mApg1GbWlOd49lUhG1JJ4EDF5MmdytT
 LPCQa4bCoWmpKp3hVbwJiPfjJx2voIpF82SVQhig4NSa0j3YQLQlGB6QAWefTO8Dsx0J
 sAyUlvjHYRAQtum2lgOy+nqoXQFXUkk14ZWXuEnjRTkKZKCw9GYER5FhAOgJSxbbqM6e bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5m7fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 23:41:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195NeKJl048220;
        Tue, 5 Oct 2021 23:41:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3bev8xgyy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 23:41:27 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 195NfQfe052035;
        Tue, 5 Oct 2021 23:41:27 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 3bev8xgyx7-3;
        Tue, 05 Oct 2021 23:41:27 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] st_courtesy.py: add more tests for Courteous Server
Date:   Tue,  5 Oct 2021 19:41:23 -0400
Message-Id: <20211005234123.41053-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20211005234123.41053-1-dai.ngo@oracle.com>
References: <20211005234123.41053-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BrNfVdsaqtIB09ZCUyeBslKZpwEFZ1qS
X-Proofpoint-GUID: BrNfVdsaqtIB09ZCUyeBslKZpwEFZ1qS
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
 nfs4.1/server41tests/st_courtesy.py | 204 ++++++++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/nfs4.1/server41tests/st_courtesy.py b/nfs4.1/server41tests/st_courtesy.py
index a38ba30b6133..c98a82b26fc9 100644
--- a/nfs4.1/server41tests/st_courtesy.py
+++ b/nfs4.1/server41tests/st_courtesy.py
@@ -9,7 +9,9 @@ from xdrdef.nfs4_type import open_to_lock_owner4
 import nfs_ops
 op = nfs_ops.NFS4ops()
 import threading
+import logging
 
+log = logging.getLogger("test.env")
 
 def _getleasetime(sess):
     res = sess.compound([op.putrootfh(), op.getattr(1 << FATTR4_LEASE_TIME)])
@@ -80,3 +82,205 @@ def testLockSleepLock(t, env):
     stateid = res.resarray[-2].stateid
     res = sess2.compound(cour_lockargs(fh, stateid))
     check(res, NFS4_OK)
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
+    sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
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
+    env.sleep(lease_time + 10, "the lease period + 10 secs")
+
+    """ 3rd client """
+    sess3 = env.c1.new_client_session(b"%s_3" % env.testname(t))
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
+    sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
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
+    """ Test courtesy clients' file access mode conflicts with deny mode
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
+    sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
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
+    sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
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
+    sess3 = env.c1.new_client_session(b"%s_3" % env.testname(t))
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

