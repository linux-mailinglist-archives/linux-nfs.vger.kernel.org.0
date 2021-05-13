Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EE937FD4F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 20:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhEMSh3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 14:37:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhEMSh2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 14:37:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DIUlco186722;
        Thu, 13 May 2021 18:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=HFpI1g6ynFM379E934otrQzV/pJP/N4UPusZ1eOLnUg=;
 b=P4ZvxEaIB1TMEBZSqVn8M3xOK3JlU/TM53ijINQJ7tN4uUU3GUbU1lhyAC2qG4Zc0IHM
 qsqnB9FFGyJOrWCzdfx9jzlh14gM4zVMs+k5/iIfqYvR8kc6uw7AzrRotB2eXGWwJP0k
 S6zuuh/iTcJhypbkDR4iemCrDMJQHq2ZvYQmcTpPbdmtLGYBNsb0Lbt/eSNUZhTYWm5V
 /ccD+zdinQpnST/XzKXCSJ0CkQeAJCV1ZynPVPC+hELRpIZgQJuGYj5xa1xDgOkBr6Ht
 PxKWLpoKIr67a/Rbhk/n6/gh97876iAdvQ1/59FNqmT6zTDy7bOhLi423Glt//rKwtrK XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38gpnujghb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 18:36:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DIUqv9080082;
        Thu, 13 May 2021 18:36:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38gppc38gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 18:36:12 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14DIaBOQ135682;
        Thu, 13 May 2021 18:36:11 GMT
Received: from userp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 38gppc38ex-1;
        Thu, 13 May 2021 18:36:11 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4: nfs4_proc_set_acl needs to restore NFS_CAP_UIDGID_NOMAP on error.
Date:   Thu, 13 May 2021 14:35:55 -0400
Message-Id: <20210513183555.28230-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aOlUiK2W6J6HqmXZNOo6TCcDxONi5YXs
X-Proofpoint-GUID: aOlUiK2W6J6HqmXZNOo6TCcDxONi5YXs
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130129
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently if __nfs4_proc_set_acl fails with NFS4ERR_BADOWNER it
re-enables the idmapper by clearing NFS_CAP_UIDGID_NOMAP before
retrying again. The NFS_CAP_UIDGID_NOMAP remains cleared even if
the retry fails. This causes problem for subsequent setattr
requests for v4 server that does not have idmapping configured.

Steps to reproduce the problem:

 # mount -o vers=4.1,sec=sys server:/export/test /tmp/mnt
 # touch /tmp/mnt/file1
 # chown 99 /tmp/mnt/file1
 # nfs4_setfacl -a A::unknown.user@xyz.com:wrtncy /tmp/mnt/file1
 Failed setxattr operation: Invalid argument
 # chown 99 /tmp/mnt/file1
 chown: changing ownership of ‘/tmp/mnt/file1’: Invalid argument
 # umount /tmp/mnt
 # mount -o vers=4.1,sec=sys server:/export/test /tmp/mnt
 # chown 99 /tmp/mnt/file1
 #

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs4proc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c65c4b41e2c1..e12630e3bb7c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5926,13 +5926,20 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
 static int nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t buflen)
 {
 	struct nfs4_exception exception = { };
-	int err;
+	struct nfs_server *server = NFS_SERVER(inode);
+	int err, nomap;
+
+	nomap = server->caps & NFS_CAP_UIDGID_NOMAP;
 	do {
 		err = __nfs4_proc_set_acl(inode, buf, buflen);
 		trace_nfs4_set_acl(inode, err);
 		err = nfs4_handle_exception(NFS_SERVER(inode), err,
 				&exception);
 	} while (exception.retry);
+
+	/* if retry still fails then restore NFS_CAP_UIDGID_NOMAP setting */
+	if (err && nomap)
+		server->caps |= NFS_CAP_UIDGID_NOMAP;
 	return err;
 }
 
-- 
2.9.5

