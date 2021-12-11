Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FFB471105
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Dec 2021 03:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhLKC6O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Dec 2021 21:58:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19026 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229886AbhLKC6N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Dec 2021 21:58:13 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BANhjt4012060;
        Sat, 11 Dec 2021 02:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=8lNd4QXK3HIT24k4e39qqgQbqsZkAeb/0Qr2owSQ94U=;
 b=S11K+hPJHHf2LdS/j7Sc57J4ivlo1J3msbboeq099b7QhcUR9H3XepNbjoN66t9k5t1l
 RNE0AAVivTuASpYQiIiDB5WmNZHRtllgPCxpU2XElL6EjmHgxFu/283dzdwtK+l39Ido
 mJsbuR6/ky4Vr0lwqdvUDXsTAJ7V3FSDmA8cpuE+tF/9Yf99ti6ebv9kLm+wXyNAqxOx
 5FFJQNr5cCX1x2+3wqlYyA9sKRmBmgv+3eo8BNq0Xybo8vlI/WRWF4wjUhbRVyaBOQit
 z3TrmYKrEhb4oB+SuvimfxDes33ws5mTBFnWyTg0UA+puag34IK4nvOyjvZF8mPqYu9h oQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cve1v0db6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 02:54:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BB2jLEb037606;
        Sat, 11 Dec 2021 02:54:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3cvh3se94u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 02:54:32 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BB2sWvl070520;
        Sat, 11 Dec 2021 02:54:32 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 3cvh3se944-1;
        Sat, 11 Dec 2021 02:54:32 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v3] pynfs: nfs4.0 enhance open_confirm to work with courteous server.
Date:   Fri, 10 Dec 2021 21:54:21 -0500
Message-Id: <20211211025421.53910-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JGcwolt79uJPVLL2q2lxBn9AqFzVCZSa
X-Proofpoint-ORIG-GUID: JGcwolt79uJPVLL2q2lxBn9AqFzVCZSa
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Linux NFSv4 courteous server resolves share reservation conflicts
with courtesy clients asynchronously and returning NFS4ERR_DELAY
to the client.

v2:
stop test after timed out on NFS4ERR_DELAY

v3:
add pynfs: on subject line

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 nfs4.0/nfs4lib.py | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
index 934def3b7333..1feb103e20d9 100644
--- a/nfs4.0/nfs4lib.py
+++ b/nfs4.0/nfs4lib.py
@@ -723,8 +723,19 @@ class NFS4Client(rpc.RPCClient):
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
+                if cnt <= 5:
+                    time.sleep(2)
+                else:
+                    raise UnexpectedCompoundRes("OPEN timed out on NFS4ERR_DELAY")
         return self.confirm(owner, res)
 
 ##     def xxxopen_claim_prev(self, owner, fh, seqid=None,
-- 
2.27.0

