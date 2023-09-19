Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0C7A59F3
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Sep 2023 08:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjISGaz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Sep 2023 02:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjISGaz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Sep 2023 02:30:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7638116
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 23:30:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6Tger027599;
        Tue, 19 Sep 2023 06:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=Cd7nhRZ8pps0JFtVj4+l2knpMO+Ydf8LqlSQV63JA+0=;
 b=dPcV0nMBsjpcwrWKFSqBh1DOshmb3Bp94gBsizFJAgVniPd3Txb6IOS0bINqWT4px/B/
 k4/rN2meUwl6T4eKX1MTozh0duPiW4Z1Zd/4FL0xEk8NSjBt3NmvtajuIiUpVlp14FLZ
 EVKydu5UX5yqzv/ZKncx1JpjDnAQ5Q3kJvVRNrJZ5XZThDKx3aZB/zZXzc84XhnytQZE
 dNtomv1tz523cWSg8H+h91focEjSvyXfYVCe8UBnErqogdj937mYsp+VX6UTaAfJIvns
 Mhfko3N8xlzXJqeeNbTl9uItMa1tw6qoeBnVQ/GPFcHjJ09RN2yLaqwrjVsey9yX4ZLH ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t548bc3b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 06:30:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38J62IZp030083;
        Tue, 19 Sep 2023 06:30:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t57am4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 06:30:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J6Ugra011533;
        Tue, 19 Sep 2023 06:30:42 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t52t57akd-1;
        Tue, 19 Sep 2023 06:30:42 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     anna@kernel.org
Cc:     trondmy@hammerspace.com, linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/1] nfs42: client needs to strip file mode's suid/sgid bit after ALLOCATE op
Date:   Mon, 18 Sep 2023 23:30:20 -0700
Message-Id: <1695105020-5886-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190054
X-Proofpoint-GUID: kfkfZAYaq60CeQcW3fmx2gkDV7_yVDFb
X-Proofpoint-ORIG-GUID: kfkfZAYaq60CeQcW3fmx2gkDV7_yVDFb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The Linux NFS server strips the SUID and SGID from the file mode
on ALLOCATE op.

Modify _nfs42_proc_fallocate to add NFS_INO_REVAL_FORCED to
nfs_set_cache_invalid's argument to force update of the file
mode suid/sgid bit.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
v3 -> v4: add Suggested-by and Reviewed-by tag.

 fs/nfs/nfs42proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 63802d195556..9d2f07feeb29 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -81,7 +81,8 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 	if (status == 0) {
 		if (nfs_should_remove_suid(inode)) {
 			spin_lock(&inode->i_lock);
-			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+			nfs_set_cache_invalid(inode,
+				NFS_INO_REVAL_FORCED | NFS_INO_INVALID_MODE);
 			spin_unlock(&inode->i_lock);
 		}
 		status = nfs_post_op_update_inode_force_wcc(inode,
-- 
2.9.5

