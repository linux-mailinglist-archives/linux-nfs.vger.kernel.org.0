Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADAE788D16
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 18:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbjHYQQ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbjHYQQh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 12:16:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E78D1BD2;
        Fri, 25 Aug 2023 09:16:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDOX1V009444;
        Fri, 25 Aug 2023 16:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=7z1mQg7FsF16ZBgHpgLeLM1xQQq1Se2Dw/ItvW75ea0=;
 b=RUsHHgMv4RuGZugwAKJBf9lsoJPwcgmpYmTvaRLSPGSrs1xo0KvJ2QGOQ+Nzi+Hyz5C9
 d6TWOHC8uLT/EquwrOMCUI1NnF3ZlcVtBs7LVFrpTINIk3d4oXx7UJCq32kYNeXe2S1V
 aupQlJB+bWpcXbFq4wzjrxCZsE3OMFXbNCUkpBzuH3iOVQ+S+1NP2P3rCPYV0hf0Hdcb
 g7I6GDO7tVg+AuWJD4qxSZ+4THhayxs8vwyuUeF9o+3dSvYANh+flMgEKoHHnWWN2CDB
 Tp2mpf9zd6aqJ/tcyQJOs8Ccr3HEe/n2BkhnXsvasjsxx+E9EnxBB1jutkfSgfpELF2Z PQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvxnud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 16:16:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PG2Clv036084;
        Fri, 25 Aug 2023 16:16:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yxhth8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 16:16:24 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37PGGILZ030021;
        Fri, 25 Aug 2023 16:16:23 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1yxhtew-2;
        Fri, 25 Aug 2023 16:16:23 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     brauner@kernel.org, chuck.lever@oracle.com, bfields@fieldses.org,
        stable@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, hch@lst.de, jlayton@kernel.org,
        vegard.nossum@oracle.com, naresh.kamboju@linaro.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.1.y 1/2] nfs: use vfs setgid helper
Date:   Fri, 25 Aug 2023 09:16:02 -0700
Message-ID: <20230825161603.371792-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825161603.371792-1-harshit.m.mogalapalli@oracle.com>
References: <20230825161603.371792-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_14,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250145
X-Proofpoint-ORIG-GUID: XCnsGUBHYK0AvTpJdfjC85N_Bs8Q_-ul
X-Proofpoint-GUID: XCnsGUBHYK0AvTpJdfjC85N_Bs8Q_-ul
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

commit 4f704d9a8352f5c0a8fcdb6213b934630342bd44 upstream.

We've aligned setgid behavior over multiple kernel releases. The details
can be found in the following two merge messages:
cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2')
426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0')
Consistent setgid stripping behavior is now encapsulated in the
setattr_should_drop_sgid() helper which is used by all filesystems that
strip setgid bits outside of vfs proper. Switch nfs to rely on this
helper as well. Without this patch the setgid stripping tests in
xfstests will fail.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Message-Id: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
[Harshit: backport to 6.1.y]
Conflicts:
	fs/internal.h -- minor conflict due to code change differences.
	include/linux/fs.h -- Used struct user_namespace *mnt_userns
			instead of struct mnt_idmap *idmap
	fs/nfs/inode.c -- Used init_user_ns instead of nop_mnt_idmap

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 fs/attr.c          | 1 +
 fs/internal.h      | 2 --
 fs/nfs/inode.c     | 4 +---
 include/linux/fs.h | 2 ++
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index b45f30e516fa..9b9a70e0cc54 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -47,6 +47,7 @@ int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
 		return ATTR_KILL_SGID;
 	return 0;
 }
+EXPORT_SYMBOL(setattr_should_drop_sgid);
 
 /**
  * setattr_should_drop_suidgid - determine whether the set{g,u}id bit needs to
diff --git a/fs/internal.h b/fs/internal.h
index 46caa33373a4..42df013f7fe7 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -242,5 +242,3 @@ ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *po
 /*
  * fs/attr.c
  */
-int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
-			     const struct inode *inode);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 6b2cfa59a1a2..e0c1fb98f907 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -717,9 +717,7 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 		if ((attr->ia_valid & ATTR_KILL_SUID) != 0 &&
 		    inode->i_mode & S_ISUID)
 			inode->i_mode &= ~S_ISUID;
-		if ((attr->ia_valid & ATTR_KILL_SGID) != 0 &&
-		    (inode->i_mode & (S_ISGID | S_IXGRP)) ==
-		     (S_ISGID | S_IXGRP))
+		if (setattr_should_drop_sgid(&init_user_ns, inode))
 			inode->i_mode &= ~S_ISGID;
 		if ((attr->ia_valid & ATTR_MODE) != 0) {
 			int mode = attr->ia_mode & S_IALLUGO;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a2b5592c6828..26ea1a0a59a1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3120,6 +3120,8 @@ extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int setattr_should_drop_suidgid(struct user_namespace *, struct inode *);
 extern int file_remove_privs(struct file *);
+int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
+			     const struct inode *inode);
 
 /*
  * This must be used for allocating filesystems specific inodes to set
-- 
2.34.1

