Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B01462D1D2
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 04:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiKQDpL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 22:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiKQDpK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 22:45:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9526A684
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 19:45:01 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH25nUc003956;
        Thu, 17 Nov 2022 03:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=wwc6DC6bbSlePCeywKNVeQCc6vfZLvrsUQos8eW5JGM=;
 b=qVDINHgJGS0PyshesU1kv0gH2/sNv1FZOUBdIr0Alc0zpPCu6waxB+f5XGNoxi26sjVi
 4gpH5vht3NcRsxwIfpweao+QENI8YN6KaP9UMAp32aPjpZSQB6weZC6a1e71Zuy3O3Av
 ylwJ2amI+Jbr7bwvFlIIqGeXgjrY2eCgogs1kgfrFDjCQG8NvtTn72+R3d0dyf74J1z7
 Mky/MfbLgUGE7WiRmFvNGWnNwjPYEMVXVneZeyjE4xyWJMCR4E5tn3/3EIZGCAryo4mf
 KhIBqU67w//gp5oVKHpklpYZjBN6tfIc27vqLBdw3P5MCqRZuHp5TqqZePXPQxbsLmSQ eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3hdy5t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 03:44:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AH1I7Dj016882;
        Thu, 17 Nov 2022 03:44:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk1ya26j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 03:44:56 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AH3iutd030624;
        Thu, 17 Nov 2022 03:44:56 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kuk1ya262-1;
        Thu, 17 Nov 2022 03:44:56 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 0/4] add support for CB_RECALL_ANY and the delegation reaper
Date:   Wed, 16 Nov 2022 19:44:44 -0800
Message-Id: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170024
X-Proofpoint-ORIG-GUID: nfhssxX2lQHCtuVvubUWWiHJZdbxy0jT
X-Proofpoint-GUID: nfhssxX2lQHCtuVvubUWWiHJZdbxy0jT
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

    . refactor courtesy_client_reaper to a generic low memory
      shrinker.

    . XDR encode and decode function for CB_RECALL_ANY op.

    . the delegation reaper that sends the advisory CB_RECALL_ANY 
      to the clients to release unused delegations.
      There is only one nfsd4_callback added for each nfs4_cleint.
      Access to it must be serialized via the client flag
      NFSD4_CLIENT_CB_RECALL_ANY.

    . Add CB_RECALL_ANY tracepoints.

v2:
    . modify deleg_reaper to check and send CB_RECALL_ANY to client
      only once per 5 secs.
v3:
    . modify nfsd4_cb_recall_any_release to use nn->client_lock to
      protect cl_recall_any_busy and call put_client_renew_locked
      to decrement cl_rpc_users.

v4:
    . move changes in nfs4state.c from patch (1/2) to patch(2/2).
    . use xdr_stream_encode_u32 and xdr_stream_encode_uint32_array
      to encode CB_RECALL_ANY arguments.
    . add struct nfsd4_cb_recall_any with embedded nfs4_callback
      and params for CB_RECALL_ANY op.
    . replace cl_recall_any_busy boolean with client flag
      NFSD4_CLIENT_CB_RECALL_ANY 
    . add tracepoints for CB_RECALL_ANY

v5:
    . refactor courtesy_client_reaper to a generic low memory
      shrinker
    . merge courtesy client shrinker and delegtion shrinker into
      one.
    . reposition nfsd_cb_recall_any and nfsd_cb_recall_any_done
      in nfsd/trace.h
    . use __get_sockaddr to display server IP address in
      tracepoints.
    . modify encode_cb_recallany4args to replace sizeof with
      ARRAY_SIZE.

---

Dai Ngo (4):
     NFSD: refactoring courtesy_client_reaper to a generic low memory shrinker
     NFSD: add support for sending CB_RECALL_ANY
     NFSD: add delegation shrinker to react to low memory condition
     NFSD: add CB_RECALL_ANY tracepoints

 fs/nfsd/nfs4callback.c |  62 +++++++++++++++++++++++
 fs/nfsd/nfs4state.c    | 116 +++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/state.h        |   9 ++++
 fs/nfsd/trace.h        |  49 +++++++++++++++++++
 fs/nfsd/xdr4.h         |   5 ++
 fs/nfsd/xdr4cb.h       |   6 +++
 6 files changed, 234 insertions(+), 13 deletions(-)
