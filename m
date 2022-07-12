Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB31E5726F7
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 22:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiGLUJY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiGLUJX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 16:09:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E486BA39D
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 13:09:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CJY2PO023202
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=PdMt26dtj7QSVmDLxENHTyQvqeUxsTf66prO/TqWW8E=;
 b=o3vsBLQEVGfuLik5YakjR4H0k7RE3kXoEH3gPcm9UhekThqyf15l+5dOUCSurlE4Bogo
 6tW3S9NJr+iXeBCfQQyEUv0Mel/ldozFHCJb7mTAERheO9I5o8xA5oWrmM1+z860uMt2
 xu+0aBH0Rp4Q/aZLTWYSt7THqVGwGI7eQg4N1od1va38jPo3K8PnC0z/NIh0I8ukriOH
 DSxPQUMawRx4cVDIVD+qMjFHmGLsK8TaoZ1PaOEYoFDc/x4rC2oXV9CdElKX7cnp5ZSB
 ssmoH4kdaKoicEyMKU6XMgLHU/sUtp3lFnL6FD6eNk5F+g9Yp/NNSLGC9U3DlyBW3r/Q XA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r17ye6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:09:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CK1Mj1020073
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:09:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70449spb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:09:15 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26CK9EDb003044
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:09:14 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70449snp-1;
        Tue, 12 Jul 2022 20:09:14 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: 
Date:   Tue, 12 Jul 2022 13:09:11 -0700
Message-Id: <1657656553-16493-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-ORIG-GUID: x0k5z7I1c1ZDf61G6Moc915NKWIOxjRK
X-Proofpoint-GUID: x0k5z7I1c1ZDf61G6Moc915NKWIOxjRK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

s patch series enforces a limit on the number of v4 clients allowed
in the system. With Courteous server support there are potentially a
lots courtesy clients exist in the system that use up memory resource
preventing them to be used by other components in the system. Also
without a limit on the number of clients, the number of clients can
grow to a very large number even for system with small memory configuration
eventually render the system into an unusable state.

---

Dai Ngo (2):
      NFSD: keep track of the number of v4 clients in the system
      NFSD: limit the number of v4 clients to 4096 per 4GB of system memory

 fs/nfsd/netns.h     |  3 +++
 fs/nfsd/nfs4state.c | 25 +++++++++++++++++++------
 fs/nfsd/nfsctl.c    | 10 ++++++++++
 3 files changed, 32 insertions(+), 6 deletions(-)

--
Dai Ngo

