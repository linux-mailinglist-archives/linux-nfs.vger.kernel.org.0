Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BC56023AC
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 07:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJRFP4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 01:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJRFPy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 01:15:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6359413E
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 22:15:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNY6hF015929
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 05:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=/cR3jMMlfJkQLK/d1gAPmESzcXL035HEtekoqju0+VI=;
 b=dogjAa20/q4y0np0d70Q5JPs5mD9O/MNkNt3FLP3CqfVtu0v2U+d1oeWiUrNgGzDBlaG
 voDaCaGXNKMuER43GD/R5sKGCh+kiCLe5TCxLx7Ink29p0ML7A/JPGk8tBs8foU4s4en
 l900GevgYHjQZNtnn7LmSWi3xlf+DXj96SfNcD+9DwNlRfS5Fg04zoKpP2+7wNa3bxMR
 urz7H0yKnBIUgpr0mctoyyYxthe1kUVFj91mNtJabAIibZmfeAcGQmmvmFDQCi6050kF
 dyX70S5CYe5kU2gYP2Yuf0//mQNsbOXRUw6R2Ulakc1YR67FRp1bgAM9SUbw8Kl64OnS Sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3dda7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 05:15:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29I4eqjh017284
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 05:15:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu6rg06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 05:15:51 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29I5Fpl4031322
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 05:15:51 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3k8hu6rg01-1;
        Tue, 18 Oct 2022 05:15:51 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] add support for CB_RECALL_ANY and the delegation shrinker
Date:   Mon, 17 Oct 2022 22:15:37 -0700
Message-Id: <1666070139-18843-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=848 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180029
X-Proofpoint-ORIG-GUID: lXoiArMG_K90n-WYuwSS78fgkjDVzbp6
X-Proofpoint-GUID: lXoiArMG_K90n-WYuwSS78fgkjDVzbp6
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

---

Dai Ngo (2):
     NFSD: add support for sending CB_RECALL_ANY
     NFSD: add delegation shrinker to react to low memory condition

 fs/nfsd/netns.h        |  3 ++
 fs/nfsd/nfs4callback.c | 64 ++++++++++++++++++++++++++++++
 fs/nfsd/nfs4state.c    | 97 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h        |  9 +++++
 fs/nfsd/xdr4cb.h       |  6 +++
 5 files changed, 178 insertions(+), 1 deletion(-)

