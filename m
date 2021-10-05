Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C24423487
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 01:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhJEXna (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 19:43:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3398 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236911AbhJEXn3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 19:43:29 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195Mhh8B022634;
        Tue, 5 Oct 2021 23:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=Q/XGoB28xdHTj+RuD0YwxdlN8IEizicmjdn9+TbrViA=;
 b=hszq2G1u3H1SMXRHOfvupVhqQ4A8m4dAC7O6/puFHZzTY2OEYEdwAkpCd3K+QAQSoyQF
 LxP8Avgmvu2mA51VJRsVmo7lnTMThn7wHeMQLojtdDOFRR7mbYjPB6oojyszroS9rOyV
 sZJ5FPgNwPLXDtlt2aHmM2vCW63ZWBQ9ZLm/hs3kwDKkekEjkWv/3LCKTfBnAy6PD4Oi
 MLX8msIClc7u2Eh59CqKwXg9cnqFSr3fFTI8eOcjhrEHrurcKmLI4JGQ+x9Jb7gZUuax
 vuOpy4Hi0E+ZiAaxnd2Ahk/QaQ4fA+GBEho+mDDpfAM41kRaClcidr0EU2XC8/qdzn+q 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454kxhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 23:41:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195NeK0C048171;
        Tue, 5 Oct 2021 23:41:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3bev8xgyy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 23:41:27 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 195NfQfc052035;
        Tue, 5 Oct 2021 23:41:26 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 3bev8xgyx7-2;
        Tue, 05 Oct 2021 23:41:26 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] st_courtesy.py: Fix problem of missing RECLAIM_COMPLETE in COUR2
Date:   Tue,  5 Oct 2021 19:41:22 -0400
Message-Id: <20211005234123.41053-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20211005234123.41053-1-dai.ngo@oracle.com>
References: <20211005234123.41053-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WLGc7YEig1f7zHm8TOWnvlxiicX4tY90
X-Proofpoint-ORIG-GUID: WLGc7YEig1f7zHm8TOWnvlxiicX4tY90
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace new_client and create_session with new_client_session.

Fixes: 18553b92ba8d0 ("pynfs: courtesy: add a test to ensure server releases state appropriately")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 nfs4.1/server41tests/st_courtesy.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/server41tests/st_courtesy.py b/nfs4.1/server41tests/st_courtesy.py
index dd911a37772d..a38ba30b6133 100644
--- a/nfs4.1/server41tests/st_courtesy.py
+++ b/nfs4.1/server41tests/st_courtesy.py
@@ -69,10 +69,9 @@ def testLockSleepLock(t, env):
     check(res, NFS4_OK)
 
     lease_time = _getleasetime(sess1)
-    env.sleep(lease_time * 2, "twice the lease period")
+    env.sleep(lease_time + 10, "the lease period + 10 secs")
 
-    c2 = env.c1.new_client(b"%s_2" % env.testname(t))
-    sess2 = c2.create_session()
+    sess2 = env.c1.new_client_session(b"%s_2" % env.testname(t))
 
     res = open_file(sess2, env.testname(t), access=OPEN4_SHARE_ACCESS_WRITE)
     check(res)
-- 
2.9.5

