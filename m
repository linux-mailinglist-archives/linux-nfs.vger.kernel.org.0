Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49DD788D10
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 18:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343845AbjHYQQ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjHYQQe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 12:16:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5265E1BCD;
        Fri, 25 Aug 2023 09:16:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDOG22018212;
        Fri, 25 Aug 2023 16:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=TY4XLDkKVe7jkw8ztxfCZAOnfcB0IjZA0SDqh7eFy7E=;
 b=p7UcrEV+9CE4d9Pi1prsgJqfRDFwlNBLE/7l6OyviqXYAEsQJR7OB2mxU4GcKthFF8Yw
 5AH6utmiefVV1CB4foudL/I2HqjjEjWIFVBHShNaFoGWZjG4rHqXUy+i7UBRQf2QrZsD
 oAT00ltsikOd1whEAi+A8sFubap/+nA0T3H4kb/o5j/zoRlnLlqs6vXK85lY+ukkX4Iy
 Y4gL1h0XOdyndyOGX6ampvb0xwE5F+7hYIJkTriah0ZRst59311dnktoNSNF1Wmx2ZtK
 Jw6uzbrNcrYkPNIEbwoSHOSdAtHqaWGyI/ctWsBqWbbPA6EVva7wvBZuiWWYDKVi48gV xA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yxpnnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 16:16:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PFqN9Y036189;
        Fri, 25 Aug 2023 16:16:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yxhtff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 16:16:19 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37PGGILX030021;
        Fri, 25 Aug 2023 16:16:18 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1yxhtew-1;
        Fri, 25 Aug 2023 16:16:18 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     brauner@kernel.org, chuck.lever@oracle.com, bfields@fieldses.org,
        stable@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, hch@lst.de, jlayton@kernel.org,
        vegard.nossum@oracle.com, naresh.kamboju@linaro.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.1.y 0/2] Address ltp nfs test failure.
Date:   Fri, 25 Aug 2023 09:16:01 -0700
Message-ID: <20230825161603.371792-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_14,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=860 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250145
X-Proofpoint-GUID: BlT1WBCEksa-YmwJXo5QHuRaNkvMkvHv
X-Proofpoint-ORIG-GUID: BlT1WBCEksa-YmwJXo5QHuRaNkvMkvHv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These two are backports for 6.1.y. Conflict resolution in done in
both patches.

I have tested LTP-nfs fchown02 and chown02 on 6.1.y with below patches
applied. The tests passed.

I would like to have a review as I am not familiar with this code.

Thanks to Vegard for helping me with this.

Thanks,
Harshit

Christian Brauner (2):
  nfs: use vfs setgid helper
  nfsd: use vfs setgid helper

 fs/attr.c          | 1 +
 fs/internal.h      | 2 --
 fs/nfs/inode.c     | 4 +---
 fs/nfsd/vfs.c      | 4 +++-
 include/linux/fs.h | 2 ++
 5 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.34.1

