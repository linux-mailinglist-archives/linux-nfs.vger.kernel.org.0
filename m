Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63CF7874A9
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbjHXPyo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 11:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbjHXPyP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 11:54:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A774198D
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 08:54:14 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OAGnhC011783;
        Thu, 24 Aug 2023 15:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=M0t0qRkINfvc2sHtMf4a1KxrRKK9S3k3liuKJmvUOf4=;
 b=SwBkaFHksiKf3nZOBaVTC9K5t17Pmfm4UNr/+JKcTHmOTEUrIdjS+8fZQBby1EvGZ/WH
 pcsUDQPYO8+oHyeuCLbomp3b0j61xC6hoAY4ae6sSYfThJU9oeBSetHz7Bsy94Wf8YKr
 uZURu1241ltJ8L7otyUjDvv1O2apbKxoydY9yoP7rDEpmIxvYZllnHaBg/eIh7Q4iq4x
 ODVr3za8ZA8iZ2c0og8/I/6i1qUGHeYKgghDNvwDnFCcWRNRR6makYCBw1WmUZQQBUnp
 8A375FQv3BIcF17KExNIZHqPtiUThGpUD0ZN/jxddNKwW1Ei+4PR7ln2WYi3bZTfSxuM Zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yu4k6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 15:54:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OEF5kt035988;
        Thu, 24 Aug 2023 15:54:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ypmtnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 15:54:06 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37OFs5GN014913;
        Thu, 24 Aug 2023 15:54:05 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sn1ypmtnk-1;
        Thu, 24 Aug 2023 15:54:05 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] nfs42: client needs to update file mode after ALLOCATE op
Date:   Thu, 24 Aug 2023 08:53:54 -0700
Message-Id: <1692892434-4887-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240134
X-Proofpoint-GUID: dEfj6O0od6fhAkTbYMs2cEN9cpvlmw0f
X-Proofpoint-ORIG-GUID: dEfj6O0od6fhAkTbYMs2cEN9cpvlmw0f
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/nfs/nfs42proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 63802d195556..d3d050171822 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -70,7 +70,7 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 	}
 
 	nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask, inode,
-			 NFS_INO_INVALID_BLOCKS);
+			NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_MODE);
 
 	res.falloc_fattr = nfs_alloc_fattr();
 	if (!res.falloc_fattr)
-- 
2.39.3

