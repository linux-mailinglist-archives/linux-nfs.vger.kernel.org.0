Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D022576ADB
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Jul 2022 01:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiGOXy6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 19:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGOXy5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 19:54:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B01904DA
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 16:54:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKYMlp025309
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=oiPNRMO3dhxe6lxvWFdORrle2cDKJZo83sRqM0vosOw=;
 b=ZcyMk4WT7DyWflsnncx2T6HaATt0lupTc1dsVvQEO01ogQ973cjyX16nilm8rf1jv6+s
 XjiYuasG7iPhH2o7AA1BjhPW6JuSzoKTBbEZ6fZwwrHtxZvzDfOPriTG8KyE4elEZ+JU
 0gxjX7MJ8aaoNFosrxgPs2jg0BF0tpe+i3puVgFswCfZITgbSAT9LHMwsOTl7Mv3jU9N
 IV2oSmAc4NukDSNQ2fMlm1ZKR28EXWn5esdVe3jUV9494HsEZe/Nmso12ZWhyYuuBiha
 gc6JP85HYU++fhcCU3nBuFJ0icWjDd9hRydNsKpq83ZoKIhEtUekhZIpG7ont6WX05Xx Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rg90ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FNp1Cp016538
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047j672-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:55 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26FNssHu021132
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:54:54 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047j66y-1;
        Fri, 15 Jul 2022 23:54:54 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/3] NFSD: limit the number of v4 clients to 1024 per 1GB of system memory
Date:   Fri, 15 Jul 2022 16:54:50 -0700
Message-Id: <1657929293-30442-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-GUID: G-t_BjEGz1HUZ3uErL6btA-7LCxuBjob
X-Proofpoint-ORIG-GUID: G-t_BjEGz1HUZ3uErL6btA-7LCxuBjob
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

v3:
. refactoring v4 initialization specific code to a helper in nfs4state.c
. fix kernel test robot issue with NFS4_CLIENTS_PER_GB when
  CONFIG_NFSD_V4 is not defined by moving v4 specific code
  to helper nfsd4_init_leases_net in nfs4state.c 

---

Dai Ngo (2):
      NFSD: refactoring v4 specific code to a helper in nfs4state.c
      NFSD: keep track of the number of v4 clients in the system
      NFSD: limit the number of v4 clients to 1024 per 1GB of system memory

 fs/nfsd/netns.h     |  3 +++
 fs/nfsd/nfs4state.c | 49 ++++++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/nfsctl.c    |  9 +--------
 fs/nfsd/nfsd.h      |  6 ++++++
 4 files changed, 51 insertions(+), 16 deletions(-)

--
Dai Ngo

