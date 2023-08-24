Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579F67873EB
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 17:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjHXPTL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 11:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbjHXPSo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 11:18:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3895519B2
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 08:18:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OAU35c025883;
        Thu, 24 Aug 2023 15:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=vMaa8yjY2UP1nI+F4yVqU5rdlqBq/OuYT++TrWqgRGk=;
 b=DRvHIAs34tbFKE+49E2DCYTpSakV0wEslfYuAsV6ozix1TwqsEKaDgBdqYa28b/dxKpl
 v4tmL7jUWdslZvvFFnO9B5qFqyKmoErBeSjwNzaD8BOwLH1JiPPoziyy6tE7cYHLTK/a
 b3ctBBaiF0/3RLj6JcoxxNLRrNpskMM28uWU0XYOJdpCU4F+zO4qCi/EEVIY91QMCu1F
 y0YVhjdO35gz41AdssIjxjEv2AoO9gnl99leMpqRdKp2op1Pa8FXt4QDEk23/4NLm25O
 iQ+cHcNwsqIU/cSCZqF884TCCuWjE7Obqw2tf7hC62DnI6h6OrIVKVeLDatbhxpe5zZd Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvvb3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 15:18:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OEYfZr036419;
        Thu, 24 Aug 2023 15:18:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yw3tsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 15:18:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37OFB794015775;
        Thu, 24 Aug 2023 15:18:37 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1yw3th8-1;
        Thu, 24 Aug 2023 15:18:37 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] nfs42: client needs to update file mode after ALLOCATE op
Date:   Thu, 24 Aug 2023 08:18:10 -0700
Message-Id: <1692890290-2772-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240129
X-Proofpoint-ORIG-GUID: tbx6QNYYClMZU4jQJuo37XSDL5ZqoUua
X-Proofpoint-GUID: tbx6QNYYClMZU4jQJuo37XSDL5ZqoUua
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
on ALLOCATE op. The GETATTR op in the ALLOCATE compound needs to
request the file mode from the server to update its file mode in
case the SUID/SGUI bit were stripped.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfs/nfs42proc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 63802d195556..ba2b83bfb37c 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -57,6 +57,9 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 		.falloc_server	= server,
 	};
 	int status;
+	struct super_block *sb = inode->i_sb;
+	u64 fattr_supported = NFS_SB(sb)->fattr_valid;
+	unsigned long mask = NFS_INO_INVALID_BLOCKS;
 
 	msg->rpc_argp = &args;
 	msg->rpc_resp = &res;
@@ -69,8 +72,10 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 		return status;
 	}
 
+	if (fattr_supported & NFS_ATTR_FATTR_MODE)
+		mask |= NFS_INO_INVALID_MODE;
 	nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask, inode,
-			 NFS_INO_INVALID_BLOCKS);
+				mask);
 
 	res.falloc_fattr = nfs_alloc_fattr();
 	if (!res.falloc_fattr)
-- 
2.39.3

