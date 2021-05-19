Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46037389872
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 23:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhESVQm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 17:16:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38432 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhESVQl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 May 2021 17:16:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JL5FPu016750;
        Wed, 19 May 2021 21:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Lm54PilXyos0v19RVpmWyjzg9CazrKgyR5d07CMI83Q=;
 b=oQuKDFO0BbdFddbHDE2mlOZNPqCuOBNfNNFLEUOd7EtpXJAcsG2NMNvGZDB9glOBaQgb
 ucv3N968Pt3932o7RXv9MpjLDut2Y8q2KqvB0JPwV22oA8S6EHOwLLuft6lNiVJrs8lx
 AL1MZ0bvJb9PbIQDWnHmOI3QR+xin/tAeoKd/gppmya4hgfd6GDdM1KELByKSypTQT6d
 Zg8Z4O1gtz8J0ZDBTeKnxTuYzx78CHJe58oyM9knqeg19KP5jrQl4pXYlMuuei/G/4Dk
 UxO4Qt50r/23GvM9RSFEGw9oi5xf2grzVGkfa0es65M2jhl9iTUXxZ8UsL64Uu7iqwab /Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 38j5qrawxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 21:15:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JL5DQN092955;
        Wed, 19 May 2021 21:15:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38meegdxr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 21:15:15 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14JLCurC109484;
        Wed, 19 May 2021 21:15:14 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3030.oracle.com with ESMTP id 38meegdxqs-1;
        Wed, 19 May 2021 21:15:14 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSv4: nfs4_proc_set_acl needs to restore NFS_CAP_UIDGID_NOMAP on error.
Date:   Wed, 19 May 2021 17:15:10 -0400
Message-Id: <20210519211510.60253-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: unBrjnylxFkF7jNcmL1jndFF6PA9mEhe
X-Proofpoint-ORIG-GUID: unBrjnylxFkF7jNcmL1jndFF6PA9mEhe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9989 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190130
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently if __nfs4_proc_set_acl fails with NFS4ERR_BADOWNER it
re-enables the idmapper by clearing NFS_CAP_UIDGID_NOMAP before
retrying again. The NFS_CAP_UIDGID_NOMAP remains cleared even if
the retry fails. This causes problem for subsequent setattr
requests for v4 server that does not have idmapping configured.

This patch modifies nfs4_proc_set_acl to detect NFS4ERR_BADOWNER
and NFS4ERR_BADNAME and skips the retry, since the kernel isn't
involved in encoding the ACEs, and return -EINVAL.

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

v2: detect NFS4ERR_BADOWNER and NFS4ERR_BADNAME and skip retry
       in nfs4_proc_set_acl.
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs4proc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 87d04f2c9385..4e052c7f0614 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5968,6 +5968,14 @@ static int nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t buflen
 	do {
 		err = __nfs4_proc_set_acl(inode, buf, buflen);
 		trace_nfs4_set_acl(inode, err);
+		if (err == -NFS4ERR_BADOWNER || err == -NFS4ERR_BADNAME) {
+			/*
+			 * no need to retry since the kernel
+			 * isn't involved in encoding the ACEs.
+			 */
+			err = -EINVAL;
+			break;
+		}
 		err = nfs4_handle_exception(NFS_SERVER(inode), err,
 				&exception);
 	} while (exception.retry);
-- 
2.9.5

