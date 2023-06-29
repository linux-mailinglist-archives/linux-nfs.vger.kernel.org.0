Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE46741E53
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 04:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjF2Cgi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Jun 2023 22:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjF2Cgh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Jun 2023 22:36:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7099C213D
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jun 2023 19:36:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1huIG002235;
        Thu, 29 Jun 2023 02:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=nq+VTikulC7/MtA6NoALJ65gGF5jo5R0NLyFgz/M0FE=;
 b=T685vmeroEjTse9901VPWVW+wn3mgBvnf5Pfa9lRTa9+azsjqjMEWbHPyNcBKmqWVnqM
 EgVuX1GH3070CiSHutAKIrHK1cytCpYVt1yw3S6S8fIZR1IFwub6sKGXRSoV8tIysFmO
 OowRfdXB97VRmqKhX6zBmYaFjqYIvo/eoVT2X+LqPG9avk59p3v9zpy/lZg/G23O2q+a
 wMYiDRQ+cPz36zfIUf844D16gQ+jI2JJ+vEDY3qR+twHDexDHjeEiRcgched+MHTJC4k
 F08YGjppHfZFUXWhY/9Kt3/GX7RVxKQDks4jF27DxXm4r4tb2OlNh09Bcd4/g+p/sEi1 QQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1ua3ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0fClN038195;
        Thu, 29 Jun 2023 02:36:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxdc87u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:36:32 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T2Zt7c011587;
        Thu, 29 Jun 2023 02:36:32 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rdpxdc87d-2;
        Thu, 29 Jun 2023 02:36:32 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 1/5] locks: allow support for write delegation
Date:   Wed, 28 Jun 2023 19:36:12 -0700
Message-Id: <1688006176-32597-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290021
X-Proofpoint-GUID: pt5X9uZ57JylatDu3ZFcrPuVsFNtZRfL
X-Proofpoint-ORIG-GUID: pt5X9uZ57JylatDu3ZFcrPuVsFNtZRfL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove the check for F_WRLCK in generic_add_lease to allow file_lock
to be used for write delegation.

First consumer is NFSD.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/locks.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index df8b26a42524..08fb0b4fd4f8 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1729,13 +1729,6 @@ generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **pr
 	if (is_deleg && !inode_trylock(inode))
 		return -EAGAIN;
 
-	if (is_deleg && arg == F_WRLCK) {
-		/* Write delegations are not currently supported: */
-		inode_unlock(inode);
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
-
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	time_out_leases(inode, &dispose);
-- 
2.39.3

