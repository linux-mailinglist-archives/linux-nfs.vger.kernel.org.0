Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFE35B779F
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 19:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiIMRU0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiIMRT7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 13:19:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60553D344A
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 09:06:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DF8D9F004861;
        Tue, 13 Sep 2022 16:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=KZRGVU83jZNIpbAn/QTtDa5QJy01A8N5oO70HU/iJR4=;
 b=Qvs4MxkrnUGOuWoCeyQn8MReaBnMwfryfeaD6DnJGumbcTG7Me3to4A/uMU0EPGnKngh
 s6d+jCxS2A+8ubZNaUbGE0vMSE5WSELcnn2yy25Ml7hd/oXllGAXReDqHSDMcd0LpXWl
 R1SLu7u1xZv36YoRYfSQADg++nSciJb+KnJMOe79EKV+oKzqspqPyYCnHN8cPSFQyzHC
 UVBm0aLLMj1TisMUBVuml5nsasjKakZB/LQmoPk1PM/HCa7D+BCCxWJSVFzU9ubO+XdU
 rFjT9xh/O37R1FGRxcgZBvRjSUkgGQ2bhv4shPE7B/o/0Bf4aTLEH+Kzt8T5tVlRIMQy BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgjf9y7j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 16:06:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28DEV9Ls016733;
        Tue, 13 Sep 2022 16:06:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jj6b2r38q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 16:06:17 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28DG6HDh023194;
        Tue, 13 Sep 2022 16:06:17 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jj6b2r38a-1;
        Tue, 13 Sep 2022 16:06:17 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 0/2] NFSD: memory shrinker for NFSv4 clients
Date:   Tue, 13 Sep 2022 09:06:08 -0700
Message-Id: <1663085170-23136-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130073
X-Proofpoint-GUID: 3vhC5upl_FEBpQMJ_lELhWoaVNPt6GmN
X-Proofpoint-ORIG-GUID: 3vhC5upl_FEBpQMJ_lELhWoaVNPt6GmN
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
  hard to read so I leave them separate for now.
---

Dai Ngo (2):
      NFSD: keep track of the number of courtesy clients in the system
      NFSD: add shrinker to reap courtesy clients on low memory condition

 fs/nfsd/netns.h     |   5 ++
 fs/nfsd/nfs4state.c | 119 +++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsctl.c    |   6 ++-
 fs/nfsd/nfsd.h      |   7 ++-
 4 files changed, 124 insertions(+), 13 deletions(-)
