Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818576107C9
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 04:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiJ1CQg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 22:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiJ1CQe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 22:16:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444CFB8789
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 19:16:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S1iIxe029139;
        Fri, 28 Oct 2022 02:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=iT4zucDp57z1i+KVHcDRTQpMS18WCUpEXWL3BFl6z28=;
 b=H0ZVzH9z6UYHjARTLHPed5f7yBs4aPpFKCCQBYrD48rKft+NZRDYWqa8FA42nCeUdoR7
 6ejDDT1WZGvJu9GyBg65Khj32trAoAhFg1yYYqRmSRNbY+JJ+S+y9qdcAholx22xq02A
 cvxZ9Jko2Q1/EBIj+9HCUfj5u2QCbQrZ0XREThXl+TH+0ehcJ6aFwMQQBr7MhY+xvMDY
 OYgzlnyUCWk43KlLVcJF4GkVaqMmku/gKpt624OFeHIdUqXS6NKIFI2O0AlQRIggzmYZ
 x5wJ5ZZrVJYHTd2ytLoqLYDVVKme+WV0mSkCXR8BwxI/53ev35sZN3vM29kdfbIJACqL HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfays3yha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 02:16:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29S06lRO012311;
        Fri, 28 Oct 2022 02:16:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagrm5vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 02:16:28 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29S2GSSG002910;
        Fri, 28 Oct 2022 02:16:28 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kfagrm5v3-1;
        Fri, 28 Oct 2022 02:16:28 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/2] add support for CB_RECALL_ANY and the delegation shrinker 
Date:   Thu, 27 Oct 2022 19:16:07 -0700
Message-Id: <1666923369-21235-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280013
X-Proofpoint-ORIG-GUID: ahGxAkTZep93qkVX2MW6A-6lhAtn5e5E
X-Proofpoint-GUID: ahGxAkTZep93qkVX2MW6A-6lhAtn5e5E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch series adds:

    . support for sending the CB_RECALL_ANY op.
      There is only one nfsd4_callback, cl_recall_any, added for each
      nfs4_client. Access to it must be serialized. For now it's done
      by the cl_recall_any_busy flag since it's used only by the
      delegation shrinker. If there is another consumer of cl_recall_any
      then a spinlock must be used.

    . the delegation shrinker that sends the advisory CB_RECALL_ANY 
      to the clients to release unused delegations.

v2:
    . modify deleg_reaper to check and send CB_RECALL_ANY to client
      only once per 5 secs.
v3:
    . modify nfsd4_cb_recall_any_release to use nn->client_lock to
      protect cl_recall_any_busy and call put_client_renew_locked
      to decrement cl_rpc_users.
---

Dai Ngo (2):
     NFSD: add support for sending CB_RECALL_ANY
     NFSD: add delegation shrinker to react to low memory condition

 fs/nfsd/netns.h        |   3 ++
 fs/nfsd/nfs4callback.c |  64 ++++++++++++++++++++++++++
 fs/nfsd/nfs4state.c    | 106 +++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h        |  10 +++++
 fs/nfsd/xdr4cb.h       |   6 +++
 5 files changed, 188 insertions(+), 1 deletion(-)
