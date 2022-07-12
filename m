Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D5C572700
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiGLULH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 16:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiGLULH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 16:11:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FFABE6B8
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 13:11:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CJY3Nb000443
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=Fc/i5TEdete7s/Cd+jRGuK/R/1q1OBeLWb4dibsVx5E=;
 b=ccSEryfu2hta8jUmTcmlT5QPRX1Pcn3IjTF/Hs7B021jZzJJt47pwwqLN9uUPdhJfCBQ
 q+AGn2zm58D4IgZlk7DWlb7JOs+m4vj3JhIsBQRwc0l2B+MiOt+3iKM/X88VChLFt4Rf
 2GFp9Ih9Tm3Rab4F0DWu1SMzpHVx9OahmfEdNHR6/7nmArbryZ6X6c890j5IcbCBSyPx
 S5a2RMw08ilQ6HojeMlITCmH/C90aMAIYT+KYjo5nwdAbMxirJfpPSH8R3JDh4Glu3Gg
 HsZ21gIhsMo7RM4ooBVg0DXoFAfA2mqLTJKVjFnjrAM9jEI/bsCTkWZf51koJpRswpc6 sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sgdsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:11:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CK1L9A019952
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:11:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70449v3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:11:04 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 26CKB4eI009546
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 20:11:04 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70449v2t-1;
        Tue, 12 Jul 2022 20:11:04 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] limit the number of v4 clients to 4096 per 4GB of system memory
Date:   Tue, 12 Jul 2022 13:10:58 -0700
Message-Id: <1657656660-16647-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-ORIG-GUID: Wk1uNx_4rQcrgW5ICXZoVsrzQTW4dCi3
X-Proofpoint-GUID: Wk1uNx_4rQcrgW5ICXZoVsrzQTW4dCi3
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

---
Resend with Subject line

Dai Ngo (2):
      NFSD: keep track of the number of v4 clients in the system
      NFSD: limit the number of v4 clients to 4096 per 4GB of system memory

 fs/nfsd/netns.h     |  3 +++
 fs/nfsd/nfs4state.c | 25 +++++++++++++++++++------
 fs/nfsd/nfsctl.c    | 10 ++++++++++
 3 files changed, 32 insertions(+), 6 deletions(-)

--
Dai Ngo
