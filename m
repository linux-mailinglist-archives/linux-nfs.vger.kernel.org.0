Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2900D5AC5C6
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Sep 2022 19:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiIDR2L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiIDR2H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 13:28:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE033A1E
        for <linux-nfs@vger.kernel.org>; Sun,  4 Sep 2022 10:28:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 284AjbtA028178;
        Sun, 4 Sep 2022 17:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=cyqofKo5ErbxI88ixQM5px4pu/uZvcH/PCgqrDjXrFY=;
 b=pCnq/+Qbr8hnwjORmk/E7duAeeONpzMAPCcMQsdaGPYUUBYLqVkiStV7CjWD20MMCpQ+
 WmxMpOxKXh0lvv+0Xb+iF8jcrpe+2TPAtqs19TGuQhlCga+gjE4fJpamN4DWKXCcKdRz
 oUmCjN4tJ9KWyqmqwRq3YoJvpwz+B3SimV7C/MUn1aULY3OvEZlJB7zSkCkmN4lyfB2w
 o+mRzQDw9umIc+JyeygwHHF4dddhi6rxA5t3nU9JDdzUxwQkGpYAV1Oe9nrLLzkrO6bk
 DaFOWB+GmcxQkirqr3Bi76fXIgNsuES5QNZtB1/QV3wsYUdKXLuWI0rpUelYZYGuBb0C Lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1a0v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Sep 2022 17:27:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 284Dh3MS033789;
        Sun, 4 Sep 2022 17:27:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc7buk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Sep 2022 17:27:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 284HRuvj029092;
        Sun, 4 Sep 2022 17:27:56 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3jbwc7buk3-1;
        Sun, 04 Sep 2022 17:27:56 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 0/2] NFSD: memory shrinker for NFSv4 clients
Date:   Sun,  4 Sep 2022 10:27:50 -0700
Message-Id: <1662312472-23981-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-04_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209040089
X-Proofpoint-GUID: 5eNm2i1rrMoMvguAkrMUWFQOx4okHvnP
X-Proofpoint-ORIG-GUID: 5eNm2i1rrMoMvguAkrMUWFQOx4okHvnP
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

The first patch adds a counter to keep track of the number of courtesy
clients in the system.

The second patch implememts the courtesy client shrinker by creating
a new trigger, in addition to the max client limit, for the laundromat
to reap courtesy clients.

By destroying the courtesy clients, all states associated with these
clients are also released.

v2:
. fix kernel test robot errors in nfsd.h when CONFIG_NFSD_V4 not defined.

v3:
. add mod_delayed_work in nfsd_courtesy_client_scan to kick start
  the laundromat.

v4:
. replace the use of xchg() with vanilla '=' in patch 1.

v5:
. rename nfsd_courtesy_client_count to nfsd_courtesy_clients
. add helper nfsd4_update_courtesy_client_count
. move nfsd_register_client_shrinker into nfsd4_init_leases_net
. move nfsd4_leases_net_shutdown from nfsd.h to nfs4state.c
. do away with shrinker 'scan' callback, just return SHRINK_STOP
. remove unused nfsd_client_shrinker_reapcount
---

Dai Ngo (2):
      NFSD: keep track of the number of courtesy clients in the system
      NFSD: add shrinker to reap courtesy clients on low memory condition

 fs/nfsd/netns.h     |  4 ++++
 fs/nfsd/nfs4state.c | 60 ++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsctl.c    |  6 +++--
 fs/nfsd/nfsd.h      |  6 +++--
 4 files changed, 67 insertions(+), 9 deletions(-)
