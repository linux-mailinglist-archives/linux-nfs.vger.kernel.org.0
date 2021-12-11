Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4DC471101
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Dec 2021 03:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhLKC42 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Dec 2021 21:56:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56636 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229886AbhLKC42 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Dec 2021 21:56:28 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BANhaGe030101;
        Sat, 11 Dec 2021 02:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=D9tDQtP9zrlPbhcL5dm5WV01+aXbMH58LQGVhH63uog=;
 b=u083oXrduzo1wxWIpbUBz7xI74GX3gL8H27bbsfiO/NkPH/wJRO/resdi460FlyA0+UO
 wKXJCmlMUfptQ+uU8bdU2JCTpu2EYZgmAdbuxbwpZ398GMxmRNC/j6ctmp9ZKHTkIpvf
 A/ZCbLlgsjUXrWsoGdGcKrfY3R0hTLaUIzmr/qzzckiYZTzSm2yD7FjfrDYk6bsb+uq3
 gtpHkFWoWbZgv/nyfyhDEMEH4co2+RwHmBG/V5yb6eIMONQvs47FXcy67M/y/lXJ62JV
 aJ553Kwp8wzqOBJ9+TZZccWq6jVgS7Dv0wSDcj9UIfXy3yrSKH05ZE0bCy57RSxvn2xc 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cve1ugd3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 02:52:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BB2jjdD034095;
        Sat, 11 Dec 2021 02:52:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3cvj1a27yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 02:52:50 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BB2qoOs063865;
        Sat, 11 Dec 2021 02:52:50 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3030.oracle.com with ESMTP id 3cvj1a27yd-1;
        Sat, 11 Dec 2021 02:52:50 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC v2] nfs4.0 enhance open_confirm to work with courteous server.
Date:   Fri, 10 Dec 2021 21:52:45 -0500
Message-Id: <20211211025245.53863-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KKZMdVWM7G_B1IuL05Pg_Qb7XyK7cjUr
X-Proofpoint-ORIG-GUID: KKZMdVWM7G_B1IuL05Pg_Qb7XyK7cjUr
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Linux NFSv4 courteous server resolves share reservation conflicts
with courtesy clients asynchronously and returning NFS4ERR_DELAY
to the client.

v2:
stop test after timed out on NFS4ERR_DELAY

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

