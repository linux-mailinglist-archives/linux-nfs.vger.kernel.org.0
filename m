Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E46F27644F
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Sep 2020 01:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIWXGL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 19:06:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58278 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWXGL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Sep 2020 19:06:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NMxe4w091956
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=eLNA4M/0nYTaTtXY9rDtMr1a1iszoKi3/Xy6lBZX4gU=;
 b=N8EN+HfmWRM8BUQ0G+M3s5pFlvgFlaODhP941EVUbYgpREUHNtFf/QB60ZQPwXjeTJN/
 rGMLL03GqD/7Uc2srBLKLgT3GRA6tdzw5qMgvdDD6jiqAtP9Y+9SISGhIcVRQHjiWwrJ
 jvLGltZjXpnAEZHtubRfznQJwZioAz3/Hktz95lafhQ4fF4az7+A3WFn7ENuVrdpDCHl
 PaVGJuSKtGOloHNxlJjKs0XfMeCqcOxd2yzx/JwlhBtCNf/0n7gw60vEyOZtmfzZnhHI
 QOlJnVu6edLWN1MDd3CrNCaIVap9DxYEMPWQVQJtIR0frIXaj5mcbZwGBjbN2H6kM9/C uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33q5rgkk6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:06:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NN68Ej138897
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:06:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 33r28w8bmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:06:09 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08NN69lX139036
        for <linux-nfs@vger.kernel.org>; Wed, 23 Sep 2020 23:06:09 GMT
Received: from userp3030.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by aserp3020.oracle.com with ESMTP id 33r28w8bm9-1;
        Wed, 23 Sep 2020 23:06:09 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] NFSv4.2: Fix NFS4ERR_STALE with inter server copy
Date:   Wed, 23 Sep 2020 19:06:05 -0400
Message-Id: <20200923230606.63904-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=1 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230175
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch provides a temporarily relief for inter copy to work with
some common configs.  For long term solution, I think Trond's suggestion
of using fs/nfs/nfs_common to store an op table that server can use to
access the client code is the way to go.

 fs/nfsd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Below are the results of my testing of upstream mainline without and with the fix.

Upstream version used for testing:  5.9-rc5

1. Upstream mainline (existing code: NFS_FS=y)


|----------------------------------------------------------------------------------------|
|  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
|----------------------------------------------------------------------------------------|
|   y    |    y     |    m     | Build errors: nfs42_ssc_open/close                      |
|----------------------------------------------------------------------------------------|
|   y    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
|        |          |          | See NOTE1.                                              |
|----------------------------------------------------------------------------------------|
|   y    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
|        |          |          | See NOTE2.                                              |
|----------------------------------------------------------------------------------------|
|   y    |    y     |    y     | Build OK, inter server copy OK                          |
|----------------------------------------------------------------------------------------|


|----------------------------------------------------------------------------------------|
|  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
|----------------------------------------------------------------------------------------|
|   m    |    y     |    m     | Build OK, inter server copy OK                          |
|----------------------------------------------------------------------------------------|
|   m    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
|----------------------------------------------------------------------------------------|
|   m    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
|----------------------------------------------------------------------------------------|
|   m    |    y     |    y     | Build OK, inter server copy OK                          |
|----------------------------------------------------------------------------------------|

2. Upstream mainline (with the fix:  !(NFSD=y && (NFS_FS=m || NFS_V4=m))


|----------------------------------------------------------------------------------------|
|  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
|----------------------------------------------------------------------------------------|
|   m    |    y     |    m     | Build OK, inter server copy OK                          |
|----------------------------------------------------------------------------------------|
|   m    |    m     |    m     | Build OK, inter server copy OK                          |
|----------------------------------------------------------------------------------------|
|   m    |    m     |   y (m)  | Build OK, inter server copy OK                          |
|----------------------------------------------------------------------------------------|
|   m    |    y     |    y     | Build OK, inter server copy OK                          |
|----------------------------------------------------------------------------------------|


|----------------------------------------------------------------------------------------|
|  NFSD  |  NFS_FS  |  NFS_V4  |               RESULTS                                   |
|----------------------------------------------------------------------------------------|
|   y    |    y     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
|----------------------------------------------------------------------------------------|
|   y    |    m     |    m     | Build OK, inter server copy failed with NFS4ERR_STALE   |
|----------------------------------------------------------------------------------------|
|   y    |    m     |   y (m)  | Build OK, inter server copy failed with NFS4ERR_STALE   |
|----------------------------------------------------------------------------------------|
|   y    |    y     |    y     | Build OK, inter server copy OK                          |
|----------------------------------------------------------------------------------------|

NOTE1:
BUG:  When inter server copy fails with NFS4ERR_STALE, it left the file
created with size of 0!

NOTE2:
When NFS_V4=y and NFS_FS=m, the build process automatically builds with NFS_V4=m
and ignores the setting NFS_V4=y in the config file. 

This probably due to NFS_V4 in fs/nfs/Kconfig is configured to depend on NFS_FS.

