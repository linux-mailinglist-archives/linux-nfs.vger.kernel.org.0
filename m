Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4D8608EED
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Oct 2022 20:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJVSJl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Oct 2022 14:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJVSJg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Oct 2022 14:09:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D388D11C3E
        for <linux-nfs@vger.kernel.org>; Sat, 22 Oct 2022 11:09:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29MBGPo1012741;
        Sat, 22 Oct 2022 18:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=gPIADgwm6BjCAyQJC42EGDI4dztVun3rPaxP4YoDsQ4=;
 b=yL/v7hs/7z+W5DUdwnR4UsDjMOIMdR7PETDhAwf5ezjyykNVg7Ranj2zbBll5j1Q1mvQ
 AOim8fm8aipNhyWuXxILET0nBI9Hrtdsiqe929qXXcyZFM8r46AgKSexnJ2x/x2gsIoy
 ItoqwTb6y2PbEoQsE7hloY64FaApyfxbMq9JoAii3F59lewKqWf1DPF0pa9ckUuBrB0r
 vW7pI9gDyDSfRxrvvro8L6ho/3y0dGzY6Sf16lP3iDi/MqAqmtDNsrIi9adQ3PrTRi2S
 LuDmf3lmLroSEuNSNz0QSA14KnIum3XFIs7SQShnFS2/9byrVAjaWvUMAwBH9Pjye81L 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc84srqru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 18:09:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29M9a4m3032064;
        Sat, 22 Oct 2022 18:09:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y2u3wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 18:09:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29MI9OHg026867;
        Sat, 22 Oct 2022 18:09:24 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kc6y2u3wv-1;
        Sat, 22 Oct 2022 18:09:23 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] add support for CB_RECALL_ANY and the delegation shrinker
Date:   Sat, 22 Oct 2022 11:09:08 -0700
Message-Id: <1666462150-11736-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210220114
X-Proofpoint-ORIG-GUID: UpYfqRDxDUGl5AtOcU_p9VKjj5hv2kIj
X-Proofpoint-GUID: UpYfqRDxDUGl5AtOcU_p9VKjj5hv2kIj
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
---

Dai Ngo (2):
     NFSD: add support for sending CB_RECALL_ANY
     NFSD: add delegation shrinker to react to low memory condition

 fs/nfsd/netns.h        |   3 ++
 fs/nfsd/nfs4callback.c |  64 ++++++++++++++++++++++++++++
 fs/nfsd/nfs4state.c    | 101 +++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h        |  10 +++++
 fs/nfsd/xdr4cb.h       |   6 +++
 5 files changed, 183 insertions(+), 1 deletion(-)
