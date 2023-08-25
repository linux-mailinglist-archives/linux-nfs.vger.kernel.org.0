Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2233788D1A
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 18:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243953AbjHYQTk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 12:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243954AbjHYQTQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 12:19:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FA71991;
        Fri, 25 Aug 2023 09:19:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDOB0q018181;
        Fri, 25 Aug 2023 16:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=25AvQlqEjwmYQR/dikHeuyopOtHWcB5ZE3MVUrX+iXY=;
 b=zrfOTEMJOa0GLFtZ+5hHz60uPo4Vg0EEZcxoyQqF6TnLPR/itGohJB0umFnpgXzYSsQ+
 ZU6mFmGLeuGZgRZ0FE9k/WKjlDfOHdbvT2ggsxAXiHvsPHVvVqsEMxpO4UzAfMlnJyom
 irdAouXolC2R8uw3lwOQLzMk7pbcjhX4SrcE/7rBp7BR7aihnsBkiYNxjJ6Z+QXd8CJs
 SbGxmLDen9HhgqsBIQXvlNNXXCI5ac4RZ4IUmH/RAF/ZLJXbpk+8t7l3TmGNWQzKLSVf
 A7vk6xqApR1RfJt6mFz/Hed6Ty31sMniuaE8cL99m0K5pTg5d8luCy/kn0r5F976GD/H kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yxpntw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 16:19:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PGBw5O005812;
        Fri, 25 Aug 2023 16:19:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yusexq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 16:19:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37PGJ4WM004997;
        Fri, 25 Aug 2023 16:19:04 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sn1yusex6-1;
        Fri, 25 Aug 2023 16:19:04 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     brauner@kernel.org, chuck.lever@oracle.com, bfields@fieldses.org,
        stable@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, hch@lst.de, jlayton@kernel.org,
        vegard.nossum@oracle.com, naresh.kamboju@linaro.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 0/2] Address nfs ltp test failure.
Date:   Fri, 25 Aug 2023 09:18:59 -0700
Message-ID: <20230825161901.371818-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_14,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=882 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250146
X-Proofpoint-GUID: o0OX6lAo4IsrApNy9L4Gp9g3YohyOkr7
X-Proofpoint-ORIG-GUID: o0OX6lAo4IsrApNy9L4Gp9g3YohyOkr7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These two are backports for 5.15.y. Conflict resolution in done in
both patches.

I have tested LTP-nfs fchown02 and chown02 on 5.15.y with below patches
applied. The tests passed.

I would like to have a review as I am not familiar with this code.

Thanks to Vegard for helping me with this.

Regards,
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

