Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06041276450
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Sep 2020 01:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWXGM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 19:06:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50322 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIWXGM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Sep 2020 19:06:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NMwtOa165267
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=X3w8e2UDLLrtUTf5mn8A8mDOYgsn18INtxe7TymHsP4=;
 b=WhH2UA8zd1nWmFLmiXd5YEf6DXYNMJcDoxyr8kDfgmoax+qJHDcL+axLC3FzyGdinDg3
 izOMr/cwpICzockFVFk2uUMfG9t8nQfUIoPsRY3q7IfzRQkB5xT4NUyBYGMMHj/7W8LV
 Hyg0rOAqNFnQT1fBRqTOx7LR5N0t3XG9CvVYi5UVsOMJXH/MMCkYKUXTmBwftwvyModH
 O5K1iPouCQLSTnVEztHEjPUUiISJqTTgQtR0bwVUDCJxozbd+lB8LNGAjvt5FrxhRtxT
 /fd+xRgM3z+qN0vWO0i3VwuEjAnRkdcFHR3NsUUNo8Anq5cE/95OYVlpqUs95A/CtG8A 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33ndnun9s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:06:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NN674V138833
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:06:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 33r28w8bmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:06:10 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08NN69lZ139036
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:06:09 GMT
Received: from userp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 33r28w8bm9-2;
        Wed, 23 Sep 2020 23:06:09 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.2: Fix NFS4ERR_STALE error when doing inter server copy
Date:   Wed, 23 Sep 2020 19:06:06 -0400
Message-Id: <20200923230606.63904-2-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
In-Reply-To: <20200923230606.63904-1-dai.ngo@oracle.com>
References: <20200923230606.63904-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=1 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230175
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFS_FS=y as dependency of CONFIG_NFSD_V4_2_INTER_SSC still have
build errors and some configs with NFSD=m to get NFS4ERR_STALE
error when doing inter server copy.

Modified depends of CONFIG_NFSD_V4_2_INTER_SSC to fix build errors
and to allow inter server copy to work with all configs with NFS_FS=m
and config with (NFSD=y, NFS_FS=y and NFS_V4=y).

Fixes: 3ac3711adb88 ("NFSD: Fix NFS server build errors")
Signed-off-by: dai.ngo@oracle.com
---
 fs/nfsd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 99d2cae91bd6..990078102a02 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -136,7 +136,7 @@ config NFSD_FLEXFILELAYOUT
 
 config NFSD_V4_2_INTER_SSC
 	bool "NFSv4.2 inter server to server COPY"
-	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2 && NFS_FS=y
+	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2 && !(NFSD=y && (NFS_FS=m || NFS_V4=m))
 	help
 	  This option enables support for NFSv4.2 inter server to
 	  server copy where the destination server calls the NFSv4.2
-- 
1.8.3.1

