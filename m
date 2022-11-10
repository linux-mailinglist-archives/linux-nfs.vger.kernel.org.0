Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8B623AF0
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Nov 2022 05:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiKJERc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Nov 2022 23:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJERb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Nov 2022 23:17:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FBD230
        for <linux-nfs@vger.kernel.org>; Wed,  9 Nov 2022 20:17:28 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA4AGAe014837;
        Thu, 10 Nov 2022 04:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=ZEY6aOgCqYlY0KAHe9O1bFtYTyWn3RT7jicOP/Of2aM=;
 b=ozyXMGPKH42v9CIMFnu4SkGA+oTaNDd8LiYzILxuXGQuwSaBXhSs3oRwQe7eJxl/H/Ev
 C/HOsZs7Y3u06SMxirFG/uGRJ8oQrBjUhiAehUJmaQD0nDPqLRz8GYKkw6OeubQtph47
 ilhD5tAtBQNzKedVKk7xIcW2EvGWypJbBakhgRdlW6BEoY96pFr2Xs+SYCj4G3nX5vLX
 to87e44S/l8PyPhhibeVIchZIxHmMUaxgk3jD0fGJJdMNl+5BmU0SNGzHXE1XS5vr5ob
 Yxqt2uFk9a21yZ97RlMzB4efDLtlhjpiCHbJfKAt/xqo2kxskmyRBsxefcaRGw1r7dpq sA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krt1pr0xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 04:17:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA40QAD000354;
        Thu, 10 Nov 2022 04:17:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsfxc3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 04:17:24 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AA4HO7Z005307;
        Thu, 10 Nov 2022 04:17:24 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kpcsfxc35-1;
        Thu, 10 Nov 2022 04:17:24 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/3] add support for CB_RECALL_ANY and the delegation shrinker
Date:   Wed,  9 Nov 2022 20:17:08 -0800
Message-Id: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100030
X-Proofpoint-GUID: HK6V5dTUGhOsQAUg_owvroZc2XUWz06V
X-Proofpoint-ORIG-GUID: HK6V5dTUGhOsQAUg_owvroZc2XUWz06V
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

    . XDR encode and decode function for CB_RECALL_ANY op.

    . the delegation shrinker that sends the advisory CB_RECALL_ANY 
      to the clients to release unused delegations.
      There is only one nfsd4_callback added for each nfs4_cleint.
      Access to it must be serialized via the client flag
      NFSD4_CLIENT_CB_RECALL_ANY.

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
---

Dai Ngo (3):
     NFSD: add support for sending CB_RECALL_ANY
     NFSD: add delegation shrinker to react to low memory condition
     NFSD: add CB_RECALL_ANY tracepoints

 fs/nfsd/netns.h        |   3 ++
 fs/nfsd/nfs4callback.c |  62 +++++++++++++++++++++++
 fs/nfsd/nfs4state.c    | 117 +++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h        |   9 ++++
 fs/nfsd/trace.h        |  53 ++++++++++++++++++++
 fs/nfsd/xdr4.h         |   5 ++
 fs/nfsd/xdr4cb.h       |   6 +++
 7 files changed, 254 insertions(+), 1 deletion(-)
