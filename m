Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57741787BD4
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 01:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjHXXM2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 19:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbjHXXML (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 19:12:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE441BDB
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 16:12:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEVLo007542;
        Thu, 24 Aug 2023 23:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=qIHVze6MEfTI9sP8Qxv0jwDUKId/MD+r+2NKqNb078U=;
 b=LPuZQIDXq40qXEA2mS4dGmmQaf6czDpLKuLwUuGSzXdQOVkfYdiqPwWuZd47rK8hKiyh
 V79YEcCFLTt/IW4oWFb/8qBrqcOUpU35fT3i4DDNgf3+8UXK86veqHr8FhSrpnShIi1l
 Cw8bCDxXGxnnMaxPaLxDKdNUF1LR3CBNuCUp+Wa3JU/3KenfmP1pqhpcWDsRji4cc3yE
 QJ1fZs7HrCj2fxlbgr1uVIBk2o8sb9kCXv7+0C5i2A2L1+ie3pSKGVYIIYLXxhd2UTte
 fZ3RSFrsLu909gWkyxbQxhUKdQfBBdMBpmhZHoHQAdunhyHQCBeMmODoXE0cSQqAaChi vQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvw9he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 23:12:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ONB1sd036189;
        Thu, 24 Aug 2023 23:12:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ywm9v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 23:12:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37ONC0ZE015310;
        Thu, 24 Aug 2023 23:12:00 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ywm9uk-1;
        Thu, 24 Aug 2023 23:12:00 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] nfs42: client needs to strip file mode's suid/sgid bit after ALLOCATE op
Date:   Thu, 24 Aug 2023 16:11:47 -0700
Message-Id: <1692918707-30648-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_18,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240202
X-Proofpoint-ORIG-GUID: AO53hHKPp4ZNoJIvr_8_NEb1jPTJYcph
X-Proofpoint-GUID: AO53hHKPp4ZNoJIvr_8_NEb1jPTJYcph
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
nfs_set_cache_invalid's argument to force update of the
file mode suid/sgid bit.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
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

