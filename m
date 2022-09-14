Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979CF5B8C54
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Sep 2022 17:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiINPyo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Sep 2022 11:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiINPyl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Sep 2022 11:54:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1CE764A
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 08:54:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EFkNqS028304;
        Wed, 14 Sep 2022 15:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=8SBa3dQJB4neXUGzhpVC+X9w2Q5iqRv4/+L0MdigOlI=;
 b=fQ2gZSnanmHz+5YvR5hsSeMAYHJNrVebHkARszDHLiVfS9mH5SWQ5B4364Di/66ddlHo
 rCfXYkCCWLxFzwzQNIILvC4ws5K2dxeKMoX4Krl507VVSOy+UiQxcwFZAxS2ypeDugBx
 7R4fUoVRujmVIr9AyEiHISaPJ2KPTmY+dXcboxnELDnvBGphN9iP+ihLhavoSHwxlVly
 N3+jMZRfsbArsr0WayifIovepKT6dkfRwaC87av2+TnWuxP6ngu+QdqGnXdc3A72h0iT
 baIeZfPzgPw4SI3zjJCiCskYXv2BHMIfflKi0MPyrdKmFUjQMgbYbTbQWTCIir1JG+71 OA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyf2pvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 15:54:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDZbB2035419;
        Wed, 14 Sep 2022 15:54:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjykyt0xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 15:54:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28EFp3ZE025970;
        Wed, 14 Sep 2022 15:54:32 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jjykyt0xj-1;
        Wed, 14 Sep 2022 15:54:32 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 0/2] NFSD: memory shrinker for NFSv4 clients
Date:   Wed, 14 Sep 2022 08:54:24 -0700
Message-Id: <1663170866-21524-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_07,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140077
X-Proofpoint-GUID: bkIYLy3BuNJQDF_ObNFH8_HzHcvtLgBh
X-Proofpoint-ORIG-GUID: bkIYLy3BuNJQDF_ObNFH8_HzHcvtLgBh
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

The first patch adds a counter to keep track of the number of
courtesy clients in the system.

The second patch implements the courtesy_client_reaper used to
expiring the courtesy clients.

By destroying the courtesy clients, all states associated with
these clients are also released.

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

v6:
. create courtesy_client_reaper and a separate delayed_work for it
  using the laundromat_wq. 
  I tried merging nfs4_get_courtesy_client_reaplist and
  nfs4_get_client_reaplist but it make the code looks ugly and
  hard to read so I leave them as separate for now.

v7:
. patch1: rename nfsd4_decr_courtesy_client_count to
  nfsd4_dec_courtesy_client_count
. patch 2: get rid of nfsd_client_shrinker_cb_count and do not
  reschedule courtesy_client_reaper
---

Dai Ngo (2):
      NFSD: keep track of the number of courtesy clients in the system
      NFSD: add shrinker to reap courtesy clients on low memory condition

 fs/nfsd/netns.h     |   4 ++
 fs/nfsd/nfs4state.c | 111 +++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsctl.c    |   6 ++-
 fs/nfsd/nfsd.h      |   7 ++-
 4 files changed, 115 insertions(+), 13 deletions(-)

