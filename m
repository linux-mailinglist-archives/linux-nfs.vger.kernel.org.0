Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1E75A6F6E
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 23:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiH3Vsy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 17:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiH3Vsp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 17:48:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9378E477
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 14:48:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ULVM7G006898;
        Tue, 30 Aug 2022 21:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=gEntBcioFa4vIQn/7iA8HQjRG1WVj7ZPRzij+NdsypQ=;
 b=eTXF6nsi6QfkFKb/PqnCqLsUoE+Lemi0y8szpAGDqnPtA8axwBg0iJsmuZmBUZWf1yso
 pLisXmXLLpMcNRhomm9Fa9XRdu5G8F6U4Vsj7OB0b4CJ9StdPTpOaT14tu3oG/eoiFW/
 fc3xdNBGsvcywUsUd2Yy8d1yoO3t9hqssTvCrQLil/g3o+exuTbaqIOUyllJu+UU9Mmq
 nrpf57++RrFJpqL6ACyXN6X1KpCH0W1VAizpWyyQdu/GTD/+GefdJqrjduvVC1sh1hjP
 L6rg/jRq9dV8lhN8j1tacoPfbW2y1euhLgPVqr00tb+EjQTzpZ4wRoO8stAm1bh9uvAj 4g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt7nac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 21:48:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ULfeVR008039;
        Tue, 30 Aug 2022 21:48:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79qapt96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 21:48:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27ULmcEJ028504;
        Tue, 30 Aug 2022 21:48:38 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3j79qapt8q-1;
        Tue, 30 Aug 2022 21:48:38 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/2] NFSD: memory shrinker for NFSv4 clients
Date:   Tue, 30 Aug 2022 14:48:31 -0700
Message-Id: <1661896113-8013-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=934 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300097
X-Proofpoint-ORIG-GUID: 1rcaSeyNX9q_qKQlIlBRvRlyJDhCnWNx
X-Proofpoint-GUID: 1rcaSeyNX9q_qKQlIlBRvRlyJDhCnWNx
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

v4:
. replace the use of xchg() with vanilla '=' in patch 1.

---

Dai Ngo (2):
      NFSD: keep track of the number of courtesy clients in the system
      NFSD: add shrinker to reap courtesy clients on low memory condition

 fs/nfsd/netns.h     |  5 ++++
 fs/nfsd/nfs4state.c | 65 ++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsctl.c    |  6 +++--
 fs/nfsd/nfsd.h      |  9 +++++--
 4 files changed, 76 insertions(+), 9 deletions(-)
