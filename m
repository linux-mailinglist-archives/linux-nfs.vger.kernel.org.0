Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8D1286C5F
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Oct 2020 03:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgJHBZ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 21:25:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48654 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgJHBZ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Oct 2020 21:25:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0981OgX9178141;
        Thu, 8 Oct 2020 01:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=a6kau7cqUBsUtJ1cxw7S8nIRYDb8rCtvLJiLWEJIUcU=;
 b=e1/5UpSFNLImwTeL1t0TltqmVRmE+vADJ2QYel1gwVpS3v29vdJSZ1MCRIMnMtf7cAX7
 7dyqY6LIQlRBRjw0Wt3BqdXHCVQL4Gb7+lS593Yiit3VbJRq2ISAIIV7YsYIFlctByMn
 vZy4Lvsbwi/+qgmoJ7LSu9BMuAztlZjLa5vDvdMY0SQTzRmghXcWbWctm8B4SjinARpP
 vorrbk9lkqHX+BLbcrkpAG9R8tE43mfHIL5lDv7466V5IgZEhPbOQVgsXQZL5BnOjYvA
 Z7B/qcrPXJsPQ5anFXL6YZenl+hcG9UE33eZoOwUvC21q28TNn0yj1OmkhyAaloTvziv xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33ym34t5r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Oct 2020 01:25:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0981KC2H081208;
        Thu, 8 Oct 2020 01:25:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 33y380ag69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Oct 2020 01:25:53 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0981Pq5R097740;
        Thu, 8 Oct 2020 01:25:52 GMT
Received: from aserp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 33y380ag60-1;
        Thu, 08 Oct 2020 01:25:52 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/1] NFSv4.2: Fix NFS4ERR_STALE with inter server copy
Date:   Wed,  7 Oct 2020 21:25:12 -0400
Message-Id: <20201008012513.89989-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=1 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080010
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This cover email is intended for including my test results.

This patch adds the ops table in nfs_common for knfsd to access
NFS client modules without calling these functions directly.

The client module registers their functions and deregisters them
when the module is loaded and unloaded respectively.

 fs/nfs/nfs4file.c       |  44 ++++++++++++--
 fs/nfs/nfs4super.c      |   6 ++
 fs/nfs/super.c          |  20 +++++++
 fs/nfs_common/Makefile  |   1 +
 fs/nfs_common/nfs_ssc.c | 136 +++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/Kconfig         |   2 +-
 fs/nfsd/nfs4proc.c      |   3 +-
 include/linux/nfs_ssc.h |  77 ++++++++++++++++++++++++
 8 files changed, 281 insertions(+), 8 deletions(-)

Test Results:

Upstream version used for testing:  5.9-rc5

|----------------------------------------------------------|
|  NFSD  |  NFS_FS  |  NFS_V4  |       RESULTS             |
|----------------------------------------------------------|
|   m    |    y     |    m     | inter server copy OK      |
|----------------------------------------------------------|
|   m    |    m     |    m     | inter server copy OK      |
|----------------------------------------------------------|
|   m    |    m     |   y (m)  | inter server copy OK      |
|----------------------------------------------------------|
|   m    |    y     |    y     | inter server copy OK      |
|----------------------------------------------------------|
|   m    |    n     |    n     | NFS4ERR_STALE error       |
|----------------------------------------------------------|


|----------------------------------------------------------|
|  NFSD  |  NFS_FS  |  NFS_V4  |        RESULTS            |
|----------------------------------------------------------|
|   y    |    y     |    m     | inter server copy OK      |
|----------------------------------------------------------|
|   y    |    m     |    m     | inter server copy OK      |
|----------------------------------------------------------|
|   y    |    m     |   y (m)  | inter server copy OK      |
|----------------------------------------------------------|
|   y    |    y     |    y     | inter server copy OK      |
|----------------------------------------------------------|
|   y    |    n     |    n     | NFS4ERR_STALE error       |
|----------------------------------------------------------|

NOTE:
When NFS_V4=y and NFS_FS=m, the build process automatically builds
with NFS_V4=m and ignores the setting NFS_V4=y in the config file. 

This probably due to NFS_V4 in fs/nfs/Kconfig is configured to
depend on NFS_FS.

