Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D95A6CE3
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 21:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiH3TO6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiH3TO5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 15:14:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1497670
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 12:14:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UI4E2V002223;
        Tue, 30 Aug 2022 19:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=XA0STSVDuG3Ma3v3ySIeNmnLpxEO6qfDVncjNOP4dEg=;
 b=3KGTFAzYZCl6kqBsWFKgC9FONdx1Xp6c+szJEZdoG8xNRDEQNl7c3c367/6vVNdFevG3
 veiHSwguAFhEXhwj+HDqRkNv3tEWwikQBMUOEZQ86kV8rUZySx4SVI00mYsc4dVrMhJ1
 /Ga2VaGX2Lk/NM1Ea3gq1uq8FNvOGC+iPyOG9nLGWT3UnWA+uNQkp4TDsZTFxZqeh2Hu
 nc1vo5AbpHNf1Et1VqkMsQylQVb/H1LJ8Lt2KmScR0Y4Fiea/5wYIIJgTu5DaRz5p3wO
 W8BqhBfhotcRLb1goYv0Iq8gkKzmyutalHV9Tf9aj0WVO+tHHrn9wYtsfZaQVp+PqYUn lQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b59y7sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 19:14:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UIXWcC035798;
        Tue, 30 Aug 2022 19:14:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q4h61p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 19:14:49 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27UJEn1t002516;
        Tue, 30 Aug 2022 19:14:49 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3j79q4h61f-1;
        Tue, 30 Aug 2022 19:14:49 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/2] NFSD: memory shrinker for NFSv4 clients
Date:   Tue, 30 Aug 2022 12:14:23 -0700
Message-Id: <1661886865-30304-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=926 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300086
X-Proofpoint-ORIG-GUID: F8cCwVbKAcHpG2NTpqshmnlyThy4MS10
X-Proofpoint-GUID: F8cCwVbKAcHpG2NTpqshmnlyThy4MS10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch series implements the memory shrinker for NFSv4 clients
to react to system low memory condition.

The memory shrinker's count callback is used to trigger the laundromat.
The actual work of destroying the expired clients is done by the
laundromat itself. We can not destroying the expired clients on the
memory shrinler's scan callback context to avoid possible deadlock.

By destroying the expired clients, all states associated with these
clients are also released.

v2:
. fix kernel test robot errors in nfsd.h when CONFIG_NFSD_V4 not defined.

v3:
. add mod_delayed_work in nfsd_courtesy_client_scan to kick start
  the laundromat.
---

Dai Ngo (2):
      NFSD: keep track of the number of courtesy clients in the system
      NFSD: add shrinker to reap courtesy clients on low memory condition

 fs/nfsd/netns.h     |  5 ++++
 fs/nfsd/nfs4state.c | 66 +++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/nfsctl.c    |  6 +++--
 fs/nfsd/nfsd.h      |  9 +++++--
 4 files changed, 75 insertions(+), 11 deletions(-)
