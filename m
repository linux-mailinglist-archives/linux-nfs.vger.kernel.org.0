Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115EB57529E
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiGNQRt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiGNQRs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 12:17:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BAA61D65
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 09:17:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EFrJ5D000875
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 16:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=SfPxDcrTv8ZKhmlLYAs96i6RDiQQaIhpdZDMIRU8ksg=;
 b=he9iozDuK6rM2Cr+C28tGxkSSkkfNRwoK7w592WRV/b2+4uIey5LaTK8Jd3fFdfuEwEh
 Os3Vx1KiIIQYLJpa8uVD4RBs2rr0sTZVwZ+5B+X+udMgKGTXyPYssTEgxx/dX46Q7uW7
 zwGGmYcddVuLIJuM+V4qdDQalg0TeU313OlbSv/xwfFxQBath7BY+QH3ZPSZnHuzGDdr
 dsKS5Z+VhYwsvQYQk//B2EwGfVdSYuPY0VxjlDXMIW6SFcFrJFEcVu/JKvZ6wFOfEdsm
 9yNXz1auJhGNykgyuEC/+xKRZOgIUPshcuZLuu5myoOzbv3Rm+lZgTYmapRDEAgLC8ns Kw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrnnjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 16:17:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EGFfMN018977
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 16:17:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70467f64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 16:17:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26EGHjDo024660
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 16:17:45 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h70467f5u-1;
        Thu, 14 Jul 2022 16:17:45 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/2] limit the number of v4 clients to 1024 per 1GB of system memory
Date:   Thu, 14 Jul 2022 09:17:40 -0700
Message-Id: <1657815462-14069-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: KPrmx7dviaYI_qI1UwCAlWMf0qMWJbbX
X-Proofpoint-ORIG-GUID: KPrmx7dviaYI_qI1UwCAlWMf0qMWJbbX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch series enforces a limit on the number of v4 clients allowed
in the system. With Courteous server support there are potentially a
lots courtesy clients exist in the system that use up memory resource
preventing them to be used by other components in the system. Also
without a limit on the number of clients, the number of clients can
grow to a very large number even for system with small memory configuration
eventually render the system into an unusable state.

v2:
. move all defines to nfsd.h
. replace unsigned int nfs4_max_client to int
. kick start laundromat in alloc_client when max client reached.
. restyle compute of maxreap in nfs4_get_client_reaplist to oneline.
. redo enforce of maxreap in nfs4_get_client_reaplist for readability
. use bit-wise interger to compute usable memory in nfsd_init_net.
. replace NFS4_MAX_CLIENTS_PER_4GB to NFS4_CLIENTS_PER_GB.
. use all memory, including high mem, to compute max client.

---

Dai Ngo (2):
      NFSD: keep track of the number of v4 clients in the system
      NFSD: limit the number of v4 clients to 1024 per 1GB of system memory

 fs/nfsd/netns.h     |  3 +++
 fs/nfsd/nfs4state.c | 28 ++++++++++++++++++++--------
 fs/nfsd/nfsctl.c    |  8 ++++++++
 fs/nfsd/nfsd.h      |  2 ++
 4 files changed, 33 insertions(+), 8 deletions(-)
--
Dai Ngo

