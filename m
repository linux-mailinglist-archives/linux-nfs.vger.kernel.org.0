Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88F5471005
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Dec 2021 02:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhLKCCb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Dec 2021 21:02:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43566 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229462AbhLKCCa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Dec 2021 21:02:30 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BANhcru030122;
        Sat, 11 Dec 2021 01:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=wEDmKxVKejqFcS4LfW3qOHrn7F414S3PVl1q2Lbn/6w=;
 b=B19VJZnR48aWI6agBX3nAPAfk/9KSX+2cHFCPY4c2I0VMCT/NyfYd8sCsGll4ExrjE8N
 EqQ1bx6q1e6nqOj8GJQHrpJkfOxa8ZifhP0SErjvGCDVQzTEqSPAF5dKhm+1eb4mNGPE
 F9KqgwJLFEQMiWLTPn1LHCCJrgXOh9xHt+oJHh6lifkXbXCv4Nq3+yI/20VQ4cVbD7sI
 Au0MBqSw8huxsXVDSIQVz5rbyqhKFy8fzgU0aWNWVL8CJ7ZIGd6DGCpgJGlslfUlSfg1
 WY+fXsscffPgoe1/gy0CafCaw7giMCZeYr+ZAB8QPkImoMnh3lxiY3RpQaqOUj1OSNCz 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cve1ugc3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 01:58:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BB1vSes077245;
        Sat, 11 Dec 2021 01:58:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3cvh3scbe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 01:58:53 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BB1wqNB079783;
        Sat, 11 Dec 2021 01:58:52 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 3cvh3scbdh-1;
        Sat, 11 Dec 2021 01:58:52 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC 1/1] nfs4.0 enhance open_confirm to work with courteous server.
Date:   Fri, 10 Dec 2021 20:58:45 -0500
Message-Id: <20211211015845.49508-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7b2n2munQofyAxhqXTb9L7uGU0Wt7Ncx
X-Proofpoint-ORIG-GUID: 7b2n2munQofyAxhqXTb9L7uGU0Wt7Ncx
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Linux NFSv4 courteous server resolves share reservation conflicts
with courtesy clients asynchronously and returning NFS4ERR_DELAY
to the client.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 nfs4.0/nfs4lib.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
index 934def3b7333..60c833478ec3 100644
--- a/nfs4.0/nfs4lib.py
+++ b/nfs4.0/nfs4lib.py
@@ -723,8 +723,17 @@ class NFS4Client(rpc.RPCClient):
     def open_confirm(self, owner, path=None,
                      access=OPEN4_SHARE_ACCESS_READ,
                      deny=OPEN4_SHARE_DENY_WRITE):
-        res = self.open_file(owner, path, access, deny)
-        check_result(res, "Opening file %s" % _getname(owner, path))
+        while 1:
+            res = self.open_file(owner, path, access, deny)
+            cnt = 0
+            try:
+                 check_result(res, "Opening file %s" % _getname(owner, path))
+                 break
+            except BadCompoundRes:
+                if res.status != NFS4ERR_DELAY: raise
+                cnt += 1
+                if cnt < 5:
+                    time.sleep(2)
         return self.confirm(owner, res)
 
 ##     def xxxopen_claim_prev(self, owner, fh, seqid=None,
-- 
2.27.0

